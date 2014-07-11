//
//  ViewController.m
//  Multilingue
//
//  Created by Duyen Hoa Ha on 11/07/2014.
//  Copyright (c) 2014 Duyen-Hoa HA. All rights reserved.
//

#import "ViewController.h"
#import "LanguageManagement.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)segmentIndexChanged:(id)sender {
    UISegmentedControl *mySegment = (UISegmentedControl*)sender;
    if (mySegment.selectedSegmentIndex == 0) {
        //show English
        self.lblMultilingue.text = [[LanguageManagement sharedLM] myLocalizedStringForKey:@"LBL_MULTILINGUE" forLang:@"en" ofTable:@"Dictionnaire"];
    } else {
        //show French
        self.lblMultilingue.text = [[LanguageManagement sharedLM] myLocalizedStringForKey:@"LBL_MULTILINGUE" forLang:@"fr" ofTable:@"Dictionnaire"];
    }
}

@end
