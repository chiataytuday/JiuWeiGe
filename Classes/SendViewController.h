//
//  SendViewController.h
//  JiuGongGe
//
//  Created by dskyu on 11-3-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JiuGongGeAppDelegate.h"
#import "QVerifyWebView.h"
#import "define.h"
#import "RRConnect.h"

extern BOOL shouldSaveImage;
extern void *gWebView;
@interface SendViewController : UIViewController <UIAlertViewDelegate,UITextViewDelegate,UIWebViewDelegate,
								RequestDelegate,RRDialogDelegate,RRSessionDelegate>{
	UIImageView *imageView;
	UILabel *count;
	UITextView *paperTextView;
	UIView *paperView;
	UILabel *paperLabel;
	UIImageView *paperImageView;
	NSString *account;
	NSString *password;
	
	UIButton *saveButton;
	UIButton *QWeiboButton;
	UIButton *SinaWeiboButton;
	UIButton *RenrenButton;
	
	Renren* _renren;
	NSArray* _permissions;
	
    NSString *Qwebhtml;
	QVerifyWebView *QwebView;
	NSString *username;
	NSString *statu;
	NSData *image;
	
	int type;
}

@property (nonatomic ,retain) IBOutlet UIImageView *imageView;
@property (nonatomic ,retain) UILabel *count;
@property (nonatomic ,retain) UITextView *paperTextView;
@property (nonatomic ,retain) UIView *paperView;
@property (nonatomic ,retain) UILabel *paperLabel;
@property (nonatomic ,retain) UIImageView *paperImageView;
@property (nonatomic ,retain) NSString *account;
@property (nonatomic ,retain) NSString *password;
@property (nonatomic ,retain) IBOutlet UIButton *saveButton;
@property (nonatomic ,retain) IBOutlet UIButton *QWeiboButton;
@property (nonatomic ,retain) IBOutlet UIButton *SinaWeiboButton;
@property (nonatomic ,retain) IBOutlet UIButton *RenrenButton;
@property (nonatomic ,retain) IBOutlet UIWebView *QwebView;
@property (nonatomic ,retain) NSString *username;
@property (nonatomic ,retain) NSString *Qwebhtml;
@property int type;

@property (nonatomic, copy) NSString *statu;
@property (nonatomic, copy) NSData *image;

@property(nonatomic,retain) Renren *_renren;

-(NSString *)userFilePath;
- (NSString *) dataFilePath;
- (NSString *) getPath;
- (void) sendWeibo:(NSString *)content;
- (void) clearContent;

- (IBAction) saveButtonPress:sender;
- (IBAction) QWeiboButtonPress:sender;
- (IBAction) SinaWeiboButtonPress:sender;
- (IBAction) RenrenButtonPress:sender;

-(void)showAlert:(NSString*) message;
@end
