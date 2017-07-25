//
//  HSLocalPlayer.m
//  FunkyPlayerService
//
//  Created by 胡晟 on 2017/6/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import "HSLocalPlayer.h"

@interface HSLocalPlayer()

/** 音乐播放器 */
@property (nonatomic ,strong) AVAudioPlayer  *player;
@property (nonatomic, copy) void(^stateBlock)(BOOL isPlaying);

@end


@implementation HSLocalPlayer

- (void)playWithPathURL:(NSURL *)filePath stateBlock:(void(^)(BOOL isPlaying))stateBlock {
    
    self.stateBlock = stateBlock;
    if ([filePath isEqual:self.player.url]) {
        [self play];
        return;
    }
    
    [self setBackPlay];

    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:filePath error:nil];
    self.player.enableRate = YES;
    self.player.volume=1.0;
    [self.player prepareToPlay];
    [self play];

}

- (void)setBackPlay {
    // 1. 获取音频回话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 2. 设置音频回话类别
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // 3. 激活音频回话
    [session setActive:YES error:nil];
    
}

- (void)play {
    [self.player play];
    if (self.stateBlock) {
        self.stateBlock(self.player.isPlaying);
    }
    
    if (self.player.url) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocalPlayerURLOrStateChangeNotification object:nil userInfo:@{
                                                                                                                                  @"playURL": self.player.url,                                                                  @"playState": @(self.player.isPlaying)
                                                                                                                                  }];
    }
}
// 暂停
- (void)pause {
    [self.player pause];
    if (self.stateBlock) {
        self.stateBlock(self.player.isPlaying);
    }
    
    
    if (self.player.url) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocalPlayerURLOrStateChangeNotification object:nil userInfo:@{
                                                                                                                                  @"playURL": self.player.url,                                                                  @"playState": @(self.player.isPlaying)
                                                                                                                                  }];
    }
}

// 继续
- (void)resume {
    [self.player play];
    if (self.stateBlock) {
        self.stateBlock(self.player.isPlaying);
    }
}

- (NSString *)currentTimeFormat {
    return [NSString stringWithFormat:@"%02zd:%02zd", (int)self.currentTime / 60, (int)self.currentTime % 60];
}

- (NSString *)totalTimeFormat {
    return [NSString stringWithFormat:@"%02zd:%02zd", (int)self.totalTime / 60, (int)self.totalTime % 60];
}

// 总时间
-(NSTimeInterval)totalTime {
    NSTimeInterval totalTimeSec = self.player.duration;
    if (isnan(totalTimeSec)) {
        return 0;
    }
    return totalTimeSec;
}

// 当前播放时间
- (NSTimeInterval)currentTime {
    NSTimeInterval playTimeSec = self.player.currentTime;
    if (isnan(playTimeSec)) {
        return 0;
    }
    return playTimeSec;
}

// 快进/快退 timeDiffer 秒 为负值时快退
- (void)seekWithTimeDiffer:(NSTimeInterval)timeDiffer {
    
    self.player.currentTime += timeDiffer;
}

// 拖动进度条的进度
-(void)setProgress:(float)progress {
    if (progress < 0 || progress > 1) {
        return;
    }
    
    self.player.currentTime = self.totalTime * progress;
}
-(float)progress {
    if (self.totalTime == 0) {
        return 0;
    }
    return self.currentTime / self.totalTime;
}

// 倍速
- (void)setRate:(float)rate {
    [self.player setRate:rate];
}
- (float)rate {
    return self.player.rate;
}


// 音量
- (void)setVolume:(float)volume {
    
    if (volume < 0 || volume > 1) {
        return;
    }
    
    self.player.volume = volume;
}
- (float)volume {
    return self.player.volume;
}


- (BOOL)isPlaying {
    return self.player.isPlaying;
}



@end
