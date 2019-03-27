//
//  SHB_PublishBookVC.m
//  Second-hand books
//
//  Created by yesdgq on 2019/3/27.
//  Copyright © 2019 Yufei_Li. All rights reserved.
//

#import "SHB_PublishBookVC.h"
#import "TOCropViewController.h"
#import "SHB_GoodsModel.h"

@interface SHB_PublishBookVC () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, TOCropViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *bookNameTF;
@property (weak, nonatomic) IBOutlet UIImageView *bookCoverIV;
@property (weak, nonatomic) IBOutlet UITextField *authorTF;
@property (weak, nonatomic) IBOutlet UITextField *prviceTF;
@property (weak, nonatomic) IBOutlet UITextView *bookIntroductionTV;
@property (nonatomic, strong) NSData *compressData;


@end

@implementation SHB_PublishBookVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发布";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F0F0F6"];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadBookCoverImage:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.bookCoverIV addGestureRecognizer:tapGesture];
    self.bookCoverIV.userInteractionEnabled = YES;
   
}

// 轻击手势触发方法
- (void)uploadBookCoverImage:(UITapGestureRecognizer *)sender {
    
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
    

    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)publishBook:(id)sender {
    
    if (self.compressData == nil) {
        ShowMessage(@"请选择书的封面图片");
        return;
    }
    
    if (self.bookNameTF.text.length == 0) {
        ShowMessage(@"请填写书的名称");
        return;
    }
    
    if (self.authorTF.text.length == 0) {
        ShowMessage(@"请填写书的作者");
        return;
    }
    
    if (self.prviceTF.text.length == 0) {
        ShowMessage(@"请填写书的价格");
        return;
    }
    
    [SVProgressHUD showWithStatus:@"信息提交中..."];
    
    // 格林尼治时间
    NSDate *date = [NSDate date];
    // 格式化日期格式
    NSDateFormatter *formatter = [NSDateFormatter new];
    // 设置显示的格式
    [formatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];
    NSString *timeStr = [formatter stringFromDate:date];
    
    // 图片保存路径
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *timeStr2 = [formatter stringFromDate:date];
    NSString *doc = [FileManageCommon GetDocumentPath];
    [FileManageCommon CreateList:doc ListName:@"picture"];
    NSString *fileName = [NSString stringWithFormat:@"picture/%@%@", self.bookNameTF.text, timeStr2];
    NSString *filePath = [doc stringByAppendingPathComponent:fileName];
    
    BOOL success = [self.compressData writeToFile:filePath atomically:YES];
    if (success) {
        
        DONG_Log(@"图片写入成功 filePath：%@", filePath);
    }
    
    // 3秒后执行以下内容  模拟登陆
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        DismissHud();
        
        //        BOOL isExisted = [DataBaseManager queryUserIsExistedWithNickName:self.userModel];
        //        if (isExisted) {
        //            ShowMessage(@"用户已存在，请换个昵称试试！");
        //            return;
        //        }
        
        ShowMessage(@"发布成功");
        
        [self.navigationController popViewControllerAnimated:YES];
        
    });
    
   
    SHB_GoodsModel *goodsModel = [[SHB_GoodsModel alloc] init];
    goodsModel.bookName = self.bookNameTF.text;
    goodsModel.author = self.authorTF.text;
    goodsModel.price  = self.prviceTF.text;
    goodsModel.introduction = self.bookIntroductionTV.text;
    goodsModel.publishTime = timeStr;
    goodsModel.coverImage = filePath;
    
    
    
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleDefault image:image];
    cropController.delegate = self;
    cropController.onDidFinishCancelled = ^(BOOL isFinished) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    };
    // Uncomment this if you wish to provide extra instructions via a title label
    //cropController.title = @"Crop Image";
    
    // -- Uncomment these if you want to test out restoring to a previous crop setting --
    //cropController.angle = 90; // The initial angle in which the image will be rotated
    //cropController.imageCropFrame = CGRectMake(0,0,2848,4288); //The initial frame that the crop controller will have visible.
    
    // -- Uncomment the following lines of code to test out the aspect ratio features --
    cropController.aspectRatioPreset = TOCropViewControllerAspectRatioPresetOriginal; //Set the initial aspect ratio as a square
    cropController.aspectRatioLockEnabled = NO; // The crop box is locked to the aspect ratio and can't be resized away from it
    //cropController.resetAspectRatioEnabled = NO; // When tapping 'reset', the aspect ratio will NOT be reset back to default
    //    cropController.aspectRatioPickerButtonHidden = YES;
    
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
        
       

        NSData *originData = UIImageJPEGRepresentation(image, 1.f);
        DONG_Log(@"%@",[NSString stringWithFormat:@"原数据大小:%.4f MB",((double)originData.length/1024.f/1024.f)]);
        DONG_Log(@"原数据尺寸: width:%f height:%f",image.size.width,image.size.height);

        // 图片压缩
        NSData *compressData = [image compressWithLengthLimit:200 * 1024];
        //UIImage *compressImage = [UIImage imageWithData:compressData];
        //DONG_Log(@"压缩数据尺寸: width:%f height:%f",compressImage.size.width, compressImage.size.height);
        DONG_Log(@"压缩数据大小:%.4f MB",(double)compressData.length/1024.f/1024.f);
        self.compressData = compressData;
        [self.bookCoverIV setImage:image];
        [self.bookCoverIV setContentMode:UIViewContentModeScaleAspectFit];
       
        
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
