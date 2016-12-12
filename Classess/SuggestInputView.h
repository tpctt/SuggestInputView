//
//  SuggestInputView.h
//  KehuFox
//
//  Created by tim on 16/11/14.
//  Copyright © 2016年 timRabbit. All rights reserved.
//

#import "UIViewWithNib.h"

/**
 获取意见反馈的数据

 @param text 文本内容
 @param imagesArray 图片数组
 */
typedef void(^SuggestInputBlock)(NSString *text , NSArray <UIImage *> * imagesArray );

@interface SuggestInputView : UIView
@property(assign,nonatomic) NSInteger maxPic;

@property(strong,nonatomic) UIImage *cameraBgIcon;

-(void)getSugeestInfo:(SuggestInputBlock)block;

@end
