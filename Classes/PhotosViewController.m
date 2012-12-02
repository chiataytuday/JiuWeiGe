//
//  PhotosViewController.m
//  JiuGongGe
//
//  Created by dskyu on 11-3-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotosViewController.h"

@implementation PhotosViewController

@synthesize scrView;
@synthesize num;
@synthesize bgImageSelect;
@synthesize diaryImageSelect;
@synthesize bgSelectRow;
@synthesize diarySelectRow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

- (void) popView
{
	[self.navigationController popViewControllerAnimated:YES];
}


-(void) viewWillAppear:(BOOL)animated
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	self.bgImageSelect = [defaults objectForKey:kBgImage];
	self.bgSelectRow = [defaults integerForKey:kBgNumber];
	self.diaryImageSelect = [defaults objectForKey:kDiaryImage];
	self.diarySelectRow = [defaults integerForKey:kDiaryNumber];	
	
	self.title = self.bgImageSelect;
}

/*
-(void) viewWillDisappear:(BOOL)animated
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:bgImageSelect forKey:kBgImage];
	[defaults setInteger:bgSelectRow forKey:kBgNumber];
	[defaults setObject:diaryImageSelect forKey:kDiaryImage];
	[defaults setInteger:diarySelectRow forKey:kDiaryNumber];
	[super viewWillDisappear:animated];	
 }
*/

- (void)viewDidLoad {

	[super viewDidLoad];
	
	PopView = self;
	isScroll = NO;
	
	self.view.backgroundColor = [UIColor blackColor];
	
	
	
	if (self.num == 1) 
	{
		scrView.contentSize = CGSizeMake(340*kBgImageCount, 480);
		scrView.showsHorizontalScrollIndicator = NO;
		
		for (int i=0; i<kBgImageCount; i++)
		{
			MyScrollView *ascrView = [[MyScrollView alloc] initWithFrame:CGRectMake(340*i, 0, 320, 480)];
			
			ascrView.delegate = self;
			NSString *imgPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"BG_%d", i+1] ofType:@"png"];
			ascrView.image = [UIImage imageWithContentsOfFile:imgPath];
			ascrView.num = 1;
			ascrView.tag = 100+i;
			
			[scrView addSubview:ascrView];
			[ascrView release];
		}
	}
	else 
	{
		scrView.contentSize = CGSizeMake(340*kDiaryImageCount, 480);
		scrView.showsHorizontalScrollIndicator = NO;
		
		for (int i=0; i<kDiaryImageCount; i++)
		{
			MyScrollView *ascrView = [[MyScrollView alloc] initWithFrame:CGRectMake(340*i, 0, 320, 480)];
			
			ascrView.delegate = self;
			NSString *imgPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"Paper_%d", i+1] ofType:@"png"];
			ascrView.image = [UIImage imageWithContentsOfFile:imgPath];
			ascrView.num = 2;
			ascrView.tag = 100+i;
			
			[scrView addSubview:ascrView];
			[ascrView release];
		}
	}
	
		
	lastPage = 0;
}


- (void)dealloc {
	[bgImageSelect release];
	[diaryImageSelect release];
	[scrView release];
    [super dealloc];
}


#pragma mark -
#pragma mark === UIScrollView Delegate ===
#pragma mark -
//ScrollView 划动的动画结束后调用.
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	CGFloat pageWidth = scrollView.frame.size.width;
	NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	NSLog(@"page = %d, lastPage = %d  %f", page, lastPage,scrollView.contentOffset.x);
	
	if (lastPage != page) 
	{
		MyScrollView *aView = (MyScrollView *)[scrView viewWithTag:100+lastPage];
		aView.zoomScale = 1.0;
		
		lastPage = page;
		selectImage = page;
	}
	isScroll = YES;
}



@end
