//
//  LoginViewController.m
//  Instagram
//
//  Created by Raghav Sreeram on 6/20/21.
//

#import "LoginViewController.h"

#import <Parse/Parse.h>
#import "Utilities.h"
#import "User.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 5;
    
    self.signupButton.layer.masksToBounds = YES;
    self.signupButton.layer.cornerRadius = 5;
}


- (IBAction)didTapLogin:(id)sender {
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        if (error) {
            [Utilities presentOkAlertControllerInViewController:self
                                                      withTitle:@"Error Logging In"
                                                        message:[NSString stringWithFormat:@"%@", error.localizedDescription]];
        } else {
            [self performSegueWithIdentifier:@"LoginSegue" sender:self];
        }
    }];
}

- (IBAction)didTapSignUp:(id)sender {
    if ([self.username.text isEqual:@""] || [self.password.text isEqual:@""]) {
        // Fields are empty
        [Utilities presentOkAlertControllerInViewController:self
                                                  withTitle:@"Invalid Input"
                                                    message:@"Username/Password field is incomplete."];
    } else {
        User *user = [User new];
        
        
        user.username = self.username.text;
        user.password = self.password.text;
        
        
                
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                [Utilities presentOkAlertControllerInViewController:self
                                                          withTitle:@"Error Creating User"
                                                            message:[NSString stringWithFormat:@"%@", error.localizedDescription]];
            }else{
                NSLog(@"Done sign up");
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
