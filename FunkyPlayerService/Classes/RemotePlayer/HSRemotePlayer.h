//
//  HSRemotePlayer.h
//  FunkyRemotePlayer
//
//  Created by 胡晟 on 2017/6/23.
//  Copyright © 2017年 funkyHS. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kRemotePlayerURLOrStateChangeNotification @"remotePlayerURLOrStateChangeNotification"


/**
 * 播放器的状态
 * 因为UI界面需要加载状态显示, 所以需要提供加载状态
 - HSPlayerStateUnknown: 未知(比如都没有开始播放音乐)
 - HSPlayerStateLoading: 正在加载()
 - HSPlayerStatePlaying: 正在播放
 - HSPlayerStateStopped: 停止
 - HSPlayerStatePause:   暂停
 - HSPlayerStateFailed:  失败(比如没有网络缓存失败, 地址找不到)
 */
typedef NS_ENUM(NSInteger, HSPlayerState) {
    HSPlayerStateUnknown = 0,
    HSPlayerStateLoading   = 1,
    HSPlayerStatePlaying   = 2,
    HSPlayerStateStopped   = 3,
    HSPlayerStatePause     = 4,
    HSPlayerStateFailed    = 5
};


//// 资源总时间，当前时间
//typedef void(^HSRemotePlayerResourceInfoBlock)(NSString *totalTimeFormat,NSString *currentTimeFormat);
//
//// 播放进度，加载进度
//typedef void(^HSRemotePlayerProgressBlockType)(float progress,float loadDataProgress);


@interface HSRemotePlayer : NSObject

+ (instancetype)shareInstance;


// 可以 实时监测状态的变更
- (void)playWithURL:(NSURL *)url isCache:(BOOL)isCache stateBlock:(void(^)(HSPlayerState state))stateChange;


// 根据url播放远程地址  isCache 控制是否需要缓存
- (void)playWithURL:(NSURL *)url isCache:(BOOL)isCache;

// 暂停
- (void)pause;

// 继续
- (void)resume;

// 停止
- (void)stop;

// 快进/快退 timeDiffer 秒 为负值时快退
- (void)seekWithTimeDiffer:(NSTimeInterval)timeDiffer;


#pragma mark - 数据提供

// 设置静音
@property (nonatomic, assign) BOOL muted;

// 声音大小
@property (nonatomic, assign) float volume;

// 倍速
@property (nonatomic, assign) float rate;

// 播放进度
@property (nonatomic, assign) float progress;

// 总时长
@property (nonatomic, assign, readonly) NSTimeInterval totalTime;
@property (nonatomic, copy, readonly) NSString *totalTimeFormat;

// 播放时长
@property (nonatomic, assign, readonly) NSTimeInterval currentTime;
@property (nonatomic, copy, readonly) NSString *currentTimeFormat;

// 资源url
@property (nonatomic, strong, readonly) NSURL *url;

// 缓存进度
@property (nonatomic, assign, readonly) float loadDataProgress;

// 音频当前播放状态
@property (nonatomic, assign, readonly) HSPlayerState state;

// 实时监听状态的改变
@property (nonatomic, copy) void(^stateChange)(HSPlayerState state);

// 监听音频播放完成
@property (nonatomic, copy) void(^playEndBlock)();


@end
