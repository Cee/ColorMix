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
@end

@implementation CMMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.classicBtn setToRounded];
    [self.fantasyBtn setToRounded];
    [self.settingsBtn setToRounded];
    self.settingsBtn.layer.borderColor = self.settingsBtn.titleLabel.textColor.CGColor;
    self.settingsBtn.layer.borderWidth = 2.f;
    [self.versionLabel setText:[NSString stringWithFormat:@"V %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.view addSubview:settingViewController.view];
    [self addChildViewController:settingViewController];
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
