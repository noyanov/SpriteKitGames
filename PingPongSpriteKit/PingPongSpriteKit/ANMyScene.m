//
//  ANMyScene.m
//  PingPongSpriteKit
//
//  Created by Alex Noyanov on 9/16/16.
//  Copyright (c) 2016 Alex Noyanov. All rights reserved.
//

#import "ANMyScene.h"

@implementation ANMyScene

CGPoint _targetLocation;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        _VX0 = 1.5;
        _VY0 = 0.7;
        _vx = _VX0;
        _vy = _VY0;
        
        self.backgroundColor = [SKColor colorWithRed:0.75 green:0.75 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        myLabel.text = @"Ping Pong+";
        myLabel.fontSize = 25;
        myLabel.fontColor = [SKColor grayColor];
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       self.frame.size.height - myLabel.fontSize - 25);
        [self addChild:myLabel];

        SKLabelNode *labelScore = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        labelScore.fontSize = 40;
        labelScore.fontColor = [SKColor greenColor];
        labelScore.position = CGPointMake(CGRectGetMidX(self.frame),
                                       self.frame.size.height - myLabel.fontSize - 25-50);
        [self addChild:labelScore];
        self.labelScore = labelScore;
        [self setScoreText];

        SKSpriteNode *spriteBall = [SKSpriteNode spriteNodeWithImageNamed:@"Ball"];
        spriteBall.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        SKAction *actionBallRotate = [SKAction rotateByAngle:M_PI duration:1];
        SKAction *actionBallMove = [SKAction customActionWithDuration:0.3 actionBlock:^(SKNode *node, CGFloat elapsedTime)
           {
               CGPoint p = spriteBall.position;
               BOOL isOut = NO;
               if(p.x <= 30) {
                   BOOL isInLeftRacket = (p.y > (self.spriteLeftRacket.position.y-self.spriteLeftRacket.size.height/2)) && (p.y < (self.spriteLeftRacket.position.y+self.spriteLeftRacket.size.height/2));
                   if(isInLeftRacket) {
                       _vx = _VX0;
                   } else if(p.x <= 0) {
                       isOut = YES;
                       _scoreRight++;
                   }
               }
               if(p.x >= self.frame.size.width-30) {
                   BOOL isInRightRacket = (p.y > (self.spriteRightRacket.position.y-self.spriteRightRacket.size.height/2)) && (p.y < (self.spriteRightRacket.position.y+self.spriteRightRacket.size.height/2));
                   if(isInRightRacket) {
                       _vx = -_VX0;
                   } else if(p.x >= self.frame.size.width) {
                       isOut = YES;
                       _scoreLeft++;
                   }
               }
//               if(p.x >= self.frame.size.width) {
//                   _vx = -_VX0;
//               }
//               if(p.x <= 0) {
//                   _vx = _VX0;
//               }
               if(p.y <= 0) {
                   _vy = _VY0;
               }
               if(p.y >= self.frame.size.height) {
                   _vy = -_VY0;
               }
               if(isOut) {
                   _vx = _VX0;
                   _vy = _VY0;
                   p.x = CGRectGetMidX(self.frame);
                   p.y = CGRectGetMidY(self.frame);
                   [self setScoreText];
               }
               p.x += _vx;
               p.y += _vy;
               spriteBall.position = p;
           }
           ];
        [spriteBall runAction:[SKAction repeatActionForever:actionBallRotate]];
        [spriteBall runAction:[SKAction repeatActionForever:actionBallMove]];
        [self addChild:spriteBall];
        self.spriteBall = spriteBall;
    
        SKSpriteNode *spriteRightRacket = [SKSpriteNode spriteNodeWithImageNamed:@"Racket"];
        spriteRightRacket.position = CGPointMake(self.frame.size.width - 25, CGRectGetMidY(self.frame));
        SKAction *actionRightRacketMove = [SKAction customActionWithDuration:0.3 actionBlock:^(SKNode *node, CGFloat elapsedTime)
              {
                  CGPoint p = spriteRightRacket.position;
                  int dy = (spriteRightRacket.position.y - spriteBall.position.y);
                  if(fabs(dy) > 2) {
                      p.y += ((dy > 0) ? -2 : +2);
                      spriteRightRacket.position = p;
                  }
              }
        ];
        [spriteRightRacket runAction:[SKAction repeatActionForever:actionRightRacketMove]];
        [self addChild:spriteRightRacket];
        self.spriteRightRacket = spriteRightRacket;

        _targetLocation = CGPointMake(25, CGRectGetMidY(self.frame));
        SKSpriteNode *spriteLeftRacket = [SKSpriteNode spriteNodeWithImageNamed:@"Racket"];
        spriteLeftRacket.position = CGPointMake(25, CGRectGetMidY(self.frame));
        SKAction *actionLeftRacketMove = [SKAction customActionWithDuration:0.3 actionBlock:^(SKNode *node, CGFloat elapsedTime)
            {
                CGPoint p = spriteLeftRacket.position;
                int dy = (spriteLeftRacket.position.y - _targetLocation.y);
                if(fabs(dy) > 2) {
                    p.y += ((dy > 0) ? -2 : +2);
                    spriteLeftRacket.position = p;
                }
            }
        ];
        [spriteLeftRacket runAction:[SKAction repeatActionForever:actionLeftRacketMove]];
        [self addChild:spriteLeftRacket];
        self.spriteLeftRacket = spriteLeftRacket;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        _targetLocation = location;
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}


- (void) setScoreText
{
    self.labelScore.text = [NSString stringWithFormat:@"%d : %d", _scoreLeft, _scoreRight];
}
@end
