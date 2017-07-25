//
//  HSLocalPlayer.h
//  FunkyPlayerService
//
//  Created by 胡晟 on 2017/6/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define kLocalPlayerURLOrStateChangeNotification @"localPlayerURLOrStateChangeNotification"


@interface HSLocalPlayer : NSObject


- (void)playWithPathURL:(NSURL *)filePath stateBlock:(void(^)(BOOL isPlaying))stateBlock;


// 暂停
- (void)pause;

// 继续
- (void)resume;

// 快进/快退 timeDiffer 秒 为负值时快退
- (void)seekWithTimeDiffer:(NSTimeInterval)timeDiffer;


#pragma mark - 数据提供


// 声音大小
@property (nonatomic, assign) float volume;

// 倍速
@property (nonatomic, assign) float rate;

//播放进度
@property (nonatomic, assign) float progress;

//总时长
@property (nonatomic, assign, readonly) NSTimeInterval totalTime;
@property (nonatomic, copy, readonly) NSString *totalTimeFormat;

//播放时长
@property (nonatomic, assign, readonly) NSTimeInterval currentTime;
@property (nonatomic, copy, readonly) NSString *currentTimeFormat;

@property (nonatomic, assign, readonly) BOOL isPlaying;

@end
