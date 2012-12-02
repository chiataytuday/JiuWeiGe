//
//  NavBeforeViewController.h
//  JiuGongGe
//
//  Created by bunny on 11-3-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NavBeforeViewController :UIViewController <UINavigationControllerDelegate>{
	UINavigationController *navController;
	
}
@property (nonatomic ,retain) UINavigationController *navController;

@end
