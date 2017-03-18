//
//  GameScene.h
//  Arkanoid
//
//  Created by Yuriy Noyanov on 19/09/16.
//  Copyright © 2016 Yuriy Noyanov. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

@interface GameScene : SKScene

@property (nonatomic) NSMutableArray<GKEntity *> *entities;
@property (nonatomic) NSMutableDictionary<NSString*, GKGraph *> *graphs;

@end
