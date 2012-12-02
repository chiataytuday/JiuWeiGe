//
//  SettingViewController.h
//  JiuGongGe
//
//  Created by dskyu on 11-3-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PhotosViewController.h"
#import "PlanVIewController.h"
#import "AboutViewController.h"
#import "JiuGongGeAppDelegate.h"
#import "define.h"

extern BOOL isChange;

@interface SettingViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
	
	UITableView *settingTableView;

	NSString *bgImageSelect;
	NSString *diaryImageSelect;
	UISwitch *welcomeSwitch;
	UISwitch *tipSwitch;
	UISlider *myslider;
	int bgSelectRow;
	int diarySelectRow;
	BOOL welcomeView; 
	
	PlanViewController *planViewController;
	PhotosViewController *photosViewController;
}

@property (nonatomic ,retain) PhotosViewController *photosViewController;
@property (nonatomic ,retain) PlanViewController *planViewController;
@property (nonatomic ,retain) IBOutlet UITableView *settingTableView;
@property (nonatomic ,retain) NSString *bgImageSelect;
@property (nonatomic ,retain) NSString *diaryImageSelect;
@property (nonatomic ,retain) IBOutlet UISwitch *welcomeSwitch;
@property (nonatomic ,retain) IBOutlet UISwitch *tipSwitch;
@property (nonatomic ,retain) IBOutlet UISlider *myslider;
@property int bgSelectRow;
@property int diarySelectRow;
@property BOOL welcomeView;

- (IBAction) switchValueChanged;
- (IBAction) sliderValueChanged;
@end
