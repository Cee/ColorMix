//
//  GameView.m
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import "CMClassicQuestionView.h"

@interface CMClassicQuestionView()
@property (nonatomic, weak) IBOutlet UIView *cardView;
@property (nonatomic, weak) IBOutlet UIView *timerView;
@property (nonatomic, weak) IBOutlet UILabel *cardTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *questionLabel;
@property (nonatomic, weak) IBOutlet UIView *optionView;
@property (nonatomic, strong) CMQuestion *question;
@end

@implementation CMClassicQuestionView

- (void)setFrame:(CGRect)frame question:(CMQuestion *)question {
    [self setFrame:frame];
    self.question = question;
    CMCard *card = question.cardList[0];
    //card
    [self.cardView cm_setBackgroundColor:card.backgroundColor];
    [self.cardTextLabel cm_setTextColor:card.textColor];
    [self.cardTextLabel cm_setText:card.textContentColor];
    //question
    [self.questionLabel setText:[self.question getQuestion]];
    //options
    NSArray *options = self.question.options;
    [options enumerateObjectsUsingBlock:^(CMColor *option, NSUInteger idx, BOOL *stop) {
        UIView *optionView = [self.optionView viewWithTag:idx+1];
        [optionView cm_setBackgroundColor:option];
        if ([option.colorName isEqual:@"WHITE"]) {
            UILabel *label = [optionView subviews][0];
            [label setTextColor:[UIColor blackColor]];
        }
    }];
}

#pragma mark - Public
- (void) startTimer {
    CGFloat interval = (CGFloat)self.question.limitTime;
    [UIView animateWithDuration:interval delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.timerView.transform = CGAffineTransformMakeTranslation(-[[UIScreen mainScreen]bounds].size.width, 0);
    } completion:^(BOOL finished) {
        [self.timerView removeFromSuperview];
        if (self.delegate && [self.delegate respondsToSelector:@selector(timeout)]) {
            [self.delegate timeout];
        }
    }];
}

#pragma mark - ButtonAction
- (IBAction)onOptionButtonClicked:(UIControl *)sender {
    [self.delegate answerQuestionWithResult:[_question checkAnswer:sender.tag-1]];
}



@end
