//
//  AboutViewController.h
//  JiuGongGe
//
//  Created by iDream002 on 11-12-13.
//  Copyright 2011 iDreamStudio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
	UITableView *mytableView;
}

@property (nonatomic ,retain) IBOutlet UITableView *mytableView;

@end
