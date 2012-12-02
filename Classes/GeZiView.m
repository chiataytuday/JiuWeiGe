//
//  GeZiView.m
//  JiuGongGe
//
//  Created by dskyu on 11-3-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GeZiView.h"


@implementation GeZiView
@synthesize content;
@synthesize title;
@synthesize bgImage;
@synthesize rButton;
@synthesize num;

-(void) textViewDidChange:(UITextView *)textView
{
/*	if (textView.text.length > 30) {
		textView.editable = NO;
	}
	textView.editable = YES;*/

	NSString *string = [[NSString alloc] initWithFormat:@"LastContent%d",self.num];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:self.content.text forKey:string];
	NSLog(@"%@",self.content.text);
	[string release];
	
}
-(void) textViewDidBeginEditing:(UITextView *)textView
{
	if (self.rButton.hidden == YES) 
	{
		[[self superview] bringSubviewToFront:self];
		[UIView beginAnimations:@"move" context:nil];
		[UIView setAnimationDuration:1.25];
		self.frame = CGRectMake(7, 10, 306, 366);
		textView.frame = CGRectMake(0, 30, 320, 210);
		self.title.frame = CGRectMake(50, 5, 160, 30);
		self.title.font = [UIFont fontWithName:@"Helvetica" size:18];
		textView.font = [UIFont fontWithName:@"Helvetica" size:36];
		self.bgImage.contentMode = UIViewContentModeScaleToFill;
		[UIView commitAnimations];
		self.rButton.hidden = NO;
	}
}

-(IBAction) endEditing:(id) sender
{
	
 }
-(IBAction) titleBeginEditing:(id) sender
{
	if (self.rButton.hidden == YES) 
	{
		[[self superview] bringSubviewToFront:self];
		[UIView beginAnimations:@"move" context:nil];
		[UIView setAnimationDuration:1.25];
		self.frame = CGRectMake(7, 10, 306, 366);
		self.content.frame = CGRectMake(0, 30, 320, 210);
		self.title.frame = CGRectMake(50, 5, 160, 30);
		self.title.font = [UIFont fontWithName:@"Helvetica" size:18];
		self.content.font = [UIFont fontWithName:@"Helvetica" size:36];
		self.bgImage.contentMode = UIViewContentModeScaleToFill;
		[UIView commitAnimations]; 
		self.rButton.hidden = NO;
	}
}

-(IBAction) rButtonPressed:(id) sender
{
	[UIView beginAnimations:@"move" context:nil];
	[UIView setAnimationDuration:1.25];
	switch (self.num) {
		case 1:
			self.frame = CGRectMake(7, 20, 100, 120);
			self.bgImage.contentMode = UIViewContentModeTopLeft;
			break;
		case 2:
			self.frame = CGRectMake(110, 20, 100, 120);
			self.bgImage.contentMode = UIViewContentModeTop;
			break;
		case 3:
			self.frame = CGRectMake(213, 20, 100, 120);
			self.bgImage.contentMode = UIViewContentModeTopRight;
			break;
		case 4:
			self.frame = CGRectMake(7, 143, 100, 120);
			self.bgImage.contentMode = UIViewContentModeLeft;
			break;
		case 5:
			self.frame = CGRectMake(213, 143, 100, 120);
			self.bgImage.contentMode = UIViewContentModeRight;
			break;
		case 6:
			self.frame = CGRectMake(7, 266, 100, 120);
			self.bgImage.contentMode = UIViewContentModeBottomLeft;
			break;
		case 7:
			self.frame = CGRectMake(110, 266, 100, 120);
			self.bgImage.contentMode = UIViewContentModeBottom;
			break;
		case 8:
			self.frame = CGRectMake(213, 266, 100, 120);
			self.bgImage.contentMode = UIViewContentModeBottomRight;
			break;

		default:
			break;
	}
	
	self.content.frame = CGRectMake(0, 15, 100, 105);
	self.title.frame = CGRectMake(2, 0, 98, 25);
	self.title.font = [UIFont fontWithName:@"Helvetica" size:14];
	self.content.font = [UIFont fontWithName:@"Helvetica" size:18];
	[UIView commitAnimations];
	self.rButton.hidden = YES;
	[self.title resignFirstResponder];
	[self.content resignFirstResponder];
}


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}


- (void)dealloc {
	[content release];
	[title release];
	[bgImage release];
	[rButton release];
    [super dealloc];
}


@end
