//
//  GeZiView.h
//  JiuGongGe
//
//  Created by dskyu on 11-3-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeZiView : UIView <UITextViewDelegate>
{
	UITextView *content;
	UITextField *title;
	UIImageView *bgImage;
	UIButton *rButton;
	NSInteger num;
}

@property (nonatomic ,retain) IBOutlet UITextView *content;
@property (nonatomic ,retain) IBOutlet UITextField *title;
@property (nonatomic ,retain) IBOutlet UIImageView *bgImage;
@property (nonatomic ,retain) IBOutlet UIButton *rButton;
@property (readwrite) NSInteger num;

-(IBAction) titleBeginEditing:(id) sender;
-(IBAction) rButtonPressed:(id) sender;
-(IBAction) endEditing:(id) sender;

@end
