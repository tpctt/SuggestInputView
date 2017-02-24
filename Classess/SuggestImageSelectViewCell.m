//
//  SuggestImageSelectViewCell.m
//  KehuFox
//
//  Created by tim on 16/11/14.
//  Copyright © 2016年 timRabbit. All rights reserved.
//

#import "SuggestImageSelectViewCell.h"
@interface SuggestImageSelectViewCell()

@property (strong,nonatomic) UIButton *delBtn;

@end



@implementation SuggestImageSelectViewCell

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


-(void)setImage:(UIImage *)image
{
    if(_image == image) return;
    _image = image;
    
    [self.imageBtn setImage:_image forState:0];
    
}

-(void)setDelBtnImage:(UIImage *)delBtnImage
{
    if(_delBtnImage == delBtnImage) return;
    _delBtnImage = delBtnImage;
    
    [self.delBtn setImage:_delBtnImage forState:0];
    
    
    self.delBtn.hidden = (self.delBtnImage == nil);

    [self.delBtn sizeToFit];

    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageBtn.frame = self.bounds;
    
    self.delBtn.layer.position = CGPointMake(self.frame.size.width , 0);
    
    
    
}
///////////////////
-(void)commonInit{
    self.imageBtn = [[UIButton alloc] initWithFrame:self.frame];
    [self.contentView addSubview:self.imageBtn];
    [self.imageBtn setUserInteractionEnabled:NO];
    
    
    self.delBtn = [[UIButton alloc] init];
    [self addSubview:self.delBtn];
    [self.delBtn setUserInteractionEnabled:NO];
    
    
    self.delBtn.layer.anchorPoint = CGPointMake( 1, 0);
    
    
    
}
@end
