//
//  ECGCustomGifHeader.m
//  TestRefresh
//  自定义有动画
//  Created by 范坛 on 2017/7/26.
//  Copyright © 2017年 范坛. All rights reserved.
//

#import "ECGCustomGifHeader.h"

@implementation ECGCustomGifHeader

#pragma mark - 重写父类的方法
- (void)prepare{
    [super prepare];
    
    //    // 设置普通状态的动画图片
    //    NSMutableArray *idleImages = [NSMutableArray array];
    //    for (NSUInteger i = 1; i<=52; i++) {
    //        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"心电_%lu.jpg", (unsigned long)i]];
    //        [idleImages addObject:image];
    //    }
    //    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=52; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"心电_%lu.jpg", (unsigned long)i]];
        [refreshingImages addObject:image];
    }
    //    [self setImages:refreshingImages duration:refreshingImages.count * 0.03 forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages duration:refreshingImages.count * 0.03 forState:MJRefreshStateRefreshing];
    
    //    //隐藏时间
    //    self.lastUpdatedTimeLabel.hidden = YES;//如果不隐藏这个会默认 图片在最左边不是在中间
    //    //隐藏状态
    //    self.stateLabel.hidden = YES;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.gifView.constraints.count) return;
    
    self.gifView.frame = self.bounds;
    if (self.stateLabel.hidden && self.lastUpdatedTimeLabel.hidden) {
        self.gifView.contentMode = UIViewContentModeCenter;
    } else {
        self.gifView.contentMode = UIViewContentModeCenter;
        
        CGFloat timeWidth = 0.0;
        if (!self.lastUpdatedTimeLabel.hidden) {
            timeWidth = self.lastUpdatedTimeLabel.mj_textWith;
        }
        self.gifView.mj_y = -(self.stateLabel.mj_h/2);
        self.stateLabel.mj_y = self.lastUpdatedTimeLabel.mj_y;
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    //    // 设置状态文字
    //        self.stateLabel.text = @"";
    
    // 重新设置key（重新显示时间）
    self.lastUpdatedTimeKey = @"";
}

#pragma mark key的处理
- (void)setLastUpdatedTimeKey:(NSString *)lastUpdatedTimeKey
{
    [super setLastUpdatedTimeKey:lastUpdatedTimeKey];
    
    // 如果label隐藏了，就不用再处理
    if (self.lastUpdatedTimeLabel.hidden) return;
    
    //    NSDate *lastUpdatedTime = [[NSUserDefaults standardUserDefaults] objectForKey:lastUpdatedTimeKey];
    
    // 如果有block
    if (self.lastUpdatedTimeText) {
        self.lastUpdatedTimeLabel.text = @"";
        return;
    }
    self.lastUpdatedTimeLabel.text = @"";
    
}

@end
