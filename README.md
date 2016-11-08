# HBRecorder
<img src="Screenshots/iPhone6plus%20Screenshot%201.png" width="230" height="408" />
<img src="Screenshots/iPhone6plus%20Screenshot%202.png" width="230" height="408" />
<img src="Screenshots/iPhone6plus%20Screenshot%203.png" width="230" height="408" />

**HBRecorder** is a video recording tool with pause/start feature & beautiful animations between video segments. **HBRecorder** is build over SCRecorder.

In short, here is a short list of the cool things you can do:

 * Record multiple video segments
 * Zoom/Focus easily
 * Remove any record segment that you don't want
 * Display the result into a convenient video player
 * Save the record session for later somewhere using a serializable NSDictionary (works in NSUserDefaults)
 * Add a configurable and animatable video filter using Core Image
 * Add a UIView as overlay, so you can render anything you want on top of your video
 * Merge and export the video using fine tunings that you choose
 * Examples for iOS are provided.

### How to get started
- install via [CocoaPods](http://cocoapods.org)


##### Install via CocoaPods

```ruby
platform :ios, '9.0'
pod 'HBRecorder'
```

# Usage

### Import Header
`#import <HBRecorder/HBRecorder.h>>`

### Present HBRecorder Controller

```objc
//get HBRecorder.storyboard reference
NSBundle *bundle = [NSBundle bundleForClass:HBRecorder.class];
UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HBRecorder.bundle/HBRecorder" bundle:bundle];

//get HBRecorder controller reference
HBRecorder *recorder = [sb instantiateViewControllerWithIdentifier:@"HBRecorder"];
recorder.delegate = self;

//Set top tile over video
recorder.topTitle = @"Top title";

//Set bottom tile over video
recorder.bottomTitle = @"HilalB - ©";

//Set recorder max recording duration
recorder.maxRecordDuration = 60 * 3;

//Set recorded movie name
recorder.movieName = @"MyAnimatedMovie";

//push recorder on navigation controller
recorder.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
[self.navigationController pushViewController:recorder animated:YES];
```

### Delegates `<HBRecorderProtocol>`
```objc
- (void)recorder:( HBRecorder *  )recorder  didFinishPickingMediaWithUrl:(NSURL * )videoUrl;

- (void)recorderDidCancel:( HBRecorder *  )recorder;
```

##### Don’t Forget iOS 10 Privacy Settings
You have to add this below key in info.plist.
```ruby
Privacy - Camera usage description
```
### Download Example to explore more



##### Requirements 
The current version of HBRecorder requires:
- Xcode 8 or later
- iOS 7 or later


##### Communication

- If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/hbrecorder). (Tag 'HBRecorder')
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/hbrecorder).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

##### Author
- [Hilal Baig](https://github.com/hilalbaig)


##### Contributors
- [![alt text][1.1]][1][![alt text][2.1]][2][![alt text][3.1]][3] Hafeez Ahmed 
- [![alt text][1.1]][4][![alt text][2.1]][5][![alt text][3.1]][6] Hilal Baig 



<!-- links to your social media accounts -->
[1]: http://www.twitter.com/imhafeezkpk
[2]: https://www.facebook.com/imhafeezkpk
[3]: http://www.github.com/imhafeez

<!-- links to your social media accounts -->
[4]: http://www.twitter.com/hilalbaig
[5]: http://www.facebook.com/hilalbaig
[6]: http://www.github.com/hilalbaig

<!-- links to social media icons -->
[1.1]: http://i.imgur.com/wWzX9uB.png (twitter icon without padding)
[2.1]: http://i.imgur.com/fep1WsG.png (facebook icon without padding)
[3.1]: http://i.imgur.com/9I6NRUm.png (github icon without padding)

##### License
- HBRecorder is available under the BSD license. See the [LICENSE file](https://github.com/hilalbaig/HBRecorder/blob/master/LICENSE).

#Apps using HBRecorder

If you are using HBRecorder in your app or know of an app that uses it, please add it to  [this list](https://github.com/hilalbaig/HBRecorder/wiki/Apps-using-HBRecorder).



