//
//  RCActorTemplate.m
//  TileMap2d
//
//  Created by hy on 12/28/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import "RCActorTemplate.h"

@interface RCActorTemplate ()
{
}
@end

@implementation RCActorTemplate
@synthesize m_actionDictionary;
@synthesize m_name;
@synthesize m_texture;

-(void) dealloc
{
    [super dealloc];
    [m_name release];
    [m_actionDictionary release];
    [m_texture release];
}

+(id) actorTemplateWithRect:(CGRect)rect actorSize:(CGSize)actorSize
{
    return [[[RCActorTemplate alloc] initWithRect:rect actorSize:actorSize] autorelease];
}

-(id) initWithRect:(CGRect)rect actorSize:(CGSize)actorSize
{
    if ((self = [super init])) {
        m_name = nil;
        
        m_actionDictionary = [NSMutableDictionary dictionary];
        [m_actionDictionary retain];
        NSLog(@"creating template : (%f %f %f %f)", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
        [self parseRect:rect actorSize:actorSize];
    }
    return self;
}

-(void) parseRect:(CGRect) rect actorSize:(CGSize) actorSize
{
    for (int i=0; i<kDefaultActorFrameRows; i++) {
        for (int j=0; j<kDefaultActorFrameCols; j++) {
            int x = rect.origin.x + j * actorSize.width;
            int y = rect.origin.y + rect.size.height - (j+1) * actorSize.height;
            CGRect frameRect = CGRectMake(x, y, actorSize.width, actorSize.height);
            // todo
        }
    }
}


+(id) actorTemplateWithDict:(NSDictionary*) actorDict
{
    return [[[self alloc] initWithDict:actorDict] autorelease];
}

-(id) initWithDict:(NSDictionary*) actorDict
{
    if ((self = [super init])) {
        m_actionDictionary = [NSMutableDictionary dictionary];
        [m_actionDictionary retain];
        
        NSString *actorName = [actorDict objectForKey:@"name"];
        self.m_name = actorName;
        
        NSArray *actionArray = (NSArray*)[actorDict objectForKey:@"action_array"];
        for (id node in actionArray) {
            NSDictionary *actionDict = (NSDictionary*)node;
            NSString *actionName = (NSString*)[actionDict objectForKey:@"action_name"];
            NSArray *frameArray = (NSArray*)[actionDict objectForKey:@"frame_array"];
            
            NSMutableDictionary *newActionDict = [NSMutableDictionary dictionary];
            NSMutableArray *newFrameArray = [NSMutableArray array];
            for (int i=0; i<frameArray.count; i++) {
                NSDictionary *frameDict = (NSDictionary*)[frameArray objectAtIndex:i];
                int x = [[frameDict objectForKey:@"x"] intValue];
                int y = [[frameDict objectForKey:@"y"] intValue];
                int width = [[frameDict objectForKey:@"width"] intValue];
                int height = [[frameDict objectForKey:@"height"] intValue];
                CGRect rect = CGRectMake(x, y, width, height);
                NSValue *rectValue = [NSValue valueWithCGRect:rect];
                [newFrameArray addObject:rectValue];
            }
            [newActionDict setObject:newFrameArray forKey:@"frame_array"];
            [newActionDict setObject:actionName forKey:@"action_name"];
            
            [m_actionDictionary setObject:newActionDict forKey:actionName];
        }
    }
    return self;
}


@end
