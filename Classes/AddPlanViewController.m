//
//  AddPlanViewController.m
//  JiuGongGe
//
//  Created by dskyu on 11-3-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddPlanViewController.h"

@implementation AddPlanViewController

@synthesize mutableDictionary;
@synthesize myarray;
@synthesize scrollView;
@synthesize customView1;
@synthesize customView2;
@synthesize customView3;
@synthesize customView4;
@synthesize customView5;
@synthesize customView6;
@synthesize customView7;
@synthesize customView8;
@synthesize customView9;
@synthesize number;
@synthesize isAddPlan;

- (NSString *) dataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	if (self.isAddPlan) {
		return [documentsDirectory stringByAppendingPathComponent:@"FangAn.plist"];
	}
	else 
	{
		return [documentsDirectory stringByAppendingPathComponent:@"User.plist"];
	}
	return nil;

	
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}

- (void)viewDidLoad {
	UIBarButtonItem *button = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"确定",@"barButton") 
																style:UIBarButtonItemStyleBordered 
															   target:self 
															   action:@selector(addRecord)] autorelease];
	button.style = UIBarButtonItemStyleBordered;
	self.navigationItem.rightBarButtonItem = button;
	
	
	int h = 44;
	int w = 302;
	
	if (self.isAddPlan) {
		NSArray *View9 = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil];
		self.customView9 = [View9 objectAtIndex:0];
		self.customView9.frame = CGRectMake(10, 10, w, h);
		self.customView9.backgroundColor = [UIColor clearColor];
		self.customView9.BgImage.image = [UIImage imageNamed:@"p1.png"];
		self.customView9.BgImage.bounds = CGRectMake(0, 0, w, h);
		self.customView9.noteLabel.text = NSLocalizedString(@"方案名:",@"labelText");
		self.customView9.noteTextField.tag = 200;
		self.customView9.noteTextField.delegate = self;
		[self.scrollView addSubview:self.customView9];
		
		NSArray *View1 = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil];
		self.customView1 = [View1 objectAtIndex:0];
		self.customView1.frame = CGRectMake(10, 10 + h * 1, w, h);
		self.customView1.backgroundColor = [UIColor clearColor];
		self.customView1.BgImage.image = [UIImage imageNamed:@"p2.png"];
		self.customView1.BgImage.bounds = CGRectMake(0, 0, w, h);
		self.customView1.noteLabel.text = NSLocalizedString(@"标题1:",@"addNumTitle");
		self.customView1.noteTextField.tag = 201;
		self.customView1.noteTextField.delegate = self;
		[self.scrollView addSubview:self.customView1];
		
		NSArray *View2 = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil];
		self.customView2 = [View2 objectAtIndex:0];
		self.customView2.frame = CGRectMake(10, 10 + h * 2, w, h);
		self.customView2.backgroundColor = [UIColor clearColor];
		self.customView2.BgImage.image = [UIImage imageNamed:@"p2.png"];
		self.customView2.BgImage.bounds = CGRectMake(0, 0, w, h);
		self.customView2.noteLabel.text = NSLocalizedString(@"标题2:",@"addNumTitle");
		self.customView2.noteTextField.tag = 202;
		self.customView2.noteTextField.delegate = self;
		[self.scrollView addSubview:self.customView2];
		
		NSArray *View3 = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil];
		self.customView3 = [View3 objectAtIndex:0];
		self.customView3.frame = CGRectMake(10, 10 + h * 3, w, h);
		self.customView3.backgroundColor = [UIColor clearColor];
		self.customView3.BgImage.image = [UIImage imageNamed:@"p2.png"];
		self.customView3.BgImage.bounds = CGRectMake(0, 0, w, h);
		self.customView3.noteLabel.text = NSLocalizedString(@"标题3:",@"addNumTitle");
		self.customView3.noteTextField.tag = 203;
		self.customView3.noteTextField.delegate = self;
		[self.scrollView addSubview:self.customView3];
		
		NSArray *View4 = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil];
		self.customView4 = [View4 objectAtIndex:0];
		self.customView4.frame = CGRectMake(10, 10 + h * 4, w, h);
		self.customView4.backgroundColor = [UIColor clearColor];
		self.customView4.BgImage.image = [UIImage imageNamed:@"p2.png"];
		self.customView4.BgImage.bounds = CGRectMake(0, 0, w, h);
		self.customView4.noteLabel.text = NSLocalizedString(@"标题4:",@"addNumTitle");
		self.customView4.noteTextField.tag = 204;
		self.customView4.noteTextField.delegate = self;
		[self.scrollView addSubview:self.customView4];
		
		NSArray *View5 = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil];
		self.customView5 = [View5 objectAtIndex:0];
		self.customView5.frame = CGRectMake(10, 10 + h * 5, w, h);
		self.customView5.backgroundColor = [UIColor clearColor];
		self.customView5.BgImage.image = [UIImage imageNamed:@"p2.png"];
		self.customView5.BgImage.bounds = CGRectMake(0, 0, w, h);
		self.customView5.noteLabel.text = NSLocalizedString(@"标题5:",@"addNumTitle");
		self.customView5.noteTextField.tag = 205;
		self.customView5.noteTextField.delegate = self;
		[self.scrollView addSubview:self.customView5];
		
		NSArray *View6 = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil];
		self.customView6 = [View6 objectAtIndex:0];
		self.customView6.frame = CGRectMake(10, 10 + h * 6, w, h);
		self.customView6.backgroundColor = [UIColor clearColor];
		self.customView6.BgImage.image = [UIImage imageNamed:@"p2.png"];
		self.customView6.BgImage.bounds = CGRectMake(0, 0, w, h);
		self.customView6.noteLabel.text = NSLocalizedString(@"标题6:",@"addNumTitle");
		self.customView6.noteTextField.tag = 206;
		self.customView6.noteTextField.delegate = self;
		[self.scrollView addSubview:self.customView6];
		
		NSArray *View7 = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil];
		self.customView7 = [View7 objectAtIndex:0];
		self.customView7.frame = CGRectMake(10, 10 + h * 7, w, h);
		self.customView7.backgroundColor = [UIColor clearColor];
		self.customView7.BgImage.image = [UIImage imageNamed:@"p2.png"];
		self.customView7.BgImage.bounds = CGRectMake(0, 0, w, h);
		self.customView7.noteLabel.text = NSLocalizedString(@"标题7:",@"addNumTitle");
		self.customView7.noteTextField.tag = 207;
		self.customView7.noteTextField.delegate = self;
		[self.scrollView addSubview:self.customView7];
		
		NSArray *View8 = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil];
		self.customView8 = [View8 objectAtIndex:0];
		self.customView8.frame = CGRectMake(10, 10 + h * 8, w, h);
		self.customView8.backgroundColor = [UIColor clearColor];
		self.customView8.BgImage.image = [UIImage imageNamed:@"p3.png"];
		self.customView8.BgImage.bounds = CGRectMake(0, 0, w, h);
		self.customView8.noteLabel.text = NSLocalizedString(@"标题8:",@"addNumTitle");
		self.customView8.noteTextField.tag = 208;
		self.customView8.noteTextField.delegate = self;
		[self.scrollView addSubview:self.customView8];
		
		if (self.number > 0) {
			self.customView1.noteTextField.text = [self.myarray objectAtIndex:0];
			self.customView2.noteTextField.text = [self.myarray objectAtIndex:1];
			self.customView3.noteTextField.text = [self.myarray objectAtIndex:2];
			self.customView4.noteTextField.text = [self.myarray objectAtIndex:3];
			self.customView5.noteTextField.text = [self.myarray objectAtIndex:4];
			self.customView6.noteTextField.text = [self.myarray objectAtIndex:5];
			self.customView7.noteTextField.text = [self.myarray objectAtIndex:6];
			self.customView8.noteTextField.text = [self.myarray objectAtIndex:7];
			self.customView9.noteTextField.text = [self.myarray objectAtIndex:8];
		}
		else {
			NSString *string = NSLocalizedString(@"请输入标题",@"placeholderText");
			self.customView1.noteTextField.placeholder = string;
			self.customView2.noteTextField.placeholder = string;
			self.customView3.noteTextField.placeholder = string;
			self.customView4.noteTextField.placeholder = string;
			self.customView5.noteTextField.placeholder = string;
			self.customView6.noteTextField.placeholder = string;
			self.customView7.noteTextField.placeholder = string;
			self.customView8.noteTextField.placeholder = string;
			self.customView9.noteTextField.placeholder = NSLocalizedString(@"请输入标题名",@"placeholderText");
			
		}

		
		self.scrollView.contentSize = CGSizeMake(320, 700);
		self.scrollView.showsHorizontalScrollIndicator = NO;
	}
	else {
		
		NSArray *View8 = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil];
		self.customView8 = [View8 objectAtIndex:0];
		self.customView8.frame = CGRectMake(10, 10 + h * 1 + 1, w, h);
		self.customView8.backgroundColor = [UIColor clearColor];
		self.customView8.BgImage.image = [UIImage imageNamed:@"p3.png"];
		self.customView8.BgImage.bounds = CGRectMake(0, 0, w, h);
		self.customView8.noteLabel.text =NSLocalizedString( @"密码:",@"passwordTitle");
		self.customView8.noteTextField.tag = 201;
		self.customView8.noteTextField.delegate = self;
		[self.scrollView addSubview:self.customView8];
		
		
		NSArray *View9 = [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil];
		self.customView9 = [View9 objectAtIndex:0];
		self.customView9.frame = CGRectMake(10, 10, w, h);
		self.customView9.backgroundColor = [UIColor clearColor];
		self.customView9.BgImage.image = [UIImage imageNamed:@"p1.png"];
		self.customView9.BgImage.bounds = CGRectMake(0, 0, w, h);
		self.customView9.noteLabel.text = NSLocalizedString(@"账号:",@"userTitle");
		self.customView9.noteTextField.tag = 200;
		self.customView9.noteTextField.delegate = self;
		[self.scrollView addSubview:self.customView9];
		
		
		self.scrollView.contentSize = CGSizeMake(320, 500);
		self.scrollView.showsHorizontalScrollIndicator = NO;
		
		if (self.number > 0) {
			self.customView8.noteTextField.text = [self.myarray objectAtIndex:1];
			self.customView9.noteTextField.text = [self.myarray objectAtIndex:0];
		}
		else {
			self.customView8.noteTextField.placeholder =NSLocalizedString( @"请输入密码",@"placeholderTitle");
			self.customView9.noteTextField.placeholder =NSLocalizedString( @"请输入账号",@"placeholderTitle");
			self.customView8.noteTextField.secureTextEntry =  YES;
		}


	}
	
    [super viewDidLoad];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
	[self.scrollView setContentOffset:CGPointMake(0, (textField.tag-202 )* 44) animated:YES];
}
- (void) addRecord
{
	if (self.isAddPlan)
	{
		NSString *planName = [[NSString alloc] initWithString:customView9.noteTextField.text];
		NSString *str1 = [[NSString alloc] initWithString:customView1.noteTextField.text];
		NSString *str2 = [[NSString alloc] initWithString:customView2.noteTextField.text];
		NSString *str3 = [[NSString alloc] initWithString:customView3.noteTextField.text];
		NSString *str4 = [[NSString alloc] initWithString:customView4.noteTextField.text];
		NSString *str5 = [[NSString alloc] initWithString:customView5.noteTextField.text];
		NSString *str6 = [[NSString alloc] initWithString:customView6.noteTextField.text];
		NSString *str7 = [[NSString alloc] initWithString:customView7.noteTextField.text];
		NSString *str8 = [[NSString alloc] initWithString:customView8.noteTextField.text];
		
		if (planName.length < 1 || str1.length < 1 || str2.length < 1 || str3.length < 1 || str4.length < 1 || str5.length < 1 || str6.length < 1 || str7.length < 1 || str8.length < 1 ) 
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告",@"alertTitle")
															message:NSLocalizedString(@"请填写完整" ,@"alertContent")
														   delegate:nil 
												  cancelButtonTitle:NSLocalizedString(@"确定",@"yesButton") 
												  otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		else
		{
			NSArray *array = [[NSArray alloc] initWithObjects:str1,str2,str3,str4,str5,str6,str7,str8,planName,nil];
			if (self.number == 0)
			{
				NSString *string = [[NSString alloc] initWithFormat:@"Plan%d",[[self.mutableDictionary allKeys] count]+1];
				[self.mutableDictionary setObject:array forKey:string];
				[string release];
				[self.mutableDictionary writeToFile:[self dataFilePath] atomically:YES];
			}
			else 
			{
				if ([[self.myarray objectAtIndex:8] isEqualToString:@"默认"]) 
				{
					
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告",@"alertTitle") 
																	message:NSLocalizedString(@"这个不能更改" ,@"alertContent")
																   delegate:nil 
														  cancelButtonTitle:NSLocalizedString(@"确定",@"yesButton") 
														  otherButtonTitles:nil];
					[alert show];
					[alert release];
				}
				else {
					NSString *string = [[NSString alloc] initWithFormat:@"Plan%d",self.number];
					[self.mutableDictionary setObject:array forKey:string];
					[string release];
					if (![planName isEqualToString:[self.myarray objectAtIndex:8]]) 
					{
						NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
						[defaults setObject:planName forKey:kPlanName];
					}
					[self.mutableDictionary writeToFile:[self dataFilePath] atomically:YES];
				}
				
			}
			[array release];
			[self.navigationController popViewControllerAnimated:YES];
		}
		
	}
	else
	{
		NSString *userName = [[NSString alloc] initWithString:customView9.noteTextField.text];
		NSString *passWord = [[NSString alloc] initWithString:customView8.noteTextField.text];
		
		if (userName.length < 1 || passWord.length < 1)
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告",@"alertTitle")
															message:NSLocalizedString(@"请填写完整" ,@"alertContent")
														   delegate:nil 
												  cancelButtonTitle:NSLocalizedString(@"确定",@"yesButton") 
												  otherButtonTitles:nil];
			[alert show];[alert show];
			[alert release];
		}
		else 
		{
			NSArray *array = [[NSArray alloc] initWithObjects:userName,passWord,nil];
			if (self.number == 0)
			{
				NSInteger count = [[self.mutableDictionary allKeys] count];
				NSString *string = [[NSString alloc] initWithFormat:@"User%d",count + 1];
				
				if (count < 1) {
					NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:count +1 ];
					[tempDic setObject:array forKey:string];
					self.mutableDictionary = tempDic;				
					[tempDic release];
				}
				else
				{
					[self.mutableDictionary setObject:array forKey:string];
				}
				[string release];
			}
			else 
			{
				NSString *string = [[NSString alloc] initWithFormat:@"User%d",self.number];
				[self.mutableDictionary setObject:array forKey:string];
				[string release];
				if (![userName isEqualToString:[self.myarray objectAtIndex:0]]) 
				{
					NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
					[defaults setObject:userName forKey:kUserName];
				}
			}
			[array release];
			[self.mutableDictionary writeToFile:[self dataFilePath] atomically:YES];
			[self.navigationController popViewControllerAnimated:YES];
		}
	}
}

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
	[customView1 release];
	[customView2 release];
	[customView3 release];
	[customView4 release];
	[customView5 release];
	[customView6 release];
	[customView7 release];
	[customView8 release];
	[customView9 release];
	[scrollView release];
	[mutableDictionary release];
	[myarray release];
    [super dealloc];
}

										
@end
