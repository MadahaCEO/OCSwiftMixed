//
//  ListViewController.m
//  Book
//
//  Created by Apple on 2021/1/9.
//  Copyright © 2021 马大哈. All rights reserved.
//

#import "ListViewController.h"
// 这个文件是系统默认创建的，可以通过编译查看编译后的framework中就包含子文件。通过引入这个文件可以调用swift类
#import <Book/Book-Swift.h>
#import <Masonry/Masonry.h>

#import "SubViewViewController.h"


@interface ListViewController ()<DetailViewModelDelegate>

@property(nonatomic, strong) UIButton *vmBtn;

@property(nonatomic, strong) UIButton *dmBtn;

@property(nonatomic, strong) UIButton *viewBtn;

@property(nonatomic, strong) UIButton *controllerBtn;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"OC Controller";

    [self.view addSubview:self.vmBtn];
    [self.vmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.height.equalTo(@40);
    }];
    
    [self.view addSubview:self.dmBtn];
    [self.dmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vmBtn.mas_bottom).mas_offset(20);
        make.left.right.equalTo(self.vmBtn);
        make.height.equalTo(@40);
    }];
    
    [self.view addSubview:self.viewBtn];
    [self.viewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dmBtn.mas_bottom).mas_offset(20);
        make.left.right.equalTo(self.vmBtn);
        make.height.equalTo(@40);
    }];
    
    [self.view addSubview:self.controllerBtn];
    [self.controllerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewBtn.mas_bottom).mas_offset(20);
        make.left.right.equalTo(self.vmBtn);
        make.height.equalTo(@40);
    }];
}


- (void)vmBtnTouched {
    DetailViewModel *vm = [[DetailViewModel alloc] init];
    vm.delegate = self;
    
    vm.name = @"名字";
    
    [vm instanceMethod];
    
    [DetailViewModel classMethod];
    
    [vm instanceMethod1WithName:@"娃哈哈"];

    [vm instanceMethod2WithName:@"娃哈哈" age:20 isTeacher:YES];
    
    NSInteger sum = [vm sumWithFirst:1 second:5];
    NSLog(@"求和： %ld",(long)sum);
    
    

    [vm instanceMethod3:@"参数1" closure:nil];
    
    [vm instanceMethod3:@"sdfsdf" closure:^{
        NSLog(@"OC 调用 Swift 实例方法, swift 通过 闭包 回调 OC，且不带有参数");
    }];
    
    
    [vm instanceMethod4:^(NSString * _Nonnull name, NSInteger age) {
        NSLog(@"OC 调用 Swift 实例方法, swift 通过 闭包 回调 OC，带有参数  %@   %ld",name,age);
    }];
    
    /*
     5 和 6 搭配验证
     */
    [vm instanceMethod5:^{
        
        NSLog(@"OC 调用 Swift 实例方法, swift 通过 闭包 回调 OC，模拟异步延迟调用");
    }];
    
    [vm instanceMethod6];
    
    
    [vm instanceMethod7];
    
}

- (void)dmBtnTouched {
    
    NSDictionary *dic = @{
        @"name":@"娃哈哈",
        @"pageCount":@(20),
        @"type":@"history",
    };
    
    DetailDataModel *dataModel = [[DetailDataModel alloc] initWithBook:dic];
    
    NSLog(@"name: %@  - pageCount: %ld  -  type: %@  -  all: %@",
          dataModel.name,
          (long)dataModel.pageCount,
          dataModel.type,
          dataModel.all);
}

- (void)viewBtnTouched {
    SubViewViewController *subVC = [[SubViewViewController alloc] init];
    [self.navigationController pushViewController:subVC animated:YES];
}

- (void)controllerBtnTouched {
    
    DetailViewController *subVC = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:subVC animated:YES];

}



#pragma mark - Delegate

//- (void)detailInfo {
//
//}

- (void)author:(NSString *)name {
    
    NSLog(@"OC 调用 Swift 实例方法, swift 通过 协议 回调 OC，%@",name);

}

- (NSInteger)age:(NSInteger)age {
    
    NSLog(@"OC 调用 Swift 实例方法, swift 通过 协议 回调 OC，带参数，且要有返回值");

    return 4 + age;
}

- (void)detailInfo {
    NSLog(@"OC 调用 Swift 实例方法, swift 通过 协议 回调 OC，不带参数");

}


- (UIButton *)vmBtn {
    if (!_vmBtn) {
        _vmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _vmBtn.backgroundColor = [UIColor clearColor];
        [_vmBtn setTitle:@"OC 调用 Swift ViewModel" forState:UIControlStateNormal];
        [_vmBtn addTarget:self action:@selector(vmBtnTouched) forControlEvents:UIControlEventTouchUpInside];
    }
    return _vmBtn;
}

- (UIButton *)dmBtn {
    if (!_dmBtn) {
        _dmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _dmBtn.backgroundColor = [UIColor clearColor];
        [_dmBtn setTitle:@"OC 调用 Swift DataModel" forState:UIControlStateNormal];
        [_dmBtn addTarget:self action:@selector(dmBtnTouched) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dmBtn;
}


- (UIButton *)viewBtn {
    if (!_viewBtn) {
        _viewBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _viewBtn.backgroundColor = [UIColor clearColor];
        [_viewBtn setTitle:@"OC 调用 Swift View" forState:UIControlStateNormal];
        [_viewBtn addTarget:self action:@selector(viewBtnTouched) forControlEvents:UIControlEventTouchUpInside];
    }
    return _viewBtn;
}

- (UIButton *)controllerBtn {
    if (!_controllerBtn) {
        _controllerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _controllerBtn.backgroundColor = [UIColor clearColor];
        [_controllerBtn setTitle:@"OC 调用 Swift Controller" forState:UIControlStateNormal];
        [_controllerBtn addTarget:self action:@selector(controllerBtnTouched) forControlEvents:UIControlEventTouchUpInside];
    }
    return _controllerBtn;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



@end
