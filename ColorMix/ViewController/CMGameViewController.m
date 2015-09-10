//
//  CMGameViewController.m
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import "CMGameViewController.h"
#import "CMScene.h"
#import "CMQuestionView.h"
#import "CMCardView.h"
#import "CMLabel.h"
#import "CMGameResultViewController.h"
#import "CMTutorialViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface CMGameViewController ()<QuestionViewDelegate>
@property (nonatomic, strong) CMScene *scene;
@property (nonatomic, strong) CMQuestionView *lastQuestionView;
@property (nonatomic, strong) CMQuestionView *currentQuestionView;
@property (nonatomic, strong) CMQuestionView *nextQuestionView;
@property (nonatomic, strong) NSMutableArray *cardViewList;
@property (weak, nonatomic) IBOutlet CMLabel *scoreLabel;
@property (nonatomic) GameMode gameMode;
@end


@implementation CMGameViewController
- (instancetype)initWithGameMode:(GameMode)mode {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.gameMode = mode;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.gameMode == fantasyMode) {
        self.cardViewList = [[NSMutableArray alloc] initWithCapacity:3];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.scene == nil) {
//        NSString *firstPlayKey = self.gameMode == classicMode ? kFirstPlayClassicKey : kFirstPlayFantasyKey;
        self.scene = [[CMScene alloc] initWithGameMode:self.gameMode];
//        if ([[NSUserDefaults standardUserDefaults] objectForKey:firstPlayKey]) {
            [self addCardViews];
            [self.currentQuestionView startTimer];
//        } else {
//            [self showTutorial];
//            [[NSUserDefaults standardUserDefaults] setObject:@"钦哥哥好帅" forKey:firstPlayKey];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }
    }
}

- (void)setScene:(CMScene *)scene {
    _scene = scene;
    CGRect frame = [UIScreen mainScreen].bounds;
    //currentQuestionView
    self.currentQuestionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CMQuestionView class]) owner:nil options:nil] objectAtIndex:0];
    [self.currentQuestionView setFrame:frame question:self.scene.currentQuestion gameMode:self.gameMode];
    self.currentQuestionView.delegate = self;
    [self.view addSubview:self.currentQuestionView];
    //nextQuestionView
    self.nextQuestionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CMQuestionView class]) owner:nil options:nil] objectAtIndex:0];
    [self.nextQuestionView setFrame:frame question:self.scene.nextQuestion gameMode:self.gameMode];
    [self.view insertSubview:self.nextQuestionView belowSubview:self.currentQuestionView];
    [self updateScore];
}

- (void) showTutorial {
    WS(weakSelf);
    CMTutorialViewController *tutorialViewController = [[CMTutorialViewController alloc] initWithMode:self.gameMode completeBlock:^(BOOL completed) {
        [weakSelf addCardViews];
        [weakSelf.currentQuestionView startTimer];
    }];
    tutorialViewController.view.frame = self.view.frame;
    [self.view addSubview:tutorialViewController.view];
    [self addChildViewController:tutorialViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private
- (void)updateScore {
    [self.scoreLabel setText:[NSString stringWithFormat:@"%ld\t",(long)self.scene.point]];
    [self.view bringSubviewToFront:self.scoreLabel];
}

- (void)addCardViews {
    //classic模式下card和question在一个view上
    if (!self.gameMode == fantasyMode) {
        return;
    }
    [self.cardViewList removeAllObjects];
    NSArray *cardList = self.scene.currentQuestion.cardList;
    [cardList enumerateObjectsUsingBlock:^(CMCard *card, NSUInteger idx, BOOL *stop) {
        CMCardView *cardView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CMCardView class]) owner:nil options:nil] objectAtIndex:0];
        [cardView updateViewWithCard:card];
        cardView.frame = self.view.bounds;
        [self.cardViewList addObject:cardView];
    }];
    [self.view bringSubviewToFront:self.scoreLabel];
    for (NSInteger i = cardList.count - 1; i >= 0; i--) {
        UIView *cardView = self.cardViewList[i];
        [self.view addSubview:cardView];
        if (self.lastQuestionView) {
            [self.view bringSubviewToFront:self.lastQuestionView];
        }
        CGFloat delay = 1.7 * (i + 1);
        [UIView animateWithDuration:0.3
                              delay:delay
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
            cardView.transform = CGAffineTransformMakeTranslation(-self.view. frame.size.width, 0);
        } completion:^(BOOL finished) {
            [cardView removeFromSuperview];
        }];
    }
}


- (void)gameEnd {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = self.gameMode == classicMode ? kClassicHighScoreKey : kFantasyHighScoreKey;
    NSNumber *highestPoint = [userDefaults objectForKey:key];
    if (highestPoint==nil || [highestPoint integerValue] < self.scene.point) {
        [userDefaults setObject:@(self.scene.point) forKey:key];
        [userDefaults synchronize];
    }
    if ([userDefaults boolForKey:kVibrateSwitchKey]) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    CMGameResultViewController *gameResultViewController = [[CMGameResultViewController alloc] initWithNibName:NSStringFromClass([CMGameResultViewController class]) bundle:nil];
    gameResultViewController.gameMode = self.gameMode;
    gameResultViewController.score = self.scene.point;
    [self.navigationController pushViewController:gameResultViewController animated:YES];
}

#pragma mark - ClassicQuestionViewDelegate
- (void)answerQuestionWithResult:(BOOL)right {
    if (right) {
        [self.scene showNextQuestion];
        [self updateScore];
        self.currentQuestionView.delegate = nil;
        self.lastQuestionView = self.currentQuestionView;
        self.currentQuestionView = self.nextQuestionView;
        self.currentQuestionView.delegate = self;
        [self.currentQuestionView startTimer];
        [self addCardViews];
        [UIView animateWithDuration:0.3 animations:^{
            self.lastQuestionView.transform = CGAffineTransformMakeTranslation(-self.view.frame.size.width, 0);
        } completion:^(BOOL finished) {
            [self.lastQuestionView removeFromSuperview];
        }];
        //生成新的nextQuestionView
        CGRect frame = [UIScreen mainScreen].bounds;
        self.nextQuestionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CMQuestionView class]) owner:nil options:nil] objectAtIndex:0];
        [self.nextQuestionView setFrame:frame question:self.scene.nextQuestion gameMode:self.gameMode];
        [self.view insertSubview:self.nextQuestionView belowSubview:self.currentQuestionView];
    } else {
        self.currentQuestionView.delegate = nil;
        [self gameEnd];
    }
}

- (void)timeout {
    [self gameEnd];
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
