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
    }
    return self;
}

-(void) addTileScene
{
    m_tileScene = [RCTileScene nodeWithTmxFile:@""];
    [self addChild:m_tileScene];
}

-(void) addUILayer
{
    m_uiLayer = [RCUILayer node];
    [self addChild:m_uiLayer];
}

@end
