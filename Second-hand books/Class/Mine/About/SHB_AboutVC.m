//
//  SHB_AboutVC.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/23.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_AboutVC.h"

@interface SHB_AboutVC ()

@property (weak, nonatomic) IBOutlet UILabel *versionLbl;
@property (weak, nonatomic) IBOutlet UILabel *buildVersionLbl;


@end

@implementation SHB_AboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"关于";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *buildVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    self.versionLbl.text = [NSString stringWithFormat:@"版本号：%@", currentVersion];
    self.buildVersionLbl.text = [NSString stringWithFormat:@"构建版本号：%@", buildVersion];;
}



@end
