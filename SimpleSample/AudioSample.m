//
//  AudioSample.m
//  DrumExpress
//
//  Created by Matthew Prockup on 4/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AudioSample.h"

@implementation AudioSample

#pragma mark -
#pragma mark SETUP
#pragma mark
-(void) initSampleFile:(NSString*) fileJawn
{
    fileName = fileJawn;
}


#pragma mark -
#pragma mark AUDIO
#pragma mark
#pragma mark Loading Audio Content

-(AudioUnitSampleType *) getSampleData
{
    return audioData;
}

- (void)loadAudio
{  
    NSLog(@"Loading Audio");
    // client format audio goes into the mixer
    
    mClientFormat.mSampleRate       = 44100.0;
    mClientFormat.mFormatID         = kAudioFormatLinearPCM;
    mClientFormat.mFormatFlags      = kAudioFormatFlagsAudioUnitCanonical;
    mClientFormat.mBytesPerPacket   = 1 * sizeof (AudioUnitSampleType);    // 8
    mClientFormat.mFramesPerPacket  = 1;
    mClientFormat.mBytesPerFrame    = 1 * sizeof (AudioUnitSampleType);    // 8
    mClientFormat.mChannelsPerFrame = 1;
    mClientFormat.mBitsPerChannel   = 8 * sizeof (AudioUnitSampleType);    // 32
    mClientFormat.mReserved         = 0;   
    
    // output format
    mOutputFormat.mSampleRate       = 44100.0;
    mOutputFormat.mFormatID         = kAudioFormatLinearPCM;
    mOutputFormat.mFormatFlags      = kAudioFormatFlagsAudioUnitCanonical;
    mOutputFormat.mBytesPerPacket   = 1 * sizeof (AudioUnitSampleType);    // 8
    mOutputFormat.mFramesPerPacket  = 1;
    mOutputFormat.mBytesPerFrame    = 1 * sizeof (AudioUnitSampleType);    // 8
    mOutputFormat.mChannelsPerFrame = 1;
    mOutputFormat.mBitsPerChannel   = 8 * sizeof (AudioUnitSampleType);    // 32
    mOutputFormat.mReserved         = 0;   
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    NSString* filePathFull = [[NSString alloc] initWithFormat:@"%@/%@.wav",basePath,fileName];
    
    sourceURL[0] = (__bridge CFURLRef)[NSURL fileURLWithPath: filePathFull];
    
    
    //sourceURL[0] = (__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:fileName ofType:@"wav"]];
    
    
    mUserData.frameNum = 0;
    mUserData.maxNumFrames = 0;
    
    for (int i = 0; i < NUMFILES && i < MAXBUFS; i++)  {
        printf("loadFiles, %d\n", i);
        
        ExtAudioFileRef xafref = 0;
        
        // open one of the two source files
        OSStatus result = ExtAudioFileOpenURL(sourceURL[i], &xafref);
        if (result || !xafref) { 
            NSLog(@"ExtAudioFileOpenURL:  %@", [self OSStatusToStr:result]); 
            return; 
        }
        
        // get the file data format, this represents the file's actual data format
        // for informational purposes only -- the client format set on ExtAudioFile is what we really want back
        AudioStreamBasicDescription fileFormat;
        UInt32 propSize = sizeof(fileFormat);
        
        result = ExtAudioFileGetProperty(xafref, kExtAudioFileProperty_FileDataFormat, &propSize, &fileFormat);
        if (result) {
            NSLog(@"ExtAudioFileGetProperty kExtAudioFileProperty_FileDataFormat:  %@", [self OSStatusToStr:result]); 
            //printf("ExtAudioFileGetProperty kExtAudioFileProperty_FileDataFormat result %ld %08X %4.4s\n", result, (unsigned int)result, (char*)&result); 
            return;
        }
        
        printf("file %d, native file format\n", i);
        //fileFormat.Print();
        
        //set the client format to be what we want back
        // this is the same format audio we're giving to the the mixer input
        result = ExtAudioFileSetProperty(xafref, kExtAudioFileProperty_ClientDataFormat, sizeof(mClientFormat), &mClientFormat);
        if (result) {
            NSLog(@"ExtAudioFileGetProperty kExtAudioFileProperty_ClientDataFormat:  %@", [self OSStatusToStr:result]); 
            NSLog(@"ExtAudioFileSetProperty kExtAudioFileProperty_ClientDataFormat %ld %08X %4.4s\n", result, (unsigned int)result, (char*)&result); 
            return; 
        }
        
        
        // get the file's length in sample frames
        UInt64 numFrames = 0;
        propSize = sizeof(numFrames);
        result = ExtAudioFileGetProperty(xafref, kExtAudioFileProperty_FileLengthFrames, &propSize, &numFrames);
        if (result) {
            NSLog(@"ExtAudioFileGetProperty kExtAudioFileProperty_FileLengthFrames:  %@", [self OSStatusToStr:result]); 
            //printf("ExtAudioFileGetProperty kExtAudioFileProperty_FileLengthFrames result %ld %08X %4.4s\n", result, (unsigned int)result, (char*)&result); 
            return; 
        }
        
        // keep track of the largest number of source frames
        if (numFrames > mUserData.maxNumFrames) mUserData.maxNumFrames = numFrames;
        
        // set up our buffer
        mUserData.soundBuffer[i].numFrames = numFrames;
        mUserData.soundBuffer[i].asbd = mClientFormat;
        
        UInt32 samples = numFrames * mUserData.soundBuffer[i].asbd.mChannelsPerFrame;
        mUserData.soundBuffer[i].data = (AudioUnitSampleType *)calloc(samples, sizeof(AudioUnitSampleType));
        
        // set up a AudioBufferList to read data into
        AudioBufferList bufList;
        bufList.mNumberBuffers = 1;
        bufList.mBuffers[0].mNumberChannels = mUserData.soundBuffer[i].asbd.mChannelsPerFrame;
        bufList.mBuffers[0].mData = mUserData.soundBuffer[i].data;
        bufList.mBuffers[0].mDataByteSize = samples * sizeof(AudioUnitSampleType);
        
        
        
        
        // perform a synchronous sequential read of the audio data out of the file into our allocated data buffer
        UInt32 numPackets = numFrames;
        result = ExtAudioFileRead(xafref, &numPackets, &bufList);
        if (result) {
            
            NSLog(@"ExtAudioFileRead:  %@", [self OSStatusToStr:result]);
            
            NSLog(@"ExtAudioFileRead result %ld %08X %4.4s\n", result, (unsigned int)result, (char*)&result); 
            free(mUserData.soundBuffer[i].data);
            mUserData.soundBuffer[i].data = 0;
            return;
        }
        
        NSLog(@"%ld",[self maxAudio:bufList.mBuffers[0].mData withSize:512]);
        audioData = bufList.mBuffers[0].mData;
        audioSize = samples;
        // close the file and dispose the ExtAudioFileRef
        ExtAudioFileDispose(xafref);
    }
    
    
}


- (NSString *)OSStatusToStr:(OSStatus)st
{
    switch (st) {
        case kAudioFileUnspecifiedError:
            return @"kAudioFileUnspecifiedError";
            
        case kAudioFileUnsupportedFileTypeError:
            return @"kAudioFileUnsupportedFileTypeError";
            
        case kAudioFileUnsupportedDataFormatError:
            return @"kAudioFileUnsupportedDataFormatError";
            
        case kAudioFileUnsupportedPropertyError:
            return @"kAudioFileUnsupportedPropertyError";
            
        case kAudioFileBadPropertySizeError:
            return @"kAudioFileBadPropertySizeError";
            
        case kAudioFilePermissionsError:
            return @"kAudioFilePermissionsError";
            
        case kAudioFileNotOptimizedError:
            return @"kAudioFileNotOptimizedError";
            
        case kAudioFileInvalidChunkError:
            return @"kAudioFileInvalidChunkError";
            
        case kAudioFileDoesNotAllow64BitDataSizeError:
            return @"kAudioFileDoesNotAllow64BitDataSizeError";
            
        case kAudioFileInvalidPacketOffsetError:
            return @"kAudioFileInvalidPacketOffsetError";
            
        case kAudioFileInvalidFileError:
            return @"kAudioFileInvalidFileError";
            
        case kAudioFileOperationNotSupportedError:
            return @"kAudioFileOperationNotSupportedError";
            
        case kAudioFileNotOpenError:
            return @"kAudioFileNotOpenError";
            
        case kAudioFileEndOfFileError:
            return @"kAudioFileEndOfFileError";
            
        case kAudioFilePositionError:
            return @"kAudioFilePositionError";
            
        case kAudioFileFileNotFoundError:
            return @"kAudioFileFileNotFoundError";
            
        default:
            return @"unknown error";
    }
}

-(int) getAudioSize{
    return audioSize;
}

#pragma mark Audio Helper Functions

- (void)printAudio:(AudioUnitSampleType*)audio withSize:(int)length
{
    for(int i = 1;i<length;i++)
    {
        NSLog(@"%f",audio[i]);
    }
    
}

- (AudioUnitSampleType)maxAudio:(AudioUnitSampleType*)audio withSize:(int)length
{   AudioUnitSampleType max = 0.0;
    for(int i = 0;i<length;i++)
    {
        if( abs(audio[i])>max)
        {
            max = abs(audio[i]);
        }
    }
    return max;


}


#pragma mark -
#pragma mark ACCESS
#pragma mark -
#pragma mark Articulation Definition
-(NSString*) getFileName{
    return fileName;
}



@end
