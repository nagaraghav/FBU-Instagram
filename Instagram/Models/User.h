//
//  User.h
//  Instagram
//
//  Created by Raghav Sreeram on 6/21/21.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : PFUser

@property (strong, nonatomic) PFFileObject *profilePicture;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *descriptionText;

- (void)updateProfilePicture:( UIImage * _Nullable )image withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
