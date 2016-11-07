//
//  HBViewController.m
//  HBRecorder
//
//  Created by HilalB on 11/07/2016.
//  Copyright (c) 2016 HilalB. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>




#import <HBRecorder/HBRecorder.h>

@interface ViewController ()<HBRecorderProtocol>
@property (strong, nonatomic) NSURL *videoPath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _playVideoButton.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated {
    
}



#pragma mark - Video Recording Methods

- (void)recorder:(HBRecorder *)recorder  didFinishPickingMediaWithUrl:(NSURL *)videoUrl {
    
    _videoPath = videoUrl;
    
    _playVideoButton.hidden = NO;
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AVAsset *asset = [AVAsset assetWithURL:_videoPath];// url= give your url video here
        AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
        imageGenerator.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMake(2, 5);//it will create the thumbnail after the 5 sec of video
        CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
        UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Run UI Updates
            _thumbnailImageView.image= thumbnail;
        });
        CMTime CMduration = asset.duration;
        int totalSeconds = CMTimeGetSeconds(CMduration);
        int seconds = totalSeconds % 60;
        int minutes = (totalSeconds / 60) % 60;
        int hours = totalSeconds / 3600;
        NSString *duration = @"";
        if (hours>0) {
            NSString *hoursString = [NSString stringWithFormat:@"%d hour(s)",hours];
            duration = [duration stringByAppendingString:hoursString];
        }
        if (minutes>0) {
            NSString *minString = [NSString stringWithFormat:@"%d min(s)",minutes];
            duration = [duration stringByAppendingString:minString];
        }
        if (seconds>0) {
            NSString *secString = [NSString stringWithFormat:@"%d sec(s)",seconds];
            duration = [duration stringByAppendingString:secString];
        }
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Run UI Updates
            //            _videoLenghtLabel.text = duration;
        });
    });
    
    
}

- (void)recorderDidCancel:(HBRecorder *)recorder {
    NSLog(@"Recorder did cancel..");
}




//To play video

- (IBAction)playVideo:(id)sender {
    
    AVPlayer *player = [[AVPlayer alloc]initWithURL:_videoPath];
    AVPlayerViewController *playerController = [[AVPlayerViewController alloc]init];
    playerController.player = player;
    [self presentViewController:playerController animated:YES completion:nil];
    playerController.view.frame = self.view.frame;
    [player play];
}

- (IBAction)openRecorder:(id)sender {
    
    NSBundle *bundle = [NSBundle bundleForClass:HBRecorder.class];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HBRecorder.bundle/HBRecorder" bundle:bundle];
    
    HBRecorder *recorder = [sb instantiateViewControllerWithIdentifier:@"HBRecorder"];
    recorder.delegate = self;
    recorder.topTitle = @"Top title";
    recorder.bottomTitle = @"HilalB - ©";
    recorder.maxRecordDuration = 60 * 3;
    recorder.movieName = @"MyAnimatedMovie";
    
    
    recorder.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController pushViewController:recorder animated:YES];
    
    
    

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
