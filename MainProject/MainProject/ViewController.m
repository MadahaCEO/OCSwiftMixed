//
//  ViewController.m
//  MainProject
//
//  Created by Apple on 2021/1/9.
//  Copyright © 2021 马大哈. All rights reserved.
//

#import "ViewController.h"
#import <Book/Book.h> // Book 是一个用于验证混编的基于OC创建的动态库
#import <Masonry/Masonry.h>

@interface ViewController ()

@property(nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"插件化混编验证";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
    ListViewController *vc = [[ListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor clearColor];
        _label.text = @"任意点击空白处";
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont  systemFontOfSize:20];
    }
    return _label;
}

@end
