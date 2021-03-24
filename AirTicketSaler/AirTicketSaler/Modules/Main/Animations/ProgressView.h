//
//  ProgressView.h
//  AirTicketSaler
//
//  Created by aprirez on 3/24/21.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

+ (instancetype)sharedInstance;

- (void)show:(void (^)(void))completion;
- (void)dismiss:(void (^)(void))completion;


@end

