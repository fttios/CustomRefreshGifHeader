//
//  ViewController.m
//  TestRefresh
//
//  Created by 范坛 on 2017/7/24.
//  Copyright © 2017年 范坛. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "ECGCustomGifHeader.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *arrayM;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    //============正确用法有动画============
    self.tableView.mj_header = [ECGCustomGifHeader headerWithRefreshingBlock:^{
        [self beginRef];
    }];
}

- (NSMutableArray *)arrayM {
    if (!_arrayM) {
        _arrayM = [NSMutableArray new];
    }
    return _arrayM;
}

-(void)beginRef{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (NSInteger i = 0; i < 5; i ++) {
            NSString *str = [NSString stringWithFormat:@"%ld",(long)i];
            [self.arrayM addObject:str];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    });
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayM.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}


@end
