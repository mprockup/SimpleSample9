//
//  AudioSample.h
//  DrumExpress
//
//  Created by Matthew Prockup on 4/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//
#import <AudioToolbox/AudioToolbox.h>
#import <Foundation/Foundation.h>
#define MAXBUFS  1
#define NUMFILES 1

typedef struct {
    AudioStreamBasicDescription asbd;
    AudioUnitSampleType *data;
	UInt32 numFrames;
} SoundBuffer;

typedef struct {
	UInt32 frameNum;
    UInt32 maxNumFrames;
    SoundBuffer soundBuffer[MAXBUFS];
}SourceAudioBufferData;


@interface AudioSample : NSObject
{
    AudioUnitSampleType* audioData;
    int audioSize;
    NSString* fileName;
    
    SourceAudioBufferData *SourceAudioBufferDataPtr;
    
    SoundBuffer *SoundBufferPtr;
    CFURLRef sourceURL[NUMFILES];
    SourceAudioBufferData mUserData;
    AudioStreamBasicDescription mClientFormat;
    AudioStreamBasicDescription mOutputFormat;
    
}


-(void) initSampleFile:(NSString*) fileJawn;
-(void) loadAudio;
- (NSString *)OSStatusToStr:(OSStatus)st;
-(AudioUnitSampleType *) getSampleData;
-(int) getAudioSize;
- (AudioUnitSampleType)maxAudio:(AudioUnitSampleType*)audio withSize:(int)length;
-(NSString*) getFileName;





@end
