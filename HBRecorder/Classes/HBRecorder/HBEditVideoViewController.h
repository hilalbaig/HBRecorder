//
//  HBEditVideoViewController.h
//  HBRecorder
//
//  Created by HilalB on 11/07/2016.
//  Copyright (c) 2016 HilalB. All rights reserved.
//

#import <SCRecorder/SCRecorder.h>

@interface HBEditVideoViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) SCRecordSession *recordSession;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *lblClipsCounter;
@property (strong, nonatomic) IBOutlet UILabel *lblClipsDuration;


- (IBAction)deletePressed:(id)sender;
- (IBAction)addPressed:(id)sender;
- (IBAction)backPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *playPauseImageView;

@property (weak, nonatomic) IBOutlet SCVideoPlayerView *videoPlayerView;

@end
