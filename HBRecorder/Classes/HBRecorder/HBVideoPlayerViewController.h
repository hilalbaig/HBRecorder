//
//  HBVideoPlayerViewController.h
//  HBRecorder
//
//  Created by HilalB on 11/07/2016.
//  Copyright (c) 2016 HilalB. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import <SCRecorder/SCRecorder.h>
#import "HBRecorder.h"

@interface HBVideoPlayerViewController : UIViewController<SCPlayerDelegate, SCAssetExportSessionDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) SCRecordSession *recordSession;
@property (weak, nonatomic) IBOutlet UILabel *filterNameLabel;
@property (weak, nonatomic) IBOutlet UIView *exportView;
@property (weak, nonatomic) IBOutlet UIView *progressView;

@property (strong, nonatomic) HBRecorder *parent;

@property (strong, nonatomic) IBOutlet UILabel *recordTime;

@property (strong, nonatomic) IBOutlet SCVideoPlayerView *playerView;

- (IBAction)backToRecorder:(id)sender;
- (IBAction)btnSaveTapped:(id)sender;

@end
