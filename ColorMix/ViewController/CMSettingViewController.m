//
//  CMSettingViewController.m
//  
//
//  Created by luck-mac on 15/6/25.
//
//

#import "CMSettingViewController.h"

@interface CMSettingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *grayscaleBtn;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@end

@implementation CMSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.grayscaleBtn setSelected:[[NSUserDefaults standardUserDefaults] boolForKey:kGrayscaleSwitchKey]];
    if (IOS8_OR_LATER) {
        UIView* visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        visualEfView.frame = self.view.bounds;
        visualEfView.alpha = 1.0;
        [self.backgroundView addSubview:visualEfView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ButtonAction
- (IBAction)onTutorialButtonClicked:(id)sender {
    
}

- (IBAction)onShareButtonClicked:(id)sender {
    
}

- (IBAction)onRateUsButtonClicked:(id)sender {
    
}

- (IBAction)onAboutUsButtonClicked:(id)sender {
    
}

- (IBAction)onGrayscaleButtonClicked:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    [[NSUserDefaults standardUserDefaults] setBool:sender.selected forKey:kGrayscaleSwitchKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
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
