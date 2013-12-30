//
//  RCGameScene.m
//  TileMap2d
//
//  Created by hy on 12/27/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import "RCGameScene.h"
#import "RCTileWorld.h"
#import "RCUILayer.h"
#import "RCActor.h"
#import "RCActorTemplateCache.h"
#import "RCActorPlistGenerator.h"
#import "RCControllerLayer.h"
#import "func.h"

#define kMoveUpAction @"move_up"
#define kMoveDownAction @"move_down"
#define kMoveLeftAction @"move_left"
#define kMoveRightAction @"move_right"
#define kStandDown @"stand_down"
#define kStandUp @"stand_up"
#define kStandLeft @"stand_left"
#define kStandRight @"stand_right"

typedef enum
{
    kActionMoveUp,
    kActionMoveDown,
    kActionMoveLeft,
    kActionMoveRight,
    kActionStandUp,
    kActionStandDown,
    kActionStandLeft,
    kActionStandRight
}ActorMoveDirectionEnum;

@interface RCGameScene () <RCControllerLayerDelegate>
{
    RCTileWorld* m_tileScene;
    RCUILayer* m_uiLayer;
    RCControllerLayer *m_controllerLayer;
    
    RCActor *m_player;
    int m_playerAction;
}

-(void) updateControllerVector:(RCControllerLayer*) controllerLayer vector:(CGPoint) pressedVector delta:(ccTime)delta;
@end

@implementation RCGameScene

+(id) scene
{
    CCScene *scene = [CCScene node];
    RCGameScene *layer = [RCGameScene node];
    [scene addChild:layer];
    return scene;
}

-(id) init
{
    if ((self = [super init])) {
        [self addTileScene];
        [self addControllerLayer];
        [self addUILayer];
        
        [[RCActorTemplateCache sharedActorTemplateCache] addActorByFile:@"game/DSMaterials/Graphics/Characters/hero.plist"];
        RCActorTemplate *actorTemplate = [[RCActorTemplateCache sharedActorTemplateCache] getActorTemplateByName:@"hero1"];
        
        m_player = [RCActor actorWithTemplate:actorTemplate];
        [self addChild:m_player];
        m_player.position = ccp(300, 150);
        [m_player setActorActionByKey:@"stand_left"];
        m_playerAction = kActionStandLeft;
        m_player.m_speed = 30;
        
        //NSString *folderPath = [imagePath stringByDeletingLastPathComponent];
        //[[RCActorPlistGenerator sharedActorPlistGenerator] generateActorPlistByFolder:folderPath image:@"game/DSMaterials/Graphics/Characters/"];
        
        [self scheduleUpdate];
    }
    return self;
}

-(void) addTileScene
{
    m_tileScene = [RCTileWorld nodeWithTmxFile:@"game/tilemap/game_world.tmx"];
    [self addChild:m_tileScene];
}

-(void) addUILayer
{
    m_uiLayer = [RCUILayer node];
    [self addChild:m_uiLayer];
}

-(void) addControllerLayer
{
    m_controllerLayer = [RCControllerLayer node];
    [self addChild:m_controllerLayer];
    m_controllerLayer.m_delegate = self;
}

-(void) addSprite
{
    NSString *imageFile = @"game/DSMaterials/Graphics/Characters/01Hero.png";
    [[CCTextureCache sharedTextureCache] addImage:imageFile];
    CCSprite *sprite = [CCSprite node];
    CCTexture2D *texture = [[CCTextureCache sharedTextureCache] textureForKey:@"game/DSMaterials/Graphics/Characters/01Hero.png"];
    CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:texture rect:CGRectMake(0, 0, texture.contentSize.width, texture.contentSize.height)];
    sprite.displayFrame = frame;
    [self addChild:sprite];
    sprite.position = ccp(100, 100);
}

-(void) update:(ccTime)delta
{
    [super update:delta];
}

-(void) updateControllerVector:(RCControllerLayer *)controllerLayer vector:(CGPoint)pressedVector delta:(ccTime)delta
{
    //NSLog(@"press vecotr:%f %f",pressedVector.x, pressedVector.y);
    if (pressedVector.x == 0 && pressedVector.y == 0) {
        if (m_playerAction == kActionMoveRight) {
            m_playerAction = kActionStandRight;
            [m_player setActorActionByKey:kStandRight];
        }
        else if (m_playerAction == kActionMoveLeft)
        {
            m_playerAction = kActionStandLeft;
            [m_player setActorActionByKey:kStandLeft];
        }
        else if (m_playerAction == kActionMoveUp)
        {
            m_playerAction = kActionStandUp;
            [m_player setActorActionByKey:kStandUp];
        }
        else if (m_playerAction == kActionMoveDown)
        {
            m_playerAction = kActionStandDown;
            [m_player setActorActionByKey:kStandDown];
        }
        
        return;
    }
    float angle = ccpToAngle(pressedVector);
    float delAngle = radiansToDegrees(angle);
    if (delAngle <0 ) {
        delAngle += 360;
    }
    if (delAngle <= 45 || delAngle >= 315) {
        if (m_playerAction != kActionMoveRight) {
            m_playerAction = kActionMoveRight;
            [m_player setActorActionByKey:kMoveRightAction];
        }
    }
    else if (delAngle > 45 && delAngle < 135)
    {
        if (m_playerAction != kActionMoveUp) {
            m_playerAction = kActionMoveUp;
            [m_player setActorActionByKey:kMoveUpAction];
        }
    }
    else if (delAngle >= 135 && delAngle <= 225)
    {
        if (m_playerAction != kActionMoveLeft) {
            m_playerAction = kActionMoveLeft;
            [m_player setActorActionByKey:kMoveLeftAction];
        }
    }
    else if (delAngle > 225 && delAngle < 315)
    {
        if (m_playerAction != kActionMoveDown) {
            m_playerAction = kActionMoveDown;
            [m_player setActorActionByKey:kMoveDownAction];
        }
    }
    
    CGPoint moveOffset = getPositionOnTheCircle(CGPointZero, m_player.m_speed, delAngle);
    moveOffset = CGPointMake(moveOffset.x*delta, moveOffset.y*delta);
    NSLog(@"moveOffset : %f %f",moveOffset.x, moveOffset.y);
    m_player.position = CGPointMake(m_player.position.x + moveOffset.x, m_player.position.y + moveOffset.y);
    
 //   NSLog(@" angle %f", delAngle);
}

@end
