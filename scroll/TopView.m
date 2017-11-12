//
//  TopView.m
//  scroll
//
//  Created by 刘雨轩 on 2017/11/12.
//  Copyright © 2017年 laiwang. All rights reserved.
//

#import "TopView.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>
#import "MyButton.h"

@implementation NoResponseView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	UIView *view = [super hitTest:point withEvent:event];
	if ([view isEqual:self]) {
		return nil;
	} else {
		return view;
	}
}
@end

@interface TopView ()
@property (nonatomic, strong) NoResponseView *view0;
@property (nonatomic, strong) NoResponseView *view1;
@property (nonatomic, strong) MyButton *btn;
@end

@implementation TopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init {
	if (self = [super init]) {
		self.view0 = [[NoResponseView alloc] init];
		_view0.backgroundColor = [UIColor purpleColor];
		[self addSubview:_view0];
		[_view0 makeConstraints:^(MASConstraintMaker *make) {
			make.top.left.right.equalTo(self);
			make.height.equalTo(150);
		}];

		self.view1 = [[NoResponseView alloc] init];
		_view1.backgroundColor = [UIColor yellowColor];
		[self addSubview:_view1];
		[_view1 makeConstraints:^(MASConstraintMaker *make) {
			make.bottom.left.right.equalTo(self);
			make.height.equalTo(100);
		}];
		
		self.btn = [MyButton buttonWithType:UIButtonTypeCustom];
		_btn.userInteractionEnabled = NO;
		[_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
		[_btn setTitle:@"btn" forState:UIControlStateNormal];
		[_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		_btn.backgroundColor = [UIColor whiteColor];
		[_view1 addSubview:_btn];
		[_btn makeConstraints:^(MASConstraintMaker *make) {
			make.center.equalTo(_view1);
			make.width.equalTo(50);
			make.height.equalTo(50);
		}];
	}
	return self;
}

- (void)didTapWithPoint:(CGPoint)point {
	if (CGRectContainsPoint(_btn.bounds, [_btn convertPoint:point fromView:self])) {
		[_btn sendActionsForControlEvents:UIControlEventTouchUpInside];
	}
}

- (void)btnClick:(UIButton *)sender {
	NSLog(@"click");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	NSLog(@"began");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	NSLog(@"move");
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//	NSLog(@"%ld,%ld,count:%ld,%@",event.type,event.subtype,event.allTouches.count,NSStringFromClass([[event.allTouches anyObject].gestureRecognizers[0] class]));
	UIView *view = [super hitTest:point withEvent:event];
	if ([view isEqual:self]) {
//		CGPoint buttonPoint = [view convertPoint:point fromView:self];
//		if (CGRectContainsPoint(_btn.bounds, buttonPoint)) {
//			[_btn sendActionsForControlEvents:UIControlEventTouchUpInside];
//		}
		return nil;
	} else {
		return view;
	}
}

@end
