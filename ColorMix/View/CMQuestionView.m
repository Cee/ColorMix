//
//  GameView.m
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import "CMQuestionView.h"

@interface CMQuestionView()
@property (nonatomic, weak) IBOutlet UIView *cardView;
@property (nonatomic, weak) IBOutlet UIView *timerView;
@property (nonatomic, weak) IBOutlet UILabel *cardTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *questionLabel;
@property (nonatomic, weak) IBOutlet UIView *optionView;
@property (nonatomic, strong) CMQuestion *question;
@property (nonatomic) GameMode gameMode;
@end

@implementation CMQuestionView

- (void)setFrame:(CGRect)frame question:(CMQuestion *)question gameMode:(GameMode)gameMode{
    [self setFrame:frame];
    self.gameMode = gameMode;
    self.question = question;
    if (self.gameMode == classicMode) {
        CMCard *card = question.cardList[0];
        //card
        [self.cardView cm_setBackgroundColor:card.backgroundColor];
        [self.cardTextLabel cm_setTextColor:card.textColor];
        [self.cardTextLabel cm_setText:card.textContentColor];
        if ([card.backgroundColor.colorName isEqualToString:@"BLACK"]) {
            [self.timerView setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.6]];
        }
        if ([card.backgroundColor.colorName isEqualToString:@"WHITE"]) {
            [self.questionLabel setTextColor:[UIColor blackColor]];
        }
    } else {
        self.gameMode = fantasyMode;
        [self.cardView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
        [self.cardTextLabel setTextColor:[UIColor whiteColor]];
        [self.cardTextLabel setText:[NSString stringWithFormat:@"#%ld", self.question.targetCardIndex + 1]];
        NSString *fontName = self.cardTextLabel.font.fontName;
        [self.cardTextLabel setFont:[UIFont fontWithName:fontName size:56]];
    }
    
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
- (void)startTimer {
    CGFloat interval = (CGFloat)self.question.limitTime;
    [UIView animateWithDuration:interval
                          delay:self.gameMode == classicMode ? 0 : self.question.cardList.count * 2
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
        self.timerView.transform = CGAffineTransformMakeTranslation(-[[UIScreen mainScreen] bounds].size.width, 0);
    } completion:^(BOOL finished) {
        [self.timerView removeFromSuperview];
        if (self.delegate && [self.delegate respondsToSelector:@selector(timeout)]) {
            [self.delegate timeout];
        }
    }];
}

#pragma mark - ButtonAction
- (IBAction)onOptionButtonClicked:(UIControl *)sender {
    [self.delegate answerQuestionWithResult:[_question checkAnswer:sender.tag - 1]];
}

@end
