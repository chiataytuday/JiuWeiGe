#import "MyScrollView.h"
#import "PhotosViewController.h"

@implementation MyScrollView


@synthesize image;
@synthesize num;

#pragma mark -
#pragma mark === Intilization ===
#pragma mark -
- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
	{
		self.delegate = self;
		self.minimumZoomScale = 0.5;
		self.maximumZoomScale = 2.5;
		self.showsVerticalScrollIndicator = NO;
		self.showsHorizontalScrollIndicator = NO;
	
		imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
		imageView.contentMode = UIViewContentModeCenter;
		[self addSubview:imageView];
    }
    return self;
}

- (void)setImage:(UIImage *)img
{
	imageView.image = img;
}

#pragma mark -
#pragma mark === UIScrollView Delegate ===
#pragma mark -
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{	
	return imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
	
	CGFloat zs = scrollView.zoomScale;
	zs = MAX(zs, 1.0);
	zs = MIN(zs, 2.0);	
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];		
	scrollView.zoomScale = zs;	
	[UIView commitAnimations];
}

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	NSString *message = [[NSString alloc] initWithFormat:NSLocalizedString(@"设置第%d张为壁纸",@"Set Number as Paperwall"),selectImage+1];
	if (buttonIndex == 0) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"设置成功!",@"alertTitle")
														message:message
													   delegate:nil 
											  cancelButtonTitle:NSLocalizedString(@"确定",@"yesButton") 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		
		NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
		if (self.num == 1) {
			[defaults setInteger:selectImage+1 forKey:kBgNumber];
			NSString *string1 = [[NSString alloc] initWithFormat:@"BG_%d",selectImage+1];
			[defaults setObject:string1 forKey:kBgImage];
		}
		else if(self.num == 2)
		{
			[defaults setInteger:selectImage+1 forKey:kDiaryNumber];
			NSString *string2 = [[NSString alloc] initWithFormat:@"Paper_%d",selectImage+1];
			[defaults setObject:string2 forKey:kDiaryImage];
			
		}
		NSLog(@"%@",[defaults objectForKey:kDiaryNumber]);
		PhotosViewController *photoController = [[PhotosViewController alloc] init];
		photoController = PopView;
		[photoController popView];
		
	}
	[message release];

	
}

#pragma mark -
#pragma mark === UITouch Delegate ===
#pragma mark -
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (!isScroll) {
		selectImage = 0;
	}
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"确定吗?",@"alertTitle")
													message:NSLocalizedString(@"设置为壁纸",@"alertContent") 
												   delegate:self 
										  cancelButtonTitle:NSLocalizedString(@"确定",@"yesButton") 
										  otherButtonTitles:NSLocalizedString(@"取消",@"noButton"),nil];
	[alert show];
	[alert release];
	
}

#pragma mark -
#pragma mark === dealloc ===
#pragma mark -
- (void)dealloc
{
	[image release];
	[imageView release];
	
    [super dealloc];
}


@end
