

#import "ViewController.h"
#import "SecondViewController.h"

//#define COMPANY @"yunda"
//#define IDNUMBER @"1201138992251"
@interface ViewController ()

@end

@implementation ViewController

-(void)loadView
{
    
    UIView *baseview = [[UIView alloc]initWithFrame:[[UIScreen mainScreen]applicationFrame]];
    baseview.backgroundColor = [UIColor orangeColor];
    self.view = baseview;
    
    
    UIButton *button_name = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_name setTintColor:[UIColor redColor]];
    [button_name setTitle:@"快递公司" forState:UIControlStateNormal];
    [button_name setFrame:CGRectMake(10, 170, 80, 40)];
    [self.view addSubview:button_name];
    
    
    UIButton *button_num = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_num setTintColor:[UIColor redColor]];
    [button_num setTitle:@"快递编号" forState:UIControlStateNormal];
    [button_num setFrame:CGRectMake(10, 240, 80, 40)];
    [self.view addSubview:button_num];
    
    
    UIButton *button_ok = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button_ok setTintColor:[UIColor brownColor]];
    [button_ok setTitle:@"确定" forState:UIControlStateNormal];
    [button_ok addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [button_ok setFrame:CGRectMake(200, 300, 80, 40)];
    [self.view addSubview:button_ok];
    
    
    
    text_name = [[UITextField alloc] initWithFrame:CGRectMake(100, 170, 150, 40)];
    text_name.borderStyle = UITextBorderStyleRoundedRect;
    text_name.placeholder = @"请输入快递公司名字";
    text_name.textColor = [UIColor darkGrayColor];
    text_name.backgroundColor = [UIColor whiteColor];
    text_name.textAlignment = 0;
    [text_name resignFirstResponder];
    [self.view addSubview:text_name];
    
  
    UIButton *chose_name = [UIButton buttonWithType:UIButtonTypeCustom];
    [chose_name setTintColor:[UIColor greenColor]];
    [chose_name setTitle:@"选择" forState:UIControlStateNormal];
    [chose_name setFrame:CGRectMake(250, 170, 50, 40)];
    [chose_name addTarget:self action:@selector(Chose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chose_name];
    
    
    text_num = [[UITextField alloc] initWithFrame:CGRectMake(100, 240, 200, 40)];
    text_num.borderStyle = UITextBorderStyleRoundedRect;
    text_num.placeholder = @"请输入快递编号";
    text_num.textColor = [UIColor darkGrayColor];
    text_num.backgroundColor = [UIColor whiteColor];
    [text_num setDelegate:self];
    [self.view addSubview:text_num];
    view_show = [[UIView alloc]initWithFrame:[[UIScreen mainScreen]applicationFrame ]];
    
   
}

#pragma mark - Target Action
-(void)buttonAction{
    
    if (text_name == nil || [text_name  isEqual: @""]) {
//        alertview =[[UIAlertView alloc]initWithFrame:CGRectMake(140, 180, 200, 100)];
//        alertview.message = @"快递公司名称不能为空，请输入快递公司名称";
//        [alertview performSelector:@selector(ok) withObject:nil afterDelay:0.5];
//        [alertview show];
       
       

    }
    if(text_num == nil || [text_num isEqual:@""])
   {
//        alertview = [[UIAlertView alloc]initWithFrame:CGRectMake(140, 180, 200, 100)];
//        alertview.message = @"快递编号不能为空，请输入快递编号";
//        [alertview performSelector:@selector(ok) withObject:nil afterDelay:0.5];
//        [alertview show];
//        NSLog(@"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
  }
    [self requestWithPost];
}
-(void)pushVC:(NSString *)infoStr
{
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    secondVC.inforString = infoStr;
    secondVC.title=@"查询结果";
    [self.navigationController pushViewController:secondVC animated:YES];
}

//- (void)companyName:(NSString *)name withChinese:(NSString *)chinese{
//   
//    NSLog(@"汉字转化为英语");
//    NSLog(@"%@,%@",name,chinese);
//}

//按任意处键盘消失
-(void)resume{
    [self.view setFrame:CGRectMake(0, 0, 320, 480)];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [text_name resignFirstResponder];
    [text_name resignFirstResponder];
}
#pragma mark texfiledDelegte
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == text_name) {
        [self.view setFrame:CGRectMake(0, -40, 320, 480)];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self resume];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    [self resume];
}

-(void)CompanyNmae:(NSString *)_companyNanme
{
    NSLog(@"_com=%@",_companyNanme);

    [text_name setText:_companyNanme];
    
}
- (void)viewDidLoad

{
    [super viewDidLoad];
 //   [self requestWithGet];
//    用POST方式
    [self requestWithPost];
}
#pragma mark - request
////POST请求
-(void)requestWithPost{
    //构建URL
    NSString *string = [NSString stringWithFormat:@"http://222.24.63.109/express/?"];
    NSURL *requestUrl= [NSURL URLWithString:string];
    //创建请求
    NSMutableURLRequest *request =[ [NSMutableURLRequest alloc]initWithURL:requestUrl];
    //设置参数
    NSString *requestPargma = [NSString stringWithFormat:@"company=%@&id=%@",text_name.text,text_num.text];
    NSData *data = [requestPargma dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
   
    [request setHTTPBody:data];
    //连接服务器
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (!connection) {
        NSLog(@"Failed to submit request");
    
    } else {
        NSLog(@"Request submitted");
    }

}

#pragma mark - NSURLConnectionDataDelegate
//收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response=%@",response);
    _receiveData=[NSMutableData alloc];
}
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_receiveData appendData:data];
}
//请求完之后调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"connectionDidFinishLoading");
    NSString *infoString = [[NSString alloc]initWithData:_receiveData encoding:NSUTF8StringEncoding];
    NSLog(@"inforstringaaaaaaaaaaaaa%@" , infoString);
    if ([infoString isEqualToString:@"null"]) {
        NSLog(@"查询成功但运单过期或没有物流信息");
    }
    else if([infoString isEqualToString:@"Param_Error"]){
        NSLog(@"缺少参数");
    }
    else if([infoString isEqualToString:@"Illegal_ID"]){
        NSLog(@"运单号或快递公司编码无效");
        
    }
    else if([infoString isEqualToString:@"Server_Error"]){
        NSLog(@"服务其错误");
        
    }
    else{
        NSLog(@"成功");
          _dic = [NSJSONSerialization JSONObjectWithData:_receiveData options:NSJSONReadingMutableLeaves error:nil];   }
    //如果成功， 则pushVC到下一个页面，调用该方法
    [self pushVC:infoString];
}
#pragma mark - memory
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark-Chose
-(void)Chose:(id)sender{
    ChoseViewController *choseVC = [[ChoseViewController alloc]init];
    choseVC.delegate = self;
    [self.navigationController pushViewController:choseVC animated:YES];
    
    
}

@end
