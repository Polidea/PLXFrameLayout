//
//  ListViewController.m
//  FrameLayoutTestApp
//
//  Created by Pawel Scibek on 01/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"
#import "EdgeAlignmentView.h"
#import "RowAlignmentView.h"
#import "RowColsArrangementView.h"
#import "SampleAppView.h"

static NSString *const kMenuItemTitle = @"MenuItemKeyLabel";
static NSString *const kMenuItemClassName = @"MenuItemKeyClassName";
static NSString *const CellReuseIdentifier = @"CellReuseIdentifier";

@implementation ListViewController {
    NSArray *_menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Frame Layout";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];

    _menuItems = @[
            @{kMenuItemTitle : @"Simple Edge Alignment", kMenuItemClassName : NSStringFromClass([EdgeAlignmentView class])},
            @{kMenuItemTitle : @"Rows & Cols Alignment", kMenuItemClassName : NSStringFromClass([RowAlignmentView class])},
            @{kMenuItemTitle : @"Rows & Cols Arangement", kMenuItemClassName : NSStringFromClass([RowColsArrangementView class])},
            @{kMenuItemTitle : @"Sample App Layout", kMenuItemClassName : NSStringFromClass([SampleAppView class])}
    ];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _menuItems[(NSUInteger) indexPath.row][kMenuItemTitle];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *viewClassName = _menuItems[(NSUInteger) indexPath.row][kMenuItemClassName];
    Class viewClass = NSClassFromString(viewClassName);

    UIView *mainView = (id) [viewClass new];
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithMainView:mainView];
    detailViewController.title = _menuItems[(NSUInteger) indexPath.row][kMenuItemTitle];

    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
