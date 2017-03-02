//
//  SuggestInputView.m
//  KehuFox
//
//  Created by tim on 16/11/14.
//  Copyright © 2016年 timRabbit. All rights reserved.
//

#import "SuggestInputView.h"
#import "SuggestImageSelectView.h"

@interface SuggestInputView()
@property (strong , nonatomic ) UITextView *textView;
@property (strong , nonatomic ) SuggestImageSelectView *imagesView;

 

@end

@implementation SuggestInputView

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
    
//    [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self  options:nil];
//    
//    [self addSubview:self.view];
//    
//    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(self.mas_top);
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.bottom.equalTo(self.mas_bottom);
//        
//        
//    }];
    
    [self subCommonInit];
    
    
    NSBundle *bundle = [NSBundle mainBundle];
//    bundle = [NSBundle bundleWithIdentifier:@"com.inwhoop.chuanchuan.SuggestInputViewBundle"];
    bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"SuggestInputViewBundle2" ofType:@"bundle"]];

    
    NSString *file = [bundle pathForResource:@"cameraIcon" ofType:@"tiff"];
//    NSString *file = [bundle pathForResource:@"cameraIcon@2x" ofType:@"png"];
    
    self.cameraBgIcon = [[UIImage imageWithContentsOfFile:file] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGFloat h = [self.imagesView getCollectViewFitSize];
    
    self.textView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 20 - h);
    
    
    self.imagesView.frame = CGRectMake(0, self.frame.size.height - 10 - h , self.frame.size.width, h );
    
    
    
    
    
}
-(void)subCommonInit
{
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.textView .font = [UIFont systemFontOfSize:15];
    
    self.imagesView = [[SuggestImageSelectView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    [self addSubview:self.textView];
    [self addSubview:self.imagesView];
    
    
    
}
-(void)setCameraBgIcon:(UIImage *)cameraBgIcon
{
    [self.imagesView setCameraBgIcon:cameraBgIcon];
    
}
-(void)getSugeestInfo:(SuggestInputBlock)block
{
    block(self.textView.text , [self.imagesView getImages].mutableCopy);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
