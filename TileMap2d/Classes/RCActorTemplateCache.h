//
//  RCActorPool.h
//  TileMap2d
//
//  Created by hy on 12/28/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class RCActorTemplate;

@interface RCActorTemplateCache : CCNode {
    
}

/** Load actors by an image file.
 Actors will be automatically divided as 24*32 pixels in 9 grids.
 Image may generate several actors if the size is big enough
 Unimpelemented.
 */
//-(void) addActorByImage:(NSString*) imageFile name:(NSString*) name;

/** Load actors by an image file.
 Actors will be automatically divided as given size pixels in 9 grids.
 Image may generate several actors if the size is big enough
 Unimpelemented.
 */
//-(void) addActorByImage:(NSString *)imageFile name:(NSString*) name actorSize:(CGSize) size;
//

+(RCActorTemplateCache*) sharedActorTemplateCache;


/**
 Load actors by plist file
 */
-(void) addActorByFile:(NSString*) plistFile;


-(RCActorTemplate*) getActorTemplateByName:(NSString*) actorName;

/** Dump all actor templates.
 */
-(void) dumpAllActorTemplates;

@end
