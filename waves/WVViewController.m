//
//  WVViewController.m
//  waves
//
//  Created by slightair on 2013/10/03.
//  Copyright (c) 2013年 slightair. All rights reserved.
//

#import "WVViewController.h"
#import "WVWaveScene.h"

@implementation WVViewController

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    // Configure the view.
    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;

    // Create and configure the scene.
    SKScene * scene = [WVWaveScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;

    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
