//
//  ViewController.m
//  SimpleSampler
//
//  Created by Matthew Prockup on 10/6/13.
//  Copyright (c) 2013 Matthew Prockup. All rights reserved.
//


#import "ViewController.h"



NSString *MixerHostAudioObjectPlaybackStateDidChangeNotification = @"MixerHostAudioObjectPlaybackStateDidChangeNotification";


@interface ViewController ()

@end

@implementation ViewController

@synthesize popOver;
@synthesize playButton;
@synthesize mixerBus0Switch, mixerBus0LevelFader, sampObj0, button0, editButton0;
@synthesize mixerBus1Switch, mixerBus1LevelFader, sampObj1, button1, editButton1;
@synthesize mixerBus2Switch, mixerBus2LevelFader, sampObj2, button2, editButton2;
@synthesize mixerBus3Switch, mixerBus3LevelFader, sampObj3, button3, editButton3;
@synthesize mixerBus4Switch, mixerBus4LevelFader, sampObj4, button4, editButton4;
@synthesize mixerBus5Switch, mixerBus5LevelFader, sampObj5, button5, editButton5;
@synthesize mixerBus6Switch, mixerBus6LevelFader, sampObj6, button6, editButton6;
@synthesize mixerBus7Switch, mixerBus7LevelFader, sampObj7, button7, editButton7;
@synthesize mixerBus8Switch, mixerBus8LevelFader, sampObj8, button8, editButton8;
@synthesize mixerOutputLevelFader;
@synthesize audioObject;
@synthesize saveButton; 
@synthesize editButton;
@synthesize loadButton;

#pragma mark -
#pragma mark Setting Up Audio

- (void) initializeMixerSettingsToUI {
    
    // Initialize mixer settings to UI
    
    //    [audioObject setMixerOutputGain: mixerOutputLevelFader.value];
    [audioObject setMixerOutputGain: 1.0];
    
    [audioObject enableMixerInput: 0 isOn: true];
    [audioObject enableMixerInput: 1 isOn: true];
    [audioObject enableMixerInput: 2 isOn: true];
    [audioObject enableMixerInput: 3 isOn: true];
    [audioObject enableMixerInput: 4 isOn: true];
    [audioObject enableMixerInput: 5 isOn: true];
    [audioObject enableMixerInput: 6 isOn: true];
    [audioObject enableMixerInput: 7 isOn: true];
    [audioObject enableMixerInput: 8 isOn: true];
    
    [self setMixerToFaders];
}

-(void) setMixerToFaders
{
    [audioObject setMixerInput: 0 gain: mixerBus0LevelFader.value];
    [audioObject setMixerInput: 1 gain: mixerBus1LevelFader.value];
    [audioObject setMixerInput: 2 gain: mixerBus2LevelFader.value];
    [audioObject setMixerInput: 3 gain: mixerBus3LevelFader.value];
    [audioObject setMixerInput: 4 gain: mixerBus4LevelFader.value];
    [audioObject setMixerInput: 5 gain: mixerBus5LevelFader.value];
    [audioObject setMixerInput: 6 gain: mixerBus6LevelFader.value];
    [audioObject setMixerInput: 7 gain: mixerBus7LevelFader.value];
    [audioObject setMixerInput: 8 gain: mixerBus8LevelFader.value];
    [audioObject setMixerOutputGain:mixerOutputLevelFader.value];
}

// Handle a change in the mixer output gain slider.
- (IBAction) mixerOutputGainChanged: (UISlider *) sender {
    
    [audioObject setMixerOutputGain: (AudioUnitParameterValue) sender.value];
    
}

// Handle a change in a mixer input gain slider. The "tag" value of the slider lets this
//    method distinguish between the two channels.
- (IBAction) mixerInputGainChanged: (UISlider *) sender {
    
    UInt32 inputBus = sender.tag;
    NSLog(@"Gain %lu Changed",inputBus);
    if([audioObject isPlaying])
    {
        [audioObject setMixerInput: (UInt32) inputBus gain: (AudioUnitParameterValue) sender.value];
    }
    
}


#pragma mark -
#pragma mark Audio Interface
- (IBAction) playOrStop: (id) sender {
    
    if (audioObject.isPlaying) {
        
        [audioObject stopAUGraph];
        
        [self setButtonsEnabled:false];
        //[self setFadersEnabled:false];
        
        [editButton setEnabled:true];
        [loadButton setEnabled:true];
        //[saveButton setEnabled:true];
        
        [self.playButton setTitle:@"START" forState:UIControlStateNormal];
        
        [self setButtonsBackground:@"ButtonRed.png"];
        
        [playButton setBackgroundImage:[UIImage imageNamed:@"ButtonGreen.png"] forState:UIControlStateNormal];
        [playButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        
        [editButton setBackgroundImage:[UIImage imageNamed:@"ButtonBlue.png"] forState:UIControlStateNormal];
        [editButton setTitleColor:[UIColor colorWithRed:27.0/255.0 green:122.0/255.0 blue:254.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [loadButton setBackgroundImage:[UIImage imageNamed:@"ButtonBlue.png"] forState:UIControlStateNormal];
        [loadButton setTitleColor:[UIColor colorWithRed:27.0/255.0 green:122.0/255.0 blue:254.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [saveButton setBackgroundImage:[UIImage imageNamed:@"ButtonGreen.png"] forState:UIControlStateNormal];
        [saveButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        
        
        
    } else {
        
        [audioObject startAUGraph];
        [self.playButton setTitle:@"STOP" forState:UIControlStateNormal];
        
        [self setButtonsEnabled:true];
        [self setMixerToFaders];
        //[self setFadersEnabled:true];
        
        [editButton setEnabled:false];
        [loadButton setEnabled:false];
        //[saveButton setEnabled:false];
        
        [self setButtonsBackground:@"ButtonGreen.png"];
        
        [playButton setBackgroundImage:[UIImage imageNamed:@"ButtonRed.png"] forState:UIControlStateNormal];
        [playButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        [editButton setBackgroundImage:[UIImage imageNamed:@"ButtonBack.png"] forState:UIControlStateNormal];
        [editButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [loadButton setBackgroundImage:[UIImage imageNamed:@"ButtonBack.png"] forState:UIControlStateNormal];
        [loadButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [saveButton setBackgroundImage:[UIImage imageNamed:@"ButtonGreen.png"] forState:UIControlStateNormal];
        [saveButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];

        
    }
}

- (IBAction) editSamples: (id) sender {
    
    
    if(![self.audioObject isPlaying])
    {
        if (isEditing) {
            
            [playButton setEnabled:true];
            [self.editButton setTitle:@"EDIT" forState:UIControlStateNormal];
            
            [self setEditButtonsHidden:true];
            isEditing = false;
            
            [self setButtonsBackground:@"ButtonRed.png"];
            
            [playButton setBackgroundImage:[UIImage imageNamed:@"ButtonGreen.png"] forState:UIControlStateNormal];
            [playButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [editButton setBackgroundImage:[UIImage imageNamed:@"ButtonBlue.png"] forState:UIControlStateNormal];
            [editButton setTitleColor:[UIColor colorWithRed:27.0/255.0 green:122.0/255.0 blue:254.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [loadButton setBackgroundImage:[UIImage imageNamed:@"ButtonBlue.png"] forState:UIControlStateNormal];
            [loadButton setTitleColor:[UIColor colorWithRed:27.0/255.0 green:122.0/255.0 blue:254.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [saveButton setBackgroundImage:[UIImage imageNamed:@"ButtonGreen.png"] forState:UIControlStateNormal];
            [saveButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        }
        else {
            
            [self.editButton setTitle:@"END EDIT" forState:UIControlStateNormal];
            [playButton setEnabled:false];
            [self setEditButtonsHidden:false];
            
            isEditing = true;
            
            [self setButtonsBackground:@"ButtonBlue.png"];
            
            [playButton setBackgroundImage:[UIImage imageNamed:@"ButtonBack.png"] forState:UIControlStateNormal];
            [playButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [editButton setBackgroundImage:[UIImage imageNamed:@"ButtonGreen.png"] forState:UIControlStateNormal];
            [editButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [loadButton setBackgroundImage:[UIImage imageNamed:@"ButtonGreen.png"] forState:UIControlStateNormal];
            [loadButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            [saveButton setBackgroundImage:[UIImage imageNamed:@"ButtonGreen.png"] forState:UIControlStateNormal];
            [saveButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Edit Failed"
                                                        message:@"You must stop audio before editing samples."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}


- (IBAction) chooseSample: (UIButton*) sender {
   
    int num = sender.tag;
    
    currentButtonTag = num;
    
    int popW = 250;
    int popH = 400;
    
    UIViewController* popOverContent = [[UIViewController alloc] init];
    UIView* popOverView = [[UIView alloc] init];
    UITableView* tableViewFiles = [[UITableView alloc] initWithFrame:CGRectMake(0,0,popW,popH)];
    tableViewFiles.delegate = self;
    tableViewFiles.dataSource = self;
    tableViewFiles.rowHeight = 40;
    [popOverView addSubview:tableViewFiles];
    popOverContent.view = popOverView;
    popOverContent.contentSizeForViewInPopover = CGSizeMake(popW, popH);
    self.popOver = [[UIPopoverController alloc] initWithContentViewController:popOverContent];
    [self.popOver presentPopoverFromRect:CGRectMake(0,0,50,25) inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
   
}

- (IBAction) playSample: (UIButton*) sender {
    int num = sender.tag;
    [[sampObjects objectAtIndex:num] makeBeep];
}

// Handle a change in playback state that resulted from an audio session interruption or end of interruption
- (void) handlePlaybackStateChanged: (id) notification {
    
    [self playOrStop: nil];
}

#pragma mark -
#pragma mark Interface Management
-(void)setButtonsEnabled:(BOOL)enable
{
    [button0 setEnabled:enable];
    [button1 setEnabled:enable];
    [button2 setEnabled:enable];
    [button3 setEnabled:enable];
    [button4 setEnabled:enable];
    [button5 setEnabled:enable];
    [button6 setEnabled:enable];
    [button7 setEnabled:enable];
    [button8 setEnabled:enable];
    
}
-(void)setFadersEnabled:(BOOL)enable
{
    [mixerBus0LevelFader setEnabled:enable];
    [mixerBus1LevelFader setEnabled:enable];
    [mixerBus2LevelFader setEnabled:enable];
    [mixerBus3LevelFader setEnabled:enable];
    [mixerBus4LevelFader setEnabled:enable];
    [mixerBus5LevelFader setEnabled:enable];
    [mixerBus6LevelFader setEnabled:enable];
    [mixerBus7LevelFader setEnabled:enable];
    [mixerBus8LevelFader setEnabled:enable];
}


-(void)setButtonsBackground:(NSString*)imageFile
{
    [button0 setBackgroundImage:[UIImage imageNamed:imageFile] forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:imageFile] forState:UIControlStateNormal];
    [button2 setBackgroundImage:[UIImage imageNamed:imageFile] forState:UIControlStateNormal];
    [button3 setBackgroundImage:[UIImage imageNamed:imageFile] forState:UIControlStateNormal];
    [button4 setBackgroundImage:[UIImage imageNamed:imageFile] forState:UIControlStateNormal];
    [button5 setBackgroundImage:[UIImage imageNamed:imageFile] forState:UIControlStateNormal];
    [button6 setBackgroundImage:[UIImage imageNamed:imageFile] forState:UIControlStateNormal];
    [button7 setBackgroundImage:[UIImage imageNamed:imageFile] forState:UIControlStateNormal];
    [button8 setBackgroundImage:[UIImage imageNamed:imageFile] forState:UIControlStateNormal];
}

-(void)setEditButtonsHidden:(BOOL)hide
{
    [editButton0 setHidden:hide];
    [editButton1 setHidden:hide];
    [editButton2 setHidden:hide];
    [editButton3 setHidden:hide];
    [editButton4 setHidden:hide];
    [editButton5 setHidden:hide];
    [editButton6 setHidden:hide];
    [editButton7 setHidden:hide];
    [editButton8 setHidden:hide];
}

#pragma mark -
#pragma mark Mixer unit control

// Handle a Mixer unit input on/off switch action. The "tag" value of the switch lets this
//    method distinguish between the two channels.
- (IBAction) enableMixerInput: (UISwitch *) sender {
    
    UInt32 inputBus = sender.tag;
    AudioUnitParameterValue isOn = (AudioUnitParameterValue) sender.isOn;
    
    [audioObject enableMixerInput: inputBus isOn: isOn];
    
}


#pragma mark -
#pragma mark Remote-control event handling
// Respond to remote control events
- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
    
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        
        switch (receivedEvent.subtype) {
                
            case UIEventSubtypeRemoteControlTogglePlayPause:
                [self playOrStop: nil];
                break;
                
            default:
                break;
        }
    }
}


#pragma mark -
#pragma mark Notification registration
// If this app's audio session is interrupted when playing audio, it needs to update its user interface
//    to reflect the fact that audio has stopped. The MixerHostAudio object conveys its change in state to
//    this object by way of a notification. To learn about notifications, see Notification Programming Topics.
- (void) registerForAudioObjectNotifications {
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver: self
                           selector: @selector (handlePlaybackStateChanged:)
                               name: MixerHostAudioObjectPlaybackStateDidChangeNotification
                             object: audioObject];
}


#pragma mark -
#pragma mark Application state management



- (void)viewDidLoad
{
    [super viewDidLoad];
    currentButtonTag = -1;
    //Interface Stuff
    
    
    isEditing = false;
    
    mixerOutputLevelFader.transform = CGAffineTransformMakeRotation(M_PI*(-0.5));
    
    [self setButtonsEnabled:false];
    //[self setFadersEnabled:false];
    [self setButtonsBackground:@"ButtonRed.png"];
    
    [playButton setBackgroundImage:[UIImage imageNamed:@"ButtonGreen.png"] forState:UIControlStateNormal];
    [playButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    
    [editButton setBackgroundImage:[UIImage imageNamed:@"ButtonBlue.png"] forState:UIControlStateNormal];
    [editButton setTitleColor:[UIColor colorWithRed:27.0/255.0 green:122.0/255.0 blue:254.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [loadButton setBackgroundImage:[UIImage imageNamed:@"ButtonBlue.png"] forState:UIControlStateNormal];
    [loadButton setTitleColor:[UIColor colorWithRed:27.0/255.0 green:122.0/255.0 blue:254.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [saveButton setBackgroundImage:[UIImage imageNamed:@"ButtonGreen.png"] forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    
    
    [self setEditButtonsHidden:true];
    
    //AudioFileStuff
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    NSArray* directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:basePath error:NULL];
    fullPaths = [[NSMutableArray alloc] init];
    fileNames = [[NSMutableArray alloc] init];
    idNames = [[NSMutableArray alloc] init];
    int count = 0;
    for(int i = 0; i< [directoryContent count]; i++)
    {
        //NSLog(@"%d : %@/%@",i,resoucePath,[directoryContent objectAtIndex:i]);
        NSString* fp = [[NSString alloc] initWithFormat:@"%@/%@",basePath,[directoryContent objectAtIndex:i]];
        NSString* filename = [[NSString alloc] initWithString:[directoryContent objectAtIndex:i]];
        NSArray* componentsJawn = [filename componentsSeparatedByString:@"."];
        NSString* suffix = [componentsJawn objectAtIndex:([componentsJawn count]-1)];
        if([suffix compare:@"wav"] == 0)
        {
            count = count+1;
            NSLog(@"%d : %@/%@",count,basePath,[directoryContent objectAtIndex:i]);
            [fullPaths addObject:fp];
            [fileNames addObject:filename];
            [idNames addObject:[componentsJawn objectAtIndex:([componentsJawn count]-2)]];
        }
    }
    
    //Audio Player Stuff
    
    sampObjects = [[NSMutableArray alloc] init];
    
    sampObj0 = [[SamplePlayer alloc] init];
    [sampObj0 initializeTrackWithSound:(NSString *)@"None"];
    [sampObjects addObject:sampObj0];
    
    sampObj1 = [[SamplePlayer alloc] init];
    [sampObj1 initializeTrackWithSound:(NSString *)@"None"];
    [sampObjects addObject:sampObj1];
    
    sampObj2 = [[SamplePlayer alloc] init];
    [sampObj2 initializeTrackWithSound:(NSString *)@"None"];
    [sampObjects addObject:sampObj2];
    
    sampObj3 = [[SamplePlayer alloc] init];
    [sampObj3 initializeTrackWithSound:(NSString *)@"None"];
    [sampObjects addObject:sampObj3];
    
    sampObj4 = [[SamplePlayer alloc] init];
    [sampObj4 initializeTrackWithSound:(NSString *)@"None"];
    [sampObjects addObject:sampObj4];
    
    sampObj5 = [[SamplePlayer alloc] init];
    [sampObj5 initializeTrackWithSound:(NSString *)@"None"];
    [sampObjects addObject:sampObj5];
    
    sampObj6 = [[SamplePlayer alloc] init];
    [sampObj6 initializeTrackWithSound:(NSString *)@"None"];
    [sampObjects addObject:sampObj6];
    
    sampObj7 = [[SamplePlayer alloc] init];
    [sampObj7 initializeTrackWithSound:(NSString *)@"None"];
    [sampObjects addObject:sampObj7];
    
    sampObj8 = [[SamplePlayer alloc] init];
    [sampObj8 initializeTrackWithSound:(NSString *)@"None"];
    [sampObjects addObject:sampObj8];
    
    
    
    MixerHostAudio *newAudioObject = [[MixerHostAudio alloc] initWithBusses:[sampObjects count] withBeepObjects:sampObjects];
    self.audioObject = newAudioObject;
    [self registerForAudioObjectNotifications];
    [self initializeMixerSettingsToUI];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    NSLog(@"Selected for %d: %@", currentButtonTag, [fileNames  objectAtIndex:[indexPath row]]);
    
    
    [((SamplePlayer*)[sampObjects objectAtIndex:currentButtonTag]) initializeTrackWithSound:[idNames  objectAtIndex:[indexPath row]]];
    
    if(currentButtonTag == 0)
    {
        [button0 setTitle:[idNames  objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
    }
    else if(currentButtonTag == 1)
    {
        [button1 setTitle:[idNames  objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
    }
    else if(currentButtonTag == 2)
    {
       [button2 setTitle:[idNames  objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
    }
    else if(currentButtonTag == 3)
    {
        [button3 setTitle:[idNames  objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
    }
    else if(currentButtonTag == 4)
    {
        [button4 setTitle:[idNames  objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
    }
    else if(currentButtonTag == 5)
    {
        [button5 setTitle:[idNames  objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
    }
    else if(currentButtonTag == 6)
    {
        [button6 setTitle:[idNames  objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
    }
    else if(currentButtonTag == 7)
    {
        [button7 setTitle:[idNames  objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
    }
    else if(currentButtonTag == 8)
    {
        [button8 setTitle:[idNames  objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
    }
    
    currentButtonTag = -1;
    [popOver dismissPopoverAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [fullPaths count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text=[NSString stringWithFormat:@"%@",[fileNames objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)savePreset:(NSString*)outFileName withData:(NSString*) dataString
{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *outFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",outFileName]];
    
    [dataString writeToFile:outFilePath atomically:TRUE encoding:NSUTF8StringEncoding error:NULL];
    
    NSLog(@"Saving: %@",outFilePath);
    NSLog(@"Data: %@",dataString);
    
}

-(NSString*) createSaveFileString
{
    NSString* str = @"";
    
    NSString* tempStr;
    
    tempStr = [[sampObjects objectAtIndex:0] getFileId];
    str = [str stringByAppendingString:[NSString stringWithFormat:@"%@",tempStr]];
    
    tempStr = [[sampObjects objectAtIndex:1] getFileId];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%@",tempStr]];
    
    tempStr = [[sampObjects objectAtIndex:2] getFileId];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%@",tempStr]];
    
    tempStr = [[sampObjects objectAtIndex:3] getFileId];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%@",tempStr]];
   
    tempStr = [[sampObjects objectAtIndex:4] getFileId];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%@",tempStr]];
    
    tempStr = [[sampObjects objectAtIndex:5] getFileId];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%@",tempStr]];
    
    tempStr = [[sampObjects objectAtIndex:6] getFileId];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%@",tempStr]];
    
    tempStr = [[sampObjects objectAtIndex:7] getFileId];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%@",tempStr]];
    
    tempStr = [[sampObjects objectAtIndex:8] getFileId];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%@",tempStr]];

    
    float tempVal;
    
    tempVal = [mixerBus0LevelFader value];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%f",tempVal]];
    
    tempVal = [mixerBus1LevelFader value];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%f",tempVal]];
    
    tempVal = [mixerBus2LevelFader value];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%f",tempVal]];
    
    tempVal = [mixerBus3LevelFader value];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%f",tempVal]];
    
    tempVal = [mixerBus4LevelFader value];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%f",tempVal]];
    
    tempVal = [mixerBus5LevelFader value];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%f",tempVal]];
    
    tempVal = [mixerBus6LevelFader value];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%f",tempVal]];
    
    tempVal = [mixerBus7LevelFader value];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%f",tempVal]];
    
    tempVal = [mixerBus8LevelFader value];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%f",tempVal]];
    
    tempVal = [mixerOutputLevelFader value];
    str = [str stringByAppendingString:[NSString stringWithFormat:@",%f",tempVal]];
    
    return str;
}

-(void) loadPreset:(NSString*)inFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *docPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",inFile]];
    NSString *dataFile = [NSString stringWithContentsOfFile:docPath encoding:NSUTF8StringEncoding error:NULL];

    NSLog(@"Loading: %@",docPath);
    NSLog(@"Data: %@",dataFile);
    
    NSArray* comps = [dataFile componentsSeparatedByString:@","];
    
    [((SamplePlayer*)[sampObjects objectAtIndex:0]) initializeTrackWithSound:(NSString*)[comps objectAtIndex:0]];
    [button0 setTitle:[comps objectAtIndex:0] forState:UIControlStateNormal];
    
    [((SamplePlayer*)[sampObjects objectAtIndex:1]) initializeTrackWithSound:(NSString*)[comps objectAtIndex:1]];
     [button1 setTitle:[comps objectAtIndex:1] forState:UIControlStateNormal];
    
    [((SamplePlayer*)[sampObjects objectAtIndex:2]) initializeTrackWithSound:(NSString*)[comps objectAtIndex:2]];
     [button2 setTitle:[comps objectAtIndex:2] forState:UIControlStateNormal];
    
    [((SamplePlayer*)[sampObjects objectAtIndex:3]) initializeTrackWithSound:(NSString*)[comps objectAtIndex:3]];
     [button3 setTitle:[comps objectAtIndex:3] forState:UIControlStateNormal];
    
    [((SamplePlayer*)[sampObjects objectAtIndex:4]) initializeTrackWithSound:(NSString*)[comps objectAtIndex:4]];
    [button4 setTitle:[comps objectAtIndex:4] forState:UIControlStateNormal];
    
    [((SamplePlayer*)[sampObjects objectAtIndex:5]) initializeTrackWithSound:(NSString*)[comps objectAtIndex:5]];
    [button5 setTitle:[comps objectAtIndex:5] forState:UIControlStateNormal];
    
    [((SamplePlayer*)[sampObjects objectAtIndex:6]) initializeTrackWithSound:(NSString*)[comps objectAtIndex:6]];
    [button6 setTitle:[comps objectAtIndex:6] forState:UIControlStateNormal];
    
    [((SamplePlayer*)[sampObjects objectAtIndex:7]) initializeTrackWithSound:(NSString*)[comps objectAtIndex:7]];
    [button7 setTitle:[comps objectAtIndex:7] forState:UIControlStateNormal];
    
    [((SamplePlayer*)[sampObjects objectAtIndex:8]) initializeTrackWithSound:(NSString*)[comps objectAtIndex:8]];
    [button8 setTitle:[comps objectAtIndex:8] forState:UIControlStateNormal];
    
    
   
    [mixerBus0LevelFader setValue:[[comps objectAtIndex:9] floatValue]];
    [mixerBus1LevelFader setValue:[[comps objectAtIndex:10] floatValue]];
    [mixerBus2LevelFader setValue:[[comps objectAtIndex:11] floatValue]];
    [mixerBus3LevelFader setValue:[[comps objectAtIndex:12] floatValue]];
    [mixerBus4LevelFader setValue:[[comps objectAtIndex:13] floatValue]];
    [mixerBus5LevelFader setValue:[[comps objectAtIndex:14] floatValue]];
    [mixerBus6LevelFader setValue:[[comps objectAtIndex:15] floatValue]];
    [mixerBus7LevelFader setValue:[[comps objectAtIndex:16] floatValue]];
    [mixerBus8LevelFader setValue:[[comps objectAtIndex:17] floatValue]];
    
    [self setMixerToFaders];
    
    
   [mixerOutputLevelFader setValue:[[comps objectAtIndex:18] floatValue]];
    
    
}

- (IBAction) savePresetPressed:(UIButton*)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Preset" message:@"Are you sure you want to save this.  This action cannot be undone" delegate:self cancelButtonTitle:@"Save" otherButtonTitles:@"Cancel", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        NSString* tempString = [self createSaveFileString];
        [self savePreset:@"savedData" withData:tempString];
    }
}


- (IBAction) loadPresetPressed:(UIButton*)sender
{
    [self loadPreset:@"savedData"];
}


- (void) alterButtonSize:(int)size
{
    
    int newHeight = button0.frame.size.height + size;
    int newWidth = button0.frame.size.width + size;
    int editWidth = editButton0.frame.size.width;
    int editHeight = editButton0.frame.size.height;
    [button0 setFrame:CGRectMake(button0.frame.origin.x, button0.frame.origin.y, newWidth, newHeight)];
    [button1 setFrame:CGRectMake(button1.frame.origin.x, button1.frame.origin.y, newWidth, newHeight)];
    [button2 setFrame:CGRectMake(button2.frame.origin.x, button2.frame.origin.y, newWidth, newHeight)];
    [button3 setFrame:CGRectMake(button3.frame.origin.x, button3.frame.origin.y, newWidth, newHeight)];
    [button4 setFrame:CGRectMake(button4.frame.origin.x, button4.frame.origin.y, newWidth, newHeight)];
    [button5 setFrame:CGRectMake(button5.frame.origin.x, button5.frame.origin.y, newWidth, newHeight)];
    [button6 setFrame:CGRectMake(button6.frame.origin.x, button6.frame.origin.y, newWidth, newHeight)];
    [button7 setFrame:CGRectMake(button7.frame.origin.x, button7.frame.origin.y, newWidth, newHeight)];
    [button8 setFrame:CGRectMake(button8.frame.origin.x, button8.frame.origin.y, newWidth, newHeight)];
    
    [editButton0 setFrame:CGRectMake(editButton0.frame.origin.x + size, editButton0.frame.origin.y, editWidth, editHeight)];
    [editButton1 setFrame:CGRectMake(editButton1.frame.origin.x + size, editButton1.frame.origin.y, editWidth, editHeight)];
    [editButton2 setFrame:CGRectMake(editButton2.frame.origin.x + size, editButton2.frame.origin.y, editWidth, editHeight)];
    [editButton3 setFrame:CGRectMake(editButton3.frame.origin.x + size, editButton3.frame.origin.y, editWidth, editHeight)];
    [editButton4 setFrame:CGRectMake(editButton4.frame.origin.x + size, editButton4.frame.origin.y, editWidth, editHeight)];
    [editButton5 setFrame:CGRectMake(editButton5.frame.origin.x + size, editButton5.frame.origin.y, editWidth, editHeight)];
    [editButton6 setFrame:CGRectMake(editButton6.frame.origin.x + size, editButton6.frame.origin.y, editWidth, editHeight)];
    [editButton7 setFrame:CGRectMake(editButton7.frame.origin.x + size, editButton7.frame.origin.y, editWidth, editHeight)];
    [editButton8 setFrame:CGRectMake(editButton8.frame.origin.x + size, editButton8.frame.origin.y, editWidth, editHeight)];
    
    
    
}



-(IBAction)fadersToggle:(UISwitch*)sender
{
    BOOL on = sender.isOn;
    
    float alphaJawn = 0;
    float frameChange = 60;
    if(on)
    {
        alphaJawn = 1;
        frameChange = -60;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        [self alterButtonSize:frameChange];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        [UIView setAnimationDelay:.25];
        [mixerBus0LevelFader setAlpha:alphaJawn];
        [mixerBus1LevelFader setAlpha:alphaJawn];
        [mixerBus2LevelFader setAlpha:alphaJawn];
        [mixerBus3LevelFader setAlpha:alphaJawn];
        [mixerBus4LevelFader setAlpha:alphaJawn];
        [mixerBus5LevelFader setAlpha:alphaJawn];
        [mixerBus6LevelFader setAlpha:alphaJawn];
        [mixerBus7LevelFader setAlpha:alphaJawn];
        [mixerBus8LevelFader setAlpha:alphaJawn];
        [UIView commitAnimations];
        
        

    }
    else{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        [mixerBus0LevelFader setAlpha:alphaJawn];
        [mixerBus1LevelFader setAlpha:alphaJawn];
        [mixerBus2LevelFader setAlpha:alphaJawn];
        [mixerBus3LevelFader setAlpha:alphaJawn];
        [mixerBus4LevelFader setAlpha:alphaJawn];
        [mixerBus5LevelFader setAlpha:alphaJawn];
        [mixerBus6LevelFader setAlpha:alphaJawn];
        [mixerBus7LevelFader setAlpha:alphaJawn];
        [mixerBus8LevelFader setAlpha:alphaJawn];
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        [UIView setAnimationDelay:.25];
        [self alterButtonSize:frameChange];
        [UIView commitAnimations];

    }

    
}

@end
