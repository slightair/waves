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
CGFloat const WVWaveFrequencyMax = 2.0;
CGFloat const WVWaveFrequencyMin = 0.2;

@interface WVWave ()

@property (nonatomic, assign) CGFloat *values;
@property (nonatomic, assign) NSUInteger counter;
@property (nonatomic, strong) NSTimer *timer;

- (void)tick;

@end

@implementation WVWave

- (id)init
{
    self = [super init];
    if (self) {
        self.values = calloc(WVWaveNumberOfWaveSplit, sizeof(CGFloat));
        self.counter = 0;
        self.frequency = 1.0;
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
    NSLog(@"freq: %f", self.frequency);
    CGFloat value = sin(self.frequency * 2 * M_PI / WVWaveNumberOfWaveSplit * self.counter) * self.scale;

    for (int i=0; i < WVWaveNumberOfWaveSplit - 1; i++) {
        self.values[i] = self.values[i + 1];
    }
    self.values[WVWaveNumberOfWaveSplit - 1] = value;
    self.counter++;
}

- (void)setFrequency:(CGFloat)frequency
{
    frequency = MAX(frequency, WVWaveFrequencyMin);
    frequency = MIN(frequency, WVWaveFrequencyMax);

    _frequency = frequency;
}

@end
