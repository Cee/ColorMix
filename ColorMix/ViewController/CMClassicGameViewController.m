//
//  CMGameViewController.m
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import "CMClassicGameViewController.h"
#import "CMScene.h"
#import "CMClassicQuestionView.h"
#import "CMGameResultViewController.h"

@interface CMClassicGameViewController ()<ClassicQuestionViewDelegate>
@property (nonatomic, strong) CMScene *scene;
@property (nonatomic, strong) CMClassicQuestionView *currentQuestionView;
@property (nonatomic, strong) CMClassicQuestionView *nextQuestionView;
@property (nonatomic, strong) UILabel *scoreLabel;
@end


@implementation CMClassicGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scene = [[CMScene alloc] initWithGameMode:classicMode];
    CGRect frame = [UIScreen mainScreen].bounds;
    self.currentQuestionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CMClassicQuestionView class]) owner:nil options:nil] objectAtIndex:0];
    [self.currentQuestionView setFrame:frame question:self.scene.currentQuestion];
    _currentQuestionView.delegate = self;
    [_currentQuestionView startTimer];
    [self.view addSubview:self.currentQuestionView];
    frame.origin.x = frame.size.width;
    self.nextQuestionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CMClassicQuestionView class]) owner:nil options:nil] objectAtIndex:0];
    [self.nextQuestionView setFrame:frame question:self.scene.nextQuestion];
    [self.view addSubview:self.nextQuestionView];
    
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 50, 20, 50, 50)];
    [self.view addSubview:self.scoreLabel];
    [self updateScore];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private
- (void) updateScore {
    [self.scoreLabel setText:[NSString stringWithFormat:@"%ld",self.scene.point]];
    [self.view bringSubviewToFront:self.scoreLabel];
}

- (void) gameEnd {
    CMGameResultViewController *gameResultViewController = [[CMGameResultViewController alloc] initWithNibName:NSStringFromClass([CMGameResultViewController class]) bundle:nil];
    gameResultViewController.gameMode = classicMode;
    [self.navigationController pushViewController:gameResultViewController animated:YES];
}

#pragma mark - ClassicQuestionViewDelegate
- (void)answerQuestionWithResult:(BOOL)right {
    if (right) {
        CGRect frame = [UIScreen mainScreen].bounds;
        [self.scene showNextQuestion];
        [self updateScore];
        self.currentQuestionView.delegate = nil;
        CMClassicQuestionView *lastQuestionView = self.currentQuestionView;
        self.currentQuestionView = self.nextQuestionView;
        self.currentQuestionView.delegate = self;
        [self.currentQuestionView startTimer];
        [UIView animateWithDuration:0.3 animations:^{
            self.currentQuestionView.frame = frame;
        } completion:^(BOOL finished) {
            [lastQuestionView removeFromSuperview];
        }];
        //生成新的nextQuestionView
        frame.origin.x = frame.size.width;
        self.nextQuestionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CMClassicQuestionView class]) owner:nil options:nil] objectAtIndex:0];
        [self.nextQuestionView setFrame:frame question:self.scene.currentQuestion];
        [self.view addSubview:self.nextQuestionView];
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
