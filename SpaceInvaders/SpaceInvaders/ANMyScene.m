//
//  ANMyScene.m
//  SpaceInvaders
//
//  Created by Alex Noyanov on 9/16/16.
//  Copyright (c) 2016 Alex Noyanov. All rights reserved.
//

#import "ANMyScene.h"
#import "ANSceneFinish.h"

@implementation ANMyScene

static const uint32_t allienShipCategory = 0x1 << 0;
static const uint32_t allienCategory     = 0x1 << 1;
static const uint32_t myShipCategory     = 0x1 << 2;
static const uint32_t bulletCategory     = 0x1 << 3;
static const uint32_t boomCategory       = 0x1 << 4;
static const uint32_t bulletDownCategory = 0x1 << 5;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        srand((unsigned)time(NULL));
        
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0);
        self.physicsWorld.contactDelegate = self;
        
        self.backgroundColor = [SKColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1.0];
        
        SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        titleLabel.name = @"titleLabel";
        titleLabel.text = @"Space Invaders";
        titleLabel.fontSize = 35;
        titleLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       self.frame.size.height - titleLabel.fontSize);
        [titleLabel runAction:[SKAction fadeOutWithDuration:5]];
        [self addChild:titleLabel];
        
        _alienShipDX = 2;
        SKSpriteNode* alienShip = [SKSpriteNode spriteNodeWithImageNamed:@"aliens_ship.png"];
        alienShip.name = @"alienShip";
        alienShip.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - titleLabel.fontSize - 30);
        alienShip.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:alienShip.size];
        alienShip.physicsBody.dynamic = YES;
        alienShip.physicsBody.categoryBitMask = allienShipCategory;
        alienShip.physicsBody.contactTestBitMask = myShipCategory | allienCategory;
        alienShip.physicsBody.collisionBitMask = myShipCategory | allienCategory;
        SKAction *actionAlientShip = [SKAction customActionWithDuration:1 actionBlock:^(SKNode *node, CGFloat elapsedTime)
        {
            CGPoint p = node.position;
            p.x += _alienShipDX;
            if(p.x > self.frame.size.width-node.frame.size.width/2) {
               _alienShipDX = -2;
            }
            if(p.x < node.frame.size.width/2) {
               _alienShipDX = 2;
            }
            node.position = p;
        }];
        [alienShip runAction:[SKAction repeatActionForever:actionAlientShip]];
        [self addChild:alienShip];
        

        _alienDX = 2;
        
        for(int line = 0; line < 6; line++) {
            NSString* imageName;
            switch(line) {
                case 0: imageName = @"alein11.png"; break;
                case 1: imageName = @"alien21.png"; break;
                case 2: imageName = @"alien31.png"; break;
                case 3: imageName = @"alein11.png"; break;
                case 4: imageName = @"alien21.png"; break;
                case 5: imageName = @"alien31.png"; break;
            }
            for(int x = 0; x < 6; x++) {
                SKSpriteNode* alien = [SKSpriteNode spriteNodeWithImageNamed:imageName];
                alien.name = [NSString stringWithFormat:@"alien%d_%d", line, x];
                alien.position = CGPointMake(x*50+30, line*60+150);
                alien.xScale = 0.8;
                alien.yScale = 0.8;
                alien.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:alien.size];
                alien.physicsBody.dynamic = YES;
                alien.physicsBody.categoryBitMask = allienCategory;
                alien.physicsBody.contactTestBitMask = myShipCategory | allienShipCategory;
                alien.physicsBody.collisionBitMask = myShipCategory | allienShipCategory;
                SKAction *actionAlient = [SKAction customActionWithDuration:0.5 actionBlock:^(SKNode *node, CGFloat elapsedTime)
                {
                    CGPoint p = node.position;
                    p.x += _alienDX;
                    if(p.x > self.frame.size.width-3) {
                        _alienDX = -2;
                        _step++;
                    }
                    if(p.x < 3) {
                        _alienDX = 2;
                        _step++;
                    }
                    if(_step > 3) {
                        _step = 0;
                    }
                    
                    if(rand()%3000 < 1)
                    {
                        // fire down
                        SKSpriteNode *bulletD = [SKSpriteNode spriteNodeWithImageNamed:@"bullet_down.png"];
                        bulletD.position = CGPointMake(p.x, p.y+node.frame.size.height/2);
                        bulletD.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bulletD.size];
                        bulletD.physicsBody.dynamic = YES;
                        bulletD.physicsBody.velocity = CGVectorMake(0, -200);
                        bulletD.physicsBody.categoryBitMask = bulletDownCategory;
                        bulletD.physicsBody.contactTestBitMask = myShipCategory | bulletCategory;
                        bulletD.physicsBody.collisionBitMask = myShipCategory | bulletCategory;
                        [self addChild:bulletD];
                    }
                    node.position = p;
                }];
                [alien runAction:[SKAction repeatActionForever:actionAlient]];
                [self addChild:alien];
            }
        }
        
        
        
        SKSpriteNode* myShip = [SKSpriteNode spriteNodeWithImageNamed:@"rocket.png"];
        myShip.name = @"myShip";
        myShip.position = CGPointMake(CGRectGetMidX(self.frame), 10);
        myShip.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:myShip.size];
        myShip.physicsBody.dynamic = YES;
        myShip.physicsBody.categoryBitMask = myShipCategory;
        myShip.physicsBody.contactTestBitMask = allienCategory | allienShipCategory;
        myShip.physicsBody.collisionBitMask = allienCategory | allienShipCategory;
        [self addChild:myShip];
        
//        SKFieldNode *gravityNode = [SKFieldNode linearGravityFieldWithVector: gravityVector];
//        gravityNode.strength = 9.8;
//        [self addChild:gravityNode];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        location.y = 30;
        SKSpriteNode *bullet = [SKSpriteNode spriteNodeWithImageNamed:@"bullet.png"];
        bullet.position = location;
        bullet.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bullet.size];
        bullet.physicsBody.dynamic = YES;
        bullet.physicsBody.velocity = CGVectorMake(0, 200);
        [bullet.physicsBody applyForce:CGVectorMake(0, 20)];
        [bullet.physicsBody applyImpulse:CGVectorMake(0, 100)];
        bullet.physicsBody.categoryBitMask = bulletCategory;
        bullet.physicsBody.contactTestBitMask = allienCategory | allienShipCategory;
        bullet.physicsBody.collisionBitMask = allienCategory | allienShipCategory;
        //SKAction *actionBullet = [SKAction moveByX:0 y:4 duration:0.05];
//        SKAction *actionBullet = [SKAction customActionWithDuration:0.05 actionBlock:^(SKNode *node, CGFloat elapsedTime)
//        {
//           CGPoint p = node.position;
//            p.y += 5;
//            if(p.y > 30) {
//               node.position = p;
//            } else {
//                [node removeFromParent];
//            }
//        }];
//        [bullet runAction:[SKAction repeatActionForever:actionBullet]];
        [self addChild:bullet];
    }
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event NS_AVAILABLE_IOS(3_0)
{
    
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event NS_AVAILABLE_IOS(3_0)
{
    
}


- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    if( ((contact.bodyA.categoryBitMask & bulletCategory) != 0) || ((contact.bodyB.categoryBitMask & bulletCategory) != 0))
    {
        SKSpriteNode *boom = [SKSpriteNode spriteNodeWithImageNamed:@"boom.png"];
        boom.position = contact.bodyA.node.position;
        boom.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:boom.size];
        boom.physicsBody.dynamic = NO;
        boom.physicsBody.angularVelocity = 0.1;
        boom.physicsBody.categoryBitMask = boomCategory;
        //boom.physicsBody.contactTestBitMask = allienCategory | allienShipCategory;
        //boom.physicsBody.collisionBitMask = allienCategory | allienShipCategory;
        SKAction* actionBoom1 = [SKAction scaleBy:1.5 duration:0.2];
        SKAction* actionBoom2 = [SKAction scaleBy:0.1 duration:0.2];
        SKAction* actionBoom3 = [SKAction removeFromParent];
        SKAction* actionBoom = [SKAction sequence:@[actionBoom1, actionBoom2, actionBoom3]];
        [boom runAction:actionBoom];
        [self addChild:boom];
        [contact.bodyA.node removeFromParent];
        [contact.bodyB.node removeFromParent];
    } else {
        if( ((contact.bodyA.categoryBitMask & bulletDownCategory) != 0) || ((contact.bodyB.categoryBitMask & bulletDownCategory) != 0))
        {
            SKSpriteNode *boom = [SKSpriteNode spriteNodeWithImageNamed:@"boom.png"];
            boom.position = contact.bodyA.node.position;
            boom.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:boom.size];
            boom.physicsBody.dynamic = NO;
            boom.physicsBody.angularVelocity = 0.1;
            boom.physicsBody.categoryBitMask = boomCategory;
            //boom.physicsBody.contactTestBitMask = allienCategory | allienShipCategory;
            //boom.physicsBody.collisionBitMask = allienCategory | allienShipCategory;
            SKAction* actionBoom1 = [SKAction scaleBy:1.5 duration:0.2];
            SKAction* actionBoom2 = [SKAction scaleBy:0.1 duration:0.2];
            SKAction* actionBoom3 = [SKAction removeFromParent];
            SKAction* actionBoom = [SKAction sequence:@[actionBoom1, actionBoom2, actionBoom3]];
            [boom runAction:actionBoom];
            [self addChild:boom];
            [contact.bodyA.node removeFromParent];
            [contact.bodyB.node removeFromParent];
            
            SKScene* finishScene = [ANSceneFinish sceneWithSize:self.frame.size];
            finishScene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:finishScene];
        }
        
    }
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
