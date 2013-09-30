//
//  CGPullDownToRefresh.h
//  CGPullDownToRefresh
//
//  Created by Tomoya Igarashi on 9/30/13.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CGPullDownToRefreshView.h"

typedef NS_ENUM(NSUInteger, CGPullDownToRefreshStatus) {
    kCGPullDownToRefreshStatusHidden = 0,
    kCGPullDownToRefreshStatusPullingDown,
    kCGPullDownToRefreshStatusOveredThreshold,
    kCGPullDownToRefreshStatusUpdating,
};

typedef void (^AnimateDidCompletion)(BOOL finished, BOOL hidden);

@interface CGPullDownToRefresh : NSObject

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CGPullDownToRefreshView *refreshView;
@property (unsafe_unretained, nonatomic) CGPullDownToRefreshStatus status;
@property (unsafe_unretained, nonatomic) CGFloat pullDownMargin;

- (id)initWithTableView:(UITableView *)tableView pullDownMargin:(CGFloat)pullDownMargin;
- (void)hidden;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (BOOL)scrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)refreshDidUpdateWithAnimated:(BOOL)animated animateDidCompletion:(AnimateDidCompletion)animateDidCompletion;
@end
