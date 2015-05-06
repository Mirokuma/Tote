//
//  DetailViewController.h
//  ToTe
//
//  Created by Jittapoo Kongthip on 4/25/2558 BE.
//  Copyright (c) 2558 Jittapoo Kongthip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ParseUI/ParseUI.h>
#import "Tote.h"


@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet PFImageView *cargoPhoto;
@property (weak, nonatomic) IBOutlet UILabel *N;
@property (strong, nonatomic) IBOutlet UITextView *etcTextview;
@property (weak, nonatomic) IBOutlet UILabel *sectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *soiLabel;
@property (weak, nonatomic) IBOutlet UILabel *Type; //tag

@property (nonatomic, strong) Tote *tote;

@end