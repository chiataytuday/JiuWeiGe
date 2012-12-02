//
//  MainViewController.h
//  JiuGongGe
//
//  Created by dskyu on 11-3-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JiuGongGeAppDelegate.h"
#import "define.h"
#import "ExpressionImage.h"

extern BOOL isChange;
extern BOOL shouldSaveImage;
@class GeZiView;
@class GeZiCenterView;

@interface MainViewController : UIViewController <UIAccelerometerDelegate>{
	UIButton *testButton;
	UIButton *testButton1;
	UIImageView *imageView;
	UIImage *saveImage;
	GeZiView *GeZiView1;
	GeZiView *GeZiView2;
	GeZiView *GeZiView3;
	GeZiView *GeZiView4;
	GeZiView *GeZiView5;
	GeZiView *GeZiView6;
	GeZiView *GeZiView7;
	GeZiView *GeZiView8;
	GeZiCenterView *GeZiCenter;
	NSDictionary *allPlan;
	NSArray *plan;
	NSArray *color;
	
	float accelX;
	float accelY;
	float accelZ;
}
@property (nonatomic ,retain )IBOutlet UIButton *testButton;
@property (nonatomic ,retain )IBOutlet UIButton *testButton1;
@property (nonatomic ,retain )IBOutlet UIImageView *imageView;
@property (nonatomic ,retain )IBOutlet UIImage *saveImage;
@property (nonatomic ,retain )IBOutlet GeZiView *GeZiView1;
@property (nonatomic ,retain )IBOutlet GeZiView *GeZiView2;
@property (nonatomic ,retain )IBOutlet GeZiView *GeZiView3;
@property (nonatomic ,retain )IBOutlet GeZiView *GeZiView4;
@property (nonatomic ,retain )IBOutlet GeZiView *GeZiView5;
@property (nonatomic ,retain )IBOutlet GeZiView *GeZiView6;
@property (nonatomic ,retain )IBOutlet GeZiView *GeZiView7;
@property (nonatomic ,retain )IBOutlet GeZiView *GeZiView8;
@property (nonatomic ,retain )IBOutlet GeZiCenterView *GeZiCenter;
@property (nonatomic ,retain ) NSDictionary *allPlan;
@property (nonatomic ,retain ) NSArray *plan;
@property (nonatomic ,retain ) NSArray *color;
@property float accelX;
@property float accelY;
@property float accelZ;

- (NSString *) dataPlanFilePath;
- (NSString *) dataUserFilePath;
- (UIImage*)screenshot ;
-(void) showChanges;
- (void) clearContent;
- (IBAction) switchBGImage:(BOOL) LeftToRight;
- (IBAction) switchPaperImage:(BOOL) LeftToRight;
- (IBAction) changeContentColor;
- (IBAction) changeTitleColor;
- (void) changePaperAlpha;
@end
