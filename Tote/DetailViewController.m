//
//  DetailViewController.m
//  ToTe
//
//  Created by Jittapoo Kongthip on 4/25/2558 BE.
//  Copyright (c) 2558 Jittapoo Kongthip. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize cargoPhoto;
@synthesize Nlabel;
@synthesize sectionLabel;
@synthesize soiLabel;
@synthesize etcTextview;
@synthesize Type;
@synthesize tote;


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
    
    self.title = tote.name;
    self.sectionLabel.text = tote.section;
    self.Nlabel.text = tote.name;
    self.soiLabel.text = tote.soi;
    self.cargoPhoto.file = tote.imageFile;
    
    for (NSArray* etc in tote.etc) {
        etcTextview.text = [etcTextview.text stringByAppendingFormat:@"%@\n", etc];
    }
    self.etcTextview.text = [tote.etc componentsJoinedByString:@"\n"];
    self.Type.text = tote.Type;
    
}

- (void)viewDidUnload
{
    [self setCargoPhoto:nil];
    [self setNlabel:nil];
    [self setSectionLabel:nil];
    [self setSoiLabel:nil];
    [self setType:nil];
    [self setEtcTextview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
