//
//  SamplePlayer.m
//  Met
//
//  Created by Matthew Prockup on 9/26/13.
//  Copyright (c) 2013 Matthew Prockup. All rights reserved.
//

#import "SamplePlayer.h"
bool isFreeToAlter;

@implementation SamplePlayer


- (void)initializeTrackWithSound:(NSString*)sound
{
    
    isFreeToAlter = true;
    playingAudio = (AudioUnitSampleType*)malloc(512*sizeof(AudioUnitSampleType));
    for(int i = 0; i<512; i++)
    {
        playingAudio[i]=0;
    }
    audiosize = 512;
    
    AudioSample* tempSample = [[AudioSample alloc]init];
    [tempSample  initSampleFile:sound];
    [tempSample loadAudio];
    
    currentSample = tempSample;
    sampName = sound;
}


- (void)getAudioData:(AudioUnitSampleType*)buffer onChannel:(int)chan withFrames:(int)numFrames{
    
    while(isFreeToAlter == false)
    {
        usleep(500);
        
    }
    isFreeToAlter = false;
    
    if(numFrames<audiosize)
    {
        for(int i = 0; i<numFrames; i++)
        {
            buffer[i] = playingAudio[i];
        }
        
        AudioUnitSampleType* temp = malloc((audiosize-numFrames)*sizeof(AudioUnitSampleType));
        memcpy(temp, &playingAudio[numFrames],(audiosize-numFrames)*sizeof(AudioUnitSampleType));
        //free(playingAudio);
        
        playingAudio = (AudioUnitSampleType*)realloc(playingAudio,(audiosize-numFrames)*sizeof(AudioUnitSampleType));
        memcpy(playingAudio, temp, (audiosize-numFrames)*sizeof(AudioUnitSampleType));
        free(temp);
        
        audiosize = audiosize-numFrames;
        
    }
    else
    {
        for(int i = 0; i<audiosize; i++)
        {
            buffer[i] = playingAudio[i];
        }
        for(int i = audiosize; i<numFrames; i++)
        {
            buffer[i] = 0;
        }
        
        free(playingAudio);
        playingAudio = (AudioUnitSampleType*)calloc(numFrames,sizeof(AudioUnitSampleType));
        audiosize = numFrames;
        
    }
    isFreeToAlter = true;
}

- (void)addAudioData:(AudioUnitSampleType*)buffer onChannel:(int)chan withFrames:(int)numFrames withGain:(float)gain{
    
    while(isFreeToAlter == false)
    {
        usleep(500);
        
    }
    isFreeToAlter = false;
    //NSLog(@"%f",gain);
    
    int addedAudioSize = numFrames;
    if(audiosize>=addedAudioSize)
    {
        for(int i = 0; i<addedAudioSize; i++)
        {
            playingAudio[i] = playingAudio[i]+buffer[i]*gain;
        }
        
    }
    else
    {
        AudioUnitSampleType* tempAudio = (AudioUnitSampleType*) malloc(addedAudioSize*sizeof(AudioUnitSampleType));
        
        
        for(int i = 0; i<audiosize; i++)
        {
            tempAudio[i] = playingAudio[i]+buffer[i]*gain;
        }
        for(int i = audiosize; i<addedAudioSize; i++)
        {
            tempAudio[i] = buffer[i]*gain;
        }
        
        
        free(playingAudio);
        playingAudio = (AudioUnitSampleType*) malloc(addedAudioSize*sizeof(AudioUnitSampleType));
        memcpy(playingAudio, tempAudio, addedAudioSize*sizeof(AudioUnitSampleType));
        free(tempAudio);
        audiosize = addedAudioSize;
    }
    isFreeToAlter = true;
    
}

-(void) makeBeep
{
    [self addAudioData:[currentSample getSampleData] onChannel:0 withFrames:[currentSample getAudioSize]  withGain:1.0];
}

-(NSString*) getFileId
{
    return sampName;
}


@end
