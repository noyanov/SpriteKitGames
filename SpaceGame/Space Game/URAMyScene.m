//
//  URAMyScene.m
//  Space Game
//
//  Created by Alex Noyanov on 1/5/17.
//  Copyright (c) 2017 Popoff Developer Studio. All rights reserved.
//

#import "URAMyScene.h"

@implementation URAMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        // Background image:
//        SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"stars.jpg"];
//        bgImage.position =CGPointMake(CGRectGetMidX(self.frame),
//                                      CGRectGetMidY(self.frame));
//        bgImage.xScale = 0.4;     // Scale X
//        bgImage.yScale = 0.4;     // Scale Y
        
        for (int i=0; i<2; i++)
        {
            SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"stars.jpg"];
            //background.position = CGPointMake(self.size.width/2, self.size.height/2);
            background.position = CGPointMake((i*background.size.width)+background.size.width/2, background.size.height/2);
            //background.position = CGPointZero; //In a Mac machine makes the center of the image positioned at lower left corner. Untill and unless specified this is the default position
            background.name =@"background";
            
           // background.xScale = 0.4;     // Scale X
           // background.yScale = 0.4;     // Scale Y

            
            [self addChild:background];
        }
        
     //   [self addChild:bgImage];    // Drawig background
//
//        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
//        
//        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//        
//        myLabel.text = @"Hello, World!";
//        myLabel.fontSize = 30;
//        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
//                                       CGRectGetMidY(self.frame));
//        
//        [self addChild:myLabel];
    }
    return self;
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        sprite.xScale = 0.6;     // Scale X
        sprite.yScale = 0.6;     // Scale Y

        
       // SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        SKAction *moveUp = [SKAction moveByX:0 y:100.0 duration:2];  // Move object up
        
       //[asteroid runAction:[SKAction repeatActionForever:moveUp]];  // Asteroid action
        
       // SKAction *action_asteroid = [SKAction rotateByAngle:M_PI duration:1];
        
        
        
       // [asteroid runAction:[SKAction repeatActionForever:action_asteroid]];  // Asteroid action
        
        [sprite runAction:[SKAction repeatActionForever:moveUp]];
        
        [self addChild:sprite];
    }
}




- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.node != nil)
    {
        for (UITouch *touch in touches) {
            CGPoint location = [touch locationInNode:self]; // Sprite location
            self.node.position = location;
        }
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.node = nil;
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.node = nil;
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if(_lastUpdateTime)
    {
        _dt = currentTime - _lastUpdateTime;
    }
    else
    {
        _dt=0;
    }
    _lastUpdateTime = currentTime;
    [self moveBackground];
}

-(void)moveBackground
{
    [self enumerateChildNodesWithName:@"background" usingBlock:^(SKNode *node, BOOL *stop){
        SKSpriteNode *bg  = (SKSpriteNode *)node;
        CGPoint bgVelocity = CGPointMake(0.0, -140.0); //The speed at which the background image will move
        CGPoint amountToMove = CGPointMultiplyScalar (bgVelocity, _dt);
        bg.position = CGPointAdd(bg.position, amountToMove);
        if (bg.position.y <= 0)//-bg.size.height/4)
        {
            bg.position = CGPointMake(bg.position.x, (bg.position.y + (bg.size.height/2)));
        }
    }];
}

CGPoint CGPointAdd(CGPoint p1, CGPoint p2)
{
    return CGPointMake(p1.x + p2.x, p1.y + p2.y);
}

CGPoint CGPointMultiplyScalar(CGPoint p1, CGFloat p2)
{
    return CGPointMake(p1.x*p2, p1.y*p2);
}


@end
