//
//  ViewController.m
//  0818_查看大图
//
//  Created by APPLE on 15/11/9.
//  Copyright (c) 2015年 big nerd ranch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *imageView;

//假设图像是从网络上获取的
@property(nonatomic,strong) UIImage *image;
@end

@implementation ViewController

//重写了图像的setter（set图像的同时修改了imageview和scrollView）
-(void)setImage:(UIImage *)image
{
    //把图像传给属性
    _image=image;
    
    //设置图像视图的内容
    self.imageView.image=image;
    
    //让图像视图根据图像自动调整大小
    [self.imageView sizeToFit];
    
    
    //告诉scrollView与图像保持一样的大小
    self.scrollView.contentSize=self.image.size;
}


//对imageView做一个懒加载，重写get方法
-(UIImageView *)imageView
{
    if (_imageView==nil) {
        _imageView=[[UIImageView alloc]init];
        
        //将imageView加入到scrollview中
        [self.scrollView addSubview:_imageView];
    }
    return _imageView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置图像
    self.image=[UIImage imageNamed:@"minion"];
    
    //1、属性1，设置边距srollView.conteninset
    self.scrollView.contentInset=UIEdgeInsetsMake(20, 20, 20, 20);
    
    //2、属性2，设置不显示垂直标识
    self.scrollView.showsHorizontalScrollIndicator=NO;
    
    //3、属性3，***偏移位置**
    self.scrollView.contentOffset=CGPointMake(100, 100);
    
    //偏移位置举例
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeContactAdd];
    
    btn.center=self.scrollView.center;
    
    //[self.scrollView addSubview:btn];//BTN添加在scrollView上，滚走了就不显示
    [self.view addSubview:btn]; //btn加在view上，始终在屏幕的正中间
    
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    //4、属性4，弹簧效果 bounces BOOL型
    //不要跟bounds搞混了
    self.scrollView.bounces =NO;

}

-(void)click
{
   // self.scrollView.contentOffset.x=200;  //不可以直接修改结构体的成员
    CGPoint offset=self.scrollView.contentOffset;
    offset.x+=20;
    offset.y+=20;
    
    //注意：设置contenoffset会忽略contensize
    self.scrollView.contentOffset=offset;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
