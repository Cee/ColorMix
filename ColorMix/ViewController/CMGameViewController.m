//
//  CMGameViewController.m
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import "CMGameViewController.h"

@interface CMGameViewController ()
@end


@implementation CMGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public
- (instancetype) initWithGameMode:(GameMode)gameMode {
    self = [super init];
    if (self) {
        
    }
    return self;
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
