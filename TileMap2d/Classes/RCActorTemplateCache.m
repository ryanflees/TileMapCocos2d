//
//  RCActorPool.m
//  TileMap2d
//
//  Created by hy on 12/28/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import "RCActorTemplateCache.h"
#import "RCActorTemplate.h"

#define kDefaultActorSize CGSizeMake(24,32)

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

//-(void) addActorByImage:(NSString *)imageFile name:(NSString*) name
//{
//    [self addActorByImage:imageFile name:name actorSize:kDefaultActorSize];
//}

//-(void) addActorByImage:(NSString *)imageFile name:(NSString*) name actorSize:(CGSize)size
//{
//    CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:imageFile];
//    if (!texture) {
//        CCLOG(@"Unable to add image file %@", imageFile);
//        return;
//    }
//    
//    CGSize actorBlockSize = CGSizeMake(size.width*kDefaultActorFrameCols
//                                       , size.height*kDefaultActorFrameRows);
//    int actorBlockCols = (int)(texture.contentSizeInPixels.width/actorBlockSize.width);
//    int actorBlockRows = (int)(texture.contentSizeInPixels.height/actorBlockSize.height);
//    int num = 0;
//    for (int i=0; i<actorBlockRows; i++) {
//        for (int j=0; j<actorBlockCols; j++) {
//            float x = j * actorBlockSize.width;
//            float y = texture.contentSize.height - (i + 1) * actorBlockSize.height;
//            CGRect actorBlockRect = CGRectMake(x,y,actorBlockSize.width,actorBlockSize.height);
//            RCActorTemplate *actorTemplate = [RCActorTemplate actorTemplateWithRect:actorBlockRect actorSize:size];
//            actorTemplate.m_name = [NSString stringWithFormat:@"%@%i",name, num];
//            [m_actorTemplateArray addObject:actorTemplate];
//            num ++;
//        }
//    }
//}


-(void) addActorByFile:(NSString *)plistFile
{
    NSString *path = [[CCFileUtils sharedFileUtils] fullPathForFilename:plistFile];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *actorArray = (NSArray*)[dict objectForKey:@"actor_array"];
    for (id node in actorArray) {
        NSDictionary *actorDict = (NSDictionary*)node;
        NSString *textureFile = [actorDict objectForKey:@"texture"];
        NSString *textureFolder = [plistFile stringByDeletingLastPathComponent];
        NSString *texturePath = nil;
        texturePath = [textureFolder stringByAppendingPathComponent:textureFile];
		CCTexture2D *texture =[[CCTextureCache sharedTextureCache] addImage:texturePath];
        if (!texture) {
            NSLog(@"failed to load texture %@",texturePath);
            continue;
        }
        RCActorTemplate *actorTemplate = [RCActorTemplate actorTemplateWithDict:actorDict];
        actorTemplate.m_texture = texture;
        [m_actorTemplateArray addObject:actorTemplate];
    }
}

-(RCActorTemplate*) getActorTemplateByName:(NSString*) actorName
{
    RCActorTemplate *result = nil;
    for (id node in m_actorTemplateArray) {
        RCActorTemplate *actorTemplate = (RCActorTemplate*)node;
        if ([actorTemplate.m_name isEqualToString:actorName]) {
            result = actorTemplate;
            break;
        }
    }
    return result;
}

-(void) dumpAllActorTemplates
{
    [m_actorTemplateArray removeAllObjects];
}


@end
