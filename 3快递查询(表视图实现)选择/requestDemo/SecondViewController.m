//
//  SecondViewController.m
//  requestDemo
//
//  Created by lichunyang on 14-4-24.
//  Copyright (c) 2014年 刘锦. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController (){

    NSInteger _index;
}

@end

@implementation SecondViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"查询结果";
    
    }
    return self;
}
-(void)setContent
{
    _DetailArray=[[NSMutableArray alloc]init];
    _timeArray=[[NSMutableArray alloc]init];
    NSData *data = [self.inforString dataUsingEncoding:NSUTF8StringEncoding];
    dataArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];//jsion转化为字典，存储在数组dataArr中
    NSLog(@"返回的数据为:%@",dataArr);
//    NSInteger count=dataArr.count;
//    NSLog(@"dataArr count : %i",count);
       for(NSDictionary *dic in dataArr){
           [_DetailArray addObject: [dic objectForKey:@"Detail"]];
           [_timeArray addObject: [dic objectForKey:@"Time"]];
    }
    NSLog(@"DetailArray %@" , _DetailArray);//将地址信息存放在DetailArray中
    NSLog(@"timeArray %@" , _timeArray); //将时间信息存放在timeArray中

    
}

-(void)loadView
{
    
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setContent];
    
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view =  view;
    NSLog(@"%lf,%lf",view.frame.size.height,view.frame.size.width);
    
    UITableView *Detailtableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height+20) style:UITableViewStylePlain];
    Detailtableview.dataSource =  self;
    Detailtableview.delegate = self;
    Detailtableview.separatorColor  =[UIColor blackColor];
    
    [view addSubview:Detailtableview];

    
}


#pragma mark - datasource
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0 ){
        return 80;
    }else{
        return 60;
    }
}
//cell的数目
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArr.count ;
}
//单元格重用机制
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentity = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if(cell != nil){
        cell.textLabel.font = [UIFont fontWithName: @"Marion" size:14];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    if(cell == nil){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentity];
        if( indexPath.row == 0 ){
            
            cell.textLabel.font = [UIFont fontWithName:@"Marion" size:16];
            cell.textLabel.textColor = [UIColor redColor];
            
            
        }else{
            cell.textLabel.textColor =[UIColor blackColor];
            //cell.textLabel.font = [UIFont fontWithName: @"Marion" size:14];
        }

    }
  
        cell.textLabel.text = [_DetailArray  objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [_timeArray objectAtIndex:indexPath.row];
        cell.textLabel.numberOfLines = 2;
         return cell;
    
}


#pragma mark -  delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _index = indexPath.row;
    NSLog(@"indexpath.row  %ld" , (long)_index);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

@end
