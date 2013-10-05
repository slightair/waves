//
//  WVWaveScene.m
//  waves
//
//  Created by slightair on 2013/10/03.
//  Copyright (c) 2013年 slightair. All rights reserved.
//

#import "WVWaveScene.h"
#import "WVWave.h"

@interface WVWaveScene ()

-(void)configurePath:(CGMutablePathRef)path withWave:(WVWave *)wave;

@property (nonatomic, strong) WVWave *wave;
@property (nonatomic, strong) SKShapeNode *waveNode;

@end

@implementation WVWaveScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];

        self.wave = [WVWave new];
        self.wave.scale = self.frame.size.height / 2 * 0.8;
        [self.wave start];

        self.waveNode = [SKShapeNode new];
        self.waveNode.lineWidth = 0.5;

        [self addChild:self.waveNode];
    }
    return self;
}

-(void)configurePath:(CGMutablePathRef)path withWave:(WVWave *)wave;
{
    CGFloat *sequence = [wave sequence];
    CGFloat distance = self.frame.size.width / (WVWaveNumberOfWaveSplit - 1);
    CGFloat centerY = CGRectGetMidY(self.frame);

    CGPathMoveToPoint(path, NULL, 0, centerY + sequence[0]);
    for (NSInteger i = 1; i < WVWaveNumberOfWaveSplit; i++) {
        CGPathAddLineToPoint(path, NULL, distance * i, centerY + sequence[i]);
    }
}

- (void)didSimulatePhysics
{
    [super didSimulatePhysics];

    CGMutablePathRef path = CGPathCreateMutable();
    [self configurePath:path withWave:self.wave];
    self.waveNode.path = path;
    CGPathRelease(path);
}

@end
