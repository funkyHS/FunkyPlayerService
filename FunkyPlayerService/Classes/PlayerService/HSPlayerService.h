//
//  HSPlayerService.h
//  FunkyPlayerService
//
//  Created by 胡晟 on 2017/6/28.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSRemotePlayer.h"
#import "HSLocalPlayer.h"



@interface HSPlayerService : NSObject

// 本地播放器
@property (nonatomic, strong) HSLocalPlayer *localAudioTool;

// 远程播放器
@property (nonatomic, strong) HSRemotePlayer *remoteAudioTool;

// 本地或远程的播放状态
@property (nonatomic, assign) HSPlayerState state;

// 当前资源url
@property (nonatomic, copy, readonly) NSURL *currentPlayURL;

// 总时长
@property (nonatomic, assign, readonly) NSTimeInterval totalTime;
@property (nonatomic, copy, readonly) NSString *totalTimeFormat;

// 播放时长
@property (nonatomic, assign, readonly) NSTimeInterval currentTime;
@property (nonatomic, copy, readonly) NSString *currentTimeFormat;


// 声音大小
@property (nonatomic, assign) float volume;

// 倍速
@property (nonatomic, assign) float rate;

//播放进度
@property (nonatomic, assign) float progress;

// 远程资源缓存进度
@property (nonatomic, assign, readonly) float loadDataProgress;



+ (instancetype)shareInstance;

/**
 传入音频资源url，会判断是远程还是本地资源

 @param url 音频资源url
 @param isCache 是远程资源文件，并且请求到了完整的资源路径，YES缓存到本地，NO不缓存
 @param stateBlock 本地或远程的播放状态
 */
- (void)playWithURL:(NSURL *)url isCache:(BOOL)isCache withStateBlock: (void(^)(HSPlayerState state))stateBlock;

// 如果是远程资源文件，并且请求到了完整的资源路径 默认缓存到本地
- (void)playWithURL:(NSURL *)url withStateBlock: (void(^)(HSPlayerState state))stateBlock;

// 播放
- (void)playCurrentAudio;

// 暂停
- (void)pauseCurrentAudio;

// 快进/快退 timeDiffer 秒 为负值时快退
- (void)seekWithTimeDiffer:(NSTimeInterval)timeDiffer;


@end
