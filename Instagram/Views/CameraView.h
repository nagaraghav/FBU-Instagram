//
//  CameraView.h
//  Instagram
//
//  Created by Raghav Sreeram on 6/21/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef enum {
    PHOTOS,
    CAMERA,
} SelectionType;


@protocol CameraViewDelegate <NSObject>

- (void)setImage:(UIImage *)image;

@end

@interface CameraView : NSObject
@property (strong, nonatomic) id<CameraViewDelegate>delegate;
@property (strong, nonatomic) UIViewController *viewController;

- (void)alertConfirmation;
@end

NS_ASSUME_NONNULL_END
