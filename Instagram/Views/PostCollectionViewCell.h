//
//  PostCollectionViewCell.h
//  Instagram
//
//  Created by Raghav Sreeram on 6/21/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"


NS_ASSUME_NONNULL_BEGIN

@interface PostCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;


@end

NS_ASSUME_NONNULL_END
