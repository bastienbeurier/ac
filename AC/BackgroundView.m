//
//  BackgroundView.m
//  AC
//
//  Created by Bastien Beurier on 5/5/16.
//  Copyright © 2016 Uber Technologies, Inc. All rights reserved.
//

#import "BackgroundView.h"

@implementation BackgroundView

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2) radius:(rect.size.width / 2) startAngle:0 endAngle:(2 * M_PI) clockwise:YES];
    [[UIColor grayColor] setFill];
    [path fill];
}

@end
