
#import "ChoseViewController.h"
#import "ViewController.h"
@interface ChoseViewController (){

   
}

@end

@implementation ChoseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title = @"快递公司";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITableView *choseTab = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStylePlain];
    choseTab.delegate = self;
    choseTab.dataSource = self;
    [self.view addSubview:choseTab];
    
    
    //读取plist文件
    NSString *path = [[NSBundle mainBundle]pathForResource:@"CompanyName" ofType:@"plist"];
    NSLog(@"工程的plist路径： %@" , path);
    Company_name = [[NSMutableArray  alloc]initWithContentsOfFile:path];
    
    //读取plist文件
    NSString *path1 = [[NSBundle mainBundle]pathForResource:@"pic" ofType:@"plist"];
    NSLog(@"工程的plist路径： %@" , path);
    Company_pic = [[NSMutableArray  alloc]initWithContentsOfFile:path1];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return Company_name.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentity = @"cell";
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if(cell == nil){
    
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
    }
    
    NSString *nameCompany = Company_name[indexPath.row];
    
    cell.textLabel.text = nameCompany;

    NSArray *compay =@[@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg",@"10.jpg",@"11.jpg"];
    NSString *companypic =compay[indexPath.row];
    

    UIImage *myimage =  [UIImage imageNamed:companypic];
    cell.imageView.image = myimage;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //添加返回
    //添加委托传值
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row
    inSection:indexPath.section]];
    NSString *text =[NSString stringWithString:cell.textLabel.text];
    NSLog(@"text=%@",text);
    [self.delegate CompanyNmae:text];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
@end
