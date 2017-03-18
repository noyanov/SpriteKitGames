//
//  ANMyScene.h
//  PingPongSpriteKit
//

//  Copyright (c) 2016 Alex Noyanov. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ANMyScene : SKScene {
    double _vx, _vy;
    double _VX0, _VY0;
    int _scoreLeft, _scoreRight;
//    CGPoint _targetLocation;
}

@property (nonatomic, strong) SKLabelNode* labelScore;
@property (nonatomic, strong) SKSpriteNode* spriteBall;
@property (nonatomic, strong) SKSpriteNode* spriteRightRacket;
@property (nonatomic, strong) SKSpriteNode* spriteLeftRacket;

@end
