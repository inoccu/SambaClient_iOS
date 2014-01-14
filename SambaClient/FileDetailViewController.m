//
//  FileDetailViewController.m
//  SambaClient
//
//  Created by 井上 研一 on 2014/01/14.
//  Copyright (c) 2014年 Artisan Edge LLC. All rights reserved.
//

#import "FileDetailViewController.h"

#import "KxSMBProvider.h"

@interface FileDetailViewController ()

@end

@implementation FileDetailViewController

@synthesize textView = _textView;
@synthesize path = _path;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = self.path;
    
    KxSMBItemFile *file = [[KxSMBProvider sharedSmbProvider] fetchAtPath:self.path];
    NSData *data = [file readDataToEndOfFile];
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    self.textView.text = text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
