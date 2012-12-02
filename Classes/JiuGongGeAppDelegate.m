//
//  JiuGongGeAppDelegate.m
//  JiuGongGe
//
//  Created by dskyu on 11-3-3.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "JiuGongGeAppDelegate.h"


@implementation JiuGongGeAppDelegate

@synthesize window;
@synthesize imageView;
@synthesize rootViewController;
@synthesize save;
@synthesize dictionary;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSDictionary *imageDefaults = [NSDictionary dictionaryWithObject:@"BG_1" forKey:kBgImage];
	NSDictionary *numDefaults = [NSDictionary dictionaryWithObject:@"0" forKey:kBgNumber];
	NSDictionary *diaryDefaults =  [NSDictionary dictionaryWithObject:@"Paper_1" forKey:kDiaryImage];
	NSDictionary *numDiaryDefaults = [NSDictionary dictionaryWithObject:@"0" forKey:kDiaryNumber];
	NSDictionary *welcomeDefaults = [NSDictionary dictionaryWithObject:@"YES" forKey:kWelcomeView];
	NSDictionary *tipDefaults = [NSDictionary dictionaryWithObject:@"YES" forKey:kGestureTip];
	NSDictionary *planDefaults = [NSDictionary dictionaryWithObject:@"Plan1" forKey:kPlan];
	NSDictionary *planNameDefaults = [NSDictionary dictionaryWithObject:@"默认" forKey:kPlanName];
	NSDictionary *SavedImageNumberDefaults = [NSDictionary dictionaryWithObject:@"1" forKey:kSavedNumber];
	NSDictionary *expressImageDefaults = [NSDictionary dictionaryWithObject:@"expression1.png" forKey:kExpressionImage];
	NSDictionary *paperAlphaDefaults = [NSDictionary dictionaryWithObject:@"0.8" forKey:kPaperAlpha];
	NSDictionary *contentDefaults = [NSDictionary dictionaryWithObject:@"0" forKey:kContentColor];
	NSDictionary *titleDefaults = [NSDictionary dictionaryWithObject:@"0" forKey:kTitleColor];
	
	[defaults registerDefaults:imageDefaults];
	[defaults registerDefaults:numDefaults];
	[defaults registerDefaults:diaryDefaults];
	[defaults registerDefaults:numDiaryDefaults];
	[defaults registerDefaults:welcomeDefaults];
	[defaults registerDefaults:planDefaults];
	[defaults registerDefaults:planNameDefaults];
	[defaults registerDefaults:SavedImageNumberDefaults];
	[defaults registerDefaults:expressImageDefaults];
	[defaults registerDefaults:paperAlphaDefaults];
	[defaults registerDefaults:contentDefaults];
	[defaults registerDefaults:titleDefaults];
	[defaults registerDefaults:tipDefaults];
	
	
	[defaults synchronize];
	
	UITabBarItem *item1 = [self.rootViewController.tabBar.items objectAtIndex:0];
	item1.image = [UIImage imageNamed:@"main.png"];
	item1.title = NSLocalizedString(@"主界面",@"tabItem1Title");
	
	UITabBarItem *item2 = [self.rootViewController.tabBar.items objectAtIndex:1];
	item2.image = [UIImage imageNamed:@"send.png"];
	item2.title = NSLocalizedString(@"发送",@"tabItem2Title");
	
	UITabBarItem *item3 = [self.rootViewController.tabBar.items objectAtIndex:2];
	item3.title = NSLocalizedString(@"以前",@"tabItem3Title");
	item3.image = [UIImage imageNamed:@"before.png"];
	
	UITabBarItem *item4 = [self.rootViewController.tabBar.items objectAtIndex:3];
	item4.image = [UIImage imageNamed:@"settings.png"];
	item4.title = NSLocalizedString(@"设置",@"tabItem4Title");
	
	[window makeKeyAndVisible];

	BOOL welcome;
	welcome = [defaults boolForKey:kWelcomeView];
	self.imageView.image = [UIImage imageNamed:@"welcome.png"];
	if (welcome) {
		[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(HiddenImage) userInfo:nil repeats:NO];
	}
	else {
		[self HiddenImage];
	}

}

-(void) HiddenImage
{
	imageView.hidden = YES;
	[window addSubview:rootViewController.view];

}



/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	
    NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        } 
    }
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"JiuGongGe.sqlite"]];
	
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
    
	[dictionary release];
	[window release];
	[rootViewController release];
	[imageView release];
	[save release];
	[super dealloc];
}


@end

