//
//  DetailsViewController.m
//  Instagram
//
//  Created by Raghav Sreeram on 6/20/21.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "PostCollectionViewCell.h"
#import <Parse/Parse.h>
#import "Utilities.h"
#import "MBProgressHUD.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *postCaption;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Utilities roundImage:self.profilePicture];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    self.dateLabel.text = [formatter stringFromDate:self.post.createdAt];
    
    if (self.post.author.profilePicture) {
        [self.profilePicture setImageWithURL:[NSURL URLWithString:self.post.author.profilePicture.url] placeholderImage:[UIImage imageNamed:@"profile_tab.png"]];
    }
    self.usernameLabel.text = self.post.author.username;
    [self.postImage setImageWithURL:[NSURL URLWithString:self.post.image.url]];
    self.postCaption.text = self.post.caption;
//    self.likesLabel.text = [NSString stringWithFormat:@"%@ Likes", self.post.likeCount];
    
    if (![self.post.author.objectId isEqualToString:[PFUser currentUser].objectId]) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
