//
//  CGPullDownToRefresh.m
//  CGPullDownToRefresh
//
//  Created by Tomoya Igarashi on 9/30/13.
//
//

#import "CGPullDownToRefresh.h"

#define PULLDOWN_MARGIN -2.f
#define ANIMATE_DURATION 0.2f

@implementation CGPullDownToRefresh

- (id)initWithTableView:(UITableView *)tableView pullDownMargin:(CGFloat)pullDownMargin
{
    self = [super init];
    
    if (self) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CGPullDownToRefreshView" owner:nil options:nil];
        _refreshView = [nib objectAtIndex:0];
        tableView.tableHeaderView = _refreshView;
        _tableView = tableView;
        _status = kCGPullDownToRefreshStatusHidden;
        _pullDownMargin = pullDownMargin < PULLDOWN_MARGIN ? pullDownMargin : PULLDOWN_MARGIN;
    }
    
    return self;
}

- (void)hidden
{
    _status = kCGPullDownToRefreshStatusHidden;
    [self animateTableHeaderViewWithDuration:ANIMATE_DURATION hidden:YES animated:NO animateDidCompletion:nil];
    [self updateStatus:kCGPullDownToRefreshStatusHidden];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_status == kCGPullDownToRefreshStatusUpdating) {
        return;
    }
    
    CGFloat threshold = self.tableView.tableHeaderView.frame.size.height;
    
    if (scrollView.contentOffset.y < PULLDOWN_MARGIN) {
        [self updateStatus:kCGPullDownToRefreshStatusOveredThreshold];
    } else if (scrollView.contentOffset.y >= PULLDOWN_MARGIN &&
               scrollView.contentOffset.y < threshold) {
        [self updateStatus:kCGPullDownToRefreshStatusPullingDown];
    } else {
        [self updateStatus:kCGPullDownToRefreshStatusHidden];
    }
//    NSLog(@"t:%f, y:%f", threshold, scrollView.contentOffset.y);
}

- (BOOL)scrollViewDidEndDragging:(UIScrollView *)scrollView
{
    if (_status == kCGPullDownToRefreshStatusOveredThreshold) {
        [self updateStatus:kCGPullDownToRefreshStatusUpdating];
        [self animateTableHeaderViewWithDuration:ANIMATE_DURATION hidden:NO animated:YES animateDidCompletion:nil];
        return TRUE;
    }
    return FALSE;
}

- (void)refreshDidUpdateWithAnimated:(BOOL)animated animateDidCompletion:(AnimateDidCompletion)animateDidCompletion
{
    [self animateTableHeaderViewWithDuration:ANIMATE_DURATION hidden:YES animated:animated animateDidCompletion:animateDidCompletion];
}

#pragma mark - Private

- (void)updateStatus:(CGPullDownToRefreshStatus)status
{
    CGPullDownToRefreshView *view = (CGPullDownToRefreshView *)self.tableView.tableHeaderView;
    
    switch (status) {
        case kCGPullDownToRefreshStatusHidden:
            [view.labelStatus setText:nil];
            [view.indicatorUpdating stopAnimating];
            [view animateHeadingViewWithAnimate:NO isHeadingUp:NO hidden:YES];
            break;
            
        case kCGPullDownToRefreshStatusPullingDown:
            [view.labelStatus setText:NSLocalizedString(@"pulling down...", @"status pulling down")];
            [view.indicatorUpdating stopAnimating];
            if (_status != kCGPullDownToRefreshStatusPullingDown) {
                [view animateHeadingViewWithAnimate:YES isHeadingUp:NO hidden:NO];
            }
            break;
            
        case kCGPullDownToRefreshStatusOveredThreshold:
            [view.labelStatus setText:NSLocalizedString(@"update when release your finger.", @"status overed threshold")];
            [view.indicatorUpdating stopAnimating];
            if (_status == kCGPullDownToRefreshStatusPullingDown) {
                [view animateHeadingViewWithAnimate:YES isHeadingUp:YES hidden:NO];
            }
            break;
            
        case kCGPullDownToRefreshStatusUpdating:
            [view.labelStatus setText:NSLocalizedString(@"updating...", @"status updating")];
            [view.indicatorUpdating startAnimating];
            [view animateHeadingViewWithAnimate:NO isHeadingUp:NO hidden:YES];
            break;
            
        default:
            break;
    }
    
    self.tableView.tableHeaderView = view;
    
    _status = status;
}

- (void)animateTableHeaderViewWithDuration:(CGFloat)duration hidden:(BOOL)hidden animated:(BOOL)animated animateDidCompletion:(AnimateDidCompletion)animateDidCompletion
{
    CGFloat topOffset = 0.f;
    
    if (hidden) {
        topOffset = -self.tableView.tableHeaderView.frame.size.height;
    }
    
    __block UITableView *block_ = self.tableView;
    
    if (animated) {
        [UIView animateWithDuration:duration
                              delay:0.2f
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             block_.contentInset = UIEdgeInsetsMake(topOffset, 0.f, 0.f, 0.f);
                         }
                         completion:^(BOOL finished) {
                             if (animateDidCompletion) {
                                 animateDidCompletion(finished, hidden);
                             }
                         }];
    } else {
        self.tableView.contentInset = UIEdgeInsetsMake(topOffset, 0.f, 0.f, 0.f);
    }
}

@end
