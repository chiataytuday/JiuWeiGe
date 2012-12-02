
#import <UIKit/UIKit.h>
#import "JiuGongGeAppDelegate.h"
#import "CoverFlowToScan.h"

extern void *dataArray;
@interface BeforeViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
	UITableView *mytableView;
	NSMutableArray *myArray;
	NSMutableArray *dateKeys;
	CoverFlowToScan *coverFlowToScanViewController;
}

@property (nonatomic ,retain) IBOutlet UITableView *mytableView;
@property (nonatomic ,retain) CoverFlowToScan *coverFlowToScanViewController;
@property (nonatomic ,retain) NSMutableArray *myArray;
@property (nonatomic ,retain) NSMutableArray *dateKeys;
- (NSString *) dataFilePath;

@end

