//
//  DetailViewController.m
//  FrameLayoutTestApp
//
//  Created by Pawel Scibek on 02/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController {
    UIView *_mainView;
}

- (instancetype)initWithMainView:(UIView *)mainView {
    self = [super init];
    if (self) {
        _mainView = mainView;
    }
    return self;
}

- (void)loadView {
    NSAssert(_mainView, @"MainView cannot be nil, use -initWithMainView: initializer.");
    self.view = _mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
}

@end
