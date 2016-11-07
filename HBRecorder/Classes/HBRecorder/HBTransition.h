//
//  HBTransition.h
//  HBRecorder
//
//  Created by HilalB on 11/07/2016.
//  Copyright (c) 2016 HilalB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SCRecorder/SCRecorder.h>

@interface HBTransition : NSObject

@property (strong, nonatomic) SCRecordSession *recordSession;


/*!
 * @discussion Transition style between segments of recorded session
    https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/
    Default value: @"CIGaussianBlur"
 */
@property (strong, nonatomic) NSString *transitionStyle;

/*!
 * @discussion Animation duration between animations recorded session 
   Default value: 0.5
 */
@property (assign, nonatomic) CGFloat animationDuration;

/*!
 * @discussion First segment will start with animation if set to false
    Default value: true
 */
@property (assign, nonatomic) BOOL skipAnimationAtStart;
@property (assign, nonatomic) BOOL skipAnimationAtEnd;

-(instancetype)init;
-(instancetype)initWithSession:(SCRecordSession*)recordSession;
-(instancetype)initWithSession:(SCRecordSession*)recordSession transitionStyle:(NSString*)transitionStyle;


- (SCFilter*) computedFilters;

@end
