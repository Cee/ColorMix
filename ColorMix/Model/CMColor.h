//
//  CMColor.h
//  
//
//  Created by luck-mac on 15/6/24.
//
//

#import <Foundation/Foundation.h>

@interface CMColor : NSObject
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSString *colorName;
- (instancetype)initWithDictionary:(NSDictionary *)colorDic;
@end
