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
        m_dpad = nil;
        [self addDPad];
    }
    return self;
}

-(void) addDPad
{
    m_dpad = [RCDPad node];
    [self addChild:m_dpad];
    m_dpad.visible = NO;
}

-(void) showDPadAt:(CGPoint)position
{
    [self showDPadAt:position scale:1.0f];
}

-(void) showDPadAt:(CGPoint)position scale:(float)scale
{
    m_dpad.visible = YES;
    m_dpad.position = position;
    m_dpad.scale = scale;
}

@end
