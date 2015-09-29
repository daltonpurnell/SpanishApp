//
//  Activity1ExercisesDetailViewController.m
//  SpanishApp
//
//  Created by Dalton on 9/29/15.
//  Copyright © 2015 Dalton. All rights reserved.
//

#import "Activity1ExercisesDetailViewController.h"

#import <OpenEars/OEPocketsphinxController.h>
#import <OpenEars/OEAcousticModel.h>

@interface Activity1ExercisesDetailViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (strong, nonatomic) NSArray *words;
@property (weak, nonatomic) IBOutlet UILabel *word;
@property (strong, nonatomic) NSString *lmPath;
@property (strong, nonatomic) NSString *dicPath;
@property (strong, nonatomic) OELanguageModelGenerator *lmGenerator;
@property (weak, nonatomic) IBOutlet UIImageView *checkMark;


@end

@implementation Activity1ExercisesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.checkMark.hidden = YES;
    
    
    // set up openears language model
    self.lmGenerator = [[OELanguageModelGenerator alloc] init];

    
    self.words = [NSArray arrayWithObjects:@"hola", @"buenos dias", @"buenas tardes", nil];
    NSString *name = @"NameIWantForMyLanguageModelFiles";
    NSError *err = [self.lmGenerator generateLanguageModelFromArray:self.words withFilesNamed:name forAcousticModelAtPath:[OEAcousticModel pathToModel:@"AcousticModelSpanish"]]; // Change "AcousticModelEnglish" to "AcousticModelSpanish" to create a Spanish language model instead of an English one.
    
    self.lmPath = [NSString stringWithFormat:@"%@/NameIWantForMyLanguageModelFiles.%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"DMP"];
    
    self.dicPath = [NSString stringWithFormat:@"%@/NameIWantForMyLanguageModelFiles.%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"DMP"];
    
    if(err == nil) {
        
        self.lmPath = [self.lmGenerator pathToSuccessfullyGeneratedLanguageModelWithRequestedName:@"NameIWantForMyLanguageModelFiles"];
        self.dicPath = [self.lmGenerator pathToSuccessfullyGeneratedDictionaryWithRequestedName:@"NameIWantForMyLanguageModelFiles"];
        
    } else {
        NSLog(@"Error: %@",[err localizedDescription]);
    }
    
    //  initiate the event observer
    
    self.openEarsEventsObserver = [[OEEventsObserver alloc] init];
    [self.openEarsEventsObserver setDelegate:self];
    
    self.word.text = [self.words objectAtIndex:arc4random()%[self.words count]];

    self.fliteController = [[OEFliteController alloc] init];
    self.slt = [[Slt alloc] init];
    
}



- (IBAction)listenButtonTapped:(id)sender {
    
    [self.fliteController say:[NSString stringWithFormat:@"%@", self.word.text] withVoice:self.slt];
    
}



- (IBAction)repeatButtonTapped:(id)sender {
    
    [[OEPocketsphinxController sharedInstance] setActive:TRUE error:nil];
    [[OEPocketsphinxController sharedInstance] startListeningWithLanguageModelAtPath:self.lmPath dictionaryAtPath:self.dicPath acousticModelAtPath:[OEAcousticModel pathToModel:@"AcousticModelSpanish"] languageModelIsJSGF:NO]; // Change "AcousticModelEnglish" to "AcousticModelSpanish" to perform Spanish recognition instead of English.
    
}


- (IBAction)nextButtonTapped:(id)sender {
    
    
    self.word.text = [self.words objectAtIndex:arc4random()%[self.words count]];
    self.checkMark.hidden = YES;
}


#pragma mark - oeeventsobserver delegate methods

- (void) pocketsphinxDidReceiveHypothesis:(NSString *)hypothesis recognitionScore:(NSString *)recognitionScore utteranceID:(NSString *)utteranceID {
    NSLog(@"The received hypothesis is %@ with a score of %@ and an ID of %@", hypothesis, recognitionScore, utteranceID);
    
    if (hypothesis == [NSString stringWithFormat:@"%@", self.word.text]) {
        // show check mark
        self.checkMark.hidden = NO;
        
    }
}

- (void) pocketsphinxDidStartListening {
    NSLog(@"Pocketsphinx is now listening.");
}

- (void) pocketsphinxDidDetectSpeech {
    NSLog(@"Pocketsphinx has detected speech.");
}

- (void) pocketsphinxDidDetectFinishedSpeech {
    NSLog(@"Pocketsphinx has detected a period of silence, concluding an utterance.");
}

- (void) pocketsphinxDidStopListening {
    NSLog(@"Pocketsphinx has stopped listening.");
}

- (void) pocketsphinxDidSuspendRecognition {
    NSLog(@"Pocketsphinx has suspended recognition.");
}

- (void) pocketsphinxDidResumeRecognition {
    NSLog(@"Pocketsphinx has resumed recognition.");
}

- (void) pocketsphinxDidChangeLanguageModelToFile:(NSString *)newLanguageModelPathAsString andDictionary:(NSString *)newDictionaryPathAsString {
    NSLog(@"Pocketsphinx is now using the following language model: \n%@ and the following dictionary: %@",newLanguageModelPathAsString,newDictionaryPathAsString);
}

- (void) pocketSphinxContinuousSetupDidFailWithReason:(NSString *)reasonForFailure {
    NSLog(@"Listening setup wasn't successful and returned the failure reason: %@", reasonForFailure);
}

- (void) pocketSphinxContinuousTeardownDidFailWithReason:(NSString *)reasonForFailure {
    NSLog(@"Listening teardown wasn't successful and returned the failure reason: %@", reasonForFailure);
}

- (void) testRecognitionCompleted {
    NSLog(@"A test file that was submitted for recognition is now complete.");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
