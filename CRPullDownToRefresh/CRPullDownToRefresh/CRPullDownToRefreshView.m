//
//  CRPullDownToRefreshView.m
//  CRPullDownToRefresh
//
//  Created by Tomoya Igarashi on 9/25/13.
//
//

#import "CRPullDownToRefreshView.h"

@implementation CRPullDownToRefreshView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)animateHeadingViewWithAnimate:(BOOL)animate isHeadingUp:(BOOL)isHeadingUp hidden:(BOOL)hidden
{
    CGFloat start = isHeadingUp ? 0.f : M_PI + 0.00001f;
    CGFloat end   = isHeadingUp ? M_PI + 0.00001f : 0.f;
    
    self.imagePullingDown.transform = CGAffineTransformMakeRotation(start);
    if (animate) {
        [UIView animateWithDuration:0.15f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.imagePullingDown.transform = CGAffineTransformMakeRotation(end);
                             self.imagePullingDown.hidden = hidden;
                         }
                         completion:nil
         ];
    } else {
        self.imagePullingDown.transform = CGAffineTransformMakeRotation(end);
        self.imagePullingDown.hidden = hidden;
    }
}

@end
