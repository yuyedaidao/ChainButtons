//
//  ChainButtons.h
//  ChainButtons
//
//  Created by Wang on 15/6/3.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChainButtons : UIView

+ (instancetype)showWithImageNameArray:(NSArray *)nameArray clickBlock:(void (^)(NSInteger index))clickBlock bottomPosition:(CGPoint)point;

@end
