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

@interface CMClassicGameViewController ()<ClassicQuestionViewDelegate>
@property (nonatomic, strong) CMScene *scene;
@property (nonatomic, strong) CMClassicQuestionView *currentQuestionView;
@property (nonatomic, strong) CMClassicQuestionView *nextQuestionView;
@end


@implementation CMClassicGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scene = [[CMScene alloc] initWithGameMode:classicMode];
    CGRect frame = [UIScreen mainScreen].bounds;
    self.currentQuestionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CMClassicQuestionView class]) owner:nil options:nil] objectAtIndex:0];
    self.currentQuestionView.delegate = self;
    [self.currentQuestionView setFrame:frame question:self.scene.currentQuestion];
    
    [self.view addSubview:self.currentQuestionView];
    frame.origin.x = frame.size.width;
    self.nextQuestionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CMClassicQuestionView class]) owner:nil options:nil] objectAtIndex:0];
    [self.nextQuestionView setFrame:frame question:self.scene.currentQuestion];
    [self.view addSubview:self.nextQuestionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ClassicQuestionViewDelegate
- (void)answerQuestionWithResult:(BOOL)right {
    if (right) {
        CGRect frame = [UIScreen mainScreen].bounds;
        [self.scene showNextQuestion];
        CMClassicQuestionView *lastQuestionView = self.currentQuestionView;
        self.currentQuestionView = self.nextQuestionView;
        self.currentQuestionView.delegate = self;
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
        [self.navigationController popViewControllerAnimated:YES];
    }
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
