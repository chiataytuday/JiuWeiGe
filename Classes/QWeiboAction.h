//
//  QWeiboAction.h
//  JiuGongGe
//
//  Created by iDream002 on 11-12-11.
//  Copyright 2011 iDreamStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
extern void *gWebView;

#define VERIFY_URL @"http://open.t.qq.com/cgi-bin/authorize?oauth_token="

@interface QWeiboAction : NSObject {
	NSString *content;
	NSData *image;
	
	NSURLConnection *connection;
	NSMutableData *responseData;
	int errorcode;
}

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSData *image;

@property (nonatomic, retain) NSURLConnection	*connection;
@property (nonatomic, retain) NSMutableData		*responseData;
@property int errorcode;

-(void)postString:(NSString *)status withImageData:(NSData *)imageData;
-(void)visitDict:(NSDictionary *)dict;
-(void) loadWebView;

@end
