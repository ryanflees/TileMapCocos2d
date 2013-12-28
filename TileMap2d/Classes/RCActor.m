//
//  RCActor.m
//  TileMap2d
//
//  Created by hy on 12/28/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import "RCActor.h"

@interface RCActor ()
{
    NSMutableDictionary *m_actionDictionary;
}

@end

@implementation RCActor

-(id) init
{
    if ((self = [super init])) {
         m_actionDictionary = [NSMutableDictionary dictionary];
        [m_actionDictionary retain];
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
    [m_actionDictionary release];
}

@end
