//
//  ANMyScene.h
//  SpaceInvaders
//

//  Copyright (c) 2016 Alex Noyanov. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ANMyScene : SKScene <SKPhysicsContactDelegate> {
    double _alienDX;
    double _alienShipDX;
    int _step;
}


// SKPhysicsContactDelegate
- (void)didBeginContact:(SKPhysicsContact *)contact;

@end
