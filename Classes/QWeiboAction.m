//
//  QWeiboAction.m
//  JiuGongGe
//
//  Created by iDream002 on 11-12-11.
//  Copyright 2011 iDreamStudio. All rights reserved.
//

#import "QWeiboAction.h"
#import "QWeibo.h"
#import "QWeiboSyncApi.h"
#import "QWeiboAsyncApi.h"
#import "QVerifyWebView.h"
#import "JSON.h"

@implementation QWeiboAction
@synthesize content;
@synthesize image;

@synthesize connection;
@synthesize responseData;
@synthesize errorcode;

-(id) init
{
	self = [super init];
	if (self) {
		self.errorcode == -1;
	}
	return self;
}

-(void) loadWebView
{
	QWeibo *QWeiboShare = [QWeibo shareQWeibo];
	if (QWeiboShare.tokenKey && ![QWeiboShare.tokenKey isEqualToString:@""] && 
		QWeiboShare.tokenSecret && ![QWeiboShare.tokenSecret isEqualToString:@""]) {
		
		QVerifyWebView *webView = (QVerifyWebView *)gWebView;
		webView.hidden = YES;
		[self postString:self.content withImageData:self.image];
		
	} else {
		
		QWeiboSyncApi *api = [[[QWeiboSyncApi alloc] init] autorelease];
		NSString *retString = [api getRequestTokenWithConsumerKey:QWeiboAppKey consumerSecret:QWeiboAppSecret];
        
		NSLog(@"Get requestToken:%@", retString);
		
		[QWeiboShare parseTokenKeyWithResponse:retString];
		
		QVerifyWebView *webView = (QVerifyWebView *)gWebView;
		
		QWeibo *QWeiboShare = [QWeibo shareQWeibo];
		
        
		NSString *url = [NSString stringWithFormat:@"%@%@", VERIFY_URL, QWeiboShare.tokenKey];
        
        
		NSURL *requestUrl = [NSURL URLWithString:url];
		NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
     //   [webView loadHTMLString:@"<html><body>fdsaf</body></html>" baseURL:nil];
		[webView loadRequest:request];
		webView.hidden = NO;
		webView.scalesPageToFit = YES;
		
	}
}
-(void)postString:(NSString *)status withImageData:(NSData *)imageData
{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	QWeibo *QWeiboShare = [QWeibo shareQWeibo];
	
	NSString *filePath = [NSTemporaryDirectory() stringByAppendingFormat:@"temp.png"];
	[imageData writeToFile:filePath atomically:YES];
	
	QWeiboAsyncApi *api = [[[QWeiboAsyncApi alloc] init] autorelease];
	self.connection = [api publishMsgWithConsumerKey:QWeiboShare.appKey 
					consumerSecret:QWeiboShare.appSecret 
					accessTokenKey:QWeiboShare.tokenKey 
				 accessTokenSecret:QWeiboShare.tokenSecret 
						   content:status 
						  imageFile:filePath
						resultType:RESULTTYPE_JSON 
						  delegate:self];
	
}

-(void) dealloc
{
	[image release];
	[content release];
	[connection release];
	[responseData release];
	[super dealloc];
}



#pragma mark -
#pragma mark NSURLConnection delegate
	 
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}
	 
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	self.responseData = [NSMutableData data];
	NSLog(@"total = %d", [response expectedContentLength]);
}
	 
- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *result = [[[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding] autorelease];
	NSLog(@"%@",result);
	NSDictionary *items = [result JSONValue];
	[self visitDict:items];
	if (self.errorcode == 0) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"成功",@"success")
														message:NSLocalizedString(@"发表成功！",@"success")
													   delegate:nil 
											  cancelButtonTitle:NSLocalizedString(@"确定",@"describer message warn button")
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}else if (self.errorcode == 5) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"失败",@"fail")
														message:NSLocalizedString(@"发表内空相同！",@"the same")
													   delegate:nil 
											  cancelButtonTitle:NSLocalizedString(@"确定",@"describer message warn button")
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		
	}else{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告",@"describer warn alert")
														message:NSLocalizedString(@"网络错误！",@"network error")
													   delegate:nil 
											  cancelButtonTitle:NSLocalizedString(@"确定",@"describer message warn button")
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	self.connection = nil;
}
	 
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告",@"describer warn alert")
													message:NSLocalizedString(@"网络错误！",@"network error")
												   delegate:nil 
										  cancelButtonTitle:NSLocalizedString(@"确定",@"describer message warn button")
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
	[NSString stringWithFormat:@"connection error:%@", error];
	self.connection = nil;
}

-(void)visitDict:(NSDictionary *)dict{  
	NSArray *keys=[dict allKeys];  
	for (NSString *key in keys) {  
		if ([key isEqualToString:@"ret"] && [[dict objectForKey:key] isEqualToNumber:[NSNumber numberWithInt:0]]) {
			self.errorcode = 0;
		}
		if ([key isEqualToString:@"ret"] && [[dict objectForKey:key] isEqualToNumber:[NSNumber numberWithInt:5]]) {
			self.errorcode = 5;
		}
		if([[dict objectForKey:key] isKindOfClass:[NSDictionary class]]){  
			[self visitDict:[dict objectForKey:key]];  
		}  
	}  
}  


@end
