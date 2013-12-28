//
//  RCActorTemplate.m
//  TileMap2d
//
//  Created by hy on 12/28/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import "RCActorTemplate.h"


@implementation RCActorTemplate
@synthesize m_name;

-(void) dealloc
{
    [super dealloc];
}

+(id) actorTemplateWithRect:(CGRect)rect actorSize:(CGSize)actorSize
{
    return [[[RCActorTemplate alloc] initWithRect:rect actorSize:actorSize] autorelease];
}

-(id) initWithRect:(CGRect)rect actorSize:(CGSize)actorSize
{
    if ((self = [super init])) {
        m_name = nil;
        NSLog(@"creating template : (%f %f %f %f)", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    }
    return self;
}


@end
