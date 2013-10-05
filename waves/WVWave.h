//
//  WVWave.h
//  waves
//
//  Created by slightair on 2013/10/05.
//  Copyright (c) 2013年 slightair. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSUInteger const WVWaveNumberOfWaveSplit;

@interface WVWave : NSObject

- (CGFloat *)sequence;
- (void)start;
- (void)stop;

@property (nonatomic, assign) CGFloat scale;

@end
