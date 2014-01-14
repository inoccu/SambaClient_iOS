//
//  EntriesTableViewController.h
//  SambaClient
//
//  Created by 井上 研一 on 2014/01/14.
//  Copyright (c) 2014年 Artisan Edge LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntriesTableViewController : UITableViewController
{
    UITableView *_tableView;
    
    NSArray *_items;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *items;

- (IBAction)clickLogin:(id)sender;

@end
