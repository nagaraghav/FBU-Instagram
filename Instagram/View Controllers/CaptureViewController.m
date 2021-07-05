//
//  CaptureViewController.m
//  Instagram
//
//  Created by Raghav Sreeram on 6/20/21.
//

#import "CaptureViewController.h"
#import "Post.h"
#import <Parse/Parse.h>
#import "Utilities.h"
#import "MBProgressHUD.h"
#import "CameraView.h"

@interface CaptureViewController () < CameraViewDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *postImage;

@property (weak, nonatomic) IBOutlet UITextView *postText;


@end

@implementation CaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.postText.delegate = self;
    self.postText.text = @"Write your caption here";
    self.postImage.layer.cornerRadius = 5;

}
- (IBAction)didTapPost:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Post postUserImage:self.postImage.image withCaption:self.postText.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            [Utilities presentOkAlertControllerInViewController:self
                                                      withTitle:@"Error Posting Content"
                                                        message:[NSString stringWithFormat:@"%@", error.localizedDescription]];
        } else {
            [self clear];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (IBAction)didTapImage:(id)sender {
    CameraView *camera = [[CameraView alloc] init];
    camera.delegate = self;
    camera.viewController = self;
    [camera alertConfirmation];
}

- (void)setImage:(UIImage *)image {
    [self.postImage setImage:image ];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([self.postText.text isEqualToString:@"Write your caption here"]) {
        self.postText.text = nil;
    }
    [self.postImage setUserInteractionEnabled:NO];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self.postImage setUserInteractionEnabled:YES];
    if ([self.postText.text isEqual:@""]) {
        self.postText.text = @"Write your caption here";
    }
}

- (IBAction)didTapBackground:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)didTapCancel:(id)sender {
    [Utilities presentConfirmationInViewController:self
                                         withTitle:@"Draft will be deleted"
                                         yesHandler:^(UIAlertAction * _Nonnull action) {
        [self clear];
    }];
}
- (void)clear {
    self.postText.text = @"Write your caption here";
    [self.postImage setImage:[UIImage imageNamed:@"image_placeholder.png"]];
    self.navigationController.tabBarController.selectedViewController = [self.navigationController.tabBarController.viewControllers objectAtIndex:0];
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
