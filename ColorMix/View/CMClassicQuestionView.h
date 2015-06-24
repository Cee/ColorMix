//
//  GameView.h
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import <UIKit/UIKit.h>
#import "CMQuestion.h"

@protocol ClassicQuestionViewDelegate <NSObject>
@required
- (void)answerQuestionWithResult:(BOOL)right;
@end

@interface CMClassicQuestionView : UIView
@property (nonatomic, weak) id<ClassicQuestionViewDelegate> delegate;
- (void)setFrame:(CGRect)frame question:(CMQuestion*)question;
@end
