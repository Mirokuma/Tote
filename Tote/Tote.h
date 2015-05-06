//
//  Tote.h
//  ToTe
//
//  Created by Jittapoo Kongthip on 4/25/2558 BE.
//  Copyright (c) 2558 Jittapoo Kongthip. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Tote : NSObject

@property (nonatomic, strong) NSString *name; // name
@property (nonatomic, strong) NSString *section; // sec
@property (nonatomic, strong) NSString *soi; // soi
@property (nonatomic, strong) PFFile *imageFile; // image
@property (nonatomic, strong) NSArray *etc; // detail
@property (nonatomic, strong) NSString *Type; // contact

-(id)initWithPFObject:(PFObject *)object;

@end