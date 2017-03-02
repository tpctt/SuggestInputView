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

 <br>
<br>![](https://github.com/tpctt/SuggestInputView/blob/master/img/1.png)
 ![](https://github.com/tpctt/SuggestInputView/blob/master/img/2.png)


也支持独立 图片选择部分出来


````objectivec
///点击图片
typedef void (^SuggestImageTapImageBlock)(NSIndexPath *path , UIImage *image,UIButton *imageBtn);
///设置图片
typedef UIImage *(^SuggestImageSetImageBlock)(NSIndexPath *path ,UIButton *imageBtn );


@interface SuggestImageSelectView : UIView

@property (strong,nonatomic) UICollectionView *collectView;
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

````
