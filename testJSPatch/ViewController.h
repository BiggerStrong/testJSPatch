//
//  ViewController.h
//  testJSPatch
//
//  Created by yuqiang on 2017/2/9.
//  Copyright © 2017年 yuqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) UITableView *testTableView1;

@property (nonatomic, retain) UITableView *testTableView2;

@property (nonatomic, retain) UITableView *testTableView3;

@property (nonatomic, retain) NSMutableArray *testArray1;

@property (nonatomic, retain) NSMutableArray *testArray2;

@property (nonatomic, retain) NSMutableArray *testArray3;

@property (nonatomic, retain) NSMutableArray *testArray;

@end

