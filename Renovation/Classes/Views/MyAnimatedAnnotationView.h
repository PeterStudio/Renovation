//
//  MyAnimatedAnnotationView.h
//  IphoneMapSdkDemo
//
//  Created by wzy on 14-11-27.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <BaiduMapAPI/BMKAnnotationView.h>
#import "CustomAnnotation.h"

@protocol MyAnimatedAnnotationViewDelegate <NSObject>

- (void)showMsgWithAnonotation:(CustomAnnotation *)annotation;
@end

@interface MyAnimatedAnnotationView : BMKAnnotationView

@property (nonatomic, assign) id<MyAnimatedAnnotationViewDelegate> delegate;
@property (nonatomic, strong) CustomAnnotation * customAnnotation;

@property (nonatomic, strong) NSMutableArray *annotationImages;
@property (nonatomic, strong) UIImageView *annotationImageView;

@end
