//
//  HBTransition.h
//  HBRecorder
//
//  Created by HilalB on 11/07/2016.
//  Copyright (c) 2016 HilalB. All rights reserved.
//

#import "HBTransition.h"
@interface HBTransition ()
{

}

@property (strong, nonatomic) NSMutableArray *animationPoints;


@end
@implementation HBTransition

-(instancetype)initWithSession:(SCRecordSession*)recordSession transitionStyle:(NSString*)transitionStyle {
    self = [super init];
    
    if (self) {
        _recordSession = recordSession;
        _animationDuration = 0.5;
        _transitionStyle = transitionStyle;
        _skipAnimationAtStart = true;
        _skipAnimationAtEnd = true;
        _animationPoints = [self getAnimationPoints];
        
    }
    
    return self;
}

-(instancetype)initWithSession:(SCRecordSession*)recordSession {
    self = [super init];
    
    if (self) {
        self = [self initWithSession:recordSession transitionStyle:@"CIGaussianBlur"];
    }
    
    return self;
}


-(instancetype)init {
    self = [super init];
    
    if (self) {
       self = [self initWithSession:[SCRecordSession new] transitionStyle:@"CIGaussianBlur"];
    }
    
    return self;
}



- (SCFilter*)computedFilters {
    //temp

    SCFilter *filter = [SCFilter filterWithCIFilterName:_transitionStyle];
    [filter setParameterValue:@0 forKey:@"inputRadius"];

    int i = 0;


    for (NSDictionary *dictionary in _animationPoints) {
        
        if ([self hasOpeningAnimationAtIndex:i]) {
            CGFloat openingPoint = [[dictionary valueForKey:@"start"] floatValue];
            [filter addAnimationForParameterKey:@"inputRadius" startValue:@100 endValue:@0 startTime:openingPoint duration:_animationDuration];
            
        }

        if ([self hasClosingAnimationAtIndex:i]) {
            CGFloat closingPoint = [[dictionary valueForKey:@"end"] floatValue];
            [filter addAnimationForParameterKey:@"inputRadius" startValue:@0 endValue:@100 startTime:closingPoint duration:_animationDuration];
        }
        
        i++;
    }
    
    return filter;
}

-(BOOL)hasOpeningAnimationAtIndex:(int)i {
    if (i == 0 && _skipAnimationAtStart == true) {
        return NO;
    } else {
        return YES;
    }
}


-(BOOL)hasClosingAnimationAtIndex:(int)i {
    
    NSInteger lastIndex = _animationPoints.count-1;
    
    if (i == lastIndex && _skipAnimationAtEnd == true) {
        return NO;
    } else {
        return YES;
    }
}



-(NSMutableArray*)getAnimationPoints {
  
    /*!
     * @discussion How we get animation points?
     * Each segment will add a dictionary of start & end points to array
     * start: start of segement with respect to total record session
     * end: end of segement with respect to total record session minus animatationDuration
     *
     * e.g let Record session: 10mins
     * segment1: 5mins ==> start:0.0 end: 4.5
     * (so segment1 will animate from 0.0 to 0.5 at start and from 4.5 to 5.0 at end)
     * segment2: 5mins ==> start:5.0 end: 9.5
     * (similarly segment2 will animate from 5.0 to 5.5 at start and from 9.5 to 10.0 at end)
     *
     */

    NSMutableArray *array = [[NSMutableArray alloc] init];
    CGFloat anchor = 0.0;
    
    for (SCRecordSessionSegment *segment in self.recordSession.segments) {
        CGFloat openingPoint = anchor;
        CGFloat closingPoint = openingPoint + CMTimeGetSeconds(segment.duration) - _animationDuration;
        NSDictionary *dictionary = @{@"start": @(openingPoint),
                                     @"end": @(closingPoint)};
        [array addObject:dictionary];
        
        anchor = anchor + CMTimeGetSeconds(segment.duration);
    }
    
    return array;
}




@end
