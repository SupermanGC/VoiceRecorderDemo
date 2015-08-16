//
//  ViewController.h
//  VoiceRecorderDemo
//
//  Created by Yang  on 29/05/2012.
//  Copyright (c) 2012  www.mobiletrain.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "WaveView.h"

@interface ViewController : UIViewController 
 {
    NSURL *recordSaveFile;
    NSTimer *recordTimer;
    
    AVAudioPlayer *audioPlayer;
    
    WaveView *wv;
}

@end
