//
//  WaveView.m
//  VoiceRecorderDemo
//
//  Created by Yang  on 29/05/2012.
//  Copyright (c) 2012 www.mobiletrain.org. All rights reserved.
//

#import "WaveView.h"

@implementation WaveView
- (id) initWithFrame:(CGRect)frame {
    if ( (self = [super initWithFrame:frame] )) {
        averagePointArray = [[NSMutableArray alloc] initWithCapacity:frame.size.width];
        peakPointArray = [[NSMutableArray alloc] initWithCapacity:frame.size.width];
        
        for (int i =0; i < frame.size.width; i++) {
            [averagePointArray addObject:[NSNumber numberWithFloat:0.0f]];
            [peakPointArray addObject:[NSNumber numberWithFloat:0.0f]];
        }
        self.clearsContextBeforeDrawing = YES;
    }
    return self;
}
- (void) addAveragePoint:(CGFloat)averagePoint andPeakPoint:(CGFloat)peakPoint {
    //NSLog(@"averagePoint %f peakPoint %f", averagePoint, peakPoint);
    [averagePointArray removeObjectAtIndex:0];
    [averagePointArray addObject:[NSNumber numberWithFloat:averagePoint]];
    // 删除averagePointArray数组第一项 
    // 然后在最后一项加入最新的数据
    
    [peakPointArray removeObjectAtIndex:0];
    [peakPointArray addObject:[NSNumber numberWithFloat:peakPoint]];
    
    //调用setNeedsDisplay 会自动的调用drawRect:
    [self setNeedsDisplay];
    // 通知self(表示当前view的) 重新刷新界面
}

- (void)drawInContext:(CGContextRef)context
{       
    CGColorRef colorRef = [[UIColor redColor] CGColor]; 
    // [UIColor redColor] 红色 OC的红色 OC类型的
    // CGColor转化成C语言的iOS类型的红色
    //画笔的颜色
    CGContextSetStrokeColorWithColor(context, colorRef);
    //画笔的宽
    CGContextSetLineWidth(context, 1.0f);
    //
    CGContextClearRect(context, self.bounds);
    // 清除context画布上上面 self.bounds区域
    
    CGPoint firstPoint = CGPointMake(0.0f, [[averagePointArray objectAtIndex:0] floatValue]);
    //画笔移动到指定的点
    CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
    
    for (int i = 1; i < [peakPointArray count]; i++)
    {
        CGPoint point = CGPointMake(i, self.bounds.size.height-([[averagePointArray objectAtIndex:i] floatValue]*self.bounds.size.height));
        //增加一个点 进行连线
        CGContextAddLineToPoint(context, point.x, point.y);
    }
    //画完了告诉系统
    CGContextStrokePath(context); 
}
// 可以在当前的View上画东西
// rect表示当前的view的宽高
-(void) drawRect2:(CGRect)rect{
    
    //相当于创建画笔
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 直接取得画布即可 因为系统帮我们创建了画布
    [self drawInContext:context];
}

-(void) drawRect:(CGRect)rect{
    // 每个uiview有一个自己的context uiview自动创建好的
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /* 坐标变换 换算成远点在左下角  CTM Context Transform Matrix */
    CGAffineTransform t = CGContextGetCTM(context);
    // [2, 0, 0, -2, 0, 200]
    NSLog(@"t is %@", NSStringFromCGAffineTransform(t));
    // 直接取得画布即可 因为系统帮我们创建了画布
    
    // 把context当前matrix坐标 向y正方向移动了view高度
    CGContextTranslateCTM(context, 0.0f, (self.bounds.size.height));
    // 把当前的matrix x` = x * 1; y` = y * -1;
    CGContextScaleCTM(context, 1.0f, -1.0f);
    
    t = CGContextGetCTM(context);
    NSLog(@"new t is %@", NSStringFromCGAffineTransform(t));
    // [2, 0, -0, 2, 0, 0]
    [self drawInContext2:context];
}
- (void)drawInContext2:(CGContextRef)context
{       
    CGColorRef colorRef = [[UIColor redColor] CGColor]; 
    // [UIColor redColor] 红色 OC的红色 OC类型的
    // CGColor转化成C语言的iOS类型的红色
    CGContextSetStrokeColorWithColor(context, colorRef);     
    CGContextSetLineWidth(context, 1.0f);
    CGContextClearRect(context, self.bounds);
    // 清除context画布上上面 self.bounds区域
    
    CGPoint firstPoint = CGPointMake(0.0f, [[averagePointArray objectAtIndex:0] floatValue]);
    CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
    
    for (int i = 1; i < [peakPointArray count]; i++)
    {
        CGPoint point = CGPointMake(i, ([[averagePointArray objectAtIndex:i] floatValue]*self.bounds.size.height));
        CGContextAddLineToPoint(context, point.x, point.y);
    } 
    CGContextStrokePath(context); 
}
// 可以在当前的View上画东西


@end
