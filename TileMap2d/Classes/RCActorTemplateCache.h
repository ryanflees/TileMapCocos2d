//
//  RCActorPool.h
//  TileMap2d
//
//  Created by hy on 12/28/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface RCActorTemplateCache : CCNode {
    
}

+(RCActorTemplateCache*) sharedActorTemplateCache;

/** Load actors by an image file.
    Actors will be automatically divided as 23*32 pixels in 9 grids.
    Image may generate several actors if the size is big enough
 */
-(void) addActorByFile:(NSString*) imageFile name:(NSString*) name;

/** Load actors by an image file.
 Actors will be automatically divided as given size pixels in 9 grids.
 Image may generate several actors if the size is big enough
 */
-(void) addActorByFile:(NSString *)imageFile name:(NSString*) name actorSize:(CGSize) size;

/** Dump all actor template
 */
-(void) dumpAllActorTemplates;

@end
