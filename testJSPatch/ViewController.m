//
//  ViewController.m
//  testJSPatch
//
//  Created by yuqiang on 2017/2/9.
//  Copyright © 2017年 yuqiang. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)handleNextButton:(id)sender {
//    self.testArray1 = [[NSMutableArray alloc]initWithArray:@[@"a1",@"a2",@"a3"]];
//    self.testArray2 = [[NSMutableArray alloc]initWithArray:@[@"b1",@"b2",@"b3"]];
//    
//    
//    
    [self.testTableView1 reloadData];
    [self.testTableView2 reloadData];
//
//    
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.testTableView1 reloadData];
//    });
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.testTableView2 reloadData];
//    });
//
//    
//    
//    return;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TEST" object:nil];
    
    return;
    NextViewController *next = [[NextViewController alloc]init];
    [self.navigationController pushViewController:next animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    NSLog(@"之前 - %@", NSThread.currentThread);
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        
//        NSLog(@"sync - %@", NSThread.currentThread);
//    });
//    NSLog(@"之后 - %@", NSThread.currentThread);
//    
//    
//    return;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeTestData) name:@"TEST" object:nil];
    
    
   
    
    
    self.testTableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 200) style:UITableViewStylePlain];
    self.testTableView1.dataSource = self;
    self.testTableView1.delegate = self;
    [self.view addSubview:self.testTableView1];
    
    self.testTableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 200) style:UITableViewStylePlain];
    self.testTableView2.dataSource = self;
    self.testTableView2.delegate = self;
    [self.view addSubview:self.testTableView2];
    
    self.testTableView3 = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 200) style:UITableViewStylePlain];
    self.testTableView3.dataSource = self;
    self.testTableView3.delegate = self;
    [self.view addSubview:self.testTableView3];
    
    
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)changeTestData
{
//    self.testArray1 = [[NSMutableArray alloc]initWithArray:@[@"a1",@"a2",@"a3"]];
//    self.testArray2 = [[NSMutableArray alloc]initWithArray:@[@"b1",@"b2",@"b3"]];
//    [self.testTableView1 reloadData];
//    [self.testTableView2 reloadData];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.testTableView2 reloadData];
//    });
//
//    
//    
//    return;
    
    
    
    
    self.testArray1 = [[NSMutableArray alloc]initWithArray:@[@"a1",@"a2",@"a3"]];
    
    __block typeof(self) weakSelf = self;
    
    [weakSelf.testArray1 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isEqualToString:@"a2"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.testTableView1 reloadData];
            });

        }
    }];
    
    self.testArray2 = [[NSMutableArray alloc]initWithArray:@[@"b1",@"b2",@"b3"]];
    [weakSelf.testArray2 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isEqualToString:@"b2"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.testTableView2 reloadData];
            });
        }
    }];
    
    self.testArray3 = [[NSMutableArray alloc]initWithArray:@[@"c1",@"c2",@"c3"]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.testTableView3 reloadData];
    });
//    //为了强制刷新表2
//    [self.testTableView2 reloadData];
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.testTableView1) {
        return self.testArray1.count;
    } else if (tableView == self.testTableView2) {
        return self.testArray2.count;
    } else {
        return self.testArray3.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =@"cell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (tableView == self.testTableView1) {
        self.testArray = [[NSMutableArray alloc]initWithArray:self.testArray1];
    } else if (tableView == self.testTableView2) {
        self.testArray = [[NSMutableArray alloc]initWithArray:self.testArray2];
    } else {
        self.testArray = [[NSMutableArray alloc]initWithArray:self.testArray3];
    }
    
    NSLog(@"%@",self.testArray);
    cell.textLabel.text = self.testArray[indexPath.row];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",self.testArray[indexPath.row]] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
