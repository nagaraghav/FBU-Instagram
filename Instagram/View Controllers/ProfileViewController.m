//
//  ProfileViewController.m
//  Instagram
//
//  Created by Raghav Sreeram on 6/20/21.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "Utilities.h"
#import "PostCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "Post.h"
#import "DetailsViewController.h"


@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) NSArray *posts;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
        
    layout.minimumInteritemSpacing = 2.5;
    layout.minimumLineSpacing = 2.5;
    
    CGFloat postsPerRow = 3;
    CGFloat itemWidth = (self.view.frame.size.width - layout.minimumInteritemSpacing * (postsPerRow - 1)) / postsPerRow;
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    if (!self.user) {
        self.user = [User currentUser];
    }
    
    self.usernameLabel.text = self.user.username;
    
    self.editButton.layer.masksToBounds = YES;
    self.editButton.layer.cornerRadius = 5;
    
    self.editButton.layer.borderWidth = 1;

    self.editButton.layer.borderColor = [UIColor grayColor].CGColor;

    [Utilities roundImage:self.profilePic];
    [self.profilePic setImageWithURL:[NSURL URLWithString:self.user.profilePicture.url] placeholderImage:[UIImage imageNamed:@"placeholder_image.png"]];
    
    
    [self getProfileFeed];
}

- (void)getProfileFeed {
 
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"author" equalTo:self.user];
    [query includeKeys:@[@"author",@"image"]];
    [query addDescendingOrder:@"createdAt"];

    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (error) {
            [Utilities presentOkAlertControllerInViewController:self
                                                      withTitle:@"Error Retreiving Feed"
                                                        message:[NSString stringWithFormat:@"%@", error.localizedDescription]];
        } else {
            self.posts = posts;
            [self.collectionView reloadData];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Details"]) {
        DetailsViewController *detailsViewController = [segue destinationViewController];
        PostCollectionViewCell *cell = sender;
        detailsViewController.post = cell.post;
    }
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"PostCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.item];
    
    cell.post = post;
    [cell.postImage setImageWithURL:[NSURL URLWithString:post.image.url] placeholderImage:[UIImage imageNamed:@"placeholder_image.png"]];
    
    return cell;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    CollectionHeader *collectionHeader = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeader" forIndexPath:indexPath];
//
//    [Utilities roundImage:collectionHeader.profilePicture];
//
//    collectionHeader.nameLabel.text = self.user.name;
//    collectionHeader.usernameLabel.text = [NSString stringWithFormat:@"@%@", self.user.username];
//    collectionHeader.descriptionLabel.text = self.user.descriptionText;
//    if (self.user.profilePicture) {
//        [collectionHeader.profilePicture setImageWithURL:[NSURL URLWithString:self.user.profilePicture.url] placeholderImage:collectionHeader.profilePicture.image];
//    }
//
//    return collectionHeader;
//}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
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
