//
//  CMMenuViewController.m
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import "CMMenuViewController.h"
#import "CMGameViewController.h"

@interface CMMenuViewController ()
@property (weak, nonatomic) IBOutlet UIButton *classicBtn;
@property (weak, nonatomic) IBOutlet UIButton *fantasyBtn;
@property (weak, nonatomic) IBOutlet UIButton *settingsBtn;
@end

@implementation CMMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.classicBtn.clipsToBounds = YES;
    self.classicBtn.layer.masksToBounds = YES;
    self.classicBtn.layer.cornerRadius = 25.f;
    self.fantasyBtn.clipsToBounds = YES;
    self.fantasyBtn.layer.masksToBounds = YES;
    self.fantasyBtn.layer.cornerRadius = 25.f;
    self.settingsBtn.clipsToBounds = YES;
    self.settingsBtn.layer.masksToBounds = YES;
    self.settingsBtn.layer.cornerRadius = 25.f;
    self.settingsBtn.layer.borderColor = [UIColor colorWithHexString:@"2ECC71"].CGColor;
    self.settingsBtn.layer.borderWidth = 2.f;
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
