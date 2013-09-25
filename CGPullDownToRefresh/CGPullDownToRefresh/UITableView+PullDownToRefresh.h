//
//  UITableView+PullDownToRefresh.h
//  CGPullDownToRefresh
//
//  Created by Tomoya Igarashi on 9/25/13.
//
//

#import <UIKit/UIKit.h>
#import "CGPullDownToRefreshView.h"

typedef NS_ENUM(NSUInteger, CGPullDownToRefreshStatus) {
    kCGPullDownToRefreshStatusHidden = 0,
    kCGPullDownToRefreshStatusPullingDown,
    kCGPullDownToRefreshStatusOveredThreshold,
    kCGPullDownToRefreshStatusUpdating,
};

@interface UITableView (PullDownToRefresh)

- (void)animateTableHeaderViewWithDuration:(CGFloat)duration hidden:(BOOL)hidden animated:(BOOL)animated;
- (void)pullDownToRefreshDidEndScroll:(UIScrollView *)scrollView;
- (BOOL)pullDownToRefreshDidEndDragging:(UIScrollView *)scrollView;
- (void)pullDownToRefreshDidEndUpdate;

@end
