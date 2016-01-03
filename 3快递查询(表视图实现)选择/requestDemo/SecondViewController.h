


#import <UIKit/UIKit.h>
@interface SecondViewController : UIViewController<UITableViewDataSource , UITableViewDelegate>
{
    NSArray *dataArr;//返回的数据存储在一个数组中
  
}

@property(nonatomic,copy)NSString *inforString;
@property(nonatomic,retain)NSMutableData *receiveData;
@property(nonatomic , retain) NSMutableArray *timeArray;//返回的时间保存在timeArray中
@property(nonatomic , retain)NSMutableArray *DetailArray;//返回的时间保存在DetailArray中
@end