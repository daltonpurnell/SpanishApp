//
//  Activity1ExercisesDetailViewController.h
//  SpanishApp
//
//  Created by Dalton on 9/29/15.
//  Copyright © 2015 Dalton. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <OpenEars/OELanguageModelGenerator.h>
#import <OpenEars/OEAcousticModel.h>

#import <Slt/Slt.h>
#import <OpenEars/OEFliteController.h>

#import <OpenEars/OEEventsObserver.h>

@interface Activity1ExercisesDetailViewController : UIViewController <OEEventsObserverDelegate>

@property (strong, nonatomic) OEFliteController *fliteController;
@property (strong, nonatomic) Slt *slt;

@property (strong, nonatomic) OEEventsObserver *openEarsEventsObserver;


@end
