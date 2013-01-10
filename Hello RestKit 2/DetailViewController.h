//
//  DetailViewController.h
//  Hello RestKit 2
//
//  Created by wangyongqi on 1/10/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
