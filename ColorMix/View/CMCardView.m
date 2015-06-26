//
//  CMCardView.m
//  
//
//  Created by luck-mac on 15/6/25.
//
//

#import "CMCardView.h"

@interface CMCardView ()
@property (weak, nonatomic) IBOutlet UILabel *colorTextLabel;
@end

@implementation CMCardView
- (void)updateViewWithCard:(CMCard *)card {
    [self cm_setBackgroundColor:card.backgroundColor];
    [self.colorTextLabel cm_setTextColor:card.textColor];
    [self.colorTextLabel cm_setText:card.textContentColor];
}

@end
