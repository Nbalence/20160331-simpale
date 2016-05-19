//
//  ViewController.m
//  01-SmpaleDemo
//
//  Created by qingyun on 16/3/31.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "QYSlider.h"
@interface ViewController ()
@property (nonatomic, strong) NSTimer *swTimer;
@property (nonatomic, strong) UISwitch *sw;
@property (nonatomic, strong) NSTimer *progressTimer;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) QYSlider *slider;
@property (nonatomic, strong) UIStepper *stepper;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@end

@implementation ViewController
#pragma mark -UISwitch
-(UISwitch *)sw {
    if (_sw == nil) {
        _sw = [[UISwitch alloc] initWithFrame:CGRectMake(100, 100, 0, 0)];
        //开启的时候着色
        _sw.onTintColor = [UIColor blueColor];
        //关闭的时候着色
        _sw.tintColor = [UIColor blackColor];
        //拇指着色
        _sw.thumbTintColor = [UIColor redColor];
        _swTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeSWState:) userInfo:_sw repeats:YES];
        //添加事件监听（valueChanged）
        [_sw addTarget:self action:@selector(swOnValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _sw;
}
//更改sw的on属性
-(void)changeSWState:(NSTimer *)timer{
    UISwitch *sw = timer.userInfo;
    //sw.on = !sw.on;
    //动态设置on状态
    [sw setOn:!sw.on animated:YES];
}

//监听on状态的改变
-(void)swOnValueChanged:(UISwitch *)sw1{
    NSLog(@"%d",sw1.on);
}

#pragma mark  -UIProgressView
-(UIProgressView *)progressView{
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        //frame
        _progressView.frame = CGRectMake(100, 150, 200, 0);
        //tintColor
        _progressView.progressTintColor = [UIColor greenColor];
        _progressView.trackTintColor = [UIColor redColor];
        //image
        _progressView.progressImage = [UIImage imageNamed:@"0"];
        _progressView.trackImage = [UIImage imageNamed:@"1"];
        _progressTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeProgress:) userInfo:_progressView repeats:YES];
    }
    return _progressView;
}

-(void)changeProgress:(NSTimer *)timer{
    UIProgressView *progressView = timer.userInfo;
    if (progressView.progress < 1.0) {
        [progressView setProgress:_progressView.progress + 0.1 animated:YES];
    }else{
        progressView.progress = 0.0;
    }
}

#pragma mark  -UISlider
-(QYSlider *)slider {
    if (_slider == nil) {
        _slider = [[QYSlider alloc] initWithFrame:CGRectMake(100, 180, 200, 31)];
        _slider.backgroundColor = [UIColor redColor];
        
        //设置最大值和最小值
        _slider.minimumValue = 0;
        _slider.maximumValue = 100;
        
        //当前取值
        _slider.value = 50;
        
        //设置最大/小对应的图片
        _slider.minimumValueImage = [UIImage imageNamed:@"coin"];
        _slider.maximumValueImage = [UIImage imageNamed:@"coin"];
        
        //tintColor
        _slider.minimumTrackTintColor = [UIColor greenColor];
        _slider.maximumTrackTintColor = [UIColor yellowColor];
        _slider.thumbTintColor = [UIColor blueColor];
        //continuous决定是否连续触发slider监听的valueChanged事件
        _slider.continuous = NO;
        //添加事件监听（valueChanged）
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

-(void)sliderValueChanged:(QYSlider *)slider {
    NSLog(@"currentValue:%f",slider.value);
}

#pragma mark  -UIStepper

-(UIStepper *)stepper {
    if (_stepper == nil) {
        _stepper = [[UIStepper alloc] initWithFrame:CGRectMake(100, 250, 0, 0)];
        
        //设置范围
        _stepper.maximumValue = 10;
        _stepper.minimumValue = -10;
        //步进
        _stepper.stepValue = 1;
        //tintColor
        //_stepper.tintColor = [UIColor greenColor];
        
        //设置分割线
        UIImage *image = [[UIImage imageNamed:@"stepper"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [_stepper setDividerImage:image forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateHighlighted];
        //设置增加按钮的图片
        //[_stepper setIncrementImage:image forState:UIControlStateNormal];
        //添加事件监听（valueChanged）
        [_stepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        //continuous设置是否连续触发valueChanged事件
        _stepper.continuous = NO;
        //设置值是否重复发生变化
        _stepper.autorepeat = NO;
        //设置值时候循环改变
        _stepper.wraps = YES;
    }
    return _stepper;
}

-(void)stepperValueChanged:(UIStepper *)stepper {
    NSLog(@"stepper current value : %lf",stepper.value);
}

#pragma mark  -UISegmentedControl
-(UISegmentedControl *)segmentedControl {
    if (_segmentedControl == nil) {
        NSArray *items = @[@"first",@"second",@"third",@"fourth"];
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
        _segmentedControl.frame = CGRectMake(10, 300, 355, 31);
        //是否保留点击效果（yes:不保留 no:保留 默认no）
        _segmentedControl.momentary = NO;
        //设置具体某段的标题
        [_segmentedControl setTitle:@"two" forSegmentAtIndex:1];
        //按照索引插入新段
        [_segmentedControl insertSegmentWithTitle:@"fifth" atIndex:5 animated:NO];
        //按照索引删除段
        [_segmentedControl removeSegmentAtIndex:4 animated:NO];
        //设置某段可用状态
        [_segmentedControl setEnabled:NO forSegmentAtIndex:2];
        //设置某段的偏移量
        //[_segmentedControl setContentOffset:CGSizeMake(50, 0) forSegmentAtIndex:2];
        //根据内容自适应宽度
        _segmentedControl.apportionsSegmentWidthsByContent = YES;
        //设置某段的属性标题
        [_segmentedControl setTitleTextAttributes:@{NSUnderlineStyleAttributeName:@1} forState:UIControlStateNormal];
        //添加事件监听（valueChanged）
        [_segmentedControl addTarget:self action:@selector(segmentedControlSelectedIndexChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

-(void)segmentedControlSelectedIndexChanged:(UISegmentedControl *)segmentedControl {
    NSLog(@"%ld",segmentedControl.selectedSegmentIndex);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建并添加switch
    [self.view addSubview:self.sw];
    //添加UIProgressView
    [self.view addSubview:self.progressView];
    //添加UISlider
    [self.view addSubview:self.slider];
    //添加UIStepper
    [self.view addSubview:self.stepper];
    //添加segmentedControl
    [self.view addSubview:self.segmentedControl];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)dealloc{
    [_swTimer invalidate];
    _swTimer = nil;
    [_progressTimer invalidate];
    _progressTimer = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
