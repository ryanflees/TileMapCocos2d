//
//  RCActorPool.m
//  TileMap2d
//
//  Created by hy on 12/28/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import "RCActorTemplateCache.h"
#import "RCActorTemplate.h"

#define kDefaultActorSize CGSizeMake(23,32)

@interface RCActorTemplateCache ()
{
    NSMutableArray *m_actorTemplateArray;
}
@end

@implementation RCActorTemplateCache
static RCActorTemplateCache* m_instanceOfActorTemplateCache = nil;

+(RCActorTemplateCache*) sharedActorTemplateCache
{
    if (!m_instanceOfActorTemplateCache) {
        m_instanceOfActorTemplateCache = [RCActorTemplateCache node];
        [m_instanceOfActorTemplateCache retain];
    }
    return m_instanceOfActorTemplateCache;
}

-(id) init
{
    if ((self = [super init])) {
        m_actorTemplateArray = [NSMutableArray array];// [[[NSMutableArray alloc] init] autorelease];
        [m_actorTemplateArray retain];
    }
    return self;
}

-(void) dealloc
{
    [super dealloc];
    [m_actorTemplateArray release];
}

-(void) addActorByFile:(NSString *)imageFile name:(NSString*) name
{
    [self addActorByFile:imageFile name:name actorSize:kDefaultActorSize];
}

-(void) addActorByFile:(NSString *)imageFile name:(NSString*) name actorSize:(CGSize)size
{
    CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:imageFile];
    if (!texture) {
        CCLOG(@"Unable to add image file %@", imageFile);
        return;
    }
    
    CGSize actorBlockSize = CGSizeMake(size.width*3, size.height*4);
    int actorBlockCol = (int)(texture.contentSizeInPixels.width/actorBlockSize.width);
    int actorBlockRow = (int)(texture.contentSizeInPixels.height/actorBlockSize.height);
    int num = 0;
    for (int i=0; i<actorBlockRow; i++) {
        for (int j=0; j<actorBlockCol; j++) {
            float x = j * actorBlockSize.width;
            float y = texture.contentSize.height - i * actorBlockSize.height;
            CGRect actorBlockRect = CGRectMake(x,y,actorBlockSize.width,actorBlockSize.height);
            RCActorTemplate *actorTemplate = [RCActorTemplate actorTemplateWithRect:actorBlockRect actorSize:size];
            actorTemplate.m_name = [NSString stringWithFormat:@"%@%i",name, num];
            [m_actorTemplateArray addObject:actorTemplate];
            num ++;
        }
    }
}

-(void) dumpAllActorTemplates
{
    [m_actorTemplateArray removeAllObjects];
}

@end
