//
//  AboutViewController.m
//  JiuGongGe
//
//  Created by iDream002 on 11-12-13.
//  Copyright 2011 iDreamStudio. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController
@synthesize mytableView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[mytableView release];
    [super dealloc];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	NSString *sectionName =NSLocalizedString( @"关于制作团队" ,@"about");
	return sectionName;
	
}

-(NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
	NSString *sectionName = @"iDreamStudio";
	return sectionName;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *SettingCellIdentifier = @"AboutCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SettingCellIdentifier] autorelease];
	}
	if (indexPath.section == 0)	
	{
		if (indexPath.row == 0) 
		{
			UITextView *abouttext = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, 160)];
			abouttext.font = [UIFont fontWithName:@"Helvetica" size:18];
			abouttext.editable = NO;
			abouttext.text = NSLocalizedString(@"    九微格由华中科技大学腾讯创新俱乐部iDreamStudio工作室开发完成，感谢您对我们的支持。\n    如果你对本应用有什么意见或建议，我们欢迎您的批评指正。\n	作者：杜宇\n	EMail:dskyu2004@163.com",@"jianjie");
			[cell addSubview:abouttext];
			[abouttext release];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
		}
	}
	return cell;
}

- (CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 180;
}

@end
