//
//  ViewController.m
//  PedometerDemo
//
//  Created by 毕向北 on 2017/8/21.
//  Copyright © 2017年 MBXB-bifujian. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showStepL;//用来显示步数的
@end

@implementation ViewController
{
    CMPedometer *_pedometer;
}
//简单的几个计步器的demo
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //0.在Info.plist中添加key Privacy - Motion Usage Description,否则会崩溃
    //注意!!!!
    //如果写在viewDidLoad. 先走了计步的方法, 然后才授权, 不可能获取数据
    //1.判断计步器是否可以使用
    if(![CMPedometer isStepCountingAvailable]){
        //这里就是不可用的
        NSLog(@"老铁系统版本过低, 没有权限");
        return;
    }
    //2. 创建计步器
    _pedometer = [CMPedometer new];
    //3. 开始计步
    [_pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        //4. 主线程中更新UI
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:pedometerData.numberOfSteps waitUntilDone:YES];
    }];
}
- (void)updateUI:(NSNumber *)steps {
    self.showStepL.text = [NSString stringWithFormat:@"大人当前一共走了%@步", steps];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
