//
//  CMMenuViewController.m
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import "CMMenuViewController.h"
#import "CMGameViewController.h"
#import "CMSettingViewController.h"

@interface CMMenuViewController ()
@property (weak, nonatomic) IBOutlet UIButton *classicBtn;
@property (weak, nonatomic) IBOutlet UIButton *fantasyBtn;
@property (weak, nonatomic) IBOutlet UIButton *settingsBtn;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (nonatomic, strong) UIView *blurView;
@end

@implementation CMMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.classicBtn setToRounded];
    [self.fantasyBtn setToRounded];
    [self.settingsBtn setToRounded];
    self.settingsBtn.layer.borderColor = self.settingsBtn.titleLabel.textColor.CGColor;
    self.settingsBtn.layer.borderWidth = 2.f;
    [self.versionLabel setText:[NSString stringWithFormat:@"v %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)removeBlurView {
    [UIView animateWithDuration:0.3 animations:^{
        _blurView.alpha = 0;
    } completion:^(BOOL finished) {
        [_blurView removeFromSuperview];
    }];
}

#pragma mark - Getter
- (UIView *)blurView {
    if (!_blurView) {
        _blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        _blurView.frame = [[UIScreen mainScreen] bounds];
        _blurView.alpha = 0;
    }
    return _blurView;
}


#pragma mark - ButtonAction
- (IBAction)onEasyButtonClicked:(id)sender {
    CMGameViewController *gameViewController = [[CMGameViewController alloc] initWithGameMode:classicMode];
    [self.navigationController pushViewController:gameViewController animated:YES];
}

- (IBAction)onFantasyButtonClicked:(id)sender {
    CMGameViewController *gameViewController = [[CMGameViewController alloc] initWithGameMode:fantasyMode];
    [self.navigationController pushViewController:gameViewController animated:YES];
}

- (IBAction)onSettingButtonClicked:(id)sender {
    CMSettingViewController *settingViewController = [[CMSettingViewController alloc] initWithNibName:NSStringFromClass([CMSettingViewController class]) bundle:nil];
    settingViewController.view.frame = self.view.bounds;
    settingViewController.view.alpha = 0;
    [self.view addSubview:self.blurView];
    [self.view addSubview:settingViewController.view];
    [self addChildViewController:settingViewController];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _blurView.alpha = 1;
        settingViewController.view.alpha = 1;
    } completion:nil];
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
