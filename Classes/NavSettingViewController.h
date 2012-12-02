//
//  NavSettingViewController.h
//  JiuGongGe
//
//  Created by dskyu on 11-3-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NavSettingViewController : UIViewController <UINavigationControllerDelegate>{
	UINavigationController *navController;

}
@property (nonatomic ,retain) UINavigationController *navController;

@end
