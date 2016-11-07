//
//  HBViewController.h
//  HBRecorder
//
//  Created by HilalB on 11/07/2016.
//  Copyright (c) 2016 HilalB. All rights reserved.
//

@import UIKit;

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (strong, nonatomic) IBOutlet UIButton *playVideoButton;

- (IBAction)playVideo:(id)sender;
- (IBAction)openRecorder:(id)sender;

@end
