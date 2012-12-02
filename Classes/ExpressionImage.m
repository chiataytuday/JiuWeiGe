//
//  ExpressionImage.m
//  JiuGongGe
//
//  Created by bunny on 11-3-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ExpressionImage.h"
#import "GeZiCenterView.h"

@implementation ExpressionImage
@synthesize myImage;
@synthesize myImageView;
@synthesize number;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *string = [[NSString alloc] initWithFormat:@"expression%d.png",self.number];
	[defaults setObject:string forKey:kExpressionImage];
	GeZiCenterView *myView = GeZiCenter;
	UIImage *image = [UIImage imageNamed:string];
	myView.weatherImage.image = image;
	[myView backToSmall];
	[image release];
	[string release];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
