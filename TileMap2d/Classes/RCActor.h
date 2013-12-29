//
//  RCActor.h
//  TileMap2d
//
//  Created by hy on 12/28/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class RCActorTemplate;

//typedef enum
//{
//    kActionMoveUp,
//    kActionMoveDown,
//    kActionMoveLeft,
//    kActionMoveRight,
//    kActionStandUp,
//    kActionStandDown,
//    kActionStandLeft,
//    kActionStandRight
//}ActorMoveDirectionEnum;

@interface RCActor : CCSprite {
    //int m_actionTag;
    NSString *m_curActionKey;
}

@property (nonatomic, readonly) NSString *m_curActionKey;
@property (nonatomic, readwrite) float m_speed;

+(id) actorWithTemplate:(RCActorTemplate*) actorTemplate;

-(void) setActorAction:(int) action;
-(void) setActorActionByKey:(NSString*) actionKey;

@end
