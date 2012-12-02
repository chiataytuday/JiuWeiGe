//
//  CoverFlowToScan.h
//  JiuGongGe
//
//  Created by bunny on 11-3-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFOpenFlowView.h"
#import "gVar.h"
#import "UIImageScale.h"

extern void *CoverFlowTitle;

@interface CoverFlowToScan : UIViewController {
	NSOperationQueue *loadImagesOperationQueue;
	UIToolbar *toolBar;
	NSInteger number;
	UIImage *showImage;
	UILabel *imageLabel;
	NSString *imageLabelName;
}
@property (nonatomic ,retain) IBOutlet UIToolbar *toolBar;
@property (nonatomic ,retain) IBOutlet UILabel *imageLabel;
@property (nonatomic ,retain) UIImage *showImage;
@property (nonatomic ,retain) NSString *imageLabelName;
@property (readwrite ) NSInteger number;
- (IBAction) popButtonPressed;
- (NSString *) dataFilePath;
@end
