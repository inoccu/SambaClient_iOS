//
//  EntriesTableViewController.m
//  SambaClient
//
//  Created by 井上 研一 on 2014/01/14.
//  Copyright (c) 2014年 Artisan Edge LLC. All rights reserved.
//

#import "EntriesTableViewController.h"
#import "FileDetailViewController.h"

#import "KxSMBProvider.h"

@interface EntriesTableViewController ()

@end

@implementation EntriesTableViewController

@synthesize tableView = _tableView;
@synthesize items = _items;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.items = [NSArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EntryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSLog(@"indexPath section:%i row:%i", indexPath.section, indexPath.row);

    KxSMBItemTree *tree = (KxSMBItemTree *)[self.items objectAtIndex:indexPath.row];
    
    cell.textLabel.text = tree.path;
    switch (tree.type) {
        case KxSMBItemTypeFile:
            cell.detailTextLabel.text = @"<File>";
            break;
        case KxSMBItemTypeDir:
            cell.detailTextLabel.text = @"<Dir>";
        default:
            break;
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"SelectFile"]) {
        UITableViewCell *cell = (UITableViewCell *)sender;
        
        FileDetailViewController *viewController = (FileDetailViewController *)[segue destinationViewController];
        viewController.path = cell.textLabel.text;
    }
}

- (void)clickLogin:(id)sender
{
    NSLog(@"clickLogin start");
    
    self.items = [[KxSMBProvider sharedSmbProvider] fetchAtPath:@"smb://10.10.1.1/mnt/sdb1"];
    NSLog(@"count: %d", [self.items count]);
    /**
    NSEnumerator *e = [self.items objectEnumerator];
    id object;
    while (object = [e nextObject]) {
        KxSMBItemTree *tree = (KxSMBItemTree *)object;
        NSLog(@"%@", [tree description]);
        if (tree.type == KxSMBItemTypeFile) {
            NSLog(@"File Path: %@", tree.path);
        }
    }
    */
    [self.tableView reloadData];
}

- (void)clickAddFile:(id)sender
{
    NSLog(@"clickAddFile start");

    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *contents = [NSString stringWithFormat:@"Add file test - %@", [formatter stringFromDate:now]];
    NSLog(@"contents: %@", contents);
    
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *newFilePath = [NSString stringWithFormat:@"smb://10.10.1.1/mnt/sdb1/test_%@.txt", [formatter stringFromDate:now]];
    
    NSData *data = [contents dataUsingEncoding:NSUTF8StringEncoding];
    
    KxSMBItemFile *file = (KxSMBItemFile *)[[KxSMBProvider sharedSmbProvider] createFileAtPath:newFilePath overwrite:YES];
    [file writeData:data];
}

@end
