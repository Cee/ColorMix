//
//  CMTutorialViewController.m
//  
//
//  Created by luck-mac on 15/6/26.
//
//

#import "CMTutorialViewController.h"
#import "CMGameViewController.h"

@interface CMTutorialViewController ()
@property (weak, nonatomic) IBOutlet UIView *upViewInFirstTutorial;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (nonatomic) NSInteger currentIndex;
@end

@implementation CMTutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _upViewInFirstTutorial.layer.borderColor = [UIColor whiteColor].CGColor;
    _upViewInFirstTutorial.layer.borderWidth = 2.0;
    _currentIndex = 1;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showNextTutorial:(id)sender {
    switch (self.currentIndex) {
        case 1:
            [_questionLabel setText:@"Color"];
            break;
        case 2:
            [_questionLabel setText:@"Text"];
            break;
        default:
            break;
    }
    [[self.view viewWithTag:self.currentIndex + 1000] setHidden:YES];
    self.currentIndex++;
    UIView *nextView = [self.view viewWithTag:self.currentIndex + 1000];
    if (nextView) {
        [nextView setHidden:NO];
    } else {
        [self.view removeFromSuperview];
        [((CMGameViewController*)self.parentViewController) startGame];
        [self removeFromParentViewController];
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
