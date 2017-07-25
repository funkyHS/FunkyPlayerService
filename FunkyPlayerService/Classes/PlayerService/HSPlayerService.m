//
//  HSPlayerService.m
//  FunkyPlayerService
//
//  Created by 胡晟 on 2017/6/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import "HSPlayerService.h"

@interface HSPlayerService ()
{
    BOOL _isRemoteURL;
}



@end

@implementation HSPlayerService

static HSPlayerService *_shareInstance;
+ (instancetype)shareInstance {
    
    if(_shareInstance == nil) {
        _shareInstance = [[HSPlayerService alloc] init];
    }
    return _shareInstance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [super allocWithZone:zone];
    });
    
    return _shareInstance;
    
}

- (void)playWithURL:(NSURL *)url isCache:(BOOL)isCache withStateBlock: (void(^)(HSPlayerState state))stateBlock {
    
    _currentPlayURL = url;
    // 远程地址
    if ([url.absoluteString.uppercaseString containsString:@"HTTP"]) {
        _isRemoteURL = YES;
        if ([self.localAudioTool isPlaying]) {
            [self.localAudioTool pause];
        }
        
        [self.remoteAudioTool playWithURL:url isCache:isCache stateBlock:^(HSPlayerState state) {
            if (stateBlock) {
                stateBlock(self.state);
            }
        }];
        
    }else {
        
        // 本地地址
        _isRemoteURL = NO;
        // 注意: 暂停远程, 会造成回调延迟, 导致block调用先本地开始, 远程暂停
        if (self.remoteAudioTool.state == HSPlayerStatePlaying || self.remoteAudioTool.state == HSPlayerStateLoading) {
            [self.remoteAudioTool pause];
        }
        
        [self.localAudioTool playWithPathURL:url stateBlock:^(BOOL isPlaying) {
            if (stateBlock) {
                stateBlock(self.state);
            }
        }];
    }
    
}

- (void)playWithURL:(NSURL *)url withStateBlock: (void(^)(HSPlayerState state))stateBlock {
    
    [self playWithURL:url isCache:YES withStateBlock:^(HSPlayerState state) {
        if (stateBlock) {
            stateBlock(state);
        }
    }];
}


// 播放
- (void)playCurrentAudio {
    _isRemoteURL ? [self.remoteAudioTool resume] : [self.localAudioTool resume];
    
}

// 暂停
- (void)pauseCurrentAudio {
    _isRemoteURL ? [self.remoteAudioTool pause] : [self.localAudioTool pause];
}

// 总时间
-(NSTimeInterval)totalTime {
    
    return _isRemoteURL ? self.remoteAudioTool.totalTime : self.localAudioTool.totalTime;
    
}
- (NSString *)totalTimeFormat {
    return [NSString stringWithFormat:@"%02zd:%02zd", (int)self.totalTime / 60, (int)self.totalTime % 60];
}

// 当前播放时间
- (NSTimeInterval)currentTime {
    
    return _isRemoteURL ? self.remoteAudioTool.currentTime : self.localAudioTool.currentTime;
    
}
- (NSString *)currentTimeFormat {
    return [NSString stringWithFormat:@"%02zd:%02zd", (int)self.currentTime / 60, (int)self.currentTime % 60];
}


// 快进/快退 timeDiffer 秒 为负值时快退
- (void)seekWithTimeDiffer:(NSTimeInterval)timeDiffer {
    
    _isRemoteURL ? [self.remoteAudioTool seekWithTimeDiffer:timeDiffer] : [self.localAudioTool seekWithTimeDiffer:timeDiffer];
}

// 倍速
- (void)setRate:(float)rate {
    
    if(_isRemoteURL) {
        self.remoteAudioTool.rate = rate;
    }else {
        self.localAudioTool.rate = rate;
    }
}
- (float)rate {
    return _isRemoteURL ? self.remoteAudioTool.rate : self.localAudioTool.rate;
}

// 音量
- (void)setVolume:(float)volume {
    
    if(_isRemoteURL) {
        self.remoteAudioTool.volume = volume;
    }else {
        self.localAudioTool.volume = volume;
    }
}
- (float)volume {
    return _isRemoteURL ? self.remoteAudioTool.volume : self.localAudioTool.volume;
}

-(void)setProgress:(float)progress {
    if (_isRemoteURL) {
        self.remoteAudioTool.progress = progress;
    }else {
        self.localAudioTool.progress = progress;
    }
}
// 播放进度
- (float)progress {
    if (self.totalTime == 0) {
        return 0;
    }
    return self.currentTime / self.totalTime;
}

- (float)loadDataProgress {
    return _isRemoteURL ? self.remoteAudioTool.loadDataProgress : 0;
}

-(HSPlayerState)state {
    
    if (_isRemoteURL) {
        return [self.remoteAudioTool state];
    }else {
        BOOL isPlaying = [self.localAudioTool isPlaying];
        if (isPlaying) {
            return HSPlayerStatePlaying;
        }else {
            return HSPlayerStatePause;
        }
    }
    
}

#pragma mark - 懒加载
- (HSLocalPlayer *)localAudioTool {
    if (!_localAudioTool) {
        _localAudioTool = [[HSLocalPlayer alloc] init];
    }
    return _localAudioTool;
}

- (HSRemotePlayer *)remoteAudioTool {
    if (!_remoteAudioTool) {
        _remoteAudioTool = [[HSRemotePlayer alloc] init];
    }
    return _remoteAudioTool;
}


@end
