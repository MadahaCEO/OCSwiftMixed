//
//  SubViewViewController.m
//  Book
//
//  Created by Apple on 2021/1/10.
//  Copyright © 2021 马大哈. All rights reserved.
//

#import "SubViewViewController.h"
#import <Book/Book-Swift.h>
#import <Masonry/Masonry.h>

@interface SubViewViewController ()

@property(nonatomic, strong) DetailView *detailView;

@end

@implementation SubViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"OC Controller 添加 Swift View";
    
    [self.view addSubview:self.detailView];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

}


- (DetailView *)detailView {
    if (!_detailView) {
        _detailView = [[DetailView alloc] initWithFrame:CGRectZero];
        _detailView.backgroundColor = [UIColor grayColor];
    }
    return _detailView;
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
