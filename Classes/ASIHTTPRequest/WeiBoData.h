//
//  WeiBoData.h
//  testPost
//
//  Created by angel li on 10-11-20.
//  Copyright 2010 Lixf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"

#define kOAuthConsumerKey				@"2913628416"		//Your Sina OAuth Key
#define kOAuthConsumerSecret			@"8ae5c9afebb0060f9b946d1729ec118b"		//Your Sina OAuth Secret
#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

#define BARBUTTON(TITLE, SELECTOR) 	[[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR] autorelease]

@interface WeiBoData : NSObject {
	NSString *username;
	NSString *password;
}
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;

-(void)postString:(NSString *)status withUrl:(NSURL *)url;
-(void)postData:(NSString *)status withImageData:(NSData *)imageData withUrl:(NSURL *)url;
-(NSURL *)getAuthUrlWithData:(NSData *)imageDatal;
-(void)getUserInformation;

-(NSData *)getUIImageToNSData:(NSString *)imagePath toFrame:(CGRect)frame;
@end
