//
//  RCActorTemplate.h
//  TileMap2d
//
//  Created by hy on 12/28/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface RCActorTemplate : CCNode {
    NSString *m_name;
}

@property (nonatomic, retain) NSString *m_name;

+(id) actorTemplateWithRect:(CGRect)rect actorSize:(CGSize)actorSize;

@end
