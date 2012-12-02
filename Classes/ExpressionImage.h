//
//  ExpressionImage.h
//  JiuGongGe
//
//  Created by bunny on 11-3-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"

extern void *GeZiCenter;

@interface ExpressionImage : UIScrollView {
	
	UIImage *myImage;
	UIImageView *myImageView;
	NSInteger number;

}

@property (nonatomic ,retain) UIImage *myImage; 
@property (nonatomic ,retain) UIImageView *myImageView;
@property (readwrite) NSInteger number;
@end
