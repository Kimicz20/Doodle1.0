//
//  CZUIView.m
//  Doodle
//
//  Created by Geek on 16/6/29.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "CZUIView.h"

@interface CZUIView()
@property (nonatomic,strong) NSMutableArray *totalPaths;
@end

@implementation CZUIView

-(NSMutableArray *)totalPaths{
    if(_totalPaths == nil){
        _totalPaths = [NSMutableArray array];
    }
    return _totalPaths;
}

-(void)clean{
    [_totalPaths removeAllObjects];
    [self setNeedsDisplay];
}

-(void)backup{
    [_totalPaths removeLastObject];
    [self setNeedsDisplay];
}

/**
 *  起始点
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch =  [touches anyObject];
    CGPoint startPoint = [touch locationInView:touch.view];
   
    //把每个起点对应的一条路径保存
    NSMutableArray *path = [NSMutableArray array];
    [path addObject:[NSValue valueWithCGPoint:startPoint]];
    
    [self.totalPaths addObject:path];
    
    [self setNeedsDisplay];
}
/**
 *  过程点
 */
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch =  [touches anyObject];
    CGPoint currentPoint = [touch locationInView:touch.view];
    
    //1.取出对应路径保存的数组
    NSMutableArray *path = [self.totalPaths lastObject];
    //2.保存路径过程中的点
    [path addObject:[NSValue valueWithCGPoint:currentPoint]];
    
    [self setNeedsDisplay];
}

/**
 *  结束点
 */
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch =  [touches anyObject];
    CGPoint endPoint = [touch locationInView:touch.view];
    
    //1.取出对应路径保存的数组
    NSMutableArray *path = [self.totalPaths lastObject];
    //2.保存路径过程中的点
    [path addObject:[NSValue valueWithCGPoint:endPoint]];
    
    [self setNeedsDisplay];
}
/**
 *  Cord2D画图过程
 */
-(void)drawRect:(CGRect)rect{
    
    //1.拿到上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2.路径点渲染
    for(NSMutableArray *path in _totalPaths){
        for(int i=0;i<path.count;i++){
            CGPoint p = [path[i] CGPointValue];
            if(i ==0 ){
                CGContextMoveToPoint(ctx, p.x, p.y);
            }else{
                CGContextAddLineToPoint(ctx, p.x, p.y);
            }
        }
    }
    
    //3.设置样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineWidth(ctx, 5);
    //4.画图
    CGContextStrokePath(ctx);
}

@end
