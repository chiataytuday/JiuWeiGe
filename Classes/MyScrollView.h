

#import <UIKit/UIKit.h>
#import "define.h";

extern int selectImage;
extern void *PopView;
extern BOOL isScroll;

@interface MyScrollView : UIScrollView <UIScrollViewDelegate,UIAlertViewDelegate>
{
	UIImage *image;
	UIImageView *imageView;
	NSInteger num;
}

@property (nonatomic, retain) UIImage *image;
@property (readwrite) NSInteger num;

@end
