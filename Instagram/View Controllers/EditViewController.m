//
//  EditViewController.m
//  Instagram
//
//  Created by Raghav Sreeram on 6/21/21.
//

#import "EditViewController.h"
#import "User.h"
#import <Parse/Parse.h>
#import "UIImageView+AFNetworking.h"
#import "CameraView.h"
#import "Utilities.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *bioField;
@property (weak, nonatomic) IBOutlet UIButton *profilePicture;
@property (strong, nonatomic) User *currentUser;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [Utilities roundImage:(UIImageView *)self.profilePicture];
    
    self.currentUser = [User currentUser];
    self.nameField.text = self.currentUser.name;
    self.usernameField.text = self.currentUser.username;
    self.bioField.text = self.currentUser.descriptionText;
    
    if (self.currentUser.profilePicture) {
        UIImageView *image = [[UIImageView alloc] init];
        [image setImageWithURL:[NSURL URLWithString:self.currentUser.profilePicture.url]];
        [self.profilePicture setImage:image.image forState:UIControlStateNormal];
    }
}

- (IBAction)saveButton:(id)sender {
    
    if ([self.nameField.text isEqualToString:@""] || [self.usernameField.text isEqualToString:@""]) {
        [Utilities presentOkAlertControllerInViewController:self
                                                  withTitle:@"Could Not Update"
                                                    message:@"One or more required fields are empty."];
    } else {
        self.currentUser.name = self.nameField.text;
        self.currentUser.username = self.usernameField.text;
        
        
        self.currentUser.descriptionText = self.bioField.text;
        self.currentUser.profilePicture = [Utilities getPFFileFromImage:self.profilePicture.imageView.image];
        
        [self.currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                [Utilities presentOkAlertControllerInViewController:self
                                                          withTitle:@"Could Not Save"
                                                            message:[NSString stringWithFormat:@"%@", error.localizedDescription]];
            } else {
                UIAlertController *success = [UIAlertController alertControllerWithTitle:@"Successfully Updated Profile" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:success animated:YES completion:nil];
                [success dismissViewControllerAnimated:YES completion:nil];
            }
        }];
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
