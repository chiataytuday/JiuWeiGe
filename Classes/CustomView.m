//
//  CustomView.m
//  JiuGongGe
//
//  Created by bunny on 11-3-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomView.h"


@implementation CustomView
@synthesize noteLabel;
@synthesize noteTextField;
@synthesize BgImage;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (IBAction)textFieldDone:(id)sender
{
	[sender resignFirstResponder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
	[BgImage release];
	[noteLabel release];
	[noteTextField release];
    [super dealloc];
}


@end
