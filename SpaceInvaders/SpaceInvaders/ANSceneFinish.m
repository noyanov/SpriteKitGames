//
//  ANSceneFinish.m
//  SpaceInvaders
//
//  Created by Alex Noyanov on 9/18/16.
//  Copyright (c) 2016 Alex Noyanov. All rights reserved.
//

#import "ANSceneFinish.h"

@implementation ANSceneFinish

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        SKLabelNode *titleLabel1 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        titleLabel1.name = @"titleLabel1";
        titleLabel1.text = @"Game";
        titleLabel1.fontSize = 45;
        titleLabel1.position = CGPointMake(CGRectGetMidX(self.frame),
                                          CGRectGetMidY(self.frame) - titleLabel1.fontSize);
        SKAction* action1 = [SKAction scaleBy:2 duration:1];
        SKAction* action2 = [SKAction scaleBy:0.7 duration:1];
        SKAction* action3 = [SKAction fadeOutWithDuration:1];
        SKAction* action4 = [SKAction removeFromParent];
        SKAction* action = [SKAction sequence:@[action1, action2, action3, action4]];
        [titleLabel1 runAction:action];
        [self addChild:titleLabel1];
        SKLabelNode *titleLabel2 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        titleLabel2.name = @"titleLabel1";
        titleLabel2.text = @"Over";
        titleLabel2.fontSize = 45;
        titleLabel2.position = CGPointMake(CGRectGetMidX(self.frame),
                                           CGRectGetMidY(self.frame) + titleLabel1.fontSize);
        [titleLabel2 runAction:action];
        [self addChild:titleLabel2];
    }
    return self;
}

@end
