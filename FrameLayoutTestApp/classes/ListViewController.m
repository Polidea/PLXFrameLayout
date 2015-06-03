//
//  ListViewController.m
//  FrameLayoutTestApp
//
//  Created by Pawel Scibek on 01/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"
#import "EdgeAlignment.h"

static NSString *const MenuItemKey_Label        = @"MenuItemKey_Label";
static NSString *const MenuItemKey_ClassName    = @"MenuItemKey_ClassName";

static NSString *const CellReuseIdentifier      = @"CellReuseIdentifier";



@implementation ListViewController{
    NSArray *_menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Frame Layout";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier];
    
    _menuItems = @[@{MenuItemKey_Label: @"Simple Edge Alignment", MenuItemKey_ClassName: @"EdgeAlignment"},
                   @{MenuItemKey_Label: @"Rows & Cols Alignment", MenuItemKey_ClassName: @"RowAlignment"},
                   @{MenuItemKey_Label: @"Rows & Cols Arangement", MenuItemKey_ClassName: @"RowColsArrangement"},
                   @{MenuItemKey_Label: @"Sample App Layout", MenuItemKey_ClassName: @"SampleApp"}];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _menuItems[indexPath.row][MenuItemKey_Label];
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *viewClassName = _menuItems[indexPath.row][MenuItemKey_ClassName];
    Class viewClass = NSClassFromString(viewClassName);

    UIView *mainView = [[viewClass alloc] initWithFrame:CGRectZero];
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithMainView:mainView];
    detailViewController.title = _menuItems[indexPath.row][MenuItemKey_Label];

    [self.navigationController pushViewController:detailViewController animated:YES];
}



@end
