//
//  RCUILayer.h
//  TileMap2d
//
//  Created by hy on 12/27/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface RCUILayer : CCLayer {
    
}

-(void) showDPadAt:(CGPoint)position;

-(void) showDPadAt:(CGPoint)position scale:(float) scale;

@end
