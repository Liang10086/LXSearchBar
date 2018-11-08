//
//  LXSearchBar.m
//  test
//
//  Created by 王明亮 on 2018/11/8.
//  Copyright © 2018 王明亮. All rights reserved.
//

#import "LXSearchBar.h"
// icon 的宽度
static CGFloat const searchIconW = 20.0;
// icon与placeholder间距
static CGFloat const iconSpacing = 10.0;

@interface LXSearchBar()
@property (nonatomic, assign) CGFloat placeholderWidth;
@property (nonatomic, strong) UITextField *textField;
@end
@implementation LXSearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setHeight];
    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        [self setHeight];
    }
    return self;
}

- (void)setHeight{
    if (@available(iOS 11.0, *)) {
        [self.heightAnchor constraintEqualToConstant:44].active = YES;
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    for (int i = 0 ; i < self.subviews.count; i ++) {
        UIView *view = self.subviews[i];
        for (UIView *textView in view.subviews) {
            if ([textView isKindOfClass:[UITextField class]]) {
                self.textField = (UITextField *)textView;
            }
        }
    }
    if (self.cornerRadius) {
        self.textField.layer.cornerRadius = self.cornerRadius;
    }
    self.textField.layer.masksToBounds = YES;
    
    if (@available(iOS 11.0, *)) {
        CGRect frame = self.textField.frame;
        CGFloat top = 8;
        CGFloat bottom = top;
        CGFloat left = 12;
        CGFloat right = left;
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);

        CGFloat offsetX = frame.origin.x - insets.left;
        CGFloat offsetY = frame.origin.y - insets.top;
        frame.origin.x = insets.left;
        frame.origin.y = insets.top;
        frame.size.height += offsetY * 2;
        frame.size.width += offsetX * 2;

        self.textField.frame = frame;
    }
    if (self.isTextCenter) {
        [self setPositionAdjustment:UIOffsetMake((self.textField.frame.size.width - self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        [self.delegate searchBarShouldBeginEditing:self];
    }
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
  
    if ([self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
     
        [self.delegate searchBarShouldEndEditing:self];

    }

    if (@available(iOS 11.0, *)) {
        if (self.isTextCenter) {
            [self setPositionAdjustment:UIOffsetMake((textField.frame.size.width - self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
        }
    }
    return YES;
}

#pragma mark 懒加载
- (CGFloat)placeholderWidth {
    if (!_placeholderWidth) {
        CGSize size = [self.placeholder boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.textField.font} context:nil].size;
        _placeholderWidth = size.width + iconSpacing + searchIconW;
    }
    return _placeholderWidth;
}

@end
