//
//  QWeibo.h
//  JiuGongGe
//
//  Created by iDream on 11-12-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define QWeiboAppKey @"801156532"
#define QWeiboAppSecret @"14c7839f297b472ec419bf2f337c261b"


@interface QWeibo : NSObject {
	NSString *appKey;
	NSString *appSecret;
	NSString *tokenKey;
	NSString *tokenSecret;
	NSString *verifier;
	
	NSString *response;
	
}

@property (nonatomic, copy) NSString *appKey;
@property (nonatomic, copy) NSString *appSecret;
@property (nonatomic, copy) NSString *tokenKey;
@property (nonatomic, copy) NSString *tokenSecret;
@property (nonatomic, copy) NSString *verifier;
@property (nonatomic, copy) NSString *response;


+ (QWeibo *) shareQWeibo;
- (void)parseTokenKeyWithResponse:(NSString *)aResponse;

@end
