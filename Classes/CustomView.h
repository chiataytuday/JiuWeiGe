//
//  CustomView.h
//  JiuGongGe
//
//  Created by bunny on 11-3-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomView : UIView {
	UIImageView *BgImage;
	UILabel *noteLabel;
	UITextField *noteTextField;
	
}
@property (nonatomic ,retain) IBOutlet UIImageView *BgImage;
@property (nonatomic ,retain) IBOutlet UILabel *noteLabel;
@property (nonatomic ,retain) IBOutlet UITextField *noteTextField;
- (IBAction)textFieldDone:(id)sender;
@end

