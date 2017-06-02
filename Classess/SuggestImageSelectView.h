//
//  SuggestImageSelectView.h
//  KehuFox
//
//  Created by tim on 16/11/14.
//  Copyright © 2016年 timRabbit. All rights reserved.
//

#import <UIKit/UIKit.h>
///点击图片
typedef void (^SuggestImageTapImageBlock)(NSIndexPath *path , UIImage *image,UIButton *imageBtn);
///设置图片
typedef UIImage *(^SuggestImageSetImageBlock)(NSIndexPath *path ,UIButton *imageBtn );


@interface SuggestImageSelectView : UIView

@property (strong,nonatomic) UICollectionView *collectView;

@property(assign,nonatomic) BOOL hideCameraBtn;
@property(strong,nonatomic) UIImage *cameraBgIcon;
@property(strong,nonatomic) UIImage *delBtnImage;

///item 的间距
@property(assign,nonatomic) CGFloat itemSpace;


@property(assign,nonatomic) NSInteger maxPic;
@property(assign,nonatomic) NSInteger numberOfRow;



@property(copy,nonatomic) SuggestImageTapImageBlock tapImageBlock;
@property(copy,nonatomic) SuggestImageSetImageBlock setImageBlock;
@property (strong,nonatomic) NSMutableArray *currectImageArray;


-(void)addImages:(NSArray*)images;
-(void)deleteImageAtIndex:(NSInteger)index;


-(NSArray *)getImages;
-(CGSize)getItemSize;
-(CGFloat)getCollectViewFitSize;


@end
