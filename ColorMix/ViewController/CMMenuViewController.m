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

@end

@implementation CMMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
