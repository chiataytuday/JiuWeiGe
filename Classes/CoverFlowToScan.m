
#import "CoverFlowToScan.h"

@implementation CoverFlowToScan
@synthesize toolBar;
@synthesize number;
@synthesize showImage;
@synthesize imageLabel;
@synthesize imageLabelName;

- (NSString *) dataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"SavedImage.plist"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
	// loading images into the queue
	if (self.number == 1) {
		NSArray *array = [[NSArray alloc] initWithContentsOfFile:[self dataFilePath]];
		loadImagesOperationQueue = [[NSOperationQueue alloc] init];
		for (int i=0; i < [array count]; i++) 
		{
			UIImage *image = [[UIImage alloc] initWithContentsOfFile:[array objectAtIndex:i]];
			UIImage	*scaledImage = [image scaleToSize:CGSizeMake(300, 360)];
			[(AFOpenFlowView *)self.view setImage:scaledImage forIndex:i];
			[image release];
		}
		CoverFlowTitle = self.imageLabel;
		self.imageLabel.text = self.imageLabelName;
		[(AFOpenFlowView *)self.view setNumberOfImages:[array count]];
		[array release];
	}
	else if (self.number == 2)
	{
		loadImagesOperationQueue = [[NSOperationQueue alloc] init];
		CoverFlowTitle = nil;
		self.imageLabel.text = self.imageLabelName;
		UIImage	*scaledImage1 = [self.showImage scaleToSize:CGSizeMake(300, 360)];
		[(AFOpenFlowView *)self.view setImage:scaledImage1 forIndex:0];
		[(AFOpenFlowView *)self.view setNumberOfImages:1];
	}
	
	
	self.toolBar.tintColor = [UIColor blackColor];
	self.toolBar.alpha = 0.3f;
	[self.view bringSubviewToFront:self.toolBar];
	[self.toolBar bringSubviewToFront:self.imageLabel];
}


 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	 return (YES);
 }



- (IBAction) popButtonPressed
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void) viewWillDisappear:(BOOL)animated
{
	[[UIApplication sharedApplication] setStatusBarHidden:NO];
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
	[imageLabelName release];
	[imageLabel release];
	[showImage release];
	[toolBar release];
    [super dealloc];
}

- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index
{
	
	
}


- (void)openFlowView:(AFOpenFlowView *)openFlowView requestImageForIndex:(int)index{
	
}


- (UIImage *)defaultImage{
	
	return [UIImage imageNamed:@"BG_1.png"];
}

@end
