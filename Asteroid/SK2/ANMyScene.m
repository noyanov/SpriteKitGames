//
//  ANMyScene.m
//  SK2
//
//  Created by Alex Noyanov on 9/17/16.
//  Copyright (c) 2016 Alex Noyanov. All rights reserved.
//

#import "ANMyScene.h"

@implementation ANMyScene

- (id) initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        /* Setup your scene here */
        
        // Background image:
        SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"space_stars"];
        bgImage.position =CGPointMake(CGRectGetMidX(self.frame),
                                      CGRectGetMidY(self.frame));
        bgImage.size = self.frame.size;
        
        [self addChild:bgImage];    // Drawig background

        SKSpriteNode *asteroid = [SKSpriteNode spriteNodeWithImageNamed:@"asteroid-cuted"];
        
        asteroid.position = CGPointMake(250,0);    // Asteroid position
        
        CGFloat scale = asteroid.frame.size.width / (self.frame.size.width*10);
        asteroid.size = CGSizeMake(asteroid.frame.size.width * scale, asteroid.frame.size.height *scale);
        //asteroid.yScale = 0.1;     // Scale Y
        // SKAction *action = [SKAction rotateByAngle:M_PI duration:10];
        

        // Creating sprite:
        SKSpriteNode *sun = [SKSpriteNode spriteNodeWithImageNamed:@"sun"];
         // Action:
        SKAction *pulseRed = [SKAction sequence:@[
                                                  [SKAction colorizeWithColor:[SKColor yellowColor] colorBlendFactor:1.5 duration:1.0],
                                                  [SKAction waitForDuration:1],
                                                  [SKAction colorizeWithColorBlendFactor:0.0 duration:10]]];
        //pulseRed = [SKAction repeatActionForever:pulseRed]; // Repeat action
        [sun runAction:[SKAction repeatActionForever:pulseRed]];
        
        
        sun.position = CGPointMake(0,350);  // Sun position
        
        sun.xScale = 0.5;   // Sun scale
        sun.yScale = 0.5;   // Sun scale

        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:120]; // Sun round moving

        [sun runAction:[SKAction repeatActionForever:action]];
        
        SKAction *moveUp = [SKAction moveByX:0 y:100.0 duration:2];  // Move object up
        [asteroid runAction:[SKAction repeatActionForever:moveUp]];  // Asteroid action
        
        SKAction *action_asteroid = [SKAction rotateByAngle:M_PI duration:1];
        

        
        [asteroid runAction:[SKAction repeatActionForever:action_asteroid]];  // Asteroid action
        
        [self addChild:asteroid];   // Drawing sprite Asteroid

        [self addChild:sun];        // Drawing sprite Sun
        
        // Stars:
        
        
        
        //self.backgroundColor = [SKColor colorWithRed:0.10 green:0.25 blue:0.55 alpha:1.0];
        
        // Label:
        //SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        /*
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 20;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        // Create phisycs:
        myLabel.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:(myLabel.frame.size)];
        myLabel.physicsBody.dynamic = YES;
        myLabel.physicsBody.mass = 0.1;
        
        myLabel.physicsBody.velocity = CGVectorMake(0, 10 );
        myLabel.physicsBody.affectedByGravity = NO;
        
        [self addChild:myLabel];
        */
        
        // Creating rocket sprite:
        //  SKSpriteNode *rocket = [SKSpriteNode spriteNodeWithImageNamed:@"rocket1"];
        //rocket.position = CGPointMake(CGRectGetMidX(self.frame),
        //                              CGRectGetMidY(self.frame));
        
       // rocket.xScale = 0.3;
       // rocket.yScale = 0.3;
        
         //       [self addChild:rocket];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                      target:self
                                                    selector:@selector(onTimer:)
                                                    userInfo:nil
                                                     repeats:YES];
        
        [self addStar1];
        [self addStar2];
        [self addStar3];
    }
    return self;
}

- (void) addStar1
{
    [self addStarToX:200 Y:200];
}
- (void) addStar2
{
    [self addStarToX:208 Y:211];
}
- (void) addStar3
{
    [self addStarToX:306 Y:287];
}
- (void) addStarToX:(CGFloat)x Y:(CGFloat)y
{
    SKSpriteNode *star = [SKSpriteNode spriteNodeWithImageNamed:@"star"];
    star.position = CGPointMake(x,y);                                // Star position
    SKAction *zoom = [SKAction scaleTo:2.0 duration:1.25];                      // Action for star
    SKAction *unZoom = [SKAction scaleTo:0.25 duration:1.25];                   // Action
    SKAction *wait =   [SKAction waitForDuration:1];
    SKAction *deleteItself =   [SKAction removeFromParent];
    SKAction *randomwait =   [SKAction waitForDuration:(rand()%10+1)];
    SKAction *allStarActions = [SKAction sequence:@[zoom, wait, unZoom, randomwait]];
    [star runAction:[SKAction  repeatActionForever:allStarActions]];
    //[star runAction:[SKAction repeatActionForever:wait]];
    //[star runAction:[SKAction repeatActionForever:unZoom]];
    [self addChild:star];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        // Creating object (sprite):
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"shuttle"];
        
        sprite.position = location;
        
        sprite.xScale = 0.3;
        sprite.yScale = 0.3;
       //SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        SKAction *moveUp = [SKAction moveByX:0 y:100.0 duration:0.5]; // Move object up
       // SKAction *zoom = [SKAction scaleTo:2.0 duration:0.25];
       // SKAction *wait = [SKAction waitForDuration: 0.5];
       // SKAction *fadeAway = [SKAction fadeOutWithDuration:0.25];
       // SKAction *removeNode = [SKAction removeFromParent];
        
        [sprite runAction:[SKAction repeatActionForever:moveUp]];
                                                // Action ^
        [self addChild:sprite];
        
        
    }
}



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
//    int r = rand() % 1000;
//    if(r < 3)
//        [self addStar1];
//    else if(r < 6)
//        [self addStar2];
//    if(r < 9)
//        [self addStar3];
}


- (void) onTimer:(id)sender
{
    
}

@end
