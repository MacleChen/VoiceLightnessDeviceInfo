//
//  ViewController.m
//  VoiceLightnessDeviceInfo
//
//  Created by 陈帆 on 2017/12/5.
//  Copyright © 2017年 陈帆. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController () {
    float _currentVolume;
    UISlider *_volumeViewSlider;
    
}

@property (weak, nonatomic) IBOutlet UILabel *showVolumeLabel;

@property (weak, nonatomic) IBOutlet UILabel *showLightLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            _volumeViewSlider = (UISlider*)view;
            break;
        }
    }
    _currentVolume = 0.3;
}

// MARK: 音量调小
- (IBAction)turnDownVolume:(UIButton *)sender {
    
    // retrieve system volume
    // change system volume, the value is between 0.0f and 1.0f
    _currentVolume -= (1.0/16.0);
    if (_currentVolume <= 0.0) {
        _currentVolume = 0.0;
    }
    
    [_volumeViewSlider setValue:_currentVolume animated:true];
    self.showVolumeLabel.text = [NSString stringWithFormat:@"%.4f", _currentVolume];
    // send UI control event to make the change effect right now.
    [_volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
}


// MARK: 音量调大
- (IBAction)turnUpVolume:(UIButton *)sender {
    // retrieve system volume
    // change system volume, the value is between 0.0f and 1.0f
    _currentVolume += (1.0/16.0);
    if (_currentVolume >= 1.0) {
        _currentVolume = 1.0;
    }
    
    [_volumeViewSlider setValue:_currentVolume animated:true];
    self.showVolumeLabel.text = [NSString stringWithFormat:@"%.4f", _currentVolume];
    
    // send UI control event to make the change effect right now.
    [_volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
}

// MARK: 亮度调小
- (IBAction)turnDownLight:(UIButton *)sender {
    CGFloat currentLight = [[UIScreen mainScreen] brightness];
    currentLight -= 0.1;
    if (currentLight <= 0.0) {
        currentLight = 0.0;
    }
    
    [[UIScreen mainScreen] setBrightness:currentLight];
    self.showLightLabel.text = [NSString stringWithFormat:@"%.4f", currentLight];
}

// MARK: 亮度调大
- (IBAction)turnUpLight:(UIButton *)sender {
    CGFloat currentLight = [[UIScreen mainScreen] brightness];
    currentLight += 0.1;
    if (currentLight >= 1.0) {
        currentLight = 1.0;
    }
    
    [[UIScreen mainScreen] setBrightness:currentLight];
    self.showLightLabel.text = [NSString stringWithFormat:@"%.4f", currentLight];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
