//
//  PostHeader.h
//  Instagram
//
//  Created by Raghav Sreeram on 7/3/21.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@class PostHeader;

@protocol PostHeaderDelegate <NSObject>

- (void)didTapProfile:(PostHeader *)header;

@end


@interface PostHeader : UITableViewHeaderFooterView

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) id <PostHeaderDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *postUsername;


@end

NS_ASSUME_NONNULL_END
