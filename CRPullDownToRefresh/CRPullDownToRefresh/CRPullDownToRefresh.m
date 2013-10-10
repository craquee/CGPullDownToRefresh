//
//  CRPullDownToRefresh.m
//  CRPullDownToRefresh
//
//  Created by Tomoya Igarashi on 9/30/13.
//
//

#import "CRPullDownToRefresh.h"

#define PULLDOWN_MARGIN -2.f
#define ANIMATE_DURATION 0.2f

@implementation CRPullDownToRefresh

- (id)initWithTableView:(UITableView *)tableView pullDownMargin:(CGFloat)pullDownMargin
{
    self = [super init];
    
    if (self) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CRPullDownToRefreshView" owner:nil options:nil];
        _refreshView = [nib objectAtIndex:0];
        tableView.tableHeaderView = _refreshView;
        _tableView = tableView;
        _status = kCRPullDownToRefreshStatusHidden;
        _pullDownMargin = pullDownMargin < PULLDOWN_MARGIN ? pullDownMargin : PULLDOWN_MARGIN;
    }
    
    return self;
}

- (void)hidden
{
    _status = kCRPullDownToRefreshStatusHidden;
    [self animateTableHeaderViewWithDuration:ANIMATE_DURATION delay:0.f hidden:YES animated:NO animateDidCompletion:nil];
    [self updateStatus:kCRPullDownToRefreshStatusHidden];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_status == kCRPullDownToRefreshStatusUpdating ||
        _status == kCRPullDownToRefreshStatusDidUpdate) {
        return;
    }
    
    CGFloat threshold = self.tableView.tableHeaderView.frame.size.height;
    
    if (scrollView.contentOffset.y < PULLDOWN_MARGIN) {
        [self updateStatus:kCRPullDownToRefreshStatusOveredThreshold];
    } else if (scrollView.contentOffset.y >= PULLDOWN_MARGIN &&
               scrollView.contentOffset.y < threshold) {
        [self updateStatus:kCRPullDownToRefreshStatusPullingDown];
    } else {
        [self updateStatus:kCRPullDownToRefreshStatusHidden];
    }
//    NSLog(@"t:%f, y:%f", threshold, scrollView.contentOffset.y);
}

- (BOOL)scrollViewDidEndDragging:(UIScrollView *)scrollView
{
    if (_status == kCRPullDownToRefreshStatusOveredThreshold) {
        [self updateStatus:kCRPullDownToRefreshStatusUpdating];
        [self animateTableHeaderViewWithDuration:ANIMATE_DURATION delay:0.f hidden:NO animated:YES animateDidCompletion:nil];
        return TRUE;
    }
    return FALSE;
}

- (void)refreshDidUpdateWithAnimateDidCompletion:(AnimateDidCompletion)animateDidCompletion
{
    [self updateStatus:kCRPullDownToRefreshStatusDidUpdate];
    [self animateTableHeaderViewWithDuration:ANIMATE_DURATION * 2.f delay:0.f hidden:YES animated:YES animateDidCompletion:animateDidCompletion];
}

#pragma mark - Private

- (void)updateStatus:(CRPullDownToRefreshStatus)status
{
    CRPullDownToRefreshView *view = (CRPullDownToRefreshView *)self.tableView.tableHeaderView;
    
    switch (status) {
        case kCRPullDownToRefreshStatusHidden:
            [view.labelStatus setText:nil];
            [view.indicatorUpdating stopAnimating];
            [view animateHeadingViewWithAnimate:NO isHeadingUp:NO hidden:YES];
            break;
            
        case kCRPullDownToRefreshStatusPullingDown:
            [view.labelStatus setText:NSLocalizedString(@"pulling down...", @"status pulling down")];
            [view.indicatorUpdating stopAnimating];
            if (_status != kCRPullDownToRefreshStatusPullingDown) {
                [view animateHeadingViewWithAnimate:YES isHeadingUp:NO hidden:NO];
            }
            break;
            
        case kCRPullDownToRefreshStatusOveredThreshold:
            [view.labelStatus setText:NSLocalizedString(@"update when release your finger", @"status overed threshold")];
            [view.indicatorUpdating stopAnimating];
            if (_status == kCRPullDownToRefreshStatusPullingDown) {
                [view animateHeadingViewWithAnimate:YES isHeadingUp:YES hidden:NO];
            }
            break;
            
        case kCRPullDownToRefreshStatusUpdating:
            [view.labelStatus setText:NSLocalizedString(@"updating...", @"status updating")];
            [view.indicatorUpdating startAnimating];
            [view animateHeadingViewWithAnimate:NO isHeadingUp:NO hidden:YES];
            break;
            
        case kCRPullDownToRefreshStatusDidUpdate:
            [view.labelStatus setText:NSLocalizedString(@"done update!", @"status done update")];
            [view.indicatorUpdating stopAnimating];
            [view animateHeadingViewWithAnimate:NO isHeadingUp:NO hidden:NO];
            break;
            
        default:
            break;
    }
    
    self.tableView.tableHeaderView = view;
    
    _status = status;
}

- (void)animateTableHeaderViewWithDuration:(CGFloat)duration delay:(CGFloat)delay hidden:(BOOL)hidden animated:(BOOL)animated animateDidCompletion:(AnimateDidCompletion)animateDidCompletion
{
    CGFloat topOffset = 0.f;
    
    if (hidden) {
        topOffset = -self.tableView.tableHeaderView.frame.size.height;
    }
    
    __block UITableView *block_ = self.tableView;
    
    if (animated) {
        [UIView animateWithDuration:duration
                              delay:delay
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
