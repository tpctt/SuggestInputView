//
//  SuggestImageSelectView.m
//  KehuFox
//
//  Created by tim on 16/11/14.
//  Copyright © 2016年 timRabbit. All rights reserved.
//

#import "SuggestImageSelectView.h"
#import "SuggestImageSelectViewCell.h"

#import "ZLPhotoActionSheet.h"
#import "ZLShowBigImgViewController.h"


@interface SuggestImageSelectView ()
<UICollectionViewDataSource , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout   , UIActionSheetDelegate >

@property (strong,nonatomic) NSMutableArray *lastSelectMoldels;
@property (assign,nonatomic) NSInteger willOprationImageIndex;

@end

@implementation SuggestImageSelectView
-(NSArray *)getImages
{
    return self.currectImageArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
        
        
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        
    }
    return self;
}

-(void)awakeFromNib
{
    
    [super awakeFromNib];
    
    
    [self commonInit];
    
    
}




///////////////////
-(void)commonInit{
    self.maxPic = 9;
    self.numberOfRow = 4;
    self.itemSpace = 5;
    
    self.currectImageArray = [NSMutableArray array];
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
    
    self.collectView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
    
   
    [self.collectView registerClass:[SuggestImageSelectViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SuggestImageSelectViewCell class])];
    [self addSubview:self.collectView];

    self.collectView.dataSource = self;
    self.collectView.delegate = self;
    self.collectView.backgroundColor = [UIColor whiteColor];
    
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews]  ;
    
    self.collectView.frame = self.bounds;

    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectView.collectionViewLayout;
    
    
    layout.itemSize = [self getItemSize];
    layout.minimumInteritemSpacing = self.itemSpace;
    layout.minimumLineSpacing = self.itemSpace;
    
    
    
}

-(CGSize)getItemSize
{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectView.collectionViewLayout;
    UIEdgeInsets inset =  layout.sectionInset ;

    
    CGFloat itemW = ((self.frame.size.width -inset.left -inset.right) - (self.numberOfRow -1 ) * self.itemSpace) / self.numberOfRow ;
    itemW = floorf(itemW) - 0 ;
    return CGSizeMake(itemW, itemW);;
    
}
-(CGFloat)getCollectViewFitSize
{
    
    NSInteger totolNum = self.currectImageArray.count;
    if (totolNum < self.maxPic) {
        if (self.hideCameraBtn == NO) {
            totolNum += 1;
        }
    }
    
    
    NSInteger rows = totolNum/self.numberOfRow + ((totolNum%self.numberOfRow )>0?1:0);
    CGFloat rowH = [self getItemSize].height;
    rowH = ceil(rowH)  ;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectView.collectionViewLayout;
    UIEdgeInsets inset =  layout.sectionInset ;
    CGFloat totalHeight = rowH * rows + (rows - 1) *self.itemSpace + inset.top + inset.bottom;
    
    return totalHeight;
//    
//    if (self.currectImageArray.count > self.numberOfRow) {
//        CGFloat rowH = 2 *[self getItemSize].height;
//        
//        rowH += self.itemSpace *(self.currectImageArray.count/self.numberOfRow + 4);
//        
//        return rowH  ;
//    }
//    return [self getItemSize].height;
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.currectImageArray.count >= self.maxPic){
        return self.currectImageArray.count;
    }
    
    return self.currectImageArray.count + (self.hideCameraBtn?0:1);

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SuggestImageSelectViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SuggestImageSelectViewCell class]) forIndexPath:indexPath];
    
    UIImage * image = nil;
    if(indexPath.row < self.currectImageArray.count){
        
        cell.delBtnImage = self.delBtnImage;

        if(self.setImageBlock){
            image = self.setImageBlock(indexPath,cell.imageBtn);
            
        }else{
            image = [self.currectImageArray objectAtIndex:indexPath.row];
            
        }

        if (image) {
            cell.image = image;
        }
        
        
    }else{
        image = self.cameraBgIcon;

        cell.delBtnImage = nil;
        cell.image = image;

    }
    
//    if(!image){
//        image = self.cameraBgIcon;
//    }
    
    
//    cell.image = image;
    
    
    
    return cell;
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.currectImageArray.count >= self.maxPic){
        [self tapImage:indexPath];
        
    }else {
        
        if( indexPath.row >= self.currectImageArray.count  ){
            [self tapAddImageView:[collectionView cellForItemAtIndexPath:indexPath]];

        }else{
            [self tapImage:indexPath];
            
        }
    }
}


-(void)tapImage:(NSIndexPath *)indexPath
{
    
    self.willOprationImageIndex = indexPath.row;
    

    if (self.tapImageBlock) {
        SuggestImageSelectViewCell *cell  = [self.collectView cellForItemAtIndexPath:indexPath];
        UIButton *btn = nil;
        if (cell) {
            btn = cell.imageBtn;
        }
        self.tapImageBlock(indexPath,nil,btn);
        return;
    }

//    UIActionSheet *sheet =  [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消"  destructiveButtonTitle:nil otherButtonTitles:@"查看大图",@"删除", nil];
    UIActionSheet *sheet =  [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消"  destructiveButtonTitle:nil otherButtonTitles:@"删除", nil];
    [sheet showInView:self];

    
    
    
}
-(void)addImages:(NSArray*)images
{
//    self.currectImageArray = images.mutableCopy;
    
    [self.currectImageArray addObjectsFromArray:images.mutableCopy];

//    [self.currectImageArray addObjectsFromArray:images];
//    if(self.currectImageArray.count > self.maxPic){
//        [self.currectImageArray removeObjectsInRange:NSMakeRange(self.maxPic, self.currectImageArray.count - self.maxPic)];
//    }
//    

    [self.collectView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.collectView .contentOffset = CGPointMake(0, self.collectView.contentSize.height - self.frame.size.height);
        if(self.collectView.contentOffset.x < 0 ||
           self.collectView.contentOffset.y < 0
           ){
            self.collectView .contentOffset = CGPointMake(0,0);

        }
        [self.superview setNeedsLayout];
        [self.superview layoutIfNeeded];
        
        
    });
    
    
//    [self.collectView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:[self.collectView numberOfItemsInSection:0] inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
    
    
}

-(void)tapAddImageView:(UIView*)view {
    
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置最大选择数量
    actionSheet.maxSelectCount = self.maxPic;
    //设置预览图最大数目
    actionSheet.maxPreviewCount = 20;
    
    
    [actionSheet showPreviewPhotoWithSender:[UIApplication sharedApplication].keyWindow.rootViewController animate:YES lastSelectPhotoModels:nil completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
        // your codes...
        
        [self addImages:selectPhotos];
//        self.lastSelectMoldels = selectPhotoModels.mutableCopy;
        
        
    }];
    
    

//    
//    [actionSheet showPreviewPhotoWithSender:[UIApplication sharedApplication].keyWindow.rootViewController animate:YES lastSelectPhotoModels:self.lastSelectMoldels completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
//        // your codes...
//        
//        [self addImages:selectPhotos];
//        self.lastSelectMoldels = selectPhotoModels.mutableCopy;
//        
//        
//    }];
//    
   


    
    
}
-(void)deleteImage:(UIImage*)image
{
    [self.currectImageArray removeObject:image];
    [self.collectView reloadData];
    
}
-(void)deleteImageAtIndex:(NSInteger)index{
    if(self.currectImageArray.count > index){
        
        [self.currectImageArray removeObjectAtIndex:index];
//        [self.lastSelectMoldels removeObjectAtIndex:index];
   
        [self.collectView reloadData];
   
    }
    
}
-(void)viewBigImage:(NSInteger )index
{
//    UIImage *image =[self.currectImageArray objectAtIndex:index];
    
//    ZLShowBigImgViewController *vc = [[ZLShowBigImgViewController alloc ] init];
//    
//    vc.arraySelectPhotos = self.lastSelectMoldels;
//    vc.selectIndex = index;
//    
//    UIResponder *vc11 = self;
//    while (1) {
//        if([vc11 isKindOfClass:[UIViewController class]] ) break;
//        vc11 = vc11.nextResponder;
//        
//    }
//    
//    UIViewController *baseVCC = vc11;
//    [baseVCC.navigationController pushViewController:vc animated:1];
    
    
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSLog(@"%d",buttonIndex);
    if(buttonIndex == 0){
        ///大图
//        [self viewBigImage:self.willOprationImageIndex];
        //删除
        [self deleteImageAtIndex:self.willOprationImageIndex];

    }else if(buttonIndex == 1){
        
        ///取消
        
    }else if(buttonIndex == 2){
        
        
    }
}

#pragma mark setter-getter


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
