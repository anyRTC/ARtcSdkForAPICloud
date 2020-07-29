//
//  ARtcSdkForAPICloud.h
//  ARtcSdkForAPICloud
//
//  Created by 余生丶 on 2020/7/6.
//  Copyright © 2020 AR. All rights reserved.
//

#import "ARtcSdkForAPICloud.h"
#import "UZAppDelegate.h"
#import "NSDictionaryUtils.h"
#import <ARtcKit/ARtcEngineKit.h>

@interface ARtcSdkForAPICloud () <ARtcEngineDelegate>
{
    ARtcEngineKit *rtcEngine;
    NSMutableDictionary *videoView;
    
    NSInteger joinChannelSuccessCallbackId;
    NSInteger leaveChannelCallbackId;
    NSInteger firstLocalVideoFrameCallbackId;
    NSInteger remoteUserJoinedCallbackId;
    NSInteger remoteUserOfflineCallbackId;
    NSInteger firstRemoteVideoDecodedCallbackId;
    NSInteger requestTokenCallbackId;
    NSInteger errorCallbackId;
    NSInteger warningCallbackId;
}
@end

@implementation ARtcSdkForAPICloud

- (id)initWithUZWebView:(UZWebView *)webView_ {
    if (self = [super initWithUZWebView:webView_]) {
    }
    return self;
}

- (void)dispose {
    // do clean
    [self destroy:nil];
}

- (void)init:(NSDictionary *)paramDict {
    if (rtcEngine == nil) {
        NSString *appId = [paramDict stringValueForKey:@"appId" defaultValue:nil];
        if (appId == nil) {
            NSDictionary *feature = [self getFeatureByName:@"arRtc"];
            appId = [feature stringValueForKey:@"appId" defaultValue:nil];
        }
        
        rtcEngine = [ARtcEngineKit sharedEngineWithAppId:appId delegate:self];
        videoView = [[NSMutableDictionary alloc] init];
    }
}

- (void)destroy:(NSDictionary *)paramDict {
    if (rtcEngine) {
        for (UIView *view in videoView.allValues) {
            [view removeFromSuperview];
        }
        [videoView removeAllObjects];
        videoView = nil;
        
        [ARtcEngineKit destroy];
        rtcEngine = nil;
    }
}

- (void)getSdkVersion:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (cbId) {
        NSString *version = [ARtcEngineKit getSdkVersion];
        [self sendResultEventWithCallbackId:cbId dataString:version stringType:kUZStringType_TEXT errDict:nil doDelete:YES];
    }
}

- (void)setParameters:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    NSString *params = [paramDict stringValueForKey:@"params" defaultValue:nil];
    if (params == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeInvalidArgument)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    int errCode = [rtcEngine setParameters:params];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)setLogFile:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    NSString *path = [paramDict stringValueForKey:@"path" defaultValue:nil];
    if (path == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeInvalidArgument)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    NSString *fullPath = [self getPathWithUZSchemeURL:path];
    int errCode = [rtcEngine setLogFile:fullPath];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)setLogFilter:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    int filter = [paramDict intValueForKey:@"filter" defaultValue:-1];
    if (filter < 0) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeInvalidArgument)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }

    int errCode = [rtcEngine setLogFilter:filter];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)joinChannel:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    NSString *uid = [paramDict stringValueForKey:@"uid" defaultValue:nil];
    NSString *token = [paramDict stringValueForKey:@"token" defaultValue:nil];
    NSString *channel = [paramDict stringValueForKey:@"channel" defaultValue:nil];
    if (channel == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeInvalidArgument)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    int errCode = [rtcEngine joinChannelByToken:token channelId:channel uid:uid joinSuccess:nil];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)leaveChannel:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    int errCode = [rtcEngine leaveChannel:nil];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)setChannelProfile:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    NSInteger profile = [paramDict integerValueForKey:@"profile" defaultValue:-1];
    if (profile < 0) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeInvalidArgument)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    int errCode = [rtcEngine setChannelProfile:profile];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)setClientRole:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    NSInteger role = [paramDict integerValueForKey:@"role" defaultValue:-1];
    if (role < 0) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeInvalidArgument)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    int errCode = [rtcEngine setClientRole:role];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)renewToken:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    NSString *token = [paramDict stringValueForKey:@"token" defaultValue:nil];
    if (token == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeInvalidArgument)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    int errCode = [rtcEngine renewToken:token];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)enableVideo:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    int errCode = [rtcEngine enableVideo];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)disableVideo:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    int errCode = [rtcEngine disableVideo];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)enableLocalVideo:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    BOOL enabled = [paramDict boolValueForKey:@"enabled" defaultValue:YES];
    int errCode = [rtcEngine enableLocalVideo:enabled];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)setEnableSpeakerphone:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }

    BOOL enableSpeaker = [paramDict boolValueForKey:@"enabled" defaultValue:YES];
    int errCode = [rtcEngine setEnableSpeakerphone:enableSpeaker];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)setDefaultAudioRouteToSpeakerphone:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }

    BOOL defaultToSpeaker = [paramDict boolValueForKey:@"enabled" defaultValue:YES];
    int errCode = [rtcEngine setDefaultAudioRouteToSpeakerphone:defaultToSpeaker];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)setVideoProfile:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    NSInteger width = [paramDict integerValueForKey:@"width" defaultValue:0];
    NSInteger height = [paramDict integerValueForKey:@"height" defaultValue:0];
    NSInteger frameRate = [paramDict integerValueForKey:@"frameRate" defaultValue:0];
    NSInteger bitrate = [paramDict integerValueForKey:@"bitrate" defaultValue:0];
    if (width == 0 || height == 0 || frameRate == 0 || bitrate == 0) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeInvalidArgument)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }

//  int errCode = [rtcEngine setVideoResolution:CGSizeMake(width, height) andFrameRate:frameRate bitrate:bitrate]; // Earlier than 2.3.0
    ARVideoEncoderConfiguration *configuration =
    [[ARVideoEncoderConfiguration alloc] initWithSize:CGSizeMake(width, height)
                                               frameRate:frameRate
                                                 bitrate:bitrate
                                         orientationMode:ARVideoOutputOrientationModeFixedPortrait];
    int errCode = [rtcEngine setVideoEncoderConfiguration:configuration];

    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)switchCamera:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    int errCode = [rtcEngine switchCamera];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)startPreview:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    int errCode = [rtcEngine startPreview];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)stopPreview:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    int errCode = [rtcEngine stopPreview];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)setupLocalVideo:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    UIView *oldView = videoView[@"localUid"];
    if (oldView) {
        [oldView removeFromSuperview];
        [videoView removeObjectForKey:@"localUid"];
    }
    
    NSDictionary *rect = [paramDict dictValueForKey:@"rect" defaultValue:nil];
    if (rect == nil) {
        int errCode = [rtcEngine setupLocalVideo:nil];
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(errCode)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    NSInteger x = [rect integerValueForKey:@"x" defaultValue:0];
    NSInteger y = [rect integerValueForKey:@"y" defaultValue:0];
    NSInteger width = [rect integerValueForKey:@"w" defaultValue:0];
    NSInteger height = [rect integerValueForKey:@"h" defaultValue:0];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    NSString *fixedOn = [paramDict stringValueForKey:@"fixedOn" defaultValue:nil];
    BOOL fixed = [paramDict boolValueForKey:@"fixed" defaultValue:YES];
    if (![self addSubview:view fixedOn:fixedOn fixed:fixed]) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeFailed)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }

    ARtcVideoCanvas *canvas = [[ARtcVideoCanvas alloc] init];
    canvas.renderMode = [paramDict integerValueForKey:@"renderMode" defaultValue:ARVideoRenderModeHidden];
    canvas.view = view;
    int errCode = [rtcEngine setupLocalVideo:canvas];
    if (errCode == 0) {
        videoView[@"localUid"] = view;
    }
    
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)setupRemoteVideo:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    NSString *uid = [paramDict stringValueForKey:@"uid" defaultValue:nil];
    if (uid.length == 0) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeInvalidArgument)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    UIView *oldView = videoView[uid];
    if (oldView) {
        [oldView removeFromSuperview];
        [videoView removeObjectForKey:uid];
    }
    
    NSDictionary *rect = [paramDict dictValueForKey:@"rect" defaultValue:nil];
    if (rect == nil) {
        ARtcVideoCanvas *canvas = [[ARtcVideoCanvas alloc] init];
        canvas.uid = uid;
        int errCode = [rtcEngine setupRemoteVideo:canvas];
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(errCode)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    NSInteger x = [rect integerValueForKey:@"x" defaultValue:0];
    NSInteger y = [rect integerValueForKey:@"y" defaultValue:0];
    NSInteger width = [rect integerValueForKey:@"w" defaultValue:0];
    NSInteger height = [rect integerValueForKey:@"h" defaultValue:0];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    NSString *fixedOn = [paramDict stringValueForKey:@"fixedOn" defaultValue:nil];
    BOOL fixed = [paramDict boolValueForKey:@"fixed" defaultValue:YES];
    if (![self addSubview:view fixedOn:fixedOn fixed:fixed]) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeFailed)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    ARtcVideoCanvas *canvas = [[ARtcVideoCanvas alloc] init];
    canvas.uid = uid;
    canvas.view = view;
    canvas.renderMode = [paramDict integerValueForKey:@"renderMode" defaultValue:ARVideoRenderModeHidden];
    int errCode = [rtcEngine setupRemoteVideo:canvas];
    if (errCode == 0) {
        videoView[uid] = view;
    }
    
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)muteLocalVideoStream:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    BOOL mute = [paramDict boolValueForKey:@"mute" defaultValue:YES];
    int errCode = [rtcEngine muteLocalVideoStream:mute];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)muteAllRemoteVideoStreams:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    BOOL mute = [paramDict boolValueForKey:@"mute" defaultValue:YES];
    int errCode = [rtcEngine muteAllRemoteVideoStreams:mute];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)muteRemoteVideoStream:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    NSString *uid = [paramDict stringValueForKey:@"uid" defaultValue:nil];
    if (uid.length == 0) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeInvalidArgument)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    BOOL mute = [paramDict boolValueForKey:@"mute" defaultValue:YES];
    int errCode = [rtcEngine muteRemoteVideoStream:uid mute:mute];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)enableAudio:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    int errCode = [rtcEngine enableAudio];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)disableAudio:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    int errCode = [rtcEngine disableAudio];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)adjustRecordingSignalVolume:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }

    NSInteger volume = [paramDict integerValueForKey:@"volume" defaultValue:100];
    if (volume < 0 || volume > 400) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeInvalidArgument)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }

    int errCode = [rtcEngine adjustRecordingSignalVolume:volume];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)adjustPlaybackSignalVolume:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }

    NSInteger volume = [paramDict integerValueForKey:@"volume" defaultValue:100];
    if (volume < 0 || volume > 400) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeInvalidArgument)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }

    int errCode = [rtcEngine adjustPlaybackSignalVolume:volume];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)adjustAudioMixingVolume:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }

    NSInteger volume = [paramDict integerValueForKey:@"volume" defaultValue:100];
    if (volume < 0 || volume > 400) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeInvalidArgument)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }

    int errCode = [rtcEngine adjustAudioMixingVolume:volume];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)muteLocalAudioStream:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    BOOL mute = [paramDict boolValueForKey:@"mute" defaultValue:YES];
    int errCode = [rtcEngine muteLocalAudioStream:mute];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)muteAllRemoteAudioStreams:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    BOOL mute = [paramDict boolValueForKey:@"mute" defaultValue:YES];
    int errCode = [rtcEngine muteAllRemoteAudioStreams:mute];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

- (void)muteRemoteAudioStream:(NSDictionary *)paramDict {
    NSInteger cbId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
    if (rtcEngine == nil) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeNotInitialized)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    NSString *uid = [paramDict stringValueForKey:@"uid" defaultValue:nil];
    if (uid.length == 0) {
        if (cbId > 0) {
            NSDictionary *ret = @{@"code" : @(ARErrorCodeInvalidArgument)};
            [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
        }
        return;
    }
    
    BOOL mute = [paramDict boolValueForKey:@"mute" defaultValue:YES];
    int errCode = [rtcEngine muteRemoteAudioStream:uid mute:mute];
    if (cbId > 0) {
        NSDictionary *ret = @{@"code" : @(errCode)};
        [self sendResultEventWithCallbackId:cbId dataDict:ret errDict:nil doDelete:YES];
    }
}

#pragma mark - Listener

- (void)joinChannelSuccessListener:(NSDictionary *)paramDict {
    joinChannelSuccessCallbackId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
}

- (void)leaveChannelListener:(NSDictionary *)paramDict {
    leaveChannelCallbackId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
}

- (void)firstLocalVideoFrameListener:(NSDictionary *)paramDict {
    firstLocalVideoFrameCallbackId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
}

- (void)remoteUserJoinedListener:(NSDictionary *)paramDict {
    remoteUserJoinedCallbackId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
}

- (void)remoteUserOfflineListener:(NSDictionary *)paramDict {
    remoteUserOfflineCallbackId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
}

- (void)firstRemoteVideoDecodedListener:(NSDictionary *)paramDict {
    firstRemoteVideoDecodedCallbackId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
}

- (void)requestTokenListener:(NSDictionary *)paramDict {
    requestTokenCallbackId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
}

- (void)errorListener:(NSDictionary *)paramDict {
    errorCallbackId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
}

- (void)warningListener:(NSDictionary *)paramDict {
    warningCallbackId = [paramDict integerValueForKey:@"cbId" defaultValue:0];
}

#pragma mark - ARtcEngineDelegate

- (void)rtcEngine:(ARtcEngineKit * _Nonnull)engine didJoinChannel:(NSString * _Nonnull)channel withUid:(NSString * _Nonnull)uid elapsed:(NSInteger)elapsed {
    if (joinChannelSuccessCallbackId > 0) {
        NSDictionary *ret = @{@"channel" : channel, @"uid" : uid};
        [self sendResultEventWithCallbackId:joinChannelSuccessCallbackId dataDict:ret errDict:nil doDelete:NO];
    }
}

- (void)rtcEngine:(ARtcEngineKit * _Nonnull)engine didLeaveChannelWithStats:(ARChannelStats * _Nonnull)stats {
    NSMutableArray *needToRemove = [[NSMutableArray alloc] initWithCapacity:(videoView.count)];
    [videoView enumerateKeysAndObjectsUsingBlock:^(NSString *uid, UIView *view, BOOL *stop) {
        if ([uid isEqualToString:@"localUid"]) {
            [view removeFromSuperview];
            [needToRemove addObject:uid];
        }
    }];
    [videoView removeObjectsForKeys:needToRemove];
    
    if (leaveChannelCallbackId > 0) {
        NSDictionary *ret = @{@"duration" : @(stats.duration)};
        [self sendResultEventWithCallbackId:leaveChannelCallbackId dataDict:ret errDict:nil doDelete:NO];
    }
}

- (void)rtcEngine:(ARtcEngineKit * _Nonnull)engine firstLocalVideoFrameWithSize:(CGSize)size elapsed:(NSInteger)elapsed {
    if (firstLocalVideoFrameCallbackId > 0) {
        NSDictionary *ret = @{@"width" : @(size.width), @"height" : @(size.height)};
        [self sendResultEventWithCallbackId:firstLocalVideoFrameCallbackId dataDict:ret errDict:nil doDelete:NO];
    }
}

- (void)rtcEngine:(ARtcEngineKit *_Nonnull)engine didJoinedOfUid:(NSString *_Nonnull)uid elapsed:(NSInteger)elapsed {
    if (remoteUserJoinedCallbackId > 0) {
        NSDictionary *ret = @{@"uid" : uid};
        [self sendResultEventWithCallbackId:remoteUserJoinedCallbackId dataDict:ret errDict:nil doDelete:NO];
    }
}

- (void)rtcEngine:(ARtcEngineKit *_Nonnull)engine didOfflineOfUid:(NSString *_Nonnull)uid reason:(ARUserOfflineReason)reason {
    if (remoteUserOfflineCallbackId > 0) {
        NSDictionary *ret = @{@"uid" : uid};
        [self sendResultEventWithCallbackId:remoteUserOfflineCallbackId dataDict:ret errDict:nil doDelete:NO];
    }
}

- (void)rtcEngine:(ARtcEngineKit *_Nonnull)engine firstRemoteVideoDecodedOfUid:(NSString *_Nonnull)uid size:(CGSize)size elapsed:(NSInteger)elapsed {
    if (firstRemoteVideoDecodedCallbackId > 0) {
        NSDictionary *ret = @{@"uid" : uid, @"width" : @(size.width), @"height" : @(size.height)};
        [self sendResultEventWithCallbackId:firstRemoteVideoDecodedCallbackId dataDict:ret errDict:nil doDelete:NO];
    }
}

- (void)rtcEngineRequestToken:(ARtcEngineKit * _Nonnull)engine {
    if (requestTokenCallbackId > 0) {
        [self sendResultEventWithCallbackId:requestTokenCallbackId dataDict:nil errDict:nil doDelete:NO];
    }
}

- (void)rtcEngine:(ARtcEngineKit *_Nonnull)engine didOccurError:(ARErrorCode)errorCode {
    if (errorCallbackId > 0) {
        NSDictionary *ret = @{@"errorCode" : @(errorCode)};
        [self sendResultEventWithCallbackId:errorCallbackId dataDict:ret errDict:nil doDelete:NO];
    }
}

- (void)rtcEngine:(ARtcEngineKit * _Nonnull)engine didOccurWarning:(ARWarningCode)warningCode {
    if (warningCallbackId > 0) {
        NSDictionary *ret = @{@"warningCode" : @(warningCode)};
        [self sendResultEventWithCallbackId:warningCallbackId dataDict:ret errDict:nil doDelete:NO];
    }
}

@end

