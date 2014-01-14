//
//  FileDetailViewController.h
//  SambaClient
//
//  Created by 井上 研一 on 2014/01/14.
//  Copyright (c) 2014年 Artisan Edge LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileDetailViewController : UIViewController
{
    UITextView *_textView;
    
    NSString *_path;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, copy) NSString *path;

@end
