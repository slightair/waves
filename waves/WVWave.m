//
//  WVWave.m
//  waves
//
//  Created by slightair on 2013/10/05.
//  Copyright (c) 2013年 slightair. All rights reserved.
//

#import "WVWave.h"

NSUInteger const WVWaveNumberOfWaveSplit = 128;
NSTimeInterval const WVWaveTickInterval = (1.0 / WVWaveNumberOfWaveSplit);

@interface WVWave ()

@property (nonatomic, assign) CGFloat *values;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSTimer *timer;

- (void)tick;

@end

@implementation WVWave

- (id)init
{
    self = [super init];
    if (self) {
        self.values = calloc(WVWaveNumberOfWaveSplit, sizeof(CGFloat));
        self.index = 0;
    }
    return self;
}

- (CGFloat *)sequence
{
    return self.values;
}

- (void)start
{
    if (self.timer) {
        return;
    }

    self.timer = [NSTimer scheduledTimerWithTimeInterval:WVWaveTickInterval
                                                  target:self
                                                selector:@selector(tick)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stop
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)tick
{
    CGFloat value = sin(2 * M_PI / WVWaveNumberOfWaveSplit * self.index) * self.scale;

    for (int i=0; i < WVWaveNumberOfWaveSplit - 1; i++) {
        self.values[i] = self.values[i + 1];
    }
    self.values[WVWaveNumberOfWaveSplit - 1] = value;
    self.index = (self.index + 1) % WVWaveNumberOfWaveSplit;
}

@end
