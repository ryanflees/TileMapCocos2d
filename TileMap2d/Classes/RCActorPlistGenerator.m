//
//  RCActorPlistGenerator.m
//  TileMap2d
//
//  Created by Bai Ryan on 13-12-29.
//  Copyright 2013年 Bai Ryan. All rights reserved.
//

#import "RCActorPlistGenerator.h"


@implementation RCActorPlistGenerator
static RCActorPlistGenerator *m_instanceOfActorPlistGenerator = nil;

+(id) sharedActorPlistGenerator
{
    if (!m_instanceOfActorPlistGenerator) {
        m_instanceOfActorPlistGenerator = [RCActorPlistGenerator node];
        [m_instanceOfActorPlistGenerator retain];
    }
    return m_instanceOfActorPlistGenerator;
}

-(id) init
{
    if ((self = [super init])) {
        
    }
    //[self generatePlistFile:CGSizeMake(72, 128) actorName:@"hero" image:@"game/DSMaterials/Graphics/Characters/01Hero.png"];
    
    return self;
}

-(void) dealloc
{
    [super dealloc];
}

-(void) generateActorPlistByFolder:(NSString*)imageSavedPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = [[NSError alloc] init];
    NSArray *fileArray = [[fileManager contentsOfDirectoryAtPath:imageSavedPath error:&error] pathsMatchingExtensions:[NSArray arrayWithObject:@"png"]];
    NSLog(@"fileList:");
    for(id node in fileArray)
    {
        NSString *fileName = (NSString*)node;
        NSLog(@"fileName:%@",fileName);
        NSString *imageFileFullPath = [@"game/DSMaterials/Graphics/Characters/" stringByAppendingString:fileName];
        [self generatePlistFile:CGSizeMake(72, 128) actorName:[fileName stringByDeletingPathExtension] image:imageFileFullPath];
    }
    [error release];
    
}

-(NSString*) getLocalFileFullPathString:(NSString*)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

-(void) generatePlistFile:(CGSize)actorBlockSize actorName:(NSString*)name image:(NSString*)image
{
    NSString *fileName = [NSString stringWithFormat:@"%@.plist",name];
    NSString *path = [self getLocalFileFullPathString:fileName];
    
    NSString *imageFileName = [image lastPathComponent];
    
    NSMutableArray *actorArray = [NSMutableArray array];
    CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:image];
    int actorBlockCols = (int)(texture.contentSizeInPixels.width/actorBlockSize.width);
    int actorBlockRows = (int)(texture.contentSizeInPixels.height/actorBlockSize.height);
    int count = 0;
    for (int i=0; i<actorBlockRows; i++) {
        for (int j=0; j<actorBlockCols; j++) {
            count ++;
            NSMutableDictionary *actorDict = [NSMutableDictionary dictionary];
            [actorDict setObject:imageFileName forKey:@"texture"];
            
            NSString *actorName = [NSString stringWithFormat:@"%@%i",name, count];
            [actorDict setObject:actorName forKey:@"name"];
            
            NSMutableArray *actionArray = [NSMutableArray array];
            [actorDict setObject:actionArray forKey:@"action_array"];
            
            float x = j * actorBlockSize.width;
            float y = i * actorBlockSize.height;
            CGRect actorBlockRect = CGRectMake(x,y,actorBlockSize.width,actorBlockSize.height);
            [self parseRect:actorBlockRect actionArray:actionArray];
            [actorArray addObject:actorDict];
        }
    }
    
    NSDictionary *rootDict = [NSDictionary dictionaryWithObject:actorArray forKey:@"actor_array"];
    
    bool res = [rootDict writeToFile:path atomically:NO];
    if (res) {
        NSLog(@"write file success");
    }
    else
    {
        NSLog(@"write file failed");
    }
}

-(void) parseRect:(CGRect)rect actionArray:(NSMutableArray*) actionArray
{
    CGSize actorSize = CGSizeMake(24, 32);
    for (int i=0; i<4; i++) {
        NSMutableDictionary *actionDict = [NSMutableDictionary dictionary];
        [actionArray addObject:actionDict];
        
        NSString *actionName;
        if (i == 0) {
            actionName = @"move_down";
        }
        else if (i == 1)
        {
            actionName = @"move_left";
        }
        else if (i == 2)
        {
            actionName = @"move_right";
        }
        else if (i == 3)
        {
            actionName = @"move_up";
        }
        [actionDict setObject:actionName forKey:@"action_name"];
        
        NSMutableArray *frameArray = [NSMutableArray array];
        [actionDict setObject:frameArray forKey:@"frame_array"];
        for (int j=0; j<3; j++) {
            if (j == 1) {
                continue;
            }
            int x = rect.origin.x + j * actorSize.width;
            int y = rect.origin.y + i * actorSize.height;
            CGRect frameRect = CGRectMake(x, y, actorSize.width, actorSize.height);
            
            NSString *xString = [NSString stringWithFormat:@"%i",x];
            NSString *yString = [NSString stringWithFormat:@"%i",y];
            NSString *wString = [NSString stringWithFormat:@"%i",(int)frameRect.size.width];
            NSString *hString = [NSString stringWithFormat:@"%i",(int)frameRect.size.height];
            
            NSMutableDictionary *rectDict = [NSMutableDictionary dictionary];
            [rectDict setObject:xString forKey:@"x"];
            [rectDict setObject:yString forKey:@"y"];
            [rectDict setObject:wString forKey:@"width"];
            [rectDict setObject:hString forKey:@"height"];
            
            [frameArray addObject:rectDict];
        }
    }
    
    for (int i=0; i<4; i++) {
        NSMutableDictionary *actionDict = [NSMutableDictionary dictionary];
        [actionArray addObject:actionDict];
        
        NSString *actionName;
        if (i == 0) {
            actionName = @"stand_down";
        }
        else if (i == 1)
        {
            actionName = @"stand_left";
        }
        else if (i == 2)
        {
            actionName = @"stand_right";
        }
        else if (i == 3)
        {
            actionName = @"stand_up";
        }
        [actionDict setObject:actionName forKey:@"action_name"];
        
        NSMutableArray *frameArray = [NSMutableArray array];
        [actionDict setObject:frameArray forKey:@"frame_array"];
        
        int x = rect.origin.x + 1 * actorSize.width;
        int y = rect.origin.y + i * actorSize.height;
        CGRect frameRect = CGRectMake(x, y, actorSize.width, actorSize.height);
        NSString *xString = [NSString stringWithFormat:@"%i",x];
        NSString *yString = [NSString stringWithFormat:@"%i",y];
        NSString *wString = [NSString stringWithFormat:@"%i",(int)frameRect.size.width];
        NSString *hString = [NSString stringWithFormat:@"%i",(int)frameRect.size.height];
        NSMutableDictionary *rectDict = [NSMutableDictionary dictionary];
        [rectDict setObject:xString forKey:@"x"];
        [rectDict setObject:yString forKey:@"y"];
        [rectDict setObject:wString forKey:@"width"];
        [rectDict setObject:hString forKey:@"height"];
        
        [frameArray addObject:rectDict];
    }
}

@end
