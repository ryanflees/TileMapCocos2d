//
//  RCDPad.m
//  TileMap2d
//
//  Created by hy on 12/27/13.
//  Copyright 2013 Bai Ryan. All rights reserved.
//

#import "RCDPad.h"
#import "func.h"

@interface RCDPad ()
{
    bool m_pressed;
    NSUInteger touchHash;
}

- (CGRect)rect;
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;
- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event;
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event;
- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event;

@end

@implementation RCDPad
@synthesize m_direction;
@synthesize m_pressedVector;

-(id) init
{
    if ((self = [super init])) {
        m_pressedVector = CGPointZero;
        m_direction = kDPadNoDirection;
        m_pressed = NO;
        
        CCSpriteFrameCache *cache = [CCSpriteFrameCache sharedSpriteFrameCache];
		[cache addSpriteFramesWithFile:@"dpad_buttons.plist"];
		[self setDisplayFrame:[cache spriteFrameByName:@"d_pad_normal.png"]];
    }
    
    return self;
}

-(void) onEnter
{
    [super onEnter];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(void) onExit
{
    [super onExit];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

-(void) dealloc
{
    [super dealloc];
}

- (CGRect) rect {
	float scaleMod = 1.5f;
	float w = [self contentSize].width * [self scale] * scaleMod;
	float h = [self contentSize].height * [self scale] * scaleMod;
	CGPoint point = CGPointMake([self position].x - (w/2), [self position].y - (h/2));
	
	return CGRectMake(point.x, point.y, w, h);
}

-(void)processTouch:(CGPoint)point {
	CCSpriteFrameCache *cache = [CCSpriteFrameCache sharedSpriteFrameCache];
	[self setColor:ccc3(255,200,200)];
	m_pressed = YES;
	CGPoint center = CGPointMake( self.rect.origin.x+self.rect.size.width/2, self.rect.origin.y+self.rect.size.height/2 );
	if(distanceBetweenPoints(point, center) < self.rect.size.width/10){
		[self setDisplayFrame:[cache spriteFrameByName:@"d_pad_normal.png"]];
		self.rotation = 0;
		m_pressedVector = ccp(0,0);
		m_direction = kDPadNoDirection;
		return;
	}
	float radians = vectorToRadians( CGPointMake(point.x-center.x, point.y-center.y) );
	float degrees = radiansToDegrees(radians) + 90;
    float sin45 = 0.7071067812f;
	if(degrees >= 337.5 || degrees < 22.5){
		[self setDisplayFrame:[cache spriteFrameByName:@"d_pad_horizontal.png"]];
		self.rotation = 180;
        m_pressedVector = ccp(-1,0);
        m_direction = kDPadLeft;
	}else if(degrees >= 22.5 && degrees < 67.5){
		[self setDisplayFrame:[cache spriteFrameByName:@"d_pad_diagonal.png"]];
		self.rotation = -90;
        m_pressedVector = ccp(-sin45,sin45);
        m_direction = kDPadUpLeft;
	}else if(degrees >= 67.5 && degrees < 112.5){
		[self setDisplayFrame:[cache spriteFrameByName:@"d_pad_horizontal.png"]];
		self.rotation = -90;
        m_pressedVector = ccp(0,1);
        m_direction = kDPadUp;
	}else if(degrees >= 112.5 && degrees < 157.5){
		[self setDisplayFrame:[cache spriteFrameByName:@"d_pad_diagonal.png"]];
		self.rotation = 0;
        m_pressedVector = ccp(sin45,sin45);
        m_direction = kkDPadUpRight;
	}else if(degrees >= 157.5 && degrees < 202.5){
		[self setDisplayFrame:[cache spriteFrameByName:@"d_pad_horizontal.png"]];
		self.rotation = 0;
        m_pressedVector = ccp(1,0);
        m_direction = kkDPadRight;
	}else if(degrees >= 202.5 && degrees < 247.5){
		[self setDisplayFrame:[cache spriteFrameByName:@"d_pad_diagonal.png"]];
		self.rotation = 90;
        m_pressedVector = ccp(sin45,-sin45);
        m_direction = kDPadDownRight;
	}else if(degrees >= 247.5 && degrees < 292.5){
		[self setDisplayFrame:[cache spriteFrameByName:@"d_pad_horizontal.png"]];
		self.rotation = 90;
        m_pressedVector = ccp(0,-1);
        m_direction = kDPadDown;
	}else{
		[self setDisplayFrame:[cache spriteFrameByName:@"d_pad_diagonal.png"]];
		self.rotation = 180;
        m_pressedVector = ccp(-sin45,-sin45);
        m_direction = kDPadDownLeft;
	}
}

- (void)processRelease {
	[self setColor:ccc3(255,255,255)];
	CCSpriteFrameCache *cache = [CCSpriteFrameCache sharedSpriteFrameCache];
	[self setDisplayFrame:[cache spriteFrameByName:@"d_pad_normal.png"]];
	self.rotation = 0;
	m_pressed = false;
	m_pressedVector = ccp(0,0);
	m_direction = kDPadNoDirection;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [touch locationInView:[touch view]];
    point = [[CCDirector sharedDirector] convertToGL:point];
    if (pointIsInCircle(point, self.position, self.rect.size.width/2)) {
        touchHash = [touch hash];
        [self processTouch:point];
        return true;
    }
    return false;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [touch locationInView: [touch view]];
	point = [[CCDirector sharedDirector] convertToGL: point];
	
    if(touchHash == [touch hash])
    {
        [self processTouch:point];
    }else if(!m_pressed)
    {
        touchHash = [touch hash];
        [self processTouch:point];
    }
//	if(pointIsInCircle(point, self.position, self.rect.size.width/2)){
//		if(touchHash == [touch hash])
//        {
//            [self processTouch:point];
//		}else if(!m_pressed)
//        {
//            touchHash = [touch hash];
//			[self processTouch:point];
//		}
//	}else if(touchHash == [touch hash])
//    {
//        [self processRelease];
//	}
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	CGPoint point = [touch locationInView: [touch view]];
	point = [[CCDirector sharedDirector] convertToGL: point];
	
	if(touchHash == [touch hash])
    {
        [self processRelease];
	}
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [touch locationInView: [touch view]];
	point = [[CCDirector sharedDirector] convertToGL: point];
	
	if(touchHash == [touch hash])
    {
        [self processRelease];
	}
}


@end
