//
//  PlanViewController.h
//  JiuGongGe
//
//  Created by dskyu on 11-3-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPlanViewController.h"
#import "define.h"

extern BOOL isChange;
@interface PlanViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
	UITableView *mytableView;
	NSMutableArray *myArray;
	NSMutableDictionary *mutableDictionary;
	NSInteger number;
	
	AddPlanViewController *addPlanViewController;
}
@property (nonatomic ,retain) IBOutlet UITableView *mytableView;
@property (nonatomic ,retain) AddPlanViewController *addPlanViewController;
@property (nonatomic ,retain) NSMutableArray *myArray;
@property (nonatomic ,retain) NSMutableDictionary *mutableDictionary;
@property (readwrite) NSInteger number;
- (NSString *) dataFilePath;
- (IBAction) deletePlan;
@end
