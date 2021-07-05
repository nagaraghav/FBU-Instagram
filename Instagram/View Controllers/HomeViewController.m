//
//  HomeViewController.m
//  Instagram
//
//  Created by Raghav Sreeram on 6/20/21.
//

#import "HomeViewController.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "Post.h"
#import <Parse/Parse.h>
#import "Utilities.h"
#import "PostCell.h"
#import "UIImageView+AFNetworking.h"
#import "CaptureViewController.h"
#import "DetailsViewController.h"
#import "ProfileViewController.h"
#import "PostHeader.h"

@interface HomeViewController () <PostHeaderDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *posts;

@property (strong, nonatomic) User *currentUser;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.currentUser = [User currentUser];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PostHeader" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"PostHeader"];
    
    [self loadFeed];
    
    self.tableView.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView.refreshControl addTarget:self action:@selector(loadFeed) forControlEvents:UIControlEventValueChanged];
//
//    CGRect frame = CGRectMake(0, self.tableView.contentSize.height, self.tableView.bounds.size.width, InfiniteScrollActivityIndicator.defaultHeight);
//    loadingMoreView = [[InfiniteScrollActivityIndicator alloc] initWithFrame:frame];
//    loadingMoreView.hidden = true;
//    [self.tableView addSubview:loadingMoreView];
    
    UIEdgeInsets insets = self.tableView.contentInset;
//    insets.bottom += InfiniteScrollActivityIndicator.defaultHeight;
    self.tableView.contentInset = insets;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];


}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


- (void)loadFeed {

    PFQuery *query = [PFQuery queryWithClassName:@"Post"];

    [query includeKeys:@[@"author",@"image"]];
    [query addDescendingOrder:@"createdAt"];
    query.limit = 20;

    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (error) {
            [Utilities presentOkAlertControllerInViewController:self
                                                      withTitle:@"Error Retreiving Feed"
                                                        message:[NSString stringWithFormat:@"%@", error.localizedDescription]];
        } else {
            self.posts = (NSMutableArray *)posts;
            [self.tableView reloadData];
        }
        [self.tableView.refreshControl endRefreshing];
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 62;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PostHeader *header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"PostHeader"];
    [Utilities roundImage:header.profilePicture];
    Post *post = self.posts[section];
    [header.profilePicture setImage:[UIImage imageNamed:@"profile_tab.png"]];
    if (post.author.profilePicture) {
        [header.profilePicture setImageWithURL:[NSURL URLWithString:post.author.profilePicture.url]];
    }
    header.postUsername.text = post.author.username;
    header.delegate = self;
    header.user = post.author;
    return header;
}


- (void)didTapProfile:(PostHeader *)header {
    [self performSegueWithIdentifier:@"Profile" sender:header];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Details"]) {
        DetailsViewController *detailsViewController = [segue destinationViewController];
        PostCell *cell = sender;
        detailsViewController.post = cell.post;
    }
    if ([segue.identifier isEqualToString:@"Profile"]) {
        ProfileViewController *profileViewController = [segue destinationViewController];
        PostHeader *header = sender;
        profileViewController.user = header.user;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", self.posts[indexPath.row]);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 62;
//}
//

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    cell.post = self.posts[indexPath.section];
    [cell.postImage setImageWithURL:[NSURL URLWithString:cell.post.image.url] placeholderImage:[UIImage imageNamed:@"placeholder_image.png"]];
    
    
    cell.postText.text = cell.post.caption;
    cell.likesLabel.text = [NSString stringWithFormat:@"%@ Likes", cell.post.likeCount];
    cell.usernameLabel.text = cell.post.author.username;
    cell.otherUsername.text = cell.post.author.username;
    
    
    [cell.userImage setImageWithURL:[NSURL URLWithString:cell.post.author.profilePicture.url] placeholderImage:[UIImage imageNamed:@"placeholder_image.png"]];
    [Utilities roundImage:cell.userImage];
    cell.postImage.layer.cornerRadius = 5;
    
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.posts.count;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
//    return self.posts.count;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.posts.count;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
