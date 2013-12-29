//
//  RCControllerLayer.m
//  TileMap2d
//
//  Created by Bai Ryan on 13-12-29.
//  Copyright 2013年 Bai Ryan. All rights reserved.
//

#import "RCControllerLayer.h"
#import "RCDPad.h"

@interface RCControllerLayer ()
{
    RCDPad *m_dPad;
}

@end

@implementation RCControllerLayer
@synthesize m_delegate;

-(id) init
{
    if ((self = [super init])) {
        m_delegate = nil;
        m_dPad = [RCDPad node];
        [self addChild:m_dPad];
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        m_dPad.position = ccp(screenSize.width*0.3f, screenSize.height*0.2f);
        
        [self scheduleUpdate];
    }
    return self;
}

-(void) dealloc
{
    [super dealloc];
}

-(void) update:(ccTime)delta
{
    if (m_delegate) {
        [m_delegate updateControllerVector:self vector:m_dPad.m_pressedVector delta:delta];
    }
}

@end
