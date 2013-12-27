//
//  RCUILayer.m
//  TileMap2d
//
//  Created by hy on 12/27/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import "RCUILayer.h"
#import "RCDPad.h"

@interface RCUILayer ()
{
    RCDPad *m_dpad;
}

@end

@implementation RCUILayer

-(id) init
{
    if ((self = [super init])) {
        [self addDPad];
    }
    return self;
}

-(void) addDPad
{
    m_dpad = [RCDPad node];
    [self addChild:m_dpad];
    m_dpad.position = ccp(200, 200);
}

@end
