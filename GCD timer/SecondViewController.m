//
//  SecondViewController.m
//  GCD timer
//
//  Created by cyp on 16/5/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "SecondViewController.h"
#import "MyCell.h"
#import "MyModel.h"
@interface SecondViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,weak) UITableView* tableV;

@property (nonatomic ,strong) NSMutableArray* arr;

@property (nonatomic ,assign) int conut;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.conut = 40;
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 20, self.view.frame.size.width, 40);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
    
    
    self.arr = [NSMutableArray array];
    
    UITableView* tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60)];
    tableV.delegate = self;
    tableV.dataSource = self;
    [self.view addSubview:tableV];
    self.tableV = tableV;
    
    for (int i = 0; i < self.conut ;i ++) {
        MyModel* model = [[MyModel alloc]init];
        model.message = @"进行中";
        model.time = 10 + i;
        
        __weak __typeof(&*self)weakSelf = self;
        
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        model.timer = timer;
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC, 1ull * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            model.time -- ;
            if (model.time <= 0) {
                dispatch_source_cancel(timer);
                return ;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableV reloadData];
            });
        });
        dispatch_source_set_cancel_handler(timer, ^{
            model.message = @"已结束";
            [weakSelf.tableV reloadData];
        });
        dispatch_resume(timer);
        
        [self.arr addObject:model];
    }
    [self.tableV reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* myCellID = @"myCellID";
    MyCell* cell = [tableView dequeueReusableCellWithIdentifier:myCellID];
    if (cell == nil) {
        cell = [[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCellID];
    }
    MyModel* model = self.arr[indexPath.row];
    cell.timeLabel.text= [NSString stringWithFormat:@"%d",model.time];
    cell.messageLabel.text = model.message;
    return cell;
}
- (void)clickBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc{
    NSLog(@"release >>> %@",[self class]);
}
@end