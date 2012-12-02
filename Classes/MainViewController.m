//
//  MainViewController.m
//  JiuGongGe
//
//  Created by dskyu on 11-3-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "GeZiView.h"
#import "GeZiCenterView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MainViewController

@synthesize testButton;
@synthesize testButton1;
@synthesize saveImage;
@synthesize imageView;
@synthesize GeZiView1;
@synthesize GeZiView2;
@synthesize GeZiView3;
@synthesize GeZiView4;
@synthesize GeZiView5;
@synthesize GeZiView6;
@synthesize GeZiView7;
@synthesize GeZiView8;
@synthesize GeZiCenter;
@synthesize allPlan;
@synthesize plan;
@synthesize color;
@synthesize accelX,accelY,accelZ;


-(void) showChanges
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *imageName = [[defaults objectForKey:kBgImage] stringByAppendingFormat:@".png"];
	UIImage *image = [UIImage imageNamed:imageName];
	self.imageView.image = image;
	NSString *imageDiaryName = [[defaults objectForKey:kDiaryImage] stringByAppendingFormat:@".png"];
	UIImage *image1 = [UIImage imageNamed:imageDiaryName];
	self.GeZiView1.bgImage.image = image1;
	self.GeZiView2.bgImage.image = image1;
	self.GeZiView3.bgImage.image = image1;
	self.GeZiView4.bgImage.image = image1;
	self.GeZiView5.bgImage.image = image1;
	self.GeZiView6.bgImage.image = image1;
	self.GeZiView7.bgImage.image = image1;
	self.GeZiView8.bgImage.image = image1;
	self.GeZiCenter.bgImage.image = image1;
	
	float alpha = [defaults floatForKey:kPaperAlpha];
	self.GeZiView1.bgImage.alpha = alpha;
	self.GeZiView2.bgImage.alpha = alpha;
	self.GeZiView3.bgImage.alpha = alpha;
	self.GeZiView4.bgImage.alpha = alpha;
	self.GeZiView5.bgImage.alpha = alpha;
	self.GeZiView6.bgImage.alpha = alpha;
	self.GeZiView7.bgImage.alpha = alpha;
	self.GeZiView8.bgImage.alpha = alpha;
	self.GeZiCenter.bgImage.alpha = alpha;
	
	NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:[self dataPlanFilePath]];
	self.allPlan = dictionary;
	[dictionary release];
	self.plan = [allPlan objectForKey:[defaults objectForKey:kPlan]];
	self.GeZiView1.title.text = [self.plan objectAtIndex:0];
	self.GeZiView2.title.text = [self.plan objectAtIndex:1];
	self.GeZiView3.title.text = [self.plan objectAtIndex:2];
	self.GeZiView4.title.text = [self.plan objectAtIndex:3];
	self.GeZiView5.title.text = [self.plan objectAtIndex:4];
	self.GeZiView6.title.text = [self.plan objectAtIndex:5];
	self.GeZiView7.title.text = [self.plan objectAtIndex:6];
	self.GeZiView8.title.text = [self.plan objectAtIndex:7];
	
	UIColor *contentColor = [self.color objectAtIndex:[defaults integerForKey:kContentColor]];
	self.GeZiView1.content.textColor = contentColor;
	self.GeZiView2.content.textColor = contentColor;
	self.GeZiView3.content.textColor = contentColor;
	self.GeZiView4.content.textColor = contentColor;
	self.GeZiView5.content.textColor = contentColor;
	self.GeZiView6.content.textColor = contentColor;
	self.GeZiView7.content.textColor = contentColor;
	self.GeZiView8.content.textColor = contentColor;
	self.GeZiCenter.dateLabel.textColor = contentColor;
	
	UIColor *titleColor = [self.color objectAtIndex:[defaults integerForKey:kTitleColor]];
	self.GeZiView1.title.textColor = titleColor;
	self.GeZiView2.title.textColor = titleColor;
	self.GeZiView3.title.textColor = titleColor;
	self.GeZiView4.title.textColor = titleColor;
	self.GeZiView5.title.textColor = titleColor;
	self.GeZiView6.title.textColor = titleColor;
	self.GeZiView7.title.textColor = titleColor;
	self.GeZiView8.title.textColor = titleColor;
	self.GeZiCenter.placeText.textColor = titleColor;
						   
}

-(void) viewWillDisappear:(BOOL)animated
{
	JiuGongGeAppDelegate *app = (JiuGongGeAppDelegate *) [[UIApplication sharedApplication]delegate];
	app.save =  [self screenshot];
	shouldSaveImage = YES;
}

-(void) viewWillAppear:(BOOL) animated
{
	if (isChange) {
		[self showChanges];
		isChange = NO;
	}

	[super viewDidAppear:animated];
	
}

- (NSString *) dataPlanFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"FangAn.plist"];
}

- (NSString *) dataUserFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"User.plist"];
}

- (void)viewDidLoad 
{
//	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
	
	NSString *filePath = [self dataPlanFilePath];
	if(![[NSFileManager defaultManager]fileExistsAtPath:filePath])
	{
		NSArray *defaultArray = [[NSArray alloc] initWithObjects:@"开心的事",@"为他人做的事",@"计划/工作/备忘",
												@"比起昨天的进步",@"心情/感悟/灵感",@"关注/八卦/新闻",@"健康/饮食/体重",
												@"梦境",@"默认",nil];
		NSDictionary *defaultPlan = [[NSDictionary alloc] initWithObjectsAndKeys:defaultArray,@"Plan1",nil];
		[defaultPlan writeToFile:filePath atomically:YES];
		[defaultArray release];
		[defaultPlan release];
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setObject:@"Plan1" forKey:kPlan];
		[defaults setObject:@"默认" forKey:kPlanName];
	}
	
	if(![[NSFileManager defaultManager]fileExistsAtPath:[self dataUserFilePath]])
	{
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setObject:@"0" forKey:kUserName];
	}
	
	self.imageView.frame = CGRectMake(0, 0, 320, 480);
	
	NSArray *mycolor = [[NSArray alloc] initWithObjects:
						[UIColor blackColor],[UIColor redColor],[UIColor orangeColor],
						[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor],
						[UIColor cyanColor],[UIColor purpleColor],[UIColor lightGrayColor],nil];
	self.color = mycolor;
	[mycolor release];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
	self.allPlan = dictionary;
	self.plan = [allPlan objectForKey:[defaults objectForKey:kPlan]];
		
	NSArray *firstView = [[NSBundle mainBundle] loadNibNamed:@"GeZiView" owner:self options:nil];
	
	self.GeZiView1 = [firstView objectAtIndex:0];
	self.GeZiView1.frame = CGRectMake(7.0f, 20.0f, 100.0f, 120.0f);
	self.GeZiView1.backgroundColor = [UIColor clearColor];
	self.GeZiView1.title.font = [UIFont fontWithName:@"Helvetica" size:14];
	self.GeZiView1.content.font = [UIFont fontWithName:@"Helvetica" size:18];
	self.GeZiView1.title.text = [self.plan objectAtIndex:0];
	self.GeZiView1.content.text = [defaults objectForKey:kLastContent1];
	self.GeZiView1.bgImage.contentMode = UIViewContentModeTopLeft;
	self.GeZiView1.bgImage.bounds = CGRectMake(0, 0, 100, 120);
	self.GeZiView1.bgImage.layer.masksToBounds = YES;
	self.GeZiView1.bgImage.layer.cornerRadius = 6;
	[self.view addSubview:self.GeZiView1];
	self.GeZiView1.content.delegate = self.GeZiView1;
	self.GeZiView1.num = 1;
	
	NSArray *secondView = [[NSBundle mainBundle] loadNibNamed:@"GeZiView" owner:self options:nil];
	self.GeZiView2 = [secondView objectAtIndex:0];
	self.GeZiView2.frame = CGRectMake(110.0f, 20.0f, 100.0f, 120.0f);
	self.GeZiView2.backgroundColor = [UIColor clearColor];
	self.GeZiView2.title.font = [UIFont fontWithName:@"Helvetica" size:14];
	self.GeZiView2.content.font = [UIFont fontWithName:@"Helvetica" size:18];
	self.GeZiView2.title.text = [self.plan objectAtIndex:1];
	self.GeZiView2.content.text = [defaults objectForKey:kLastContent2];
	self.GeZiView2.bgImage.contentMode = UIViewContentModeTop;
	self.GeZiView2.bgImage.bounds = CGRectMake(0, 0, 100, 120);
	self.GeZiView2.bgImage.layer.masksToBounds = YES;
	self.GeZiView2.bgImage.layer.cornerRadius = 6;
	[self.view addSubview:self.GeZiView2];
	self.GeZiView2.content.delegate = self.GeZiView2;
	self.GeZiView2.num = 2;
	
	NSArray *thirdView = [[NSBundle mainBundle] loadNibNamed:@"GeZiView" owner:self options:nil];
	self.GeZiView3 = [thirdView objectAtIndex:0];
	self.GeZiView3.frame = CGRectMake(213.0f, 20.0f, 100.0f, 120.0f);
	self.GeZiView3.backgroundColor = [UIColor clearColor];
	self.GeZiView3.title.font = [UIFont fontWithName:@"Helvetica" size:14];
	self.GeZiView3.content.font = [UIFont fontWithName:@"Helvetica" size:18];
	self.GeZiView3.title.text = [self.plan objectAtIndex:2];
	self.GeZiView3.content.text = [defaults objectForKey:kLastContent3];
	self.GeZiView3.bgImage.contentMode = UIViewContentModeTopRight;
	self.GeZiView3.bgImage.layer.masksToBounds = YES;
	self.GeZiView3.bgImage.layer.cornerRadius = 6;
	[self.view addSubview:self.GeZiView3];
	self.GeZiView3.content.delegate = self.GeZiView3;
	self.GeZiView3.num = 3;
	
	NSArray *fourthView = [[NSBundle mainBundle] loadNibNamed:@"GeZiView" owner:self options:nil];
	self.GeZiView4 = [fourthView objectAtIndex:0];
	self.GeZiView4.frame = CGRectMake(7.0f, 143.0f, 100.0f, 120.0f);
	self.GeZiView4.backgroundColor = [UIColor clearColor];
	self.GeZiView4.title.font = [UIFont fontWithName:@"Helvetica" size:14];
	self.GeZiView4.content.font = [UIFont fontWithName:@"Helvetica" size:18];
	self.GeZiView4.title.text = [self.plan objectAtIndex:3];
	self.GeZiView4.content.text = [defaults objectForKey:kLastContent4];
	self.GeZiView4.bgImage.contentMode = UIViewContentModeLeft;
	self.GeZiView4.bgImage.layer.masksToBounds = YES;
	self.GeZiView4.bgImage.layer.cornerRadius = 6;
	[self.view addSubview:self.GeZiView4];
	self.GeZiView4.content.delegate = self.GeZiView4;
	self.GeZiView4.num = 4;
	
	NSArray *fifthView = [[NSBundle mainBundle] loadNibNamed:@"GeZiView" owner:self options:nil];
	self.GeZiView5 = [fifthView objectAtIndex:0];
	self.GeZiView5.frame = CGRectMake(213.0f, 143.0f, 100.0f, 120.0f);
	self.GeZiView5.backgroundColor = [UIColor clearColor];
	self.GeZiView5.title.font = [UIFont fontWithName:@"Helvetica" size:14];
	self.GeZiView5.content.font = [UIFont fontWithName:@"Helvetica" size:18];
	self.GeZiView5.title.text = [self.plan objectAtIndex:4];
	self.GeZiView5.content.text = [defaults objectForKey:kLastContent5];
	self.GeZiView5.bgImage.contentMode = UIViewContentModeRight;
	self.GeZiView5.bgImage.layer.masksToBounds = YES;
	self.GeZiView5.bgImage.layer.cornerRadius = 6;
	[self.view addSubview:self.GeZiView5];
	self.GeZiView5.content.delegate = self.GeZiView5;
	self.GeZiView5.num = 5;
	
	NSArray *sixthView = [[NSBundle mainBundle] loadNibNamed:@"GeZiView" owner:self options:nil];
	self.GeZiView6 = [sixthView objectAtIndex:0];
	self.GeZiView6.frame = CGRectMake(7.0f, 266.0f, 100.0f, 120.0f);
	self.GeZiView6.backgroundColor = [UIColor clearColor];
	self.GeZiView6.title.font = [UIFont fontWithName:@"Helvetica" size:14];
	self.GeZiView6.content.font = [UIFont fontWithName:@"Helvetica" size:18];
	self.GeZiView6.title.text = [self.plan objectAtIndex:5];
	self.GeZiView6.content.text = [defaults objectForKey:kLastContent6];
	self.GeZiView6.bgImage.contentMode = UIViewContentModeBottomLeft;
	self.GeZiView6.bgImage.layer.masksToBounds = YES;
	self.GeZiView6.bgImage.layer.cornerRadius = 6;
	[self.view addSubview:self.GeZiView6];
	self.GeZiView6.content.delegate = self.GeZiView6;
	self.GeZiView6.num = 6;
	
	NSArray *seventhView = [[NSBundle mainBundle] loadNibNamed:@"GeZiView" owner:self options:nil];
	self.GeZiView7 = [seventhView objectAtIndex:0];
	self.GeZiView7.frame = CGRectMake(110.0f, 266.0f, 100.0f, 120.0f);
	self.GeZiView7.backgroundColor = [UIColor clearColor];
	self.GeZiView7.title.font = [UIFont fontWithName:@"Helvetica" size:14];
	self.GeZiView7.content.font = [UIFont fontWithName:@"Helvetica" size:18];
	self.GeZiView7.title.text = [self.plan objectAtIndex:6];
	self.GeZiView7.content.text = [defaults objectForKey:kLastContent7];
	self.GeZiView7.bgImage.contentMode = UIViewContentModeBottom;
	self.GeZiView7.bgImage.layer.masksToBounds = YES;
	self.GeZiView7.bgImage.layer.cornerRadius = 6;
	[self.view addSubview:self.GeZiView7];
	self.GeZiView7.content.delegate = self.GeZiView7;
	self.GeZiView7.num = 7;
	
	NSArray *eighthView = [[NSBundle mainBundle] loadNibNamed:@"GeZiView" owner:self options:nil];
	self.GeZiView8 = [eighthView objectAtIndex:0];
	self.GeZiView8.frame = CGRectMake(213.0f, 266.0f, 100.0f, 120.0f);
	self.GeZiView8.backgroundColor = [UIColor clearColor];
	self.GeZiView8.title.font = [UIFont fontWithName:@"Helvetica" size:14];
	self.GeZiView8.content.font = [UIFont fontWithName:@"Helvetica" size:18];
	self.GeZiView8.title.text = [self.plan objectAtIndex:7];
	self.GeZiView8.content.text = [defaults objectForKey:kLastContent8];
	self.GeZiView8.bgImage.contentMode = UIViewContentModeBottomRight;
	self.GeZiView8.bgImage.layer.masksToBounds = YES;
	self.GeZiView8.bgImage.layer.cornerRadius = 6;
	[self.view addSubview:self.GeZiView8];
	self.GeZiView8.content.delegate = self.GeZiView8;
	self.GeZiView8.num = 8;
	
	NSArray *centerView = [[NSBundle mainBundle] loadNibNamed:@"GeZiCenterView" owner:self options:nil];
	self.GeZiCenter = [centerView objectAtIndex:0];
	self.GeZiCenter.frame = CGRectMake(110.0f, 143.0f, 100.0f, 120.0f);
	self.GeZiCenter.backgroundColor = [UIColor clearColor];
	
	NSDate *now = [NSDate date];
	NSDateFormatter *dateFormmatter = [[NSDateFormatter alloc] init];
	[dateFormmatter setDateFormat:@"YYYY/MM/dd  ccc"];
	self.GeZiCenter.dateLabel.text = [dateFormmatter stringFromDate:now];
	self.GeZiCenter.dateLabel.textColor = [UIColor blueColor];
	self.GeZiCenter.dateLabel.frame = CGRectMake(6,91, 88, 21);
	[dateFormmatter release];
	self.GeZiCenter.placeText.placeholder = NSLocalizedString(@"地点",@"placeText");
	self.GeZiCenter.placeText.frame = CGRectMake(2, 0, 98, 25);
	self.GeZiCenter.placeText.textColor = [UIColor blackColor];
	NSLog(@"%@",[defaults objectForKey:kLastPlace]);
	self.GeZiCenter.placeText.text = [defaults objectForKey:kLastPlace];
	self.GeZiCenter.bgImage.contentMode = UIViewContentModeCenter;
	self.GeZiCenter.bgImage.layer.masksToBounds = YES;
	self.GeZiCenter.bgImage.layer.cornerRadius = 6;
	self.GeZiCenter.weatherImage.backgroundColor = [UIColor clearColor];
	
	NSUserDefaults *dafaults = [NSUserDefaults standardUserDefaults];
	self.GeZiCenter.weatherImage.image = [UIImage imageNamed:[dafaults objectForKey:kExpressionImage]];
	
	self.GeZiCenter.scrollView.contentSize = CGSizeMake(320, 450);
	self.GeZiCenter.scrollView.hidden = YES;
	
	int line = 0,row = 0;
	float width = 60,height = 60;
	for (int i = 0; i < kExpressionImageCount; i++)
	{
		ExpressionImage *expressionScroll = [[ExpressionImage alloc] init];
		expressionScroll.contentSize = CGSizeMake(width, height);
		UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"expression%d",i + 1]];
		UIImageView *expressionView = [[UIImageView alloc] initWithImage:image];
		expressionView.frame = CGRectMake(0, 0, width, height);
		expressionScroll.myImage = image;
		expressionScroll.myImageView = expressionView;
		expressionScroll.number = i + 1;
		[expressionScroll addSubview:expressionScroll.myImageView];
		expressionScroll.frame = CGRectMake(width*line, height*row, width, height);
		line++;
		if (line == 5) {
			line = 0;
			row++;
		}
		[self.GeZiCenter.scrollView addSubview:expressionScroll];
		[image release];
		[expressionView release];
		[expressionScroll release];
	}
	[self.view addSubview:self.GeZiCenter];
	
	[self showChanges];
	
	
	
	UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
	accelerometer.updateInterval = 1.0f/20.0f;
	accelerometer.delegate = self;
	
	
//	if ([defaults boolForKey:kGestureTip])
	if (FALSE)
	{
		[UIView beginAnimations:@"gesturnTip" context:nil];
		[UIView setAnimationDuration:1.5];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"温馨提示" ,@"gesture alert title")
														message:NSLocalizedString(@"关于手势：您可以通过左右摇摆更改背景，上下摇摆更改纸张，向前摇摆更改内容颜色，向后摇摆更改标题颜色，乱摆清空内容!",@"gesture alert content") 
													   delegate:nil 
											  cancelButtonTitle:NSLocalizedString(@"确定",@"gesturn alert done button")
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		[UIView commitAnimations];
	}

	
	[super viewDidLoad];
	
}


- (UIImage*)screenshot 
{
    CGSize imageSize = CGSizeMake(320, 411);
	UIGraphicsBeginImageContext(imageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) 
    {
		CGContextSaveGState(context);
   		CGContextTranslateCTM(context, 0, -20);
		CGContextConcatCTM(context, [window transform]);
		[[window layer] renderInContext:context];
		CGContextRestoreGState(context);
	}
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
} 

	
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return YES;
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

- (void)dealloc {
	[testButton release];
	[testButton1 release];
	[saveImage release];
	[imageView release];
	[GeZiView1 release];
	[GeZiView2 release];
	[GeZiView3 release];
	[GeZiView4 release];
	[GeZiView5 release];
	[GeZiView6 release];
	[GeZiView7 release];
	[GeZiView8 release];
	[GeZiCenter release];
	[allPlan release];
	[plan release];
	[color release];
    [[UIAccelerometer sharedAccelerometer] setDelegate:nil];
    [super dealloc];
}

#pragma mark -
#pragma mark GestureAction

- (void) clearContent
{
	self.GeZiView1.content.text = @"";
	self.GeZiView2.content.text = @"";
	self.GeZiView3.content.text = @"";
	self.GeZiView4.content.text = @"";
	self.GeZiView5.content.text = @"";
	self.GeZiView6.content.text = @"";
	self.GeZiView7.content.text = @"";
	self.GeZiView8.content.text = @"";
	self.GeZiCenter.placeText.text = @"";
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:@"" forKey:kLastContent1];
	[defaults setObject:@"" forKey:kLastContent1];
	[defaults setObject:@"" forKey:kLastContent1];
	[defaults setObject:@"" forKey:kLastContent1];
	[defaults setObject:@"" forKey:kLastContent1];
	[defaults setObject:@"" forKey:kLastContent1];
	[defaults setObject:@"" forKey:kLastContent1];
	[defaults setObject:@"" forKey:kLastContent1];
	[defaults setObject:@"" forKey:kLastPlace];
}

- (IBAction) switchBGImage:(BOOL) LeftToRight
{
	int number;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	number = [[defaults objectForKey:kBgNumber] intValue];
	
	if (LeftToRight) 
	{
		number++;
		if (number <= kBgImageCount) 
		{
			[defaults setInteger:number forKey:kBgNumber];
			[defaults setObject:[NSString stringWithFormat:@"BG_%d",number] forKey:kBgImage];
			
			[self showChanges];
			UIImage *tempImage = [UIImage imageNamed:[NSString stringWithFormat:@"BG_%d.png",[defaults integerForKey:kBgNumber]-1]];
			UIImageView *tempImageView = [[UIImageView alloc] initWithImage:tempImage];
			tempImageView.frame = CGRectMake(0, 0, 320, 480);
			[self.view addSubview:tempImageView];
			[self.view sendSubviewToBack:tempImageView];
			
			self.imageView.frame = CGRectMake(-320, 0, 320, 480);
			
			[UIView beginAnimations:@"swichBGImageLeftToRight" context:nil];
			[UIView setAnimationDuration:kSwitchDuration];
			
			self.imageView.frame = CGRectMake(0, 0, 320, 480);
			tempImageView.frame = CGRectMake(320, 0, 320, 480);
			
			[UIView commitAnimations];
			[tempImage release];
			[tempImageView release];
		}
	}
	else 
	{
		number--;
		if (number >= 1)
		{
			[defaults setInteger:number forKey:kBgNumber];
			[defaults setObject:[NSString stringWithFormat:@"BG_%d",number] forKey:kBgImage];
			
			[self showChanges];
			UIImage *tempImage = [UIImage imageNamed:[NSString stringWithFormat:@"BG_%d.png",[defaults integerForKey:kBgNumber]+1]];
			UIImageView *tempImageView = [[UIImageView alloc] initWithImage:tempImage];
			tempImageView.frame = CGRectMake(0, 0, 320, 480);
			[self.view addSubview:tempImageView];
			[self.view sendSubviewToBack:tempImageView];
			
			self.imageView.frame = CGRectMake(320, 0, 320, 480);
			
			[UIView beginAnimations:@"swichBGImageRightToLeft" context:nil];
			[UIView setAnimationDuration:kSwitchDuration];
			
			self.imageView.frame = CGRectMake(0, 0, 320, 480);
			tempImageView.frame = CGRectMake(-320, 0, 320, 480);
			
			[UIView commitAnimations];
			[tempImage release];
			[tempImageView release];
		}
	}
}

- (IBAction) switchPaperImage:(BOOL) LeftToRight
{
	int number;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	number = [[defaults objectForKey:kDiaryNumber] intValue];
	
	if (LeftToRight) 
	{
		number++;
		if (number <= kDiaryImageCount) 
		{
			[defaults setInteger:number forKey:kDiaryNumber];
			[defaults setObject:[NSString stringWithFormat:@"Paper_%d",number] forKey:kDiaryImage];
			
			[UIView beginAnimations:@"disappear" context:nil];
			[UIView setAnimationDuration:kAppearDelay];
			float alpha = 0.2;
			self.GeZiView1.bgImage.alpha = alpha;
			self.GeZiView2.bgImage.alpha = alpha;
			self.GeZiView3.bgImage.alpha = alpha;
			self.GeZiView4.bgImage.alpha = alpha;
			self.GeZiView5.bgImage.alpha = alpha;
			self.GeZiView6.bgImage.alpha = alpha;
			self.GeZiView7.bgImage.alpha = alpha;
			self.GeZiView8.bgImage.alpha = alpha;
			self.GeZiCenter.bgImage.alpha = alpha;
			[UIView commitAnimations];
			
			[NSTimer scheduledTimerWithTimeInterval:kAppearDelay target:self selector:@selector(appear) userInfo:nil repeats:NO];
			
		}
	}
	else 
	{
		number--;
		if (number >= 1)
		{
			[defaults setInteger:number forKey:kDiaryNumber];
			[defaults setObject:[NSString stringWithFormat:@"Paper_%d",number] forKey:kDiaryImage];
			
			[UIView beginAnimations:@"disappear" context:nil];
			[UIView setAnimationDuration:kAppearDelay];
			float alpha = 0.2;
			self.GeZiView1.bgImage.alpha = alpha;
			self.GeZiView2.bgImage.alpha = alpha;
			self.GeZiView3.bgImage.alpha = alpha;
			self.GeZiView4.bgImage.alpha = alpha;
			self.GeZiView5.bgImage.alpha = alpha;
			self.GeZiView6.bgImage.alpha = alpha;
			self.GeZiView7.bgImage.alpha = alpha;
			self.GeZiView8.bgImage.alpha = alpha;
			self.GeZiCenter.bgImage.alpha = alpha;
			[UIView commitAnimations];
			
			[NSTimer scheduledTimerWithTimeInterval:kAppearDelay target:self selector:@selector(appear) userInfo:nil repeats:NO];
			
		}
	}
}

- (void) appear
{
	 [UIView beginAnimations:@"appear" context:nil];
	 [UIView setAnimationDuration:1.5];
	 [self showChanges];
	 [UIView commitAnimations];
	 
}

- (IBAction) changeContentColor
{
	int number;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	number = [defaults integerForKey:kContentColor];
	number++;
	number = number % [self.color count];
	[defaults setInteger:number forKey:kContentColor];
	[self showChanges];
}

- (IBAction) changeTitleColor
{
	int number;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	number = [defaults integerForKey:kTitleColor];
	number++;
	number = number % [self.color count];
	[defaults setInteger:number forKey:kTitleColor];
	[self showChanges];
}

- (void) changePaperAlpha
{
	
}

#pragma mark -
#pragma mark UIAccelerationDelegate
-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	self.accelX = -[acceleration x];
	self.accelY = [acceleration y];
	if (accelX > 0.9 && accelX <1.1) 
	{
		NSLog(@"fdsfsa");
	}
}

@end
