//
//  RCActorPlistGenerator.h
//  TileMap2d
//
//  Created by Bai Ryan on 13-12-29.
//  Copyright 2013年 Bai Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface RCActorPlistGenerator : CCNode {
    
}

+(id) sharedActorPlistGenerator;

-(void) generateActorPlistByFolder:(NSString*)imageSavedPath image:(NSString*)image;

@end
