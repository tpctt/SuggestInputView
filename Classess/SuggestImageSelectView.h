//
//  SuggestImageSelectView.h
//  KehuFox
//
//  Created by tim on 16/11/14.
//  Copyright © 2016年 timRabbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuggestImageSelectView : UIView

@property (strong,nonatomic) UICollectionView *collectView;
@property(strong,nonatomic) UIImage *cameraBgIcon;
///item 的间距
@property(assign,nonatomic) CGFloat itemSpace;


@property(assign,nonatomic) NSInteger maxPic;
@property(assign,nonatomic) NSInteger numberOfRow;

-(void)addImages:(NSArray*)images;
-(void)deleteImageAtIndex:(NSInteger)index;


-(NSArray *)getImages;
-(CGSize)getItemSize;
-(CGFloat)getCollectViewFitSize;


@end
