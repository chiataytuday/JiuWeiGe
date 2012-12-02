//
//  JiuGongGeAppDelegate.h
//  JiuGongGe
//
//  Created by dskyu on 11-3-3.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//
#import "define.h"

@interface JiuGongGeAppDelegate : NSObject <UIApplicationDelegate> {

    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	
	UIImageView *imageView;
    UIWindow *window;
	UITabBarController *rootViewController;
	UIImage *save;
	
	NSDictionary *dictionary;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UITabBarController *rootViewController;
@property (nonatomic, retain) IBOutlet UIImage *save;
@property (nonatomic, retain) NSDictionary *dictionary;

- (NSString *)applicationDocumentsDirectory;
- (void) HiddenImage;
@end

