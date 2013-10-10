//
//  CRPullDownToRefresh.h
//  CRPullDownToRefresh
//
//  Created by Tomoya Igarashi on 9/30/13.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CRPullDownToRefreshView.h"

typedef NS_ENUM(NSUInteger, CRPullDownToRefreshStatus) {
    kCRPullDownToRefreshStatusHidden = 0,
    kCRPullDownToRefreshStatusPullingDown,
    kCRPullDownToRefreshStatusOveredThreshold,
    kCRPullDownToRefreshStatusUpdating,
    kCRPullDownToRefreshStatusDidUpdate,
};

typedef void (^AnimateDidCompletion)(BOOL finished, BOOL hidden);

@interface CRPullDownToRefresh : NSObject

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CRPullDownToRefreshView *refreshView;
@property (unsafe_unretained, nonatomic) CRPullDownToRefreshStatus status;
@property (unsafe_unretained, nonatomic) CGFloat pullDownMargin;

- (id)initWithTableView:(UITableView *)tableView pullDownMargin:(CGFloat)pullDownMargin;
- (void)hidden;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (BOOL)scrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)refreshDidUpdateWithAnimateDidCompletion:(AnimateDidCompletion)animateDidCompletion;
@end
