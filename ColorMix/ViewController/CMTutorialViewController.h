//
//  CMTutorialViewController.h
//  
//
//  Created by luck-mac on 15/6/26.
//
//

#import <UIKit/UIKit.h>

typedef void (^CMTutorialBlock)(BOOL completed);

@interface CMTutorialViewController : UIViewController
- (instancetype)initWithMode:(GameMode)gameMode completeBlock:(CMTutorialBlock)block;
@end
