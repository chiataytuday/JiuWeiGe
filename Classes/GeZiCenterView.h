//
//  GeZiCenterView.h
//  JiuGongGe
//
//  Created by bunny on 11-3-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"

void *GeZiCenter;

@interface GeZiCenterView : UIView <UITextFieldDelegate>{
	UIImageView *bgImage;
	UIImageView *weatherImage;
	UITextField *placeText;
	UILabel *dateLabel;
	UIScrollView *scrollView;
}

@property (nonatomic ,retain) IBOutlet UIImageView *bgImage;
@property (nonatomic ,retain) IBOutlet UIImageView *weatherImage;
@property (nonatomic ,retain) IBOutlet UILabel *dateLabel;
@property (nonatomic ,retain) IBOutlet UITextField *placeText;
@property (nonatomic ,retain) IBOutlet UIScrollView *scrollView;

-(IBAction) textEditingFinish:(id) sender;
-(IBAction) textFliedValueChanged:(id) sender;
- (void) backToSmall;
@end
