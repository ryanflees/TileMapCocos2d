//
//  RCActor.m
//  TileMap2d
//
//  Created by hy on 12/28/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import "RCActor.h"
#import "RCActorTemplate.h"

@interface RCActor ()
{
    NSDictionary *m_actionDictionary;
    CCTexture2D *m_texture;
    
    float m_interval;
    float m_intervalTimer;
    int m_frameIndex;
}

@end

@implementation RCActor
@synthesize m_curActionKey;

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
    [m_texture release];
}

+(id) actorWithTemplate:(RCActorTemplate*) actorTemplate
{
    return [[self alloc] initWithTemplate:actorTemplate];
}

-(id) initWithTemplate:(RCActorTemplate*) actorTemplate
{
    if ((self = [super init])) {
        m_curActionKey = nil;
        
        m_actionDictionary = [NSDictionary dictionaryWithDictionary: actorTemplate.m_actionDictionary];
        [m_actionDictionary retain];
        
        CCTexture2D *texture = actorTemplate.m_texture;
        m_texture = texture;
        [m_texture retain];

        m_interval = 0.3f;
        m_intervalTimer = 0;
        m_frameIndex = 0;
    
    }
    return self;
}

-(void) setActorActionByKey:(NSString*) actionKey
{
    [m_curActionKey release];
    NSDictionary *actionDict = [m_actionDictionary objectForKey:actionKey];
    if (!actionDict) {
        m_curActionKey = nil;
        NSLog(@"fail to set actor action, key not exist");
        return;
    }
    m_curActionKey = actionKey;
    [m_curActionKey retain];
    m_intervalTimer = 0;
    m_frameIndex = 0;
    [self displayActionFirstFrame:m_curActionKey];
}

-(void) onEnter
{
    [super onEnter];
    [self scheduleUpdate];
}

-(void) onExit
{
    [super onExit];
    [self unscheduleUpdate];
}

-(void) update:(ccTime)delta
{
    if (m_curActionKey) {
        
        NSDictionary *actionDict = [m_actionDictionary objectForKey:m_curActionKey];
        NSArray *frameArray = (NSArray*)[actionDict objectForKey:@"frame_array"];
        if (frameArray.count == 1) {
            [self displayActionFirstFrame:m_curActionKey];
        }
        else
        {
            if (m_intervalTimer >= m_interval) {
                [self displayNextActionFrame:m_curActionKey];
                m_intervalTimer = 0;
            }
            else
            {
                m_intervalTimer += delta;
            }
        }
    }
}

-(void) displayNextActionFrame:(NSString*)actionKey
{
    NSDictionary *actionDict = [m_actionDictionary objectForKey:actionKey];
    NSArray *frameArray = (NSArray*)[actionDict objectForKey:@"frame_array"];
    m_frameIndex ++;
    if (m_frameIndex == frameArray.count) {
        m_frameIndex = 0;
    }
    NSValue *rectValue = [frameArray objectAtIndex:m_frameIndex];
    CGRect rect = [rectValue CGRectValue];
    CGRect newRect = CC_RECT_PIXELS_TO_POINTS(rect);
    CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:m_texture rect:newRect];
    [self setDisplayFrame:frame];
}

-(void) displayActionFirstFrame:(NSString*) actionKey
{
    NSDictionary *actionDict = [m_actionDictionary objectForKey:actionKey];
    NSArray *frameArray = (NSArray*)[actionDict objectForKey:@"frame_array"];
    NSValue *rectValue = [frameArray objectAtIndex:0];
    CGRect rect = [rectValue CGRectValue];
    CGRect newRect = CC_RECT_PIXELS_TO_POINTS(rect);
    CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:m_texture rect:newRect];
    [self setDisplayFrame:frame];
}

@end
