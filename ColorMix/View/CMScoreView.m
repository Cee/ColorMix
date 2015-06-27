//
//  CMScoreView.m
//  
//
//  Created by luck-mac on 15/6/25.
//
//

#import "CMScoreView.h"
#import "CMColorFactory.h"

@interface CMScoreView()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end
@implementation CMScoreView

#pragma mark - Public
- (instancetype)initWithScore:(NSInteger)score {
    self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil][0];
    if (self) {
        [self setScore:score];
    }
    return self;
}

#pragma mark - Private
- (void)setScore:(NSInteger)score {
    if (score == 0) {
        [self.scoreLabel setHidden:YES];
        return;
    }
    NSMutableAttributedString *scoreAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld", (long)score] attributes:@{NSStrokeWidthAttributeName : @(10.f) , NSFontAttributeName : self.scoreLabel.font}];
    for (int i = 0 ; i < scoreAttributedString.length; i ++) {
        CMColor *randomColor = [[CMColorFactory sharedInstance] createColorExcept:@"WHITE"];
        [scoreAttributedString addAttribute:NSStrokeColorAttributeName value:randomColor.color range:NSMakeRange(i, 1)];
    }
    [self.scoreLabel setAttributedText:scoreAttributedString];
}

@end
