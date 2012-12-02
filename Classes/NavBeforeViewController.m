//
//  NavBeforeViewController.m
//  JiuGongGe
//
//  Created by bunny on 11-3-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NavBeforeViewController.h"
#import "BeforeViewController.h"

@implementation NavBeforeViewController

@synthesize navController;


-(void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	[viewController viewWillAppear:animated];
}

-(void) navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	[viewController viewDidAppear:animated];
}

- (void)viewDidLoad {
	BeforeViewController *beforeController = [[BeforeViewController alloc] initWithNibName:@"BeforeViewController" bundle:nil];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:beforeController];
	self.navController = nav;
	self.navController.delegate = self;
	[self.view addSubview:self.navController.view];
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated 
{   [super viewWillAppear:animated];     
	[self.navController viewWillAppear:animated];  
	//tabbarController直接用selectedViewController更方便 
} 



- (void)dealloc {
	[navController release];
    [super dealloc];
}


@end
