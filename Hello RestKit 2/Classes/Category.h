//
//  Category.h
//  Hello RestKit 2
//
//  Created by wangyongqi on 1/11/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Icon.h"

@interface Category : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pluralName;
@property (nonatomic, copy) NSString *shortName;
@property (nonatomic, strong) Icon *icon;
@property (nonatomic) bool *primary;


@end
