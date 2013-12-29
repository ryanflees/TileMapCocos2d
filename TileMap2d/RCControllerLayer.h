//
//  RCControllerLayer.h
//  TileMap2d
//
//  Created by Bai Ryan on 13-12-29.
//  Copyright 2013年 Bai Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class RCControllerLayer;

@protocol RCControllerLayerDelegate <NSObject>
@required
-(void) updateControllerVector:(RCControllerLayer*) controllerLayer vector:(CGPoint) pressedVector delta:(ccTime)delta;

@end

@interface RCControllerLayer : CCLayer {
}
@property (nonatomic, retain)id<RCControllerLayerDelegate> m_delegate;

@end
