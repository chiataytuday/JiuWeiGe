//
//  NavSettingViewController.m
//  JiuGongGe
//
//  Created by dskyu on 11-3-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NavSettingViewController.h"
#import "SettingViewController.h"

@implementation NavSettingViewController

@synthesize navController;


-(void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	[viewController viewWillAppear:animated];
}

-(void) navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	[viewController viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated 
{   
	[super viewWillAppear:animated];     
	[self.navController viewWillAppear:animated];  
} 

- (void)viewDidLoad {
	SettingViewController *settingController = [[SettingViewController alloc] initWithNibName:@"SettingView" bundle:nil];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:settingController];
	self.navController = nav;
	self.navController.delegate = self;
	[self.view addSubview:self.navController.view];
    [super viewDidLoad];
}


- (void)dealloc {
	[navController release];
    [super dealloc];
}


@end
