//
//  ProfileViewController.h
//  Instagram
//
//  Created by Raghav Sreeram on 6/20/21.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (strong, nonatomic) User *user;
@end

NS_ASSUME_NONNULL_END
