//
//  Venue.h
//  Hello RestKit 2
//
//  Created by wangyongqi on 1/11/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "Stats.h"
#import "Likes.h"
#import "Specials.h"
#import "HereNow.h"

@interface Venue : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) id contact;
@property (nonatomic, strong) Location *location;
@property (nonatomic, copy) NSString *canonicalUrl;
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic) bool verified;
@property (nonatomic) bool restricted;
@property (nonatomic, strong) Stats *stats;
@property (nonatomic, strong) Likes *likes;
@property (nonatomic, strong) Specials *specials;
@property (nonatomic, strong) HereNow *hereNow;
@property (nonatomic, copy) NSString *referralId;

@end
