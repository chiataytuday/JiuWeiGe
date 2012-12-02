//
//  PhotosViewController.h
//  JiuGongGe
//
//  Created by dskyu on 11-3-6.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyScrollView.h"
#import "define.h"

extern int selectImage;
extern void *PopView;
extern BOOL isChange;
extern BOOL isScroll;

@interface PhotosViewController : UIViewController <UIScrollViewDelegate>{
	UIScrollView *scrView;
	NSInteger lastPage;
	NSInteger num;

	NSString *bgImageSelect;
	NSString *diaryImageSelect;
	int bgSelectRow;
	int diarySelectRow;
	
}
@property (nonatomic ,retain) IBOutlet UIScrollView *scrView;
@property (readwrite) NSInteger num;
@property int bgSelectRow;
@property int diarySelectRow;
@property (nonatomic ,retain) IBOutlet NSString *bgImageSelect;
@property (nonatomic ,retain) IBOutlet NSString *diaryImageSelect;

- (void) popView;
@end
