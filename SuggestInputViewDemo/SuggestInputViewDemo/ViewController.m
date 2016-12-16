//
//  ViewController.m
//  SuggestInputViewDemo
//
//  Created by tim on 16/12/12.
//  Copyright © 2016年 timRabbit. All rights reserved.
//

#import "ViewController.h"
#import "SuggestInputView.h"

@interface ViewController ()
@property (strong,nonatomic) SuggestInputView *suggestInputView;

@end

@implementation ViewController
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.suggestInputView setNeedsLayout];
    [self.suggestInputView layoutIfNeeded];
   

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.suggestInputView = [[SuggestInputView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.suggestInputView];   
    
    UIImage *image = [UIImage imageNamed:@"cameraIcon"];
    self.suggestInputView.cameraBgIcon = image;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

