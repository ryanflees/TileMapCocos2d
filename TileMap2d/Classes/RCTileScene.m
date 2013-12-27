//
//  RCTileScene.m
//  TileMap2d
//
//  Created by hy on 12/27/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import "RCTileScene.h"

@interface RCTileScene ()
{
    CCNode *m_gameNode;
}
@end

@implementation RCTileScene

+(id) nodeWithTmxFile:(NSString*) tmxFile
{
    RCTileScene *layer = [[[RCTileScene alloc] initWithTxmFile:tmxFile] autorelease];
    return layer;
}

-(id) initWithTxmFile:(NSString*) tmxFile
{
    if ((self = [super init])) {
     
      }
    
    return self;
}

@end
