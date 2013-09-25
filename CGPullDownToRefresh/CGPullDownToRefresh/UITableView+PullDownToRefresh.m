//
//  UITableView+PullDownToRefresh.m
//  CGPullDownToRefresh
//
//  Created by Tomoya Igarashi on 9/25/13.
//
//

#import "UITableView+PullDownToRefresh.h"
#import "CGPullDownToRefreshView.h"

static CGPullDownToRefreshStatus kStatus;

#define PULLDOWN_MARGIN -5.f
#define IPHONE_IOS7_PULLDOWN_MARGIN -69.f // PULLDOWN_MARGIN + status bar(20.f) + nav bar(44.f)
#define BASE_Y 0.f
#define IPHONE_IOS7_BASE_Y 64.f // status bar(20.f) + nav bar(44.f)

@implementation UITableView (PullDownToRefresh)

- (void)animateTableHeaderViewWithDuration:(CGFloat)duration hidden:(BOOL)hidden animated:(BOOL)animated
{
    CGFloat topOffset = [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.f ? IPHONE_IOS7_BASE_Y : BASE_Y;
    
    if (hidden) {
        topOffset = -self.tableHeaderView.frame.size.height;
    }
    
    __block UITableView *blockself = self;
    
    if (animated) {
        // bk:viewDidLoad以降、iOS7がviewの位置を自動補正する。
        // しかし自前でコントロールする場合はここで位置を合わせる必要がある。
        if (hidden &&
            [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.f) {
            topOffset = 0.f;
        }
        [UIView animateWithDuration:duration
                         animations:^{
                             blockself.contentInset = UIEdgeInsetsMake(topOffset, 0.f, 0.f, 0.f);
                         }
                         completion:^(BOOL finished) {
                             if (hidden) {
                                 [blockself setStatus:kCGPullDownToRefreshStatusHidden];
                             }
                         }];
    } else {
        self.contentInset = UIEdgeInsetsMake(topOffset, 0.f, 0.f, 0.f);
        if (hidden) {
            [self setStatus:kCGPullDownToRefreshStatusHidden];
        }
    }
}

- (void)setStatus:(CGPullDownToRefreshStatus)status
{
    CGPullDownToRefreshView *view = (CGPullDownToRefreshView *)self.tableHeaderView;
    
    switch (status) {
        case kCGPullDownToRefreshStatusHidden:
            [view.labelStatus setText:nil];
            [view.indicatorUpdating stopAnimating];
            [self animateHeadingView:view.imagePullingDown isHeadingUp:NO hidden:YES animate:NO];
            break;
            
        case kCGPullDownToRefreshStatusPullingDown:
            [view.labelStatus setText:NSLocalizedString(@"pulling down...", @"status pulling down")];
            [view.indicatorUpdating stopAnimating];
            if (kStatus != kCGPullDownToRefreshStatusPullingDown) {
                [self animateHeadingView:view.imagePullingDown isHeadingUp:NO hidden:NO animate:YES];
            }
            break;
            
        case kCGPullDownToRefreshStatusOveredThreshold:
            [view.labelStatus setText:NSLocalizedString(@"update when release your finger.", @"status overed threshold")];
            [view.indicatorUpdating stopAnimating];
            if (kStatus == kCGPullDownToRefreshStatusPullingDown) {
                [self animateHeadingView:view.imagePullingDown isHeadingUp:YES hidden:NO animate:YES];
            }
            break;
            
        case kCGPullDownToRefreshStatusUpdating:
            [view.labelStatus setText:NSLocalizedString(@"updating...", @"status updating")];
            [view.indicatorUpdating startAnimating];
            [self animateHeadingView:view.imagePullingDown isHeadingUp:NO hidden:YES animate:NO];
            break;
            
        default:
            break;
    }

    self.tableHeaderView = view;
    
    kStatus = status;
}

- (void)animateHeadingView:(UIImageView *)image isHeadingUp:(BOOL)isHeadingUp hidden:(BOOL)hidden animate:(BOOL)animate
{
    CGFloat start = isHeadingUp ? 0.f : M_PI + 0.00001f;
    CGFloat end   = isHeadingUp ? M_PI + 0.00001f : 0.f;
    
    image.transform = CGAffineTransformMakeRotation(start);
    if (animate) {
        [UIView animateWithDuration:0.15f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             image.transform = CGAffineTransformMakeRotation(end);
                             image.hidden = hidden;
                         }
                         completion:nil
         ];
    } else {
        image.transform = CGAffineTransformMakeRotation(end);
        image.hidden = hidden;
    }
}

- (void)pullDownToRefreshDidEndScroll:(UIScrollView *)scrollView
{
    if (kStatus == kCGPullDownToRefreshStatusUpdating) {
        return;
    }
    
    CGFloat margin = [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.f ? IPHONE_IOS7_PULLDOWN_MARGIN : PULLDOWN_MARGIN;
    
    CGFloat threshold = self.tableHeaderView.frame.size.height;
    
    if (scrollView.contentOffset.y < margin) {
        [self setStatus:kCGPullDownToRefreshStatusOveredThreshold];
    } else if (scrollView.contentOffset.y >= margin &&
               scrollView.contentOffset.y < threshold) {
        [self setStatus:kCGPullDownToRefreshStatusPullingDown];
    } else {
        [self setStatus:kCGPullDownToRefreshStatusHidden];
    }
    
    NSLog(@"t:%f, y:%f", threshold, scrollView.contentOffset.y);
}

- (BOOL)pullDownToRefreshDidEndDragging:(UIScrollView *)scrollView
{
    if (kStatus == kCGPullDownToRefreshStatusOveredThreshold) {
        [self setStatus:kCGPullDownToRefreshStatusUpdating];
        [self animateTableHeaderViewWithDuration:0.15f hidden:NO animated:YES];
        return TRUE;
    }
    return FALSE;
}

- (void)pullDownToRefreshDidEndUpdate
{
    [self animateTableHeaderViewWithDuration:0.15f hidden:YES animated:YES];
}

@end
