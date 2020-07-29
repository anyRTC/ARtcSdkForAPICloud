/*
Title: ARtcKit
Description: ARtcKit SDK for APICloud
*/

<p style="color: #ccc; margin-bottom: 30px;">来自于：ar云平台</p>

<ul id="tab" class="clearfix">
	<li class="active"><a href="#method-content">Method</a></li>
</ul>
<div id="method-content">

<div class="outline">
[init](#1)

[destroy](#2)

[getSdkVersion](#3)

[setParameters](#4)

[setLogFile](#5)

[setLogFilter](#6)

[joinChannel](#7)

[leaveChannel](#8)

[setChannelProfile](#9)

[setClientRole](#10)

[renewToken](#11)

[enableVideo](#12)

[disableVideo](#13)

[enableLocalVideo](#14)

[setVideoProfile](#15)

[switchCamera](#16)

[startPreview](#17)

[stopPreview](#18)

[setupLocalVideo](#19)

[setupRemoteVideo](#20)

[muteLocalVideoStream](#21)

[muteAllRemoteVideoStreams](#22)

[muteRemoteVideoStream](#23)

[enableAudio](#24)

[disableAudio](#25)

[muteLocalAudioStream](#26)

[muteAllRemoteAudioStreams](#27)

[muteRemoteAudioStream](#28)

[joinChannelSuccessListener](#29)

[leaveChannelListener](#30)

[firstLocalVideoFrameListener](#31)

[remoteUserJoinedListener](#32)

[remoteUserOfflineListener](#33)

[firstRemoteVideoDecodedListener](#34)

[requestTokenListener](#35)

[errorListener](#36)

[warningListener](#37)

</div>

# **概述**

anyRTC SDK 是anyRTC 为实时互动通信及直播类应用量身打造而成的SDK,包括了实时音频、视频、混音、屏幕共享等功能，适用于娱乐、游戏、教育等场景。支持公有云、混合云、私有云等部署方式。

使用前请前往anyRTC 网站（https://www.anyrtc.io）注册账号，并创建应用。

前端调用 arRtc 模块方法，初始化和加入频道。

**建议使用此模块之前先配置 config.xml 文件的 Feature，方法如下**

	名称：arRtc
	参数：appId
	描述：配置 arRtc 应用信息
```js
	<feature name="arRtc">
		<param name="appId" value="123456789" />
	</feature>
```


# **init**<div id="1"></div>

初始化RTC服务

init({params})

## params

appId：

- 类型：字符串
- 默认值：无
- 描述：（可选项）appid 为应用程序开发者签发的 App ID, 不设置时使用 config.xml 中的配置

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.init({appId:'appId'});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **destroy**<div id="2"></div>

该方法释放 ARtcKit SDK 使用的所有资源。有些应用程序只在用户需要时才进行语音通话，不需要时则将资源释放出来用于其他操作，该方法对这类程序可能比较有用。 只要调用了 destroy(), 用户将无法再使用和回调该 SDK 内的其它方法。如需再次使用通信功能，必须重新初始化。 

destroy()

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.destroy();
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **getSdkVersion**<div id="3"></div>

该方法返回 SDK 版本号字符串

getSdkVersion(callback(ret))

## callback(ret)

ret：

- 类型：字符串
- 描述：ARtcKit SDK 版本号

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.getSdkVersion(function(ret){
    api.alert({msg:'ARtcKit RTC SDK Version: ' + ret});
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **setParameters**<div id="4"></div>

设置特有参数

setParameters({params}, callback(ret))

## params

params：

- 类型：字符串
- 默认值：无
- 描述：将特有参数组装为 JSON 字符串

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.setParameters({
    params:''
}, function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **setLogFile**<div id="5"></div>

设置 SDK 的输出 log 文件。SDK 运行时产生的所有 log 将写入该文件。应用程序必须保证指定的目录存在而且可写。

setLogFile({params}, callback(ret))

## params

path：

- 类型：字符串
- 默认值：无
- 描述：将特有参数组装为 JSON 字符串

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

##示例代码

```js
var arRtc = api.require('arRtc');
arRtc.setLogFile({
    path:'cache://arRtc.log'
}, function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


#**setLogFilter**<div id="6"></div>

设置 SDK 的输出日志过滤器。不同的过滤器可以用或组合。

setLogFilter({params}, callback(ret))

## params

filter：

- 类型：数字
- 默认值：0x000f，INFO | WARNING | ERROR | FATAL
- 取值范围：
    * 1: INFO
    * 2: WARNING
    * 4: ERROR
    * 8: FATAL
    * 0x800: DEBUG

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.setLogFilter({
    filter:0x080f
}, function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **joinChannel**<div id="7"></div>

该方法让用户加入通话频道，在同一个频道内的用户可以互相通话，多个用户加入同一个频道，可以群聊。 使用不同 App ID 的应用程序是不能互通的。如果已在通话中，用户必须调用 leaveChannel() 退出当前通话，才能进入下一个频道。 

joinChannel({params}, callback(ret))

## params

token：

- 类型：字符串
- 默认值：空
- 描述：（可选项）
    * 安全要求不高: 将值设为 null
    * 安全要求高: 将值设置为 Token 值。 如果你已经启用了 App Certificate, 请务必使用 Token。 

channel：

- 类型：字符串
- 默认值：无
- 描述：标识通话的频道名，长度在64字节以内的字符串。以下为支持的字符集范围（共89个字符）: a-z,A-Z,0-9,space,! #$%&,()+, -,:;<=.#$%&,()+,-,:;<=.,>?@[],^_,{|},~

uid：

- 类型：字符串
- 默认值：无
- 描述：（可选项）uid 用户 ID，建议设置长度1~48，确保uid符合规则，并保证唯一性。如果不填或设置为nil，SDK 会自动分配一个，并在 joinChannelSuccessListener 回调方法中返回。

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.joinChannel({
    channel:'test'
}, function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **leaveChannel**<div id="8"></div>

离开频道，即挂断或退出通话。当调用 joinChannel() API 方法后，必须调用 leaveChannel() 结束通话，否则无法开始下一次通话。不管当前是否在通话中，都可以调用 leaveChannel()，没有副作用。该方法会把会话相关的所有资源释放掉。该方法是异步操作，调用返回时并没有真正退出频道。在真正退出频道后，SDK 会触发 leaveChannelListener 回调。

leaveChannel(callback(ret))

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.leaveChannel(function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **setChannelProfile**<div id="9"></div>

该方法用于设置频道模式(Profile)。RtcEngine 需知道应用程序的使用场景(例如通信模式或直播模式), 从而使用不同的优化手段。

setChannelProfile({params}, callback(ret))

## params

profile：

- 类型：数字
- 默认值：0, Communication
- 取值范围：
    * 0: Communication, 用于常见的一对一或群聊，频道中的任何用户可以自由说话
    * 1: LiveBroadcasting, 直播模式有主播和观众两种用户角色，可以通过调用 setClientRole 设置。主播可收发语音和视频，但观众只能收，不能发
    * 2: Game, 频道内任何用户可自由发言。该模式下默认使用低功耗低码率的编解码器

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc. setChannelProfile({
    profile: 1
}, function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **setClientRole**<div id="10"></div>

直播模式下在加入频道前，用户需要通过本方法设置观众(默认)或主播模式。在加入频道后，用户可以通过本方法切换用户模式。

setClientRole({params}, callback(ret))

## params

role：

- 类型：数字
- 默认值：2, 观众
- 取值范围：
    * 1: 主播
    * 2: 观众

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc. setClientRole({
    role: 1
}, function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **renewToken**<div id="11"></div>

该方法用于更新 Token。如果启用了 Token 机制，过一段时间后使用的 Token 会失效。 当 errorListener 回调报告 ERR_TOKEN_EXPIRED(109) ，或收到 requestTokenListener 回调时，应用程序应重新获取 Token，然后调用该 API 更新 Token，否则 SDK 无法和服务器建立连接。

renewToken({params}, callback(ret))

## params

token：

- 类型：字符串
- 默认值：无
- 描述：更新的 Token

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.renewToken({
    token:''
}, function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **enableVideo**<div id="12"></div>

该方法用于打开视频模式。可以在加入频道前或者通话中调用，在加入频道前调用，则自动开启视频模式，在通话中调用则由音频模式切换为视频模式。调用 disableVideo() 方法可关闭视频模式。

enableVideo(callback(ret))

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.enableVideo(function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **disableVideo**<div id="13"></div>

该方法用于关闭视频。可以在加入频道前或者通话中调用，在加入频道前调用，则自动开启纯音频模式，在通话中调用则由视频模式切换为纯音频频模式。 调用 enableVideo() 方法可开启视频模式。

disableVideo(callback(ret))

##callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.disableVideo(function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **enableLocalVideo**<div id="14"></div>

该方法用于打开或关闭本地视频采集和渲染。

enableLocalVideo({params}, callback(ret))

## params

enabled：

- 类型：布尔值
- 默认值：true
- 描述：是否打开本地视频

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.enableLocalVideo({
    enabled:true
}, function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **setVideoProfile**<div id="15"></div>

该方法设置视频编码属性（Profile），如分辨率、帧率、码率等。 当设备的摄像头不支持指定的分辨率时，SDK 会自动选择一个合适的摄像头分辨率，但是编码分辨率仍然用 setVideoProfile() 指定的。

setVideoProfile({params}, callback(ret))

## params

width：

- 类型：数字
- 默认值：无
- 描述：视频分辨率宽度

height：

- 类型：数字
- 默认值：无
- 描述：视频分辨率高度

frameRate：

- 类型：数字
- 默认值：无
- 描述：视频帧率

bitrate：

- 类型：数字
- 默认值：无
- 描述：视频码率

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

##示例代码

```js
var arRtc = api.require('arRtc');
arRtc.setVideoProfile({
    width: 360,
    height: 360,
    frameRate: 15,
    bitrate: 800
}, function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **switchCamera**<div id="16"></div>

该方法用于在前置/后置摄像头间切换。

switchCamera(callback(ret))

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.switchCamera(function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **startPreview**<div id="17"></div>

该方法用于启动本地视频预览。在开启预览前，必须先调用 setupLocalVideo() 设置预览窗口及属性，且必须调用 enableVideo() 开启视频功能。 如果在调用 joinChannel() 进入频道之前调用了 startPreview() 启动本地视频预览，在调用 leaveChannel() 退出频道之后本地预览仍然处于启动状态，如需要关闭本地预览，需要调用 stopPreview()。

startPreview(callback(ret))

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.startPreview(function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **stopPreview**<div id="18"></div>

该方法用于停止本地视频预览。

stopPreview(callback(ret))

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.stopPreview(function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **setupLocalVideo**<div id="19"></div>

该方法设置本地视频显示信息。应用程序通过调用此接口绑定本地视频流的显示视窗，并设置视频显示模式。在应用程序开发中，通常在初始化后调用该方法进行本地视频设置，然后再加入频道。退出频道后，绑定仍然有效，如果需要解除绑定，可以不设置 rect 调用 setupLocalVideo() 。

setupLocalVideo({params}, callback(ret))

## params

rect：

- 类型：JSON 对象
- 默认值：无
- 描述：（可选项）视频区域的位置及尺寸
- 内部字段：

```js
{
    x: 0, //（可选项）数字类型；视频区域左上角的 x 坐标（相对于所属的 Window 或 Frame）；默认：0
    y: 0, //（可选项）数字类型；视频区域左上角的 y 坐标（相对于所属的 Window 或 Frame）；默认：0
    w: 360, // 数字类型；视频区域的宽度
    h: 640 // 数字类型；视频区域的高度
}
```

fixedOn：

- 类型：字符串
- 默认值：模块依附于当前 window
- 描述：（可选项）模块视图添加到指定 frame 的名字（只指 frame，传 window 无效）

fixed：

- 类型：布尔值
- 默认值：true （不随之滚动）
- 描述：（可选项）模块是否随所属 window 或 frame 滚动

renderMode：

- 类型：数字
- 默认值：1
- 描述：（可选项）视频显示模式
- 取值范围：
    * 1: Hidden, 如果视频尺寸与显示视窗尺寸不一致，则视频流会按照显示视窗的比例进行周边裁剪或图像拉伸后填满视窗。
    * 2: Fit, 如果视频尺寸与显示视窗尺寸不一致，在保持长宽比的前提下，将视频进行缩放后填满视窗。
    * 3: Adaptive, 如果自己和对方都是竖屏，或者如果自己和对方都是横屏使用 Hidden；如果对方和自己一个竖屏一个横屏，则使用 Fit。

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

##示例代码

```js
var arRtc = api.require('arRtc');
arRtc.setupLocalVideo({
    rect:{ x: 0, y: 0, w: 360, h: 640 },
    fixed: false,
    renderMode: 1
}, function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **setupRemoteVideo**<div id="20"></div>

该方法绑定远程用户和显示视图，即设定 uid 指定的用户用哪个视图显示。调用该接口时需要指定远程视频的 uid，一般可以在进频道前提前设置好。

如果应用程序不能事先知道对方的 uid，可以在 APP 收到 remoteUserJoinedListener 事件时设置。如果启用了视频录制功能，视频录制服务会做为一个哑客户端加入频道，因此其他客户端也会收到它的 remoteUserJoinedListener 事件，APP 不应给它绑定视图（因为它不会发送视频流），如果 APP 不能识别哑客户端，可以在 firstRemoteVideoDecodedListener 事件时再绑定视图。解除某个用户的绑定视图可以不设置 rect。退出频道后，SDK 会把远程用户的绑定关系清除掉。

setupRemoteVideo({params}, callback(ret))

## params

uid：

- 类型：字符串
- 默认值：无
- 描述：远程用户ID，uid 用户 ID，建议设置长度1~48，确保uid符合规则，并保证唯一性。

rect：

- 类型：JSON 对象
- 默认值：无
- 描述：（可选项）视频区域的位置及尺寸
- 内部字段：

```js
{
    x: 0, //（可选项）数字类型；视频区域左上角的 x 坐标（相对于所属的 Window 或 Frame）；默认：0
    y: 0, //（可选项）数字类型；视频区域左上角的 y 坐标（相对于所属的 Window 或 Frame）；默认：0
    w: 360, // 数字类型；视频区域的宽度
    h: 640 // 数字类型；视频区域的高度
}
```

fixedOn：

- 类型：字符串
- 默认值：模块依附于当前 window
- 描述：（可选项）模块视图添加到指定 frame 的名字（只指 frame，传 window 无效）

fixed：

- 类型：布尔值
- 默认值：true （不随之滚动）
- 描述：（可选项）模块是否随所属 window 或 frame 滚动

renderMode：

- 类型：数字
- 默认值：1
- 描述：（可选项）视频显示模式
- 取值范围：
    * 1: Hidden, 如果视频尺寸与显示视窗尺寸不一致，则视频流会按照显示视窗的比例进行周边裁剪或图像拉伸后填满视窗。
    * 2: Fit, 如果视频尺寸与显示视窗尺寸不一致，在保持长宽比的前提下，将视频进行缩放后填满视窗。
    * 3: Adaptive, 如果自己和对方都是竖屏，或者如果自己和对方都是横屏使用 Hidden；如果对方和自己一个竖屏一个横屏，则使用 Fit。

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

##示例代码

```js
var arRtc = api.require('arRtc');
arRtc.setupRemoteVideo({
    uid: '123456'
    rect:{ x: 0, y: 0, w: 360, h: 640 },
    fixed: false,
    renderMode: 1
}, function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **muteLocalVideoStream**<div id="21"></div>

暂停/恢复发送本地视频流。注意：该方法不影响本地视频流获取，没有禁用摄像头。

muteLocalVideoStream({params}, callback(ret))

## params

mute：

- 类型：布尔值
- 默认值：true
- 取值范围：
    * true: 不发送本地视频流。
    * false: 发送本地视频流

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.muteLocalVideoStream({
    mute: true
}, function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **muteAllRemoteVideoStreams**<div id="22"></div>

暂停/恢复播放所有人的视频流。

muteAllRemoteVideoStreams({params}, callback(ret))

## params

mute：

- 类型：布尔值
- 默认值：true
- 取值范围：
    * true: 停止接收和播放所有远端视频流
    * false: 允许接收和播放所有远端视频流

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.muteAllRemoteVideoStreams({
    mute: true
}, function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **muteRemoteVideoStream**<div id="23"></div>

暂停/恢复播放指定的远端视频流。如果之前有调用过 muteAllRemoteVideoStreams(true) 对所有远端视频进行静音，在调用本 API 之前请确保你已调用 muteAllRemoteVideoStreams(false) 。 muteAllRemoteVideoStreams 是全局控制，muteRemoteVideoStream 是精细控制。

muteRemoteVideoStream({params}, callback(ret))

## params

uid：

- 类型：字符串
- 默认值：无
- 描述：远程用户ID，uid 用户ID，建议设置长度1~48，确保uid符合规则，并保证唯一性。

mute：

- 类型：布尔值
- 默认值：true
- 取值范围：
    * true: 停止接收和播放指定用户的视频流
    * false: 允许接收和播放指定用户的视频流

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.muteRemoteVideoStream({
    uid: '123456'
    mute: true
}, function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **enableAudio**<div id="24"></div>

打开音频(默认为开启状态)。

enableAudio(callback(ret))

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.enableAudio(function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **disableAudio**<div id="25"></div>

关闭音频。

disableAudio(callback(ret))

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.disableAudio(function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

##可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本

# **muteLocalAudioStream**<div id="26"></div>

静音/取消静音。该方法用于允许/禁止往网络发送本地音频流。

muteLocalAudioStream({params}, callback(ret))

## params

mute：

- 类型：布尔值
- 默认值：true
- 取值范围：
    * true: 麦克风静音
    * false: 取消静音

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.muteLocalAudioStream({
    mute:true
}, function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **muteAllRemoteAudioStreams**<div id="27"></div>

暂停/恢复播放远端用户的音频流，即对所有远端用户进行静音与否。

muteAllRemoteAudioStreams({params}, callback(ret))

## params

mute：

- 类型：布尔值
- 默认值：true
- 取值范围：
    * true: 停止接收和播放所有远端音频流
    * false: 允许接收和播放所有远端音频流

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.muteAllRemoteAudioStreams({
    mute: 1
}, function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **muteRemoteAudioStream**<div id="28"></div>

静音/取消静音指定远端用户。如果之前有调用过 muteAllRemoteAudioStreams(true) 对所有远端音频进行静音，在调用本 API 之前请确保你已调用 muteAllRemoteAudioStreams(false) 。 muteAllRemoteAudioStreams 是全局控制，muteRemoteAudioStream 是精细控制。

muteRemoteAudioStream({params}, callback(ret))

## params

uid：

- 类型：字符串
- 默认值：无
- 描述：远程用户ID，建议设置长度1~48，确保uid符合规则，并保证唯一性。

mute：

- 类型：布尔值
- 默认值：true
- 取值范围：
    * true: 停止接收和播放指定用户的音频流
    * false: 允许接收和播放指定用户的音频流

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	code: 0 // 返回的状态码，0为调用成功，否则为调用失败
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.muteRemoteAudioStream({
    uid: '123456',
    mute: true
}, function(ret) {
	if (ret.code == 0) {
		// success
	}
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **joinChannelSuccessListener**<div id="29"></div>

该回调方法表示该客户端成功加入了指定的频道。

joinChannelSuccessListener(callback(ret))

##callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	channel: 'test' // 字符串类型；频道名
	uid: '123456' // 字符串类型；用户 ID。如果 joinChannel 时指定了 uid，则此处返回该 ID；否则使用 ar云平台 服务器自动分配的 ID
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.joinChannelSuccessListener(function(ret) {
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **leaveChannelListener**<div id="30"></div>

当用户调用 leaveChannel 离开频道后，SDK 会触发该回调。

leaveChannelListener(callback())

##示例代码

```js
var arRtc = api.require('arRtc');
arRtc.leaveChannelListener(function() {
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **firstLocalVideoFrameListener**<div id="31"></div>

提示第一帧本地视频画面已经显示在屏幕上。

firstLocalVideoFrameListener(callback(ret))

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	width: 360 // 数字类型；视频宽度。
	height: 640 // 数字类型；视频高度。
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.firstLocalVideoFrameListener(function(ret) {
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **remoteUserJoinedListener**<div id="32"></div>

提示有用户加入了频道。如果该客户端加入频道时已经有用户在频道中，SDK也会向应用程序上报这些已在频道中的用户。

remoteUserJoinedListener(callback(ret))

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	uid: 1 // 数字类型；远程用户 ID。
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.remoteUserJoinedListener(function(ret) {
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **remoteUserOfflineListener**<div id="33"></div>

提示有用户离开了频道（或掉线）。SDK 判断用户离开频道（或掉线）的依据是超时: 在一定时间内（15 秒）没有收到对方的任何数据包，判定为对方掉线。 在网络较差的情况下，可能会有误报。建议可靠的掉线检测应该由信令来做。

remoteUserOfflineListener(callback(ret))

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	uid: 1 // 数字类型；远程用户 ID。
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.remoteUserOfflineListener(function(ret) {
    //arRtc.setupRemoteVideo({uid:ret.uid});
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **firstRemoteVideoDecodedListener**<div id="34"></div>

提示已收到第一帧远程视频流并解码。

firstRemoteVideoDecodedListener(callback(ret))

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	uid: 1 // 数字类型；远程用户 ID。
	width: 360 // 数字类型；视频宽度。
	height: 640 // 数字类型；视频高度。
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.firstRemoteVideoDecodedListener(function(ret) {
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **requestTokenListener**<div id="35"></div>

在调用 joinChannel 时如果指定了 Token，由于 Token 具有一定的时效，在通话过程中SDK可能由于网络原因和服务器失去连接，重连时可能需要新的 Token。 该回调通知APP需要生成新的 Token，并需调用 renewToken() 为 SDK 指定新的 Token。

requestTokenListener(callback())

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.requestTokenListener(function() {
    //arRtc.renewToken({token:'new token'});
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本


# **errorListener**<div id="36"></div>

该回调方法表示 SDK 运行时出现了（网络或媒体相关的）错误。通常情况下，SDK 上报的错误意味着 SDK 无法自动恢复，需要应用程序干预或提示用户。比如启动通话失败时，SDK 会上报 StartCall(1002) 错误，应用程序可以提示用户启动通话失败，并调用 leaveChannel() 退出频道。

errorListener(callback(ret))

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	errorCode: 0 // 数字类型；错误代码
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.errorListener(function(ret) {
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本

# **warningListener**<div id="37"></div>

该回调方法表示 SDK 运行时出现了（网络或媒体相关的）警告。通常情况下，SDK 上报的警告信息应用程序可以忽略，SDK 会自动恢复。比如和服务器失去连接时，SDK 可能会上报 OpenChannelTimeout(106) 警告，同时自动尝试重连。

warningListener(callback(ret))

## callback(ret)

ret：

- 类型：JSON 对象

内部字段：

```js
{
	warningCode: 0 // 数字类型；警告代码
}
```

## 示例代码

```js
var arRtc = api.require('arRtc');
arRtc.warningListener(function(ret) {
});
```

## 可用性

iOS 系统，Android 系统

可提供的 4.0.0 及更高版本

</div>
