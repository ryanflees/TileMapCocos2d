//
//  cool.h
//  WhiteBall
//
//  Created by Ryan Bai on 12-7-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#ifndef WhiteBall_cool_h
#define WhiteBall_cool_h

#define PI 3.14159f
#include "cocos2d.h"

float squareSumRoot(CGPoint vector)
{
    float sum = vector.x*vector.x + vector.y +vector.y;
    return sqrt(sum);
}

float degreesToRadians(float d){
	return d * (PI/180);
}

float radiansToDegrees(float r){
	return r * (180/PI);
}

float vectorToRadians(CGPoint vector){
	if(vector.y == 0){ vector.y = 0.000001f; }
	float baseRadians = atan(vector.x/vector.y);
	if(vector.y < 0){ baseRadians += PI; }	//Adjust for -Y
	return baseRadians;
}

CGPoint radiansToVector(float radians){
	return ccp(sin(radians-PI/2), cos(radians-PI/2));
}

float distanceBetweenPoints(CGPoint p1, CGPoint p2){
	return sqrt( pow( (p1.x-p2.x) ,2) + pow( (p1.y-p2.y) ,2) );
}

CGPoint vectorDistanceBetweenPoints(CGPoint p1,CGPoint p2)
{
    return ccp(p1.x-p2.x, p1.y-p2.y);
}

bool pointIsInRect(CGPoint p, CGRect r){
	bool isInRect = false;
	if( p.x < r.origin.x + r.size.width && 
	   p.x > r.origin.x &&
	   p.y < r.origin.y + r.size.height &&
	   p.y > r.origin.y )
	{
		isInRect = true;
	}
	return isInRect;
}

bool pointIsInCircle(CGPoint p, CGPoint origin, float radius){
	bool isInCircle = false;
	if(distanceBetweenPoints(p, origin) <= radius){
		isInCircle = true;
	}
	return isInCircle;
}

float angleDifference(float angleA, float angleB){
	float diff = fabs(angleA-angleB);
	if(fabs((angleA+360)-angleB) < diff){
		diff = fabs((angleA+360)-angleB);
	}
	if(fabs((angleA-360)-angleB) < diff){
		diff = fabs((angleA-360)-angleB);
	}
	if(fabs(angleA-(angleB+360)) < diff){
		diff = fabs(angleA-(angleB+360));
	}
	if(fabs(angleA-(angleB-360)) < diff){
		diff = fabs(angleA-(angleB-360));
	}
	return diff;
}

float absoluteValue(float num){
	if(num < 0){
		num = num * -1;
	}
	return num;
}

float convertPositionX(CGPoint areaSize, float x){
	return x - (areaSize.x/2);
}

float convertPositionY(CGPoint areaSize, float y){
	return y - (areaSize.y/2);
}

CGPoint midPoint(CGPoint p1, CGPoint p2){
	return ccp( (p1.x+p2.x)/2 , (p1.y+p2.y)/2 );
}

CGPoint getPositionOnTheCircle(CGPoint center,float radius,int angle)
{
    CGPoint pos;
    
    if(angle >= 0 || angle <= 90)
    {
        pos.x = cosf((float)angle*PI/180)*radius + center.x;
        pos.y = sinf((float)angle*PI/180)*radius + center.y;
    }
    else if(angle > 90 || angle <= 180)
    {
        int supplement = 180 - angle;
        pos.x = -cosf((float)supplement*PI/180)*radius + center.x;
        pos.y = sinf((float)supplement*PI/180)*radius + center.y;
    }
    else if(angle > 180 || angle <= 270)
    {
        int supplement = angle - 180;
        pos.x = -cosf((float)supplement*PI/180)*radius + center.x;
        pos.y = -sinf((float)supplement*PI/180)*radius + center.y;
    }
    else if(angle > 270 || angle <= 360)
    {
        int supplement = 360 - angle;
        pos.x = cosf((float)supplement*PI/180)*radius + center.x;
        pos.y = -sinf((float)supplement*PI/180)*radius + center.y;
    }
    return pos;
}

//

#endif
