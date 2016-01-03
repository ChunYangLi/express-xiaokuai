//
//  ChoseViewController.h
//  requestDemo
//
//  Created by lichunyang on 14-7-24.
//  Copyright (c) 2014年 刘锦. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChoseViewControllerDelegate <NSObject>

-(void)CompanyNmae:(NSString *)_companyNanme;

@end

@interface ChoseViewController : UIViewController<UITableViewDataSource ,UITableViewDelegate>
{
    NSMutableArray *Company_name;
    NSMutableArray *Company_pic;
   
}
@property  (nonatomic , assign)id<ChoseViewControllerDelegate> delegate;
@end
