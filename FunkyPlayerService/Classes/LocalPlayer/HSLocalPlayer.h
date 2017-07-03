//
//  HSLocalPlayer.h
//  FunkyPlayerService
//
//  Created by 胡晟 on 2017/6/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface HSLocalPlayer : NSObject


- (void)playWithPathURL:(NSURL *)filePath stateBlock:(void(^)(BOOL isPlaying))stateBlock;


// 暂停
- (void)pause;

// 继续
- (void)resume;

// 快进/快退 timeDiffer 秒 为负值时快退
- (void)seekWithTimeDiffer:(NSTimeInterval)timeDiffer;

// 拖动进度条的进度
- (void)seekWithProgress:(float)progress;


#pragma mark - 数据提供

@property (nonatomic, assign, readonly) BOOL isPlaying;

// 声音大小
@property (nonatomic, assign) float volume;

// 倍速
@property (nonatomic, assign) float rate;

//总时长
@property (nonatomic, assign, readonly) NSTimeInterval totalTime;
@property (nonatomic, copy, readonly) NSString *totalTimeFormat;

//播放时长
@property (nonatomic, assign, readonly) NSTimeInterval currentTime;
@property (nonatomic, copy, readonly) NSString *currentTimeFormat;

//播放进度
@property (nonatomic, assign, readonly) float progress;

@end
