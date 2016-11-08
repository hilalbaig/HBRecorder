# HBRecorder
**HBRecorder** is a video recording tool with pause/start feature & beautiful animations between video segments.

### How to get started
- install via [CocoaPods](http://cocoapods.org)


##### Install via CocoaPods

```ruby
platform :ios, '9.0'
pod 'HBRecorder'
```

### Usage

#### Import Header
`#import <HBRecorder/HBRecorder.h>>`

#### Present HBRecorder Controller

```objc
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
```

##### Delegates
```objc
- (void)recorder:( HBRecorder *  )recorder  didFinishPickingMediaWithUrl:(NSURL * )videoUrl;
- (void)recorderDidCancel:( HBRecorder *  )recorder;
```

##### Don’t Forget iOS 10 Privacy Settings
You have to add this below key in info.plist.
```ruby
Privacy - Camera usage description
```



### Requirements 
The current version of HBRecorder requires:
- Xcode 8 or later
- iOS 7 or later


### Communication

- If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/hbrecorder). (Tag 'HBRecorder')
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/hbrecorder).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

### Author
- [Hilal Baig](https://github.com/hilalbaig)


### Contributors
- [Hafeez Ahmed](https://github.com/imhafeezkpk)
- [Hilal Baig](https://github.com/hilalbaig)


### License
- HBRecorder is available under the BSD license. See the [LICENSE file](https://github.com/HBRecorder/HBRecorder/blob/master/LICENSE.txt).

