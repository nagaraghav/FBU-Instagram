//
//  Utilities.h
//  Instagram
//
//  Created by Fiona Barry on 7/6/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utilities : NSObject

+ (void) presentOkAlertControllerInViewController:(UIViewController *)viewController
                                        withTitle:(NSString *)title
                                          message:(NSString *)message;

+ (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size;

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;

+ (void)roundImage:(UIImageView *)imageView;

+ (void)presentConfirmationInViewController:(UIViewController *)viewController withTitle:(nonnull NSString *)title yesHandler:(void(^)(UIAlertAction * _Nonnull action))yesHandler;

@end

NS_ASSUME_NONNULL_END
