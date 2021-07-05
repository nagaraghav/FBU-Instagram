//
//  User.m
//  Instagram
//
//  Created by Raghav Sreeram on 6/21/21.
//

#import "User.h"
#import "Utilities.h"

@implementation User

@dynamic profilePicture;
@dynamic name;
@dynamic descriptionText;
//@dynamic likes;

- (void)updateProfilePicture:( UIImage * _Nullable )image withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    self.profilePicture = [Utilities getPFFileFromImage:image];
    [self saveInBackgroundWithBlock:completion];
}




@end
