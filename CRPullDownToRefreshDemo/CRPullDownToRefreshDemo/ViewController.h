//
//  ViewController.h
//  CRPullDownToRefreshDemo
//
//  Created by Tomoya Igarashi on 9/27/13.
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *rootView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
