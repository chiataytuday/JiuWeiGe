//
//  PlanViewController.m
//  JiuGongGe
//
//  Created by dskyu on 11-3-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlanViewController.h"


@implementation PlanViewController

@synthesize mytableView;
@synthesize myArray;
@synthesize addPlanViewController;
@synthesize mutableDictionary;
@synthesize number;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
	
        
    }
    return self;
}

- (NSString *) dataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	if (self.number == 1) 
	{
		return [documentsDirectory stringByAppendingPathComponent:@"FangAn.plist"];
	}
	else if	(self.number == 2)
	{
		return [documentsDirectory stringByAppendingPathComponent:@"User.plist"];
	}
	return nil;
}

- (void) viewWillAppear:(BOOL)animated
{
	NSString *paths = [[NSString alloc] initWithString:[self dataFilePath]];
	if([[NSFileManager defaultManager]fileExistsAtPath:paths])
	{
		NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:paths];
		self.mutableDictionary = dictionary;
		NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[self.mutableDictionary allKeys]];
		self.myArray = array;
		[array release];
		[dictionary release];
	}
	[paths release];
	[mytableView reloadData];
}


- (void)viewDidLoad {
	
	UIBarButtonItem *button = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"添加" ,@"addButton")
																  style:UIBarButtonItemStyleBordered 
																 target:self 
																 action:@selector(addPlan)] autorelease];
	self.navigationItem.rightBarButtonItem = button;
	
	if (self.number == 1) {
		self.title = NSLocalizedString(@"可选方案",@"avaliablePlan");
	}
	else if (self.number == 2)
	{
		self.title = NSLocalizedString(@"可选账号",@"avaliableUser");
	}
	
    [super viewDidLoad];
}

- (void) addPlan
{
	AddPlanViewController *addView = [[[AddPlanViewController alloc] initWithNibName:@"AddPlanViewController" bundle: nil] autorelease];
	self.addPlanViewController = addView;
	self.addPlanViewController.mutableDictionary = self.mutableDictionary;
	self.addPlanViewController.myarray = nil;
	self.addPlanViewController.number = 0;
	if (self.number == 1) {
		self.addPlanViewController.isAddPlan = YES;
		self.addPlanViewController.title = NSLocalizedString( @"添加自定义方案",@"navTitle");
		self.title = NSLocalizedString(@"可选方案",@"avaliablePlan");
	}
	else if (self.number == 2) {
		self.addPlanViewController.isAddPlan = NO;
		self.addPlanViewController.title = NSLocalizedString( @"添加账号(新浪)",@"navTitle");
		self.title = NSLocalizedString(@"可选账号",@"avaliableUser");
	}

	[self.navigationController pushViewController:addView animated:YES];	
}



- (IBAction) deletePlan
{
	[self.mytableView setEditing:!self.mytableView.editing animated:YES];
		
}

- (void)dealloc {
	[myArray release];
	[mytableView release];
	[addPlanViewController release];
	[mutableDictionary release];
    [super dealloc];
}

#pragma mark -
#pragma mark TabelViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.myArray count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *PlanCellIdentifier = @"PlanCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PlanCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:PlanCellIdentifier] autorelease];
	}
	NSLog(@"%@,%@",self.mutableDictionary,[NSString stringWithFormat:@"Plan%d", indexPath.row+1]);
	
	if (self.number == 1) {
		NSArray *array = [self.mutableDictionary objectForKey:[NSString stringWithFormat:@"Plan%d", indexPath.row+1]];
		NSString *string = [[NSString alloc] initWithString:[array objectAtIndex:8]];
		cell.textLabel.text = string;
		[string release];
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
		
	}
	else if (self.number == 2)
	{
		NSArray *array = [self.mutableDictionary objectForKey:[NSString stringWithFormat:@"User%d", indexPath.row+1]];
		NSString *string = [[NSString alloc] initWithString:[array objectAtIndex:0]];
		cell.textLabel.text = string;
		[string release];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	return cell;
	
}

#pragma mark TabelViewDelegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (self.number == 1) 
	{
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setObject:[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text] forKey:kPlanName];
		NSString *string = [[NSString alloc] initWithFormat:@"Plan%d",indexPath.row + 1];
		[defaults setObject:string forKey:kPlan];
		[string release];
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		self.title = [NSString stringWithFormat:NSLocalizedString(@"可选方案(%@)",@"avaliablePlan"),[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text]];
	}
	else if (self.number == 2)
	{
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setObject:[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text] forKey:kUserName];
		NSString *string = [[NSString alloc] initWithFormat:@"User%d",indexPath.row + 1];
		[defaults setObject:string forKey:kUser];
		[string release];
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
		self.title = [NSString stringWithFormat:NSLocalizedString(@"可选账号(%@)",@"avaliableUser"),[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text]];
	}
	isChange = YES;
}

- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	AddPlanViewController *addView = [[[AddPlanViewController alloc] initWithNibName:@"AddPlanViewController" bundle: nil] autorelease];
	self.addPlanViewController = addView;
	self.addPlanViewController.mutableDictionary = self.mutableDictionary;
		
	if (self.number == 1) {	
		self.addPlanViewController.myarray = [self.mutableDictionary objectForKey:[NSString stringWithFormat:@"Plan%d",indexPath.row + 1]];
		self.addPlanViewController.number = indexPath.row + 1;
		self.addPlanViewController.title = [self.addPlanViewController.myarray objectAtIndex:8];
		self.addPlanViewController.isAddPlan = YES;
		self.title = NSLocalizedString(@"可选方案",@"avaliablePlan");
	}
	else if (self.number == 2)
	{
		self.addPlanViewController.myarray = [self.mutableDictionary objectForKey:[NSString stringWithFormat:@"User%d",indexPath.row + 1]];
		self.addPlanViewController.number = indexPath.row + 1;
		self.addPlanViewController.title = [self.addPlanViewController.myarray objectAtIndex:0];
		self.addPlanViewController.isAddPlan = NO;
		self.title = NSLocalizedString(@"可选账号",@"avaliableUser");
		
	}	
		
	[self.navigationController pushViewController:addView animated:YES];
	
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
		   editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
		return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)
		editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *cellText = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([cellText isEqualToString:[defaults objectForKey:kUserName]]) 
	{
		[defaults setObject:@"0" forKey:kUserName];
	}
	else if ([cellText isEqualToString:[defaults objectForKey:kPlanName]])
	{
		[defaults setObject:@"Plan1" forKey:kPlan];
		[defaults setObject:@"默认" forKey:kPlanName];
	}
	
	
	if ([[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text] isEqualToString:@"默认"]) 
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告",@"alertTitle") 
														message:NSLocalizedString(@"这个不能删除",@"alertContent")
													   delegate:nil 
											  cancelButtonTitle:NSLocalizedString(@"确定",@"yesButton")
											  otherButtonTitles: nil];
		[alert show];
		[alert release];
	}
	else 
	{
		NSUInteger row=[indexPath row];
		
		NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] initWithCapacity:[self.mutableDictionary count]];
		int k = 1;
		int p = 1;
		BOOL flag = YES;
		for (int i = 0; i < [self.myArray count]; i++)
		{
			if (i == row && flag == YES) 
			{
				flag = NO;
				p++;
			}
			else {
				if (self.number == 1) {
					NSArray *tempArray = [self.mutableDictionary objectForKey:[NSString stringWithFormat: @"Plan%d",p]];
					p++;
					[tempDictionary setObject:tempArray forKey:[NSString stringWithFormat:@"Plan%d",k]];
					k++;
				}
				else if (self.number == 2)
				{
					NSArray *tempArray = [self.mutableDictionary objectForKey:[NSString stringWithFormat: @"User%d",p]];
					p++;
					[tempDictionary setObject:tempArray forKey:[NSString stringWithFormat:@"User%d",k]];
					k++;
				}
			}
		}
		[tempDictionary writeToFile:[self dataFilePath] atomically:YES];
		[tempDictionary release];
		[self.myArray removeObjectAtIndex:row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
						 withRowAnimation:UITableViewRowAnimationFade];
		
	}
}

@end
