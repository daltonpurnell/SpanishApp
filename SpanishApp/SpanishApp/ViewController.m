//
//  ViewController.m
//  SpanishApp
//
//  Created by Dalton on 9/29/15.
//  Copyright © 2015 Dalton. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Congratulations!\n You have won a trip to Mexico!" message:@"Once you board the plane, we'll teach you some Spanish so you'll be ready to communicate." preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // TODO: play video of getting on plane
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
