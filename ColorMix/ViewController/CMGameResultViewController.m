//
//  CMGameResultViewController.m
//  
//
//  Created by luck-mac on 15/6/25.
//
//

#import "CMGameResultViewController.h"
#import "CMMenuViewController.h"
#import "CMGameViewController.h"
@interface CMGameResultViewController ()
@property (weak, nonatomic) IBOutlet UIButton *homeBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *replayBtn;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@end

@implementation CMGameResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_replayBtn setToRounded];
    [_shareBtn setToRounded];
    [_homeBtn setToRounded];
    _homeBtn.layer.borderColor = _homeBtn.titleLabel.textColor.CGColor;
    _homeBtn.layer.borderWidth = 2.0;
    [_scoreLabel setText:[NSString stringWithFormat:@"Score:%ld",self.score]];
    NSInteger highestScore = [[[NSUserDefaults standardUserDefaults] objectForKey:self.gameMode == classicMode ? kClassicHighScoreKey : kFantasyHighScoreKey] integerValue];
    [_highScoreLabel setText:[NSString stringWithFormat:@"Best:%ld",highestScore]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ButtonAction
- (IBAction)onReplayButtonClicked:(id)sender {
    CMGameViewController *gameViewController = [[CMGameViewController alloc] initWithGameMode:_gameMode];
    [self.navigationController pushViewController:gameViewController animated:YES];
    self.navigationController.viewControllers = @[self.navigationController.childViewControllers[0], self.navigationController.topViewController];
}

- (IBAction)onShareButtonClicked:(id)sender {
    
}
- (IBAction)onHomeButtonClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
