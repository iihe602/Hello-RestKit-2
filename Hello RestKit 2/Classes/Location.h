//
//  Location.h
//  Hello RestKit 2
//
//  Created by wangyongqi on 1/11/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (nonatomic, copy) NSString *address;
@property (nonatomic) float lat;
@property (nonatomic) float lng;
@property (nonatomic) int distance;

@property (nonatomic, copy) NSString *postalCode;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *cc;

@end
