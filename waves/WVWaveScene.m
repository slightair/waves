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
@property (nonatomic, strong) SKLabelNode *statusLabel;
@property (nonatomic, assign) CGPoint prevTouchLocation;

@end

@implementation WVWaveScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];

        self.wave = [WVWave new];
        self.wave.scale = self.frame.size.height / 2 * 0.8;
        self.wave.frequency = 0.1;
        [self.wave start];

        self.waveNode = [SKShapeNode new];
        self.waveNode.lineWidth = 0.5;

        [self addChild:self.waveNode];

        self.statusLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.statusLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        self.statusLabel.fontSize = 16;
        self.statusLabel.position = CGPointMake(20, 20);
        [self addChild:self.statusLabel];
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

- (void)update:(NSTimeInterval)currentTime
{
    CGMutablePathRef path = CGPathCreateMutable();
    [self configurePath:path withWave:self.wave];
    self.waveNode.path = path;
    CGPathRelease(path);

    self.statusLabel.text = [NSString stringWithFormat:@"freq: %.3f, rad: %.3f", self.wave.frequency, self.wave.radian];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.prevTouchLocation = [[touches anyObject] locationInNode:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[touches anyObject] locationInNode:self];
    CGFloat distanceX = location.x - self.prevTouchLocation.x;
    self.prevTouchLocation = location;

    self.wave.frequency += distanceX / 60;
}

@end
