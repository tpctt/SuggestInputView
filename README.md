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
@property(assign,nonatomic) NSInteger maxPic;///最大图片数量

@property(strong,nonatomic) UIImage *cameraBgIcon;///添加图片的按钮的image

-(void)getSugeestInfo:(SuggestInputBlock)block;//获取文本和图片

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
@property(strong,nonatomic) UIImage *cameraBgIcon;///相机图片
@property(strong,nonatomic) UIImage *delBtnImage;//删除图片的按钮的image

///item 的间距
@property(assign,nonatomic) CGFloat itemSpace;
///item 高度
@property(assign,nonatomic) CGFloat itemHeight;


@property(assign,nonatomic) NSInteger maxPic;//最大图片数量
@property(assign,nonatomic) NSInteger numberOfRow;//一行几个图片



@property(copy,nonatomic) SuggestImageTapImageBlock tapImageBlock;
@property(copy,nonatomic) SuggestImageSetImageBlock setImageBlock;
@property (strong,nonatomic) NSMutableArray *currectImageArray;//当前image/url 的数组


-(void)addImages:(NSArray*)images;//添加图片
-(void)deleteImageAtIndex:(NSInteger)index;//删除图片


-(NSArray *)getImages;//获取全部图片
-(CGSize)getItemSize;//获取 item 大小
-(CGFloat)getCollectViewFitSize;//获取 collectionView 的fit高度


@end

````

设置图片/点击图片的代码,可直接使用
````
{
        @weakify(self);
        self.suggestImageSelectView.setImageBlock = ^UIImage *(NSIndexPath *path , UIButton *imageBtn){
            
            @strongify(self);
            
            
            id image = [self.suggestImageSelectView.currectImageArray objectAtIndex:path.row];
            
            if ([image isKindOfClass:[UIImage class]]) {
                return image;
                
            }else if ([image isKindOfClass:[NSString class]]){
                [imageBtn sd_setImageWithURL:[NSURL URLWithString:image] forState:0 placeholderImage:[UIImage imageNamed:@"default_banner"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                }];
            }else{
                return [UIImage imageNamed:@"default_banner"];
                
            }
            
            return nil;
            
            
        };
        
        self.suggestImageSelectView.tapImageBlock = ^(NSIndexPath *path , UIImage *image, UIButton *btn){
            //datu
            @strongify(self);
            
            NSMutableArray* tmps = [[NSMutableArray alloc] init];
                for (NSInteger i = 0; i < self.obj.picture_list.count; i ++) {
                    TQBCommentImageObject * imgObj = [self.obj.picture_list safeObjectAtIndex:i];
                        LWImageBrowserModel* model = [[LWImageBrowserModel alloc] initWithplaceholder:[UIImage imageNamed:@"default_banner"]
                                                                                                 thumbnailURL:[NSURL URLWithString:imgObj.url]
                                                                                                        HDURL:[NSURL URLWithString:imgObj.url]
                                                                                                containerView:self.contentView
                                                                                          positionInContainer: CGRectMake(K_DEVICE_WIDTH/2,K_DEVICE_HEIGHT/2 -32, 10, 10)
                                                                                                             index:path.row];
                        [tmps addObject:model];
                }
            
            LWImageBrowser* browser = [[LWImageBrowser alloc] initWithImageBrowserModels:tmps currentIndex:path.row];
    
            self.detailView = [[TQBCommentDetailView  alloc] initWithCommentObject:self.obj];
            
            [RACObserve(self.detailView, prise) subscribeNext:^(id x) {
                @strongify(self);

                if (![x boolValue]) {
                    return ;
                }
                if (![TQBUserObject isLoged]) {
                    ///避免收藏也会弹出提示申请窗
                    [[Config sharedInstance]gotoLogin ];
                    
                }else{
                    
                    self.praiseVM.id = self.obj.id;
                    [self.praiseVM.command execute:nil];
                    
                }
            }];
            
            browser.detailView = self.detailView;
            browser.isShowPageControl = NO;
            [browser show];


        };
        

        self.suggestImageSelectView.cameraBgIcon = nil;

        
    }

````

