//
//  WeiBoData.m
//  testPost
//
//  Created by angel li on 10-11-20.
//  Copyright 2010 Lixf. All rights reserved.
//

#import "WeiBoData.h"
#import "StringUtil.h"

@implementation WeiBoData
@synthesize username, password;

-(void)postString:(NSString *)status withUrl:(NSURL *)url{
	NSString *postString = [NSString stringWithFormat:@"%@",
                            [status encodeAsURIComponent]];
	ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
	[request setDelegate:self];
	[self getUserInformation];
    NSString* auth = [NSString stringWithFormat:@"%@:%@",username,password];
    NSString* basicauth = [NSString stringWithFormat:@"Basic %@", [NSString base64encode:auth]];
	[request addRequestHeader:@"Authorization" value:basicauth];
	[request addPostValue:postString forKey:@"status"];
	[request startSynchronous];
	[request release];		
}


-(void)postData:(NSString *)status withImageData:(NSData *)imageData withUrl:(NSURL *)url{
	NSString *postString = [NSString stringWithFormat:@"%@",
                            [status encodeAsURIComponent]];
	ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
	[request setDelegate:self];
//	[self getUserInformation];
    NSString* auth = [NSString stringWithFormat:@"%@:%@", username, password];
    NSString* basicauth = [NSString stringWithFormat:@"Basic %@", [NSString base64encode:auth]];
	[request setPostFormat:ASIMultipartFormDataPostFormat];
	[request addRequestHeader:@"Authorization" value:basicauth];
	[request addPostValue:postString forKey:@"status"];
	if(imageData)
		[request setData:imageData forKey:@"pic"];
	//else
	//	NSLog(@"Image was null");
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[request startAsynchronous];
	[request release];		
}


-(NSData *)getUIImageToNSData:(NSString *)imagePath toFrame:(CGRect)frame{
	UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
	if(![[imagePath lastPathComponent] isEqualToString:@"png"])
	{
		UIGraphicsBeginImageContext(frame.size);
		[image drawInRect:frame];
		// Draw picture first
		UIImage *currentImage = UIGraphicsGetImageFromCurrentImageContext();
		NSData *imageData = UIImagePNGRepresentation(currentImage);
		return imageData;
	}
	return UIImagePNGRepresentation(image);
}


-(NSURL *)getAuthUrlWithData:(NSData *)imageData{
	NSString* aURL = @"";
	if(imageData)
		aURL = @"http://api.t.sina.com.cn/statuses/upload.json";
	else
		aURL = @"http://api.t.sina.com.cn/statuses/update.json";
	NSString *URL = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)aURL, (CFStringRef)@"%", NULL, kCFStringEncodingUTF8);
	NSURL *finalURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@source=%@", 
											URL,
											([URL rangeOfString:@"?"].location != NSNotFound) ? @"&" : @"?" , 
											kOAuthConsumerKey]];	
	return finalURL;
}


- (void)requestFinished:(ASIHTTPRequest *)request {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	NSLog(@"request responseString:%@", [request responseString]);
	
	if ([[request responseString] rangeOfString:@"error_code\":\"403"].location == NSNotFound) 
	{
		if ([[request responseString] rangeOfString:@"error\":\"40028"].location == NSNotFound)
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"成功",@"request success alert")
															message:NSLocalizedString(@"发送成功",@"request success message")
														   delegate:nil
												  cancelButtonTitle:NSLocalizedString(@"确定",@"request success button")
												  otherButtonTitles:nil ];
			[alert show];
			[alert release];
		}
		else 
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"发送失败",@"request fail alert2")
															message:NSLocalizedString(@"不要太贪心哦！你已经发过一次啦。",@"request fail message2")
														   delegate:nil
												  cancelButtonTitle:NSLocalizedString(@"确定",@"equest fail button2")
												  otherButtonTitles:nil ];
			[alert show];
			[alert release];
		}

		
	}
	else 
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"发送失败",@"request fail alert1")
														message:NSLocalizedString(@"请确认您的账户!",@"request fail message1")
													   delegate:nil
											  cancelButtonTitle:NSLocalizedString(@"确定",@"request fail button1")
											  otherButtonTitles:nil ];
		[alert show];
		[alert release];
	}

	
}


- (void)requestFailed:(ASIHTTPRequest *)request {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	NSError *error = [request error];
	NSLog(@"error:%@", error);
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"失败",@"request fail alert2")
													message:NSLocalizedString(@"发送失败，请检查网络或您的账户!",@"request fail message2")
												   delegate:nil
										  cancelButtonTitle:NSLocalizedString(@"确定",@"request fail button2")
										  otherButtonTitles:nil ];
	[alert show];
	[alert release];
}



-(void)getUserInformation
{
	
}

@end
