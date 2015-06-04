//
//  ChainButtons.m
//  ChainButtons
//
//  Created by Wang on 15/6/3.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import "ChainButtons.h"

static CGFloat const ChainBtnWidth = 30.0f;
static CGFloat const ChainBtnSpace = 10.0f;
static NSInteger const ChainBtnTag = 1356;
static CGFloat const ChainBtnDurationAnimation = 0.2;
@interface ChainButtons ()
@property (nonatomic,strong) NSArray *imageNameArray;
@property (nonatomic,assign) CGPoint bottomPosition;
@property (nonatomic,assign) void (^clickBlock)(NSInteger index);
@property (nonatomic,strong) NSMutableArray *buttonArray;
@end

@implementation ChainButtons
- (instancetype)initWithImageNameArray:(NSArray *)nameArray bottomPosition:(CGPoint)point{
    if(self = [super initWithFrame:[UIScreen mainScreen].bounds]){
        self.imageNameArray = nameArray;
        self.bottomPosition = point;
    }
    return self;
}
- (void)prepareButtons{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    [self addGestureRecognizer:tap];
    
    self.buttonArray = [NSMutableArray array];
    [self.imageNameArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, ChainBtnWidth, ChainBtnWidth);
        button.center = self.bottomPosition;
        button.tag = ChainBtnTag+idx;
        button.hidden = YES;
        button.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_a",obj]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_b",obj]] forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.buttonArray addObject:button];
        
        [self addSubview:button];
    
    }];
}
- (void)showButtons{
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
      
        obj.hidden = NO;
        
        [UIView animateWithDuration:ChainBtnDurationAnimation delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            obj.center = CGPointMake(self.bottomPosition.x, self.bottomPosition.y-(idx+1)*ChainBtnSpace-idx*ChainBtnWidth);
        } completion:nil];
        
    }];
}
- (void)hideButtons{
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
        [UIView animateWithDuration:ChainBtnDurationAnimation delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            obj.center = self.bottomPosition;
        } completion:^(BOOL finished) {
            obj.hidden = YES;
            if(idx == self.imageNameArray.count-1){
                [self removeFromSuperview];
            }
        }];
//        [UIView animateWithDuration:ChainBtnDurationAnimation delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            obj.center = self.bottomPosition;
//        } completion:^(BOOL finished) {
//            obj.hidden = YES;
//            if(idx == self.imageNameArray.count-1){
//                [self removeFromSuperview];
//            }
//        }];
    }];
}
- (void)buttonClicked:(UIButton *)button{
    if(self.clickBlock){
        self.clickBlock(button.tag-ChainBtnTag);
    }
}
- (void)tapHandler:(UITapGestureRecognizer *)gesture{
    [self hideButtons];
}
+ (instancetype)showWithImageNameArray:(NSArray *)nameArray clickBlock:(void (^)(NSInteger))clickBlock bottomPosition:(CGPoint)point{
    ChainButtons *chainButtons = [[ChainButtons alloc] initWithImageNameArray:nameArray bottomPosition:point];
    chainButtons.clickBlock = clickBlock;
    
    [[UIApplication sharedApplication].keyWindow addSubview:chainButtons];
    
    [chainButtons prepareButtons];
    [chainButtons showButtons];
    
    return chainButtons;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
