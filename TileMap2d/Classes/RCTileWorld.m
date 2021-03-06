//
//  RCTileScene.m
//  TileMap2d
//
//  Created by hy on 12/27/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import "RCTileWorld.h"
#import "RCActorController.h"

@interface RCTileWorld ()
{
    CCTMXTiledMap *m_tileMap;
    CCNode *m_gameNode;
    RCActorController* m_actorController;
}
@end

@implementation RCTileWorld

+(id) nodeWithTmxFile:(NSString*) tmxFile
{
    RCTileWorld *layer = [[[RCTileWorld alloc] initWithTxmFile:tmxFile] autorelease];
    return layer;
}

-(id) initWithTxmFile:(NSString*) tmxFile
{
    if ((self = [super init])) {
     
    }
    
    m_gameNode = [CCNode node];
    m_gameNode.scale = 2.0f;
    [self addChild:m_gameNode];
    
    if (tmxFile && ![tmxFile isEqualToString:@""]) {
        m_tileMap = [CCTMXTiledMap tiledMapWithTMXFile:tmxFile];
        [m_gameNode addChild:m_tileMap];
    }
    
    m_actorController = [RCActorController node];
    [self addChild:m_actorController];
    
    return self;
}

@end
