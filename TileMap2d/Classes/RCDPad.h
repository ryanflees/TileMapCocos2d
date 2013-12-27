//
//  RCDPad.h
//  TileMap2d
//
//  Created by hy on 12/27/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

enum
{
	kDPadNoDirection,
	kDPadUp,
	kkDPadUpRight,
	kkDPadRight,
	kDPadDownRight,
	kDPadDown,
	kDPadDownLeft,
	kDPadLeft,
	kDPadUpLeft
};

@interface RCDPad : CCSprite <CCTouchOneByOneDelegate>{
    CGPoint m_pressedVector;
    int m_direction;
}

@property (readonly, nonatomic) CGPoint m_pressedVector;
@property (readonly, nonatomic) int m_direction;

@end







