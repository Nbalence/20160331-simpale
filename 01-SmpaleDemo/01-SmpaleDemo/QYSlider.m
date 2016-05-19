//
//  QYSlider.m
//  01-SmpaleDemo
//
//  Created by qingyun on 16/3/31.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYSlider.h"

@implementation QYSlider

//重置最小值对应的图片
- (CGRect)minimumValueImageRectForBounds:(CGRect)bounds {
    CGRect rect = CGRectMake(40, 0, 10, 10);
    return rect;
}

@end
