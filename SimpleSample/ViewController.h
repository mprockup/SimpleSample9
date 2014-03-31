//
//  ViewController.h
//  SimpleSampler
//
//  Created by Matthew Prockup on 10/6/13.
//  Copyright (c) 2013 Matthew Prockup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SamplePlayer.h"
#import "MixerHostAudio.h"
#import "PopoverViewController.h"

@interface ViewController : UIViewController
{
    SamplePlayer* sampObj0;
    SamplePlayer* sampObj1;
    SamplePlayer* sampObj2;
    SamplePlayer* sampObj3;
    SamplePlayer* sampObj4;
    SamplePlayer* sampObj5;
    SamplePlayer* sampObj6;
    SamplePlayer* sampObj7;
    SamplePlayer* sampObj8;
    
    NSMutableArray  *sampObjects;
    
    AudioComponentInstance toneUnit;
    
    UIButton *playButton;
    
    UIButton *button0;
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    UIButton *button4;
    UIButton *button5;
    UIButton *button6;
    UIButton *button7;
    UIButton *button8;
    
    NSArray* buttons;
    
    UIButton *editButton0;
    UIButton *editButton1;
    UIButton *editButton2;
    UIButton *editButton3;
    UIButton *editButton4;
    UIButton *editButton5;
    UIButton *editButton6;
    UIButton *editButton7;
    UIButton *editButton8;
    
    NSArray* editButtons;
    
    UIButton *editButton;
    
    UISwitch        *mixerBus0Switch;
    UISwitch        *mixerBus1Switch;
    UISwitch        *mixerBus2Switch;
    UISwitch        *mixerBus3Switch;
    UISwitch        *mixerBus4Switch;
    UISwitch        *mixerBus5Switch;
    UISwitch        *mixerBus6Switch;
    UISwitch        *mixerBus7Switch;
    UISwitch        *mixerBus8Switch;
    
    NSArray* switches;
    
    UISlider        *mixerBus0LevelFader;
    UISlider        *mixerBus1LevelFader;
    UISlider        *mixerBus2LevelFader;
    UISlider        *mixerBus3LevelFader;
    UISlider        *mixerBus4LevelFader;
    UISlider        *mixerBus5LevelFader;
    UISlider        *mixerBus6LevelFader;
    UISlider        *mixerBus7LevelFader;
    UISlider        *mixerBus8LevelFader;
    
    NSArray* faders;
    
    UISwitch           *fadersToggle;
    
    UISlider        *mixerOutputLevelFader;
    
    UIPopoverController *popOver;
    
    
    
    NSMutableArray* fullPaths;
    NSMutableArray* fileNames;
    NSMutableArray* idNames;
    int currentButtonTag;
    
    bool isEditing;
    
    UIButton *saveButton;
    UIButton *loadButton;
}

- (float*)getDataOnChannel:(int)channel withFrames:(int)numFrame;
- (void)createToneUnit;
- (void)startAudio;
- (void) loadPreset:(NSString*)inFile;
- (NSString*) createSaveFileString;
- (void)savePreset:(NSString*)outFileName withData:(NSString*) dataString;

@property (nonatomic, retain)    IBOutlet UISlider           *mixerBus0LevelFader;
@property (nonatomic, retain)    IBOutlet UISlider           *mixerBus1LevelFader;
@property (nonatomic, retain)    IBOutlet UISlider           *mixerBus2LevelFader;
@property (nonatomic, retain)    IBOutlet UISlider           *mixerBus3LevelFader;
@property (nonatomic, retain)    IBOutlet UISlider           *mixerBus4LevelFader;
@property (nonatomic, retain)    IBOutlet UISlider           *mixerBus5LevelFader;
@property (nonatomic, retain)    IBOutlet UISlider           *mixerBus6LevelFader;
@property (nonatomic, retain)    IBOutlet UISlider           *mixerBus7LevelFader;
@property (nonatomic, retain)    IBOutlet UISlider           *mixerBus8LevelFader;
//@property (nonatomic, retain)    NSArray                     *faders;

@property (nonatomic, retain)    IBOutlet UISlider           *mixerOutputLevelFader;

@property (nonatomic, retain)    IBOutlet UIButton           *playButton;

@property (nonatomic, retain)    IBOutlet UIButton           *button0;
@property (nonatomic, retain)    IBOutlet UIButton           *button1;
@property (nonatomic, retain)    IBOutlet UIButton           *button2;
@property (nonatomic, retain)    IBOutlet UIButton           *button3;
@property (nonatomic, retain)    IBOutlet UIButton           *button4;
@property (nonatomic, retain)    IBOutlet UIButton           *button5;
@property (nonatomic, retain)    IBOutlet UIButton           *button6;
@property (nonatomic, retain)    IBOutlet UIButton           *button7;
@property (nonatomic, retain)    IBOutlet UIButton           *button8;
//@property (nonatomic, retain)    NSArray                     *buttons;

@property (nonatomic, retain)    IBOutlet UIButton           *editButton0;
@property (nonatomic, retain)    IBOutlet UIButton           *editButton1;
@property (nonatomic, retain)    IBOutlet UIButton           *editButton2;
@property (nonatomic, retain)    IBOutlet UIButton           *editButton3;
@property (nonatomic, retain)    IBOutlet UIButton           *editButton4;
@property (nonatomic, retain)    IBOutlet UIButton           *editButton5;
@property (nonatomic, retain)    IBOutlet UIButton           *editButton6;
@property (nonatomic, retain)    IBOutlet UIButton           *editButton7;
@property (nonatomic, retain)    IBOutlet UIButton           *editButton8;
//@property (nonatomic, retain)    NSArray                     *editButtons;

@property (nonatomic, retain)    IBOutlet UIButton           *editButton;
@property (nonatomic, retain)    IBOutlet UIButton           *saveButton;
@property (nonatomic, retain)    IBOutlet UIButton           *loadButton;

@property (nonatomic, retain)    IBOutlet UISwitch           *mixerBus0Switch;
@property (nonatomic, retain)    IBOutlet UISwitch           *mixerBus1Switch;
@property (nonatomic, retain)    IBOutlet UISwitch           *mixerBus2Switch;
@property (nonatomic, retain)    IBOutlet UISwitch           *mixerBus3Switch;
@property (nonatomic, retain)    IBOutlet UISwitch           *mixerBus4Switch;
@property (nonatomic, retain)    IBOutlet UISwitch           *mixerBus5Switch;
@property (nonatomic, retain)    IBOutlet UISwitch           *mixerBus6Switch;
@property (nonatomic, retain)    IBOutlet UISwitch           *mixerBus7Switch;
@property (nonatomic, retain)    IBOutlet UISwitch           *mixerBus8Switch;

@property (nonatomic, retain)    IBOutlet UISwitch           *fadersToggle;

//@property (nonatomic, retain)    NSArray                     *switches;

@property (nonatomic, retain)    SamplePlayer                *sampObj0;
@property (nonatomic, retain)    SamplePlayer                *sampObj1;
@property (nonatomic, retain)    SamplePlayer                *sampObj2;
@property (nonatomic, retain)    SamplePlayer                *sampObj3;
@property (nonatomic, retain)    SamplePlayer                *sampObj4;
@property (nonatomic, retain)    SamplePlayer                *sampObj5;
@property (nonatomic, retain)    SamplePlayer                *sampObj6;
@property (nonatomic, retain)    SamplePlayer                *sampObj7;
@property (nonatomic, retain)    SamplePlayer                *sampObj8;
//@property (nonatomic, retain)    NSArray                     *sampObjs;


@property (nonatomic, retain) MixerHostAudio *audioObject;

@property (nonatomic,strong) UIPopoverController *popOver;

- (IBAction) enableMixerInput:          (UISwitch *) sender;
- (IBAction) mixerInputGainChanged:     (UISlider *) sender;
- (IBAction) mixerOutputGainChanged:    (UISlider *) sender;
- (IBAction) playOrStop:                (id) sender;
- (IBAction) playSample: (id) sender;
- (IBAction) fadersToggle:(UISwitch*)sender;
- (IBAction) savePresetPressed:(UIButton*)sender;
- (IBAction) loadPresetPressed:(UIButton*)sender;





@end
