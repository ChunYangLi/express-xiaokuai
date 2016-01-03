//


#import <UIKit/UIKit.h>
#import "ChoseViewController.h"

@interface ViewController : UIViewController<NSURLConnectionDataDelegate,NSURLConnectionDelegate , UITextFieldDelegate , ChoseViewControllerDelegate>
{
    UITextField *text_name;
    UITextField *text_num;
    UIView *view_show;
   // UIAlertView *alertview;
    
}

@property(nonatomic,retain)NSMutableData *receiveData;
@property(nonatomic,retain)NSDictionary *dic;

-(void)CompanyNmae:(NSString *)_companyNanme;

@end
