//
//  CGPullDownToRefreshView.h
//  CGPullDownToRefresh
//
//  Created by Tomoya Igarashi on 9/25/13.
//
//

#import <UIKit/UIKit.h>

@interface CGPullDownToRefreshView : UIView

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelStatus;
@property (unsafe_unretained, nonatomic) IBOutlet UIActivityIndicatorView *indicatorUpdating;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imagePullingDown;

- (void)animateHeadingViewWithAnimate:(BOOL)animate isHeadingUp:(BOOL)isHeadingUp hidden:(BOOL)hidden;
@end
