//
//  Tote.m
//  ToTe
//
//  Created by Jittapoo Kongthip on 4/25/2558 BE.
//  Copyright (c) 2558 Jittapoo Kongthip. All rights reserved.
//

#import "Tote.h"

@implementation Tote

-(id)initWithPFObject:(PFObject *)object
{
    if (self = [super init]) {
        self.name = [object objectForKey:@"name"];
        self.imageFile = [object objectForKey:@"imageFile"];
        self.section = [object objectForKey:@"section"];
        self.soi = [object objectForKey:@"soi"];
        self.etc = [object objectForKey:@"etc"];
        self.Type = [object objectForKey:@"Type"];
    }
    return self;
}

@end
