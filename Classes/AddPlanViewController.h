//
//  AddPlanViewController.h
//  JiuGongGe
//
//  Created by dskyu on 11-3-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomView.h"
#import "define.h"

@interface AddPlanViewController : UIViewController <UITextFieldDelegate>{
	NSMutableDictionary *mutableDictionary;
	NSArray *myarray;
	UIScrollView *scrollView;
	CustomView *customView1;
	CustomView *customView2;
	CustomView *customView3;
	CustomView *customView4;
	CustomView *customView5;
	CustomView *customView6;
	CustomView *customView7;
	CustomView *customView8;
	CustomView *customView9;
	NSInteger number;
	BOOL isAddPlan;
	

}
@property (nonatomic ,retain) NSMutableDictionary *mutableDictionary;
@property (nonatomic ,retain) NSArray *myarray;
@property (nonatomic ,retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic ,retain) CustomView *customView1;
@property (nonatomic ,retain) CustomView *customView2;
@property (nonatomic ,retain) CustomView *customView3;
@property (nonatomic ,retain) CustomView *customView4;
@property (nonatomic ,retain) CustomView *customView5;
@property (nonatomic ,retain) CustomView *customView6;
@property (nonatomic ,retain) CustomView *customView7;
@property (nonatomic ,retain) CustomView *customView8;
@property (nonatomic ,retain) CustomView *customView9;
@property (readwrite ) NSInteger number;
@property (readwrite ) BOOL isAddPlan;

- (NSString *) dataFilePath;
@end
