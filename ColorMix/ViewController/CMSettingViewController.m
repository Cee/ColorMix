//
//  CMSettingViewController.m
//  
//
//  Created by luck-mac on 15/6/25.
//
//

#import "CMSettingViewController.h"
#import "CMMenuViewController.h"
#import "CMTutorialViewController.h"

@interface CMSettingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *vibrateBtn;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@end

@implementation CMSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.alpha = 0;
    [self.vibrateBtn setSelected:[[NSUserDefaults standardUserDefaults] boolForKey:kVibrateSwitchKey]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ButtonAction
- (IBAction)onTutorialButtonClicked:(id)sender {
    WS(weakSelf);
    CMTutorialViewController *tutorialViewController = [[CMTutorialViewController alloc] initWithMode:classicMode completeBlock:^(BOOL completed) {
        CMTutorialViewController *tutorialViewController = [[CMTutorialViewController alloc] initWithMode:fantasyMode completeBlock:nil];
        tutorialViewController.view.frame = self.view.bounds;
        [weakSelf.view addSubview:tutorialViewController.view];
        [weakSelf addChildViewController:tutorialViewController];
    }];
    tutorialViewController.view.frame = self.view.bounds;
    [self.view addSubview:tutorialViewController.view];
    [self addChildViewController:tutorialViewController];
}

- (IBAction)onShareButtonClicked:(id)sender {
    
}

- (IBAction)onRateUsButtonClicked:(id)sender {
    
}

- (IBAction)onAboutUsButtonClicked:(id)sender {
    
}

- (IBAction)onVibrateButtonClicked:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    [[NSUserDefaults standardUserDefaults] setBool:sender.selected forKey:kVibrateSwitchKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [((CMMenuViewController*)self.parentViewController) removeBlurView];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromParentViewController];
        [self.view removeFromSuperview];
    }];
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
