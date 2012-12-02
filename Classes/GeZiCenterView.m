//
//  GeZiCenterView.m
//  JiuGongGe
//
//  Created by bunny on 11-3-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GeZiCenterView.h"


@implementation GeZiCenterView

@synthesize bgImage;
@synthesize dateLabel;
@synthesize placeText;
@synthesize weatherImage;
@synthesize scrollView;


-(IBAction) textFliedValueChanged:(id) sender
{
	[[NSUserDefaults standardUserDefaults] setObject:self.placeText.text forKey:kLastPlace];
}

-(IBAction) textEditingFinish:(id) sender
{
	[[NSUserDefaults standardUserDefaults] setObject:self.placeText.text forKey:kLastPlace];
	[sender resignFirstResponder];
}

- (void) backToSmall
{
	[UIView beginAnimations:@"move" context:nil];
	[UIView setAnimationDuration:1.25];
	self.frame = CGRectMake(110, 143, 100, 120);
	self.placeText.frame = CGRectMake(2, 0, 98, 25);
	self.dateLabel.frame = CGRectMake(6,91, 88, 21);
	self.placeText.font = [UIFont fontWithName:@"Helvetica" size:15];
	self.dateLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
	self.placeText.enabled = YES;
	self.bgImage.contentMode = UIViewContentModeCenter;
	[UIView commitAnimations]; 
	
	
	self.weatherImage.hidden = NO;
	self.scrollView.hidden = YES;
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	GeZiCenter = self;
	if (self.scrollView.hidden) {
		[[self superview] bringSubviewToFront:self];
		[UIView beginAnimations:@"move" context:nil];
		[UIView setAnimationDuration:1.25];
		self.frame = CGRectMake(7, 10, 306, 366);
		self.placeText.frame = CGRectMake(20, 5, 150, 30);
		self.placeText.font = [UIFont fontWithName:@"Helvetica" size:18];
		self.placeText.enabled = NO;
		self.dateLabel.frame = CGRectMake(180, 5, 110, 30);
		self.dateLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
		self.bgImage.contentMode = UIViewContentModeScaleToFill;
		[UIView commitAnimations]; 
		
		self.weatherImage.hidden = YES;
		self.scrollView.hidden = NO;
	}
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)dealloc {
	[scrollView release];
	[bgImage release];
	[dateLabel release];
	[placeText release];
	[weatherImage release];
    [super dealloc];
}


@end
