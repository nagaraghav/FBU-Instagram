//
//  PostHeader.m
//  Instagram
//
//  Created by Raghav Sreeram on 7/3/21.
//

#import "PostHeader.h"

@implementation PostHeader


- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(profileTapped:)];
    [self addGestureRecognizer:profileTapGestureRecognizer];
}

- (void)profileTapped:(UITapGestureRecognizer *)sender {
    [self.delegate didTapProfile:self];
}



@end
