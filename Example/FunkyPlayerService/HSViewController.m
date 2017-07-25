//
//  HSViewController.m
//  FunkyRemotePlayer
//
//  Created by funkyHS on 06/23/2017.
//  Copyright (c) 2017 funkyHS. All rights reserved.
//

#import "HSViewController.h"
#import "HSPlayerService.h"


@interface HSViewController ()

@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

@property (weak, nonatomic) IBOutlet UIProgressView *loadPV;

@property (nonatomic, weak) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UISlider *playSlider;

@property (weak, nonatomic) IBOutlet UIButton *mutedBtn;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;



@end

@implementation HSViewController

- (NSTimer *)timer {
    if (!_timer) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(update) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _timer = timer;
    }
    return _timer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self timer];
}


- (void)update {
    
    self.playTimeLabel.text =  [HSPlayerService shareInstance].currentTimeFormat;
    
    self.totalTimeLabel.text = [HSPlayerService shareInstance].totalTimeFormat;
    
    self.playSlider.value = [HSPlayerService shareInstance].progress;
    
    self.volumeSlider.value = [HSPlayerService shareInstance].volume;
    
    self.loadPV.progress = [HSPlayerService shareInstance].loadDataProgress;
    
    self.mutedBtn.selected = [HSPlayerService shareInstance].remoteAudioTool.muted;
    
    
}


- (IBAction)play:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://audio.xmcdn.com/group23/M04/63/C5/wKgJNFg2qdLCziiYAGQxcTOSBEw402.m4a"];
    [[HSPlayerService shareInstance] playWithURL:url isCache:YES withStateBlock:^(HSPlayerState state) {
        NSLog(@"========= %ld",(long)state);
    }];
    
}
- (IBAction)pause:(id)sender {
    [[HSPlayerService shareInstance] pauseCurrentAudio];
}

- (IBAction)resume:(id)sender {
    [[HSPlayerService shareInstance] playCurrentAudio];
}
- (IBAction)kuaijin:(id)sender {
    [[HSPlayerService shareInstance] seekWithTimeDiffer:-15];
}
- (IBAction)progress:(UISlider *)sender {
    [HSPlayerService shareInstance].progress = sender.value;
}
- (IBAction)rate:(id)sender {
    [[HSPlayerService shareInstance] setRate:2];
}
- (IBAction)muted:(UIButton *)sender {
    sender.selected = !sender.selected;
    [[HSPlayerService shareInstance].remoteAudioTool setMuted:sender.selected];
}
- (IBAction)volume:(UISlider *)sender {
    [[HSPlayerService shareInstance] setVolume:sender.value];
}


@end
