//
//  SettingViewController.m
//  JiuGongGe
//
//  Created by dskyu on 11-3-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"


@implementation SettingViewController

@synthesize settingTableView;
@synthesize bgImageSelect;
@synthesize diaryImageSelect;
@synthesize bgSelectRow;
@synthesize diarySelectRow;
@synthesize photosViewController;
@synthesize planViewController;
@synthesize welcomeView;
@synthesize welcomeSwitch;
@synthesize tipSwitch;
@synthesize myslider;

 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
	 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) 
	 {
	 
	 }
	 return self;
 }


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

-(void) viewWillAppear:(BOOL)animated
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	self.bgImageSelect = [defaults objectForKey:kBgImage];
	self.diaryImageSelect = [defaults objectForKey:kDiaryImage];

	self.bgSelectRow = [defaults integerForKey:kBgNumber];
	self.diarySelectRow = [defaults integerForKey:kDiaryNumber];
	self.title = NSLocalizedString(@"设置",@"settingTitle");
	self.title = NSLocalizedString(@"设置 ",@"settingTitle1");

	JiuGongGeAppDelegate *app = [[UIApplication sharedApplication] delegate];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0f];
	app.rootViewController.view.frame = CGRectMake(0, 0, 320, 480);
	[UIView commitAnimations];
	[settingTableView reloadData];
	
	
}


-(void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];

}

- (void)dealloc {
	[photosViewController release];
	[planViewController release];
	[settingTableView release];
	[bgImageSelect release];
	[diaryImageSelect release];
	[welcomeSwitch release];
	[tipSwitch release];
	[myslider release];
    [super dealloc];
}
- (IBAction) switchValueChanged
{
	isChange = YES;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if (self.welcomeSwitch.on) {
		welcomeView = YES;
	}
	else {
		welcomeView = NO;
	}
	[defaults setBool:welcomeView forKey:kWelcomeView];
}

- (IBAction) sliderValueChanged
{
	isChange = YES;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setFloat:self.myslider.value forKey:kPaperAlpha];

}

-(void) tipSwitchValueChanged
{
	isChange = YES;
	BOOL flag;
	if (self.tipSwitch.on) {
		flag = YES;
	}
	else {
		flag = NO;
	}

	[[NSUserDefaults standardUserDefaults] setBool:flag forKey:kGestureTip];
}

#pragma mark -
#pragma mark Table Date Source Methods
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 4;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 0) {
		return 1;
	}
	if (section == 1) {
		return 3;
	}
	if (section == 2) {
		return 2;
	}
	return 1;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if (section == 0) {
		NSString *sectionName = NSLocalizedString(@"开机界面", @"WelcomeImage");
		return sectionName;
	}
	if (section == 1) {
		NSString *sectionName =NSLocalizedString( @"图片",@"PictureSettings");
		return sectionName;
	}
	if (section == 2) {
		NSString *sectionName =NSLocalizedString( @"账号" ,@"AccountSettings");
		return sectionName;
	}
	NSString *sectionName =NSLocalizedString( @"其它" ,@"OtherSettings");
	return sectionName;
	
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *SettingCellIdentifier = @"SettingCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SettingCellIdentifier] autorelease];
	}
	if (indexPath.section == 0)	
	{
		if (indexPath.row == 0) 
		{
			CGRect frame = CGRectMake(200, 9, 50, 60);
			self.welcomeSwitch.frame = frame;
			NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
			welcomeView = [defaults boolForKey:kWelcomeView];
			[self.welcomeSwitch setOn:welcomeView];
			[cell addSubview:welcomeSwitch];
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.textLabel.text = NSLocalizedString(@"是否打开欢迎界面:",@"isOpenWelcomeImage");
		}
	/*	if (indexPath.row == 1) 
		{
			NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
			
			UISwitch *mySwitch = [[UISwitch	alloc] initWithFrame:CGRectMake(200, 9, 50, 60)];
			[mySwitch setOn:[defaults boolForKey:kGestureTip]];
			[mySwitch addTarget:nil action:@selector(tipSwitchValueChanged) forControlEvents:UIControlEventValueChanged];
			self.tipSwitch = mySwitch;
			[mySwitch release];
			[cell addSubview:self.tipSwitch];
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.textLabel.text = NSLocalizedString(@"是否打开温馨提示:",@"isOpenGestureTip");
			 
		}*/
		
		
	}
	
	if (indexPath.section == 1)	{
		if (indexPath.row == 0) {
			cell.textLabel.text = NSLocalizedString(@"背景",@"background");
			cell.detailTextLabel.textAlignment = UITextAlignmentRight;
			cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.bgImageSelect];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; 
		}
		if (indexPath.row == 1) {
			cell.textLabel.text = NSLocalizedString(@"纸张",@"paper");
			cell.detailTextLabel.textAlignment = UITextAlignmentRight;
			cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.diaryImageSelect];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; 
		}
		if (indexPath.row == 2) {
			CGRect frame = CGRectMake(150, 0, 150, 44);
			self.myslider.frame = frame;
			[self.myslider setMinimumValue:0.5];
			NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
			myslider.value = [defaults floatForKey:kPaperAlpha];
			[cell addSubview:myslider];
			cell.textLabel.text = NSLocalizedString(@"纸张透明度",@"paper alpha");
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
	}
	if (indexPath.section == 2)	{
		if (indexPath.row == 0) {
			NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
			cell.textLabel.text = NSLocalizedString(@"标题方案",@"planOfTitle");
			cell.detailTextLabel.textAlignment = UITextAlignmentRight;
			cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[defaults objectForKey:kPlanName]];

		}
		if (indexPath.row == 1) {
			NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
			cell.textLabel.text = NSLocalizedString(@"微博账号",@"user");
			cell.detailTextLabel.textAlignment = UITextAlignmentRight;
	
			if (![[defaults objectForKey:kUserName] isEqualToString:@"0"]) {
				cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[defaults objectForKey:kUserName]];
			}
			else {
				cell.detailTextLabel.text = NSLocalizedString(@"未设置",@"No setting");
			}
			
		}
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; 
	}
	if (indexPath.section == 3) {
		if (indexPath.row == 0) {
			
			cell.textLabel.text = NSLocalizedString(@"关于",@"about");
			cell.detailTextLabel.textAlignment = UITextAlignmentRight;
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; 
		}
	}
	
	return cell;
}

#pragma mark Table Delegate Methods

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	isChange = YES;
	if (indexPath.section != 0) 
	{
		if (indexPath.section == 1)
		{
			if (indexPath.row != 2) 
			{
				JiuGongGeAppDelegate *app = [[UIApplication sharedApplication] delegate];
				[UIView beginAnimations:nil context:nil];
				[UIView setAnimationDuration:1.0f];
				app.rootViewController.view.frame = CGRectMake(0, -64, 320, 593);
				[UIView commitAnimations];
				
				PhotosViewController *photosView = [[[PhotosViewController alloc] initWithNibName:@"PhotosViewController" bundle:nil] autorelease];
				self.photosViewController = photosView;
				if (indexPath.row == 0)
				{
					self.photosViewController.num = 1;
				}
				else if (indexPath.row == 1) 
				{
					self.photosViewController.num = 2;
				}
				[self.navigationController pushViewController:photosView animated:YES];
				self.navigationController.navigationBar.backItem.title =NSLocalizedString( @"确定",@"doneButton");
			}
		}
		if (indexPath.section == 2) {
			JiuGongGeAppDelegate *app1 = [[UIApplication sharedApplication] delegate];
			[UIView beginAnimations:nil context:nil];
			[UIView setAnimationDuration:1.0f];
			app1.rootViewController.view.frame = CGRectMake(0, 20, 320, 529);
			[UIView commitAnimations];
			
			PlanViewController *planView = [[[PlanViewController alloc] initWithNibName:@"PlanViewController" bundle: nil] autorelease];
			self.planViewController = planView;
			if (indexPath.row == 0)
			{
				self.navigationController.navigationBar.backItem.title = NSLocalizedString(@"方案设定",@"planSetting");
				self.planViewController.number = 1;
			}
			else if (indexPath.row == 1)
			{
				self.navigationController.navigationBar.backItem.title = NSLocalizedString(@"账号设定",@"userSetting");
				self.planViewController.number = 2;
			}
			[self.navigationController pushViewController:planView animated:YES];
			
		}
		if (indexPath.section == 3) {
			AboutViewController *aboutView = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle: nil];
			self.navigationController.navigationBar.backItem.title = NSLocalizedString(@"关于",@"About");
			[self.navigationController pushViewController:aboutView animated:YES];
			[aboutView release];
		}
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	}

}


@end
