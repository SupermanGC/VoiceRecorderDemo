//
//  WaveView.h
//  VoiceRecorderDemo
//
//  Created by Yang  on 29/05/2012.
//  Copyright (c) 2012 www.mobiletrain.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaveView : UIView {
    NSMutableArray *averagePointArray;
    NSMutableArray *peakPointArray;
}

- (void) addAveragePoint:(CGFloat)averagePoint andPeakPoint:(CGFloat)peakPoint;
// p (averagePoint, peakPoint)
//- (void) addAveragePoint:(CGPoint)p;

@end
