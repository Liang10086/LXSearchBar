//
//  ViewController.m
//  LXSearchBar
//
//  Created by 王明亮 on 2018/11/8.
//  Copyright © 2018 王明亮. All rights reserved.
//

#import "ViewController.h"
#import "LXSearchBar.h"
@interface ViewController ()<UISearchBarDelegate>
@property (nonatomic, strong) LXSearchBar *searchBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar = [[LXSearchBar alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 44)];
    self.searchBar.placeholder = @"输入搜索的内容";
    self.searchBar.isTextCenter = YES;
    self.searchBar.cornerRadius = 12;
    self.searchBar.delegate = self;
    
    [self.view addSubview:self.searchBar];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@">>>> %@",searchText);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchBar endEditing:YES];
}

@end
