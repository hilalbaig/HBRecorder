//
//  HBVideoPlayerViewController.m
//  HBRecorder
//
//  Created by HilalB on 11/07/2016.
//  Copyright (c) 2016 HilalB. All rights reserved.
//

#import "HBVideoPlayerViewController.h"
#import "HBEditVideoViewController.h"
#import "SCWatermarkOverlayView.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "HBTransition.h"


@interface HBVideoPlayerViewController () {
}

@property (strong, nonatomic) SCAssetExportSession *exportSession;

@property NSInteger transitionType;

@property NSMutableArray		*clips;
@property NSMutableArray		*clipTimeRanges;

@end

@implementation HBVideoPlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
    if (self) {
        // Custom initialization
    }
	
    return self;
}

- (void)dealloc {

    [_playerView.player pause];
    _playerView.player = nil;
    [self cancelSaveToCameraRoll];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.exportView.clipsToBounds = YES;
    self.exportView.layer.cornerRadius = 20;

    
    
    
    //	_player.loopEnabled = YES;
    
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   

    
    int totalSeconds = CMTimeGetSeconds(_recordSession.duration);
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    
    _recordTime.text = [NSString stringWithFormat:@"%02d:%02d",minutes, seconds];
    
    //Transition live rendering
//    HBTransition *transition = [[HBTransition alloc] initWithSession:self.recordSession transitionStyle:@"CIGaussianBlur"];
//    self.filterView.filters = @[[transition computedFilters]];
//    _playerView.player.SCImageView = self.filterView;
    
    [_playerView.player setItemByAsset:_recordSession.assetRepresentingSegments];
	[_playerView.player play];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_playerView.player pause];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[HBEditVideoViewController class]]) {
        HBEditVideoViewController *editVideo = segue.destinationViewController;
        editVideo.recordSession = self.recordSession;
    }
}

- (void)assetExportSessionDidProgress:(SCAssetExportSession *)assetExportSession {
    dispatch_async(dispatch_get_main_queue(), ^{
        float progress = assetExportSession.progress;
        
        CGRect frame =  self.progressView.frame;
        frame.size.width = self.progressView.superview.frame.size.width * progress;
        self.progressView.frame = frame;
    });
}

- (void)cancelSaveToCameraRoll
{
    [_exportSession cancelExport];
}

- (IBAction)cancelTapped:(id)sender {
    [self cancelSaveToCameraRoll];
}


- (void)saveToCameraRoll {
    self.navigationItem.rightBarButtonItem.enabled = NO;

    [_playerView.player pause];

    SCAssetExportSession *exportSession = [[SCAssetExportSession alloc] initWithAsset:self.recordSession.assetRepresentingSegments];

    //Transitions..
    HBTransition *transition = [[HBTransition alloc] initWithSession:self.recordSession transitionStyle:@"CIGaussianBlur"];
    
    
    exportSession.videoConfiguration.filter = [transition computedFilters];
    exportSession.videoConfiguration.preset = SCPresetHighestQuality;
    exportSession.audioConfiguration.preset = SCPresetHighestQuality;
    exportSession.videoConfiguration.maxFrameRate = 35;

    if (_parent.movieName.length) {
        NSURL *path = [self.recordSession.outputUrl URLByDeletingLastPathComponent];
        NSString *strPathWithoutName = [path absoluteString];
        NSString *newFilePathSring = [NSString stringWithFormat:@"%@%@.mov",strPathWithoutName,_parent.movieName];
        exportSession.outputUrl = [NSURL URLWithString:newFilePathSring];
    } else {
        exportSession.outputUrl = self.recordSession.outputUrl;
    }
    
    
    
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.delegate = self;
    exportSession.contextType = SCContextTypeAuto;
    self.exportSession = exportSession;
    
    self.exportView.hidden = NO;
    self.exportView.alpha = 0;
    CGRect frame =  self.progressView.frame;
    frame.size.width = 0;
    self.progressView.frame = frame;
    
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.exportView.alpha = 1;
    }];

    SCWatermarkOverlayView *overlay = [SCWatermarkOverlayView new];
    overlay.topTitle = _parent.topTitle;
    overlay.bottomTitle = _parent.bottomTitle;
    overlay.date = self.recordSession.date;
    exportSession.videoConfiguration.overlay = overlay;
    NSLog(@"Starting exporting");

    CFTimeInterval time = CACurrentMediaTime();
    __weak typeof(self) wSelf = self;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        __strong typeof(self) strongSelf = wSelf;

        if (!exportSession.cancelled) {
            NSLog(@"Completed compression in %fs", CACurrentMediaTime() - time);
        }

        if (strongSelf != nil) {
            [strongSelf.playerView.player play];
            strongSelf.exportSession = nil;
            strongSelf.navigationItem.rightBarButtonItem.enabled = YES;

            [UIView animateWithDuration:0.3 animations:^{
                strongSelf.exportView.alpha = 0;
            }];
        }

        NSError *error = exportSession.error;
        if (exportSession.cancelled) {
            NSLog(@"Export was cancelled");
        } else if (error == nil) {
            //[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            
            [_parent.delegate recorder:_parent didFinishPickingMediaWithUrl:exportSession.outputUrl];
            
            
            int viewsToPop = 2;
            self.navigationController.navigationBarHidden = NO;

            [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - viewsToPop - 1] animated:YES];

        } else {
            if (!exportSession.cancelled) {
                [[[UIAlertView alloc] initWithTitle:@"Failed to save" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }
        }
    }];
}

- (BOOL)startMediaBrowser {
    //Validations
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO) {
        return NO;
    }
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    
    mediaUI.allowsEditing = YES;
    mediaUI.delegate = self;
    
    [self presentViewController:mediaUI animated:YES completion:nil];
    return YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSURL *url = info[UIImagePickerControllerMediaURL];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    SCRecordSessionSegment *segment = [SCRecordSessionSegment segmentWithURL:url info:nil];
    
    [_recordSession addSegment:segment];
}


- (IBAction)backToRecorder:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSaveTapped:(id)sender {
    [self saveToCameraRoll];
    
    
}
@end
