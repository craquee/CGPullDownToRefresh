//
//  DetailViewController.h
//  CRPullDownToRefreshDemo
//
//  Created by Tomoya Igarashi on 9/24/13.
//
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
