//
//  URAMyScene.h
//  Space Game
//

//  Copyright (c) 2017 Popoff Developer Studio. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface URAMyScene : SKScene
{
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _dt;
    CGPoint _velocity;
}

@property SKNode* node;

@end
