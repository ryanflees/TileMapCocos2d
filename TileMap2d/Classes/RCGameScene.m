//
//  RCGameScene.m
//  TileMap2d
//
//  Created by hy on 12/27/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import "RCGameScene.h"
#import "RCTileScene.h"
#import "RCUILayer.h"
#import "RCActor.h"
#import "RCActorTemplateCache.h"

@interface RCGameScene ()
{
    RCTileScene* m_tileScene;
    RCUILayer* m_uiLayer;
}

@end

@implementation RCGameScene

+(id) scene
{
    CCScene *scene = [CCScene node];
    RCTileScene *layer = [RCGameScene node];
    [scene addChild:layer];
    return scene;
}

-(id) init
{
    if ((self = [super init])) {
        [self addTileScene];
        [self addUILayer];
        [self addSprite];
    }
    return self;
}

-(void) addTileScene
{
    m_tileScene = [RCTileScene nodeWithTmxFile:@"game/tilemap/game_world.tmx"];
    [self addChild:m_tileScene];
}

-(void) addUILayer
{
    m_uiLayer = [RCUILayer node];
    [self addChild:m_uiLayer];
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
    
    [[RCActorTemplateCache sharedActorTemplateCache] addActorByFile:@"game/DSMaterials/Graphics/Characters/01Hero.png" name:@"hero"];
}

@end
