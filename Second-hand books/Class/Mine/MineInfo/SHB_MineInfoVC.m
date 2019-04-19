//
//  SHB_MineInfoVC.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/22.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_MineInfoVC.h"
#import "SHB_MineInfoSection0Cell.h"
#import "SHB_MineInfoSection1Cell.h"
#import "SHB_MineInfoSection2Cell.h"
#import "TOCropViewController.h"
#import "SHB_UserModel.h"


@interface SHB_MineInfoVC () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, TOCropViewControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) SHB_UserModel *userModel;
@property (nonatomic, strong) NSData *avatarData;

@end

@implementation SHB_MineInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人信息";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSArray *array = [DataBaseManager queryUserWithUserId:UserInfoManager.userId];
    self.userModel = array.firstObject;
    [self.tableView reloadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
        
        UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [submitButton setTitle:@"保存修改" forState:UIControlStateNormal];
        [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        submitButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [submitButton setBackgroundColor:[UIColor colorWithHex:@"#2B7650"]];
        [submitButton addTarget:self action:@selector(submitChanges) forControlEvents:UIControlEventTouchUpInside];
        self.submitButton = submitButton;
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
        [footerView addSubview:submitButton];
        [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(footerView.mas_left).offset(60);
            make.right.equalTo(footerView.mas_right).offset(-60);
            make.centerY.equalTo(footerView.mas_centerY);
            make.height.equalTo(@50);
        }];
        _tableView.tableFooterView = footerView;
        
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        SHB_MineInfoSection0Cell *cell = [SHB_MineInfoSection0Cell cellWithTableView:tableView];
        cell.userModel = self.userModel;
        
        return cell;
        
    } else if (indexPath.section == 1) {
        
        SHB_MineInfoSection1Cell *cell = [SHB_MineInfoSection1Cell cellWithTableView:tableView];
        [cell setModel:self.userModel index:indexPath];
        @weakify(self);
        [[cell.contentTF.rac_textSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString * _Nullable x) {
            DONG_Log(@"x:%@", x);
            @strongify(self);
            switch (cell.contentTF.tag) {
                case 0:
                    self.userModel.nickName = x;
                    break;
                    
                case 1:
                    self.userModel.name = x;
                    break;
                    
                case 2:
                    self.userModel.mobilePhone = x;
                    break;
                    
                default:
                    break;
            }
        }];
        
        return cell;
        
    } else {
        
        SHB_MineInfoSection2Cell *cell = [SHB_MineInfoSection2Cell cellWithTableView:tableView];
        cell.userModel = self.userModel;
        @weakify(self);
        [cell.contentTextView.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            self.userModel.personalProfile = x;
        }];
        
        return cell;
    }
}

#pragma mark -  UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 118;
    } else if (indexPath.section ==1) {
        return 45;
    } else {
        return 145;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) return 0;
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 取消选中
    if (indexPath.section == 0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        // 取消
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }];
        [alert addAction:cancelAction];
        
        // 拍照
        UIAlertAction *confimAction1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
        }];
        [alert addAction:confimAction1];
        
        // 从手机相册中选择
        UIAlertAction *confimAction2 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
            
        }];
        [alert addAction:confimAction2];
        
        // 保存图片
        //        UIAlertAction *confimAction3 = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //
        //        }];
        //        [alert addAction:confimAction3];
        
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                
            }
                break;
                
            case 1:
                
                break;
                
            case 2:
            {
                
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)submitChanges {
    
    [SVProgressHUD showWithStatus:@"提交信息中..."];
    
    // 3秒后执行以下内容  模拟登陆
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if ([UserInfoManager.nickname isEqualToString:self.userModel.nickName]) {
            
            BOOL success = [self.avatarData writeToFile:self.userModel.avatar atomically:YES];
            if (success) {
                
                DONG_Log(@"头像写入成功");
            }
         
            // 更新数据库
            [DataBaseManager updateUserInfoWithUserModel:self.userModel];
            
            DismissHud();
            ShowMessage(@"修改成功");
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            
            if ([self.userModel.nickName isEqualToString:@"admin"]) {
                ShowMessage(@"不能使用该昵称！");
                return;
            }
            
            BOOL isExisted = [DataBaseManager queryUserIsExistedWithNickName:self.userModel];
            if (isExisted) {
                ShowMessage(@"用户已存在，请换个昵称试试！");
                return;
            }
            
            BOOL success = [self.avatarData writeToFile:self.userModel.avatar atomically:YES];
            if (success) {
                
                DONG_Log(@"头像写入成功");
            }
            
            // 更新数据库
            [DataBaseManager updateUserInfoWithUserModel:self.userModel];
            
            DismissHud();
            ShowMessage(@"修改成功");
            UserInfoManager.nickname = self.userModel.nickName;
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    });
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleDefault image:image];
    cropController.delegate = self;
    cropController.customAspectRatio = (CGSize){1.f, 1.f};
    
    cropController.onDidFinishCancelled = ^(BOOL isFinished) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    };
    // Uncomment this if you wish to provide extra instructions via a title label
    //cropController.title = @"Crop Image";
    
    // -- Uncomment these if you want to test out restoring to a previous crop setting --
    //cropController.angle = 90; // The initial angle in which the image will be rotated
    //cropController.imageCropFrame = CGRectMake(0,0,2848,4288); //The initial frame that the crop controller will have visible.
    
    // -- Uncomment the following lines of code to test out the aspect ratio features --
    //cropController.aspectRatioPreset = TOCropViewControllerAspectRatioPresetSquare; //Set the initial aspect ratio as a square
    cropController.aspectRatioLockEnabled = YES; // The crop box is locked to the aspect ratio and can't be resized away from it
    //cropController.resetAspectRatioEnabled = NO; // When tapping 'reset', the aspect ratio will NOT be reset back to default
    cropController.aspectRatioPickerButtonHidden = YES;
    
    // -- Uncomment this line of code to place the toolbar at the top of the view controller --
    //cropController.toolbarPosition = TOCropViewControllerToolbarPositionTop;
    
    //cropController.rotateButtonsHidden = YES;
    //cropController.rotateClockwiseButtonHidden = NO;
    
    cropController.doneButtonTitle = @"完成";
    cropController.cancelButtonTitle = @"取消";
    
    //If profile picture, push onto the same navigation stack
    [picker pushViewController:cropController animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -
#pragma mark TOCropViewControllerDelegate

- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    [self updateImageViewWithImage:image fromCropViewController:cropViewController];
}

- (void)updateImageViewWithImage:(UIImage *)image fromCropViewController:(TOCropViewController *)cropViewController
{
    
    [cropViewController dismissAnimatedFromParentViewController:self withCroppedImage:image toView:nil toFrame:CGRectZero setup:nil completion:^{
        
        NSString *doc = [FileManageCommon GetDocumentPath];
        [FileManageCommon CreateList:doc ListName:@"picture"];
        NSString *filePath = [doc stringByAppendingPathComponent:@"picture/avatarss.png"];
        DONG_Log(@"文件路径：%@", filePath);
        
        NSData *originData = UIImageJPEGRepresentation(image, 1.f);
        DONG_Log(@"%@",[NSString stringWithFormat:@"原数据大小:%.4f MB",((double)originData.length/1024.f/1024.f)]);
        DONG_Log(@"原数据尺寸: width:%f height:%f",image.size.width,image.size.height);
        
        // 图片压缩
        NSData *compressData = [image compressWithLengthLimit:30.f * 1024.f];
        self.avatarData = compressData;
        self.userModel.avatar = filePath;
        UIImage *compressImage = [UIImage imageWithData:compressData];
        DONG_Log(@"压缩数据尺寸: width:%f height:%f",compressImage.size.width, compressImage.size.height);
        DONG_Log(@"压缩数据大小:%.4f MB",(double)compressData.length/1024.f/1024.f);
        
        // 头像的临时显示
        SHB_MineInfoSection0Cell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.tempAvatarImage = compressImage;
        
    }];
}




/**
 展示图片库（从相册中选取、拍照）
 
 @param sourceType UIImagePickerController源
 */
- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *profilePicker = [[UIImagePickerController alloc] init];
    profilePicker.modalPresentationStyle = UIModalPresentationPopover;
    profilePicker.sourceType = sourceType;
    profilePicker.allowsEditing = NO;
    profilePicker.delegate = self;
    profilePicker.preferredContentSize = CGSizeMake(512.f, 512.f);
    profilePicker.popoverPresentationController.sourceView = self.view;
    
    [self presentViewController:profilePicker animated:YES completion:nil];
}


@end
