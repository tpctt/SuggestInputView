# SuggestInputView
SuggestInputView 常见的意见反馈部分的代码封装,支持图片和文本输入 
 

````objectivec
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
````


![img1](https://github.com/tpctt/SuggestInputView/tree/master/img/1.png)
![img2](https://github.com/tpctt/SuggestInputView/tree/master/img/2.png)

