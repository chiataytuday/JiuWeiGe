//
//  SendViewController.m
//  JiuGongGe
//
//  Created by dskyu on 11-3-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SendViewController.h"
#import "WeiBoData.h"
#import "StringUtil.h"
#import "QWeiboAction.h"
#import "QWeibo.h"
#import "QWeiboSyncApi.h"
#import "RRConnect.h"
#import	"JSON.h"

@implementation SendViewController

@synthesize imageView;
@synthesize account;
@synthesize password;
@synthesize count;
@synthesize paperTextView;
@synthesize paperView;
@synthesize paperLabel;
@synthesize paperImageView;
@synthesize saveButton;
@synthesize QWeiboButton;
@synthesize SinaWeiboButton;
@synthesize RenrenButton;
@synthesize type;
@synthesize QwebView;
@synthesize username;
@synthesize statu;
@synthesize image;
@synthesize _renren;
@synthesize Qwebhtml;

- (NSString *) dataFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"SavedImage.plist"];
}

- (NSString *) userFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"User.plist"];
}

- (NSString *) getPath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSUserDefaults *times = [NSUserDefaults standardUserDefaults];
	NSDate *now = [NSDate date];
	NSDateFormatter *dateFormmatter = [[NSDateFormatter alloc] init];
	[dateFormmatter setDateFormat:@"YYYY-MM-dd"];
	
	NSString *number = [[NSString alloc] initWithString:[dateFormmatter stringFromDate:now]];
	
	if (![number isEqualToString:[times objectForKey:kSavedDate]] || [times objectForKey:kSavedDate] == nil) 
	{
		[times setObject:number forKey:kSavedDate];
		[times setInteger:1 forKey:kSavedNumber];
	} 
	NSInteger ImageNumber = [times integerForKey:kSavedNumber];
	
	NSString *string = [[[NSString alloc] init] autorelease];
	if (ImageNumber < 10) 
	{
		string = [number stringByAppendingFormat:@"-0%d.png",ImageNumber];
	}
	else if (ImageNumber >= 10)
	{
		string = [number stringByAppendingFormat:@"-%d.png",ImageNumber];
	}
	[number release];
	if (ImageNumber == 99) {
		[times setInteger:1 forKey:kSavedNumber];
	}
	else 
	{
		[times setInteger:ImageNumber + 1 forKey:kSavedNumber];
	}
	
	return [documentsDirectory stringByAppendingPathComponent:string];
}

-(void) viewWillAppear:(BOOL)animated
{
	JiuGongGeAppDelegate *app = [[UIApplication sharedApplication] delegate];
	self.imageView.image = app.save;	
	
	NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:[self userFilePath]];
	NSArray *array = [dictionary objectForKey:[[NSUserDefaults standardUserDefaults] objectForKey:kUser]];	
	self.account = [array objectAtIndex:0];
	self.password = [array objectAtIndex:1];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	gWebView = self.QwebView;
	self.QwebView.hidden = YES;
	self.QwebView.delegate = self;

}

- (void) saveDairy
{
	if (shouldSaveImage)
	{
		shouldSaveImage = NO;
		NSString *paths = [[NSString alloc] initWithString:[self getPath]];
		NSString *dataPath = [[NSString alloc] initWithString:[self dataFilePath]];
		[UIImagePNGRepresentation(self.imageView.image) writeToFile:paths atomically:YES];
		if([[NSFileManager defaultManager]fileExistsAtPath:dataPath])
		{
			NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:dataPath];
			[array addObject:paths];
			[array writeToFile:dataPath atomically:YES];
			[array release];
		}
		else {
			NSMutableArray *array1 = [[NSMutableArray alloc] initWithObjects:paths,nil];
			[array1 writeToFile:dataPath atomically:YES];
			[array1 release];
		}
		[paths release];
		[dataPath release];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"成功",@"success alert")
														message:NSLocalizedString(@"保存日记成功",@"save message successfully")
													   delegate:nil 
											  cancelButtonTitle:NSLocalizedString(@"确定",@"save message done button")
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else 
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示",@"warn alert")
														message:NSLocalizedString(@"没有保存的必要了！",@"save message repeat")
													   delegate:nil 
											  cancelButtonTitle:NSLocalizedString(@"确定",@"save message warn button")
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}

	
}



- (void) dairyDescribe
{
		UIView *paperTempView = [[UIView alloc] initWithFrame:CGRectMake(10, -310, 300, 300)];
		self.paperView = paperTempView;
		[paperTempView release];
		
		UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 4, 140, 40)];
		myLabel.font = [UIFont fontWithName:@"Helvetica" size:28];
		myLabel.text = NSLocalizedString(@"日记描述",@"Diary describer");
		myLabel.backgroundColor = [UIColor clearColor];
		self.paperLabel = myLabel;
		[myLabel release];
		
		UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 4, 40, 40)];
		countLabel.font = [UIFont fontWithName:@"Helvetica" size:22];
		countLabel.backgroundColor = [UIColor clearColor];
		countLabel.textColor = [UIColor darkGrayColor];
		UIImageView *myImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paperView.png"]];
		self.paperImageView = myImageView;
		[myImageView release];
		
		UITextView *writeView = [[UITextView alloc] initWithFrame:CGRectMake(10, 40, 280, 190)];
		writeView.font = [UIFont fontWithName:@"Helvetica" size:22];
		
		writeView.text = [[NSUserDefaults standardUserDefaults] objectForKey:kDiaryDescriber];
		writeView.backgroundColor = [UIColor clearColor];
		writeView.delegate = self;
		writeView.returnKeyType = UIReturnKeySend;
		
		countLabel.text = [NSString stringWithFormat:@"%d",140 - writeView.text.length];
		self.count = countLabel;
		[countLabel release];
		self.paperTextView = writeView;
		[writeView release];
		
		UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeContactAdd] ;
		[cancelButton addTarget:nil action:@selector(cancelSend) forControlEvents:UIControlEventTouchUpInside];
		cancelButton.center = CGPointMake(15, 15);
		cancelButton.transform = CGAffineTransformIdentity;
		cancelButton.transform = CGAffineTransformMakeRotation(3.14/4);
	
		
		[self.paperView addSubview:cancelButton];
		[self.paperView addSubview:self.paperImageView];
		[self.paperView addSubview:self.paperTextView];
		[self.paperView addSubview:self.paperLabel];
		[self.paperView addSubview:self.count];
		[self.view addSubview:self.paperView];
		
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:1];
		
		self.paperView.frame = CGRectMake(10, 10, 300, 300);
		
		[UIView commitAnimations];
		[writeView becomeFirstResponder];

}

- (IBAction) saveButtonPress:sender
{
	[self saveDairy];
}
- (IBAction) QWeiboButtonPress:sender
{
	[self dairyDescribe];
	self.type = 1;
}
- (IBAction) SinaWeiboButtonPress:sender
{
	if (self.account.length < 1 || self.password.length < 1) 
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告",@"no user alert")
														message:NSLocalizedString(@"未设置可用账号，请先在设置项中设置！",@"no user message")
													   delegate:nil 
											  cancelButtonTitle:NSLocalizedString(@"确定",@"no user done button")
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else {
		[self dairyDescribe];
		self.type = 2;
	}

}
- (IBAction) RenrenButtonPress:sender
{
	_renren=[[Renren alloc] initWithAppKeyAndId:@"53ff680cc5754e2799c92d8ea2562a2b" andAppId:@"172686"];
	if ([_renren isSessionValid]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示",@"alert")
														message:NSLocalizedString(@"已登录",@"Login OK")
													   delegate:self 
											  cancelButtonTitle:NSLocalizedString(@"继续",@"continue")
											  otherButtonTitles:NSLocalizedString(@"退出",@"logout"),nil];
		[alert show];
		[alert release];
	}else {
		_permissions = [[NSArray arrayWithObjects:@"photo_upload publish_feed status_update operate_like",nil] retain];
		[_renren authorize:_permissions delegate:self];
	}
	
}


- (void) sendQWeibo:(NSString *)content
{
	QWeiboAction *QAction = [[QWeiboAction alloc] init];
	JiuGongGeAppDelegate *app = [[UIApplication sharedApplication] delegate];
	NSData *imageData = [[NSData alloc] initWithData:UIImagePNGRepresentation(app.save)];
	QAction.content = content;
	QAction.image = imageData;
	[QAction loadWebView];
	[QAction release];
	
}

- (void) sendSinaWeibo:(NSString *)content
{
	WeiBoData *weiBoData = [[WeiBoData alloc] init];
	weiBoData.username = self.account;
	weiBoData.password = self.password;
	
	NSString *postString = content;
	//post data
	
	NSData *imageData = self.image;
	NSURL* URL = [weiBoData getAuthUrlWithData:imageData];
	
	if(imageData)
		[weiBoData postData:postString withImageData:imageData withUrl:URL];
	else
		[weiBoData postString:postString withUrl:URL];
}

- (void) sendRenren:(NSString *)content
{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	NSString *caption = self.statu;
	UIImage *img=[[UIImage alloc] initWithData:self.image];
	NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObjectsAndKeys:
								 @"photos.upload",@"method",
								 caption,@"caption",
								 img,@"upload",
								 @"0",@"aid",
								 nil];
	[_renren requestWithParams:params andDelegate:self];

	[img release];
	[caption release];
}


- (void) sendWeibo:(NSString *)content
{
	JiuGongGeAppDelegate *app = [[UIApplication sharedApplication] delegate];
	NSData *imageData = [[NSData alloc] initWithData:UIImagePNGRepresentation(app.save)];
	self.statu = content;
	self.image = imageData;
	switch (self.type) {
		case 1:
			[self sendQWeibo:content];
			break;
		case 2:
			[self sendSinaWeibo:content];
			break;
		case 3:
			[self sendRenren:content];
			break;
		default:
			break;
	}
}

-(void) textViewDidChange:(UITextView *)textView
{
	int numCount;
	numCount = 140 - [self.count.text intValue];
	NSLog(@"%d",textView.text.length);
	if (numCount < textView.text.length ) 
	{
		NSString *capture = [textView.text substringFromIndex:numCount];
		NSLog(@"%@",capture);
		
		 if ([capture isEqualToString:@"\n"]) 
		 {
			 NSString *string = [[NSString alloc] initWithString:textView.text];
			 textView.text = [string substringToIndex:numCount]; 
			 [string release];
			 
			 if (textView.text.length > 0) 
			 {
				 [self sendWeibo:textView.text];
				 
				 [UIView beginAnimations:nil context:nil];
				 [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
				 [UIView setAnimationDuration:1];
				 
				 self.paperView.frame = CGRectMake(10, -310, 300, 300);
				 
				 [UIView commitAnimations];
				 
				 [self.paperTextView resignFirstResponder];
			 }
			 else 
			 {
				 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告",@"describer warn alert")
																 message:NSLocalizedString(@"无描述！",@"describer message repeat")
																delegate:nil 
													   cancelButtonTitle:NSLocalizedString(@"确定",@"describer message warn button")
													   otherButtonTitles:nil];
				 [alert show];
				 [alert release];
			 }

			 
			 
		 }
		 else if (textView.text.length >= 140) 
		 {
			 NSString *string = [[NSString alloc] initWithString:textView.text];
			 textView.text = [string substringToIndex:140];
			 [string release];
		 }
		 
	}
	self.count.text = [NSString stringWithFormat:@"%d",140 - textView.text.length];
	NSLog(@"%@",textView.text);
	[[NSUserDefaults standardUserDefaults] setObject:textView.text forKey:kDiaryDescriber];
}

- (void) cancelSend
{
	[[NSUserDefaults standardUserDefaults] setObject:self.paperTextView.text forKey:kDiaryDescriber];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:1];
	
	self.paperView.frame = CGRectMake(10, -310, 300, 300);
	
	[UIView commitAnimations];
	
	[self.paperTextView resignFirstResponder];
}

-(void) textViewDidEndEditing:(UITextView *)textView
{
	[textView resignFirstResponder];
}

- (void) clearContent
{
	self.paperTextView.text = @"";
	self.count.text = @"140";
	[[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kDiaryDescriber];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[paperLabel release];
	[paperImageView release];
	[paperView release];
	[paperTextView release];
	[count release];
	[password release];
	[account release];
	[imageView release];
	[saveButton release];
	[QWeiboButton release];
	[SinaWeiboButton release];
	[RenrenButton release];
	[QwebView release];
	[username release];
	[image release];
	[statu release];
	[_renren release];
	[_permissions release];
    [Qwebhtml release];
    [super dealloc];
}

#pragma mark -
#pragma mark private methods

-(NSString*) valueForKey:(NSString *)key ofQuery:(NSString*)query
{
	NSArray *pairs = [query componentsSeparatedByString:@"&"];
	for(NSString *aPair in pairs){
		NSArray *keyAndValue = [aPair componentsSeparatedByString:@"="];
		if([keyAndValue count] != 2) continue;
		if([[keyAndValue objectAtIndex:0] isEqualToString:key]){
			return [keyAndValue objectAtIndex:1];
		}
	}
	return nil;
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	
	NSString *query = [[request URL] query];
	NSString *verifier = [self valueForKey:@"oauth_verifier" ofQuery:query];
    
	if (verifier && ![verifier isEqualToString:@""]) {
		
		QWeibo *QWeiboShare = [QWeibo shareQWeibo];
		
		QWeiboSyncApi *api = [[[QWeiboSyncApi alloc] init] autorelease];
		NSString *retString = [api getAccessTokenWithConsumerKey:QWeiboShare.appKey 
												  consumerSecret:QWeiboShare.appSecret 
												 requestTokenKey:QWeiboShare.tokenKey 
											  requestTokenSecret:QWeiboShare.tokenSecret 
														  verify:verifier];
		NSLog(@"\nget access token:%@", retString);
		[QWeiboShare parseTokenKeyWithResponse:retString];
		self.username = [self valueForKey:@"name" ofQuery:retString];
		self.QwebView.hidden = YES;
		QWeiboAction *QAction = [[QWeiboAction alloc] init];
		[QAction postString:self.statu withImageData:self.image];
		return NO;
	}
	
  
	return YES;
}

-(void) webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString: @"document.getElementsByName('u')[0].value='369534035';"];
    [webView stringByEvaluatingJavaScriptFromString: @"document.getElementsByName('p')[0].value='';"];
    [webView stringByEvaluatingJavaScriptFromString: @"document.forms[0].submit();"];
    
    
}   

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0) {
		[self dairyDescribe];
		self.type = 3;
	}else if (buttonIndex == 1) {
		[_renren logout:self];
	}
}


/**
 * Rest api接口成功调用后，调用此方法，返回结果数据
 */

- (void)request:(Request *)request didLoad:(id)result {
	NSLog(@"数据请求成功 解析数据");
	NSMutableDictionary* dict=request.params;
    NSString* methondname=[dict valueForKey:@"method"];
	//SBJSON *jsonParser = [[SBJSON new] autorelease];
	if ([result isKindOfClass:[NSArray class]]) {
		
		if ([methondname isEqualToString:@"photos.upload"]) {
			[self showAlert:NSLocalizedString(@"发表成功",@"success")];
		}
	}else {
		[self showAlert:NSLocalizedString(@"发表成功",@"success")];
	}
}


-(void)showAlert:(NSString*) message{
	UIAlertView *av =[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示",@"alert")
												 message:message delegate:nil
									   cancelButtonTitle:NSLocalizedString(@"确定",@"OK") otherButtonTitles:nil] autorelease];
	[av show];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (void)request:(Request *)request didFailWithError:(NSError *)error {
	//NSLog(@"error localizedDescription=======================%@",[error localizedDescription]);
	[self showAlert:[error localizedDescription]];
};

@end
