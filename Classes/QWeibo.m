//
//  QWeibo.m
//  JiuGongGe
//
//  Created by iDream on 11-12-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QWeibo.h"
#import "NSURL+QAdditions.h"

#define AppKey			@"appKey"
#define AppSecret		@"appSecret"
#define AppTokenKey		@"tokenKey"
#define AppTokenSecret	@"tokenSecret"

@implementation QWeibo

@synthesize appKey;
@synthesize appSecret;
@synthesize tokenKey;
@synthesize tokenSecret;
@synthesize verifier;
@synthesize response;

static QWeibo* sharedQWeiboObj = nil;

+ (QWeibo *) shareQWeibo
{
	if (!sharedQWeiboObj) {
		sharedQWeiboObj = [[QWeibo alloc] init];
	}
	return sharedQWeiboObj;
}

- (id) init
{
	self = [super init];
	if (self) {
		self.appKey = QWeiboAppKey;
		self.appSecret = QWeiboAppSecret;
	}
	return self;
}

- (void)parseTokenKeyWithResponse:(NSString *)aResponse {
	
	NSDictionary *params = [NSURL parseURLQueryString:aResponse];
	self.tokenKey = [params objectForKey:@"oauth_token"];
	self.tokenSecret = [params objectForKey:@"oauth_token_secret"];
	
}

- (void)dealloc {
	[appKey release];
	[appSecret release];
	[tokenKey release];
	[tokenSecret release];
	[verifier release];
	
    [super dealloc];
}


@end
