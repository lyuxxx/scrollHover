//
//  ViewController.m
//  scroll
//
//  Created by 刘雨轩 on 2017/11/12.
//  Copyright © 2017年 laiwang. All rights reserved.
//

#import "ViewController.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>
#import <NSObject+FBKVOController.h>
#import "TopView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) TopView *topView;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	self.scroll = ({
		UIScrollView *scroll = [[UIScrollView alloc] init];
		if (@available(iOS 11.0, *)) {
			scroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
		} else {
			// Fallback on earlier versions
		}
		scroll.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
		scroll.scrollIndicatorInsets = UIEdgeInsetsMake(250, 0, 0, 0);
		[self.view addSubview:scroll];
		[scroll makeConstraints:^(MASConstraintMaker *make) {
			make.edges.equalTo(self.view).offset(UIEdgeInsetsMake(64, 0, 0, 0));
		}];
		
		UIView *content = [[UIView alloc] init];
		content.backgroundColor = [UIColor redColor];
		[scroll addSubview:content];
		[content makeConstraints:^(MASConstraintMaker *make) {
			make.edges.equalTo(scroll);
			make.width.equalTo(kScreenWidth);
			make.height.equalTo(kScreenHeight + 1000);
		}];
		
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
		[scroll addGestureRecognizer:tap];
		
		scroll;
		
	});
	
	self.topView = [[TopView alloc] init];
	[self.view addSubview:_topView];
	[_topView makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.view).offset(64);
		make.left.right.equalTo(self.view);
		make.height.equalTo(250);
	}];
	
	[self.KVOController observe:self.scroll keyPath:@"contentOffset" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
		CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
//		NSLog(@"%@",NSStringFromCGPoint(offset));
		CGFloat newOffset = offset.y + 250;
		if (offset.y >= -100) {
			[_topView updateConstraints:^(MASConstraintMaker *make) {
				make.top.equalTo(-150 + 64);
			}];
		} else {
			[_topView updateConstraints:^(MASConstraintMaker *make) {
				make.top.equalTo(-newOffset + 64);
			}];
		}
	}];
}

- (void)didTap:(UITapGestureRecognizer *)sender {
	NSLog(@"scroll Tap %@",NSStringFromCGPoint([sender locationInView:_topView]));
	[self.topView didTapWithPoint:[sender locationInView:_topView]];
}

@end
