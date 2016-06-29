//
//  ViewController.m
//  Doodle
//
//  Created by Geek on 16/6/29.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "ViewController.h"
#import "CZUIView.h"
#import "UIImage+MJ.h"
#import "MBProgressHUD+MJ.h"

@interface ViewController ()
- (IBAction)clean:(UIButton *)sender;
- (IBAction)backup:(UIButton *)sender;
- (IBAction)save:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet CZUIView *paintView;

@end

@implementation ViewController

- (IBAction)clean:(UIButton *)sender {
    [self.paintView clean];
}

- (IBAction)backup:(UIButton *)sender {
    [self.paintView backup];
}

- (IBAction)save:(UIButton *)sender {
    
    //1.获取图片
    UIImage *pic = [UIImage captureWithView:self.paintView];
    
    //2.保存图片
    UIImageWriteToSavedPhotosAlbum(pic, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if(error){
        [MBProgressHUD showError:@"保存失败"];
    }else{
        [MBProgressHUD showSuccess:@"保存成功"];
    }
    
}
@end
