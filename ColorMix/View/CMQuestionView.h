//
//  GameView.h
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import <UIKit/UIKit.h>
#import "CMQuestion.h"

@protocol QuestionViewDelegate <NSObject>
@required
- (void)answerQuestionWithResult:(BOOL)right;
- (void)timeout;
@end

@interface CMQuestionView : UIView
@property (nonatomic, weak) id<QuestionViewDelegate> delegate;
- (void)setFrame:(CGRect)frame question:(CMQuestion*)question;
- (void)startTimer;
@end
