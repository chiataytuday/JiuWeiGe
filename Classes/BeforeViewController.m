
#import "BeforeViewController.h"

@implementation BeforeViewController

@synthesize myArray;
@synthesize mytableView;
@synthesize dateKeys;
@synthesize coverFlowToScanViewController;


- (NSString *) dataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"SavedImage.plist"];
}

- (void) viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBar.hidden = NO;
	[[UIApplication sharedApplication] setStatusBarHidden:NO];
	JiuGongGeAppDelegate *app = [[UIApplication sharedApplication] delegate];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0f];
	app.rootViewController.view.frame = CGRectMake(0, 0, 320, 480);
	[UIView commitAnimations];
	
	NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:[self dataFilePath]];
	if ([self.myArray count] <= 0 || ![self.myArray isEqualToArray:array])
	{
		self.myArray = array;
		[self.mytableView reloadData];
	}
	[array release];
	/*
	
	NSMutableArray *array2 = [[NSMutableArray alloc] initWithCapacity:[self.myArray count]+1];
	self.dateKeys = array2;
	[array2 release];
	
	NSString *lastString = [[NSString alloc] init];
	lastString = nil;
	
	NSNumber *count = [[NSNumber alloc] initWithInt:0];
	BOOL add = NO;
	
	for (NSString *string in self.myArray) 
	{
		if (![lastString isEqualToString:[[string substringFromIndex:string.length - 17] substringToIndex:10]]) 
		{
			lastString = [[string substringFromIndex:string.length - 17] substringToIndex:10];
			NSString *newString = [[NSString alloc] initWithString:lastString];
			[self.dateKeys addObject:newString];
			[newString release];
			
			add = YES;
			
			if (add && [count intValue] > 0) 
			{
				[self.dateKeys addObject:count];
				count = [NSNumber numberWithInt:0];
				add = NO;
			}
		}
		else 
		{
			int temp;
			temp = [count intValue] + 1;
			count = [NSNumber numberWithInt:temp];
			add	= NO;
		}
	}
	[count release];
	
	NSLog(@"%@",self.dateKeys);
	 */
}


- (void)viewDidLoad
{
    
	UIBarButtonItem *ScanButton = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"CoverFlow" ,@"CoverFlow" )
																   style:UIBarButtonItemStyleBordered 
																  target:self 
																  action:@selector(CoverFlowScan)] autorelease];
	self.navigationItem.rightBarButtonItem = ScanButton;
	
	UIBarButtonItem *deleteButton = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"删除" ,@"deleteImage")
																	style:UIBarButtonItemStyleBordered 
																   target:self 
																   action:@selector(deleteRecord)] autorelease];
	self.navigationItem.leftBarButtonItem = deleteButton;
	
	self.title = NSLocalizedString(@"以前的日记",@"beforeImage");
	
	NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:[self dataFilePath]];
	self.myArray = array;
	[array release];
	
	[super viewDidLoad];
}

- (void) CoverFlowScan
{
	if ([self.myArray count] > 0) {
		self.navigationController.navigationBar.hidden = YES;
		CoverFlowToScan *addView = [[[CoverFlowToScan alloc] initWithNibName:@"CoverFlowToScan" bundle: nil] autorelease];
		self.coverFlowToScanViewController = addView;
		self.coverFlowToScanViewController.number = 1;
		self.coverFlowToScanViewController.showImage = nil;
		NSString *string = [[NSString alloc] initWithString:[myArray objectAtIndex:0]];
		self.coverFlowToScanViewController.imageLabelName = [NSString stringWithFormat:@"%@ 1 of %d",
															 [[string substringFromIndex:string.length - 17] substringToIndex:13]
															 ,[myArray count]];
		[string release];
		
		dataArray = self.myArray;
		[self.navigationController pushViewController:addView animated:YES];	
		
		
		JiuGongGeAppDelegate *app = [[UIApplication sharedApplication] delegate];
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:1.0f];
		app.rootViewController.view.frame = CGRectMake(0, 0, 320, 529);
		[UIView commitAnimations];
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告" ,@"alertTitle")
														message:NSLocalizedString(@"无内容",@"alertContent") 
													   delegate:nil 
											  cancelButtonTitle:NSLocalizedString(@"确定" ,@"yesButton")
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
		
}

- (void) deleteRecord
{
	if ([self.myArray count] > 0) {
		[self.mytableView setEditing:!self.mytableView.editing animated:YES];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告" ,@"alertTitle")
														message:NSLocalizedString(@"无内容",@"alertContent") 
													   delegate:nil 
											  cancelButtonTitle:NSLocalizedString(@"确定" ,@"yesButton")
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

- (void) dealloc
{
	[coverFlowToScanViewController release];
	[mytableView release];
	[myArray release];
	[dateKeys release];
	[super dealloc];
}

#pragma mark -
#pragma mark tableViewDelegate

- (NSInteger ) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.myArray count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *BeforeCellIdentifier = @"BeforeCellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BeforeCellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:BeforeCellIdentifier] autorelease];
	}
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	NSArray *array = [[NSArray alloc] initWithContentsOfFile:[self dataFilePath]];
	NSString *string = [[NSString alloc] initWithString:[array objectAtIndex:indexPath.row]];
	cell.textLabel.textAlignment = UITextAlignmentRight;
	cell.textLabel.text = [[string substringFromIndex:string.length - 17] substringToIndex:13];
	cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	[array release];
	[string release];
	UIImage *image = [[UIImage alloc] initWithContentsOfFile:[self.myArray objectAtIndex:indexPath.row]];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	imageView.frame = CGRectMake(20, 10, 140, 168);
	[cell addSubview:imageView];
	[imageView release];
	[image release];
	return cell;
}

- (CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 188;
}

- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	self.navigationController.navigationBar.hidden = YES;
	CoverFlowToScan *addView = [[[CoverFlowToScan alloc] initWithNibName:@"CoverFlowToScan" bundle: nil] autorelease];
	self.coverFlowToScanViewController = addView;
	self.coverFlowToScanViewController.number = 2;
	UIImage *image = [[UIImage alloc] initWithContentsOfFile:[self.myArray objectAtIndex:indexPath.row]];
	self.coverFlowToScanViewController.showImage = image;
	self.coverFlowToScanViewController.imageLabelName = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
	[image release];
	dataArray = nil;
	[self.navigationController pushViewController:addView animated:YES];	
	
	JiuGongGeAppDelegate *app = [[UIApplication sharedApplication] delegate];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0f];
	app.rootViewController.view.frame = CGRectMake(0, 0, 320, 529);
	[UIView commitAnimations];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
		
}



- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
		   editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}

- (BOOL) tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)
editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSUInteger row=[indexPath row];
	
	NSError *error;
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	UITableViewCell *cell = [[UITableViewCell alloc] init];
	cell = [mytableView cellForRowAtIndexPath:indexPath];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",cell.textLabel.text]];
	if ([fileMgr removeItemAtPath:filePath error:&error] != YES)
	{
		NSLog(@"Unable to delete file: %@", [error localizedDescription]);
	}
	//显示文件目录的内容

	[self.myArray removeObjectAtIndex:row];
	[self.myArray writeToFile:[self dataFilePath] atomically:YES];
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
					 withRowAnimation:UITableViewRowAnimationFade];
		
}

@end
