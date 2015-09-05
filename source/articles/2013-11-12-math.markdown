---
title: Open + Download Native Apps with a PhoneGap/Cordova Plugin
date: 2013-11-12
layout: post
---
<p>Are you working on a PhoneGap/Cordova app that needs to be able to communicate with other native applications? You may want to get the <strong><a href="https://github.com/Ross-Hunter/external_app_launcher">demo code</a></strong>, maybe give it a once over, and then continue reading.</p>

<p>Note: This work was completed in a pre-PhoneGap 3.0.0 world. There is now a <a href="http://cordova.apache.org/docs/en/edge/plugin_ref_spec.md.html">Plugin Specification Guide</a> that should be adhered to. This code would need to be adapted to fit that structure.</p>

<h3>Prologue</h3>

<p>Recently, we were brought in to add functionality to an existing PhoneGap app that had been created by an internal team. One new bit of functionality was to integrate with another 3rd party app. We wanted to be able to click a button in our PhoneGap app and have it open a native Android or iOS app if it was already installed. If the 3rd party app was not installed, we wanted to launch the appropriate marketplace to download the app.</p>

<p>As anyone who has done any PhoneGap development knows, "write once, deploy everywhere" is a bigger lie than the cake. We decided that when we needed to write platform specific code we would keep it isolated to plugins and create a plugin for each platform that conformed to the same interface. Examples of plugins we implemented in this app include calendar, datepicker (Android only) and Google Analytics. Our process for these followed the same template as *ExternalAppLauncher*: a common interface in *lib* that references a Cordova Plugin that is defined in a platform specific javascript file. In the demo code, you'll notice a *Dependencies* folder for each platform, which is concatenated to the common codebase of the PhoneGap site by our build process.</p> 

<h3>Pretend we are building a web app</h3>

<p>The folder structure represented in the demo code is a remnant of the original project we inherited. I have not done extensive PhoneGap development outside of this project, so I am not sure if those are PhoneGap/Cordova conventions or not, but they work.</p>

<p>Being the good little OO developer that I am, I was hyper focused on keeping the same interface for our app code regardless of platform or environment. We abstracted Environment options into an Environment object and our platform specific code into Cordova plugins. So in our app, the actual call to open the external app is quite simple</p>

<script src="https://gist.github.com/Ross-Hunter/7433959.js"></script>

<p>Android uses the app identifier for both launching and finding the app in the Google Play store. iOS uses a <a href="https://developer.apple.com/library/ios/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/AdvancedAppTricks/AdvancedAppTricks.html#//apple_ref/doc/uid/TP40007072-CH7-SW50">custom url scheme</a>. for launching the native app, but in order to find it in the app store you need to know the app store url.</p>

<p>In order to cover our bases, we defined an app options object in our Environment object like so:</p>

<script src="https://gist.github.com/Ross-Hunter/7433984.js"></script>

<h3>Going Native</h3>

<p>Now let's move into the platform specific code. Basing my code off open-source examples, I created a plugin in Java for Android and in Objective-C for iOS. The basics of setting up a Cordova plugin for iOS and Android are outside the scope of this blog post but check out PhoneGap documentation for <a href="http://docs.PhoneGap.com/en/2.7.0/guide_plugin-development_android_index.md.html#Developing%20a%20Plugin%20on%20Android">Android</a> and <a href="http://docs.PhoneGap.com/en/2.7.0/guide_plugin-development_ios_index.md.html#Developing%20a%20Plugin%20on%20iOS">iOS</a>, if you'd like to know more. PhoneGap's documentation is pretty good. There are examples of how to do this in <a href="https://github.com/sbahal/external-app-launcher">just iOS</a>, but I found the information about Android was quite scattered.</p>

<p>We wanted these 2 plugins to have the same external interface. Cordova enforces some of this for us by giving us the <a href="http://docs.PhoneGap.com/en/2.7.0/guide_plugin-development_index.md.html">cordova.exec()</a> method. The 2 methods I wanted to be able to pass through to the native code were *launchApp* and *launchMarket*. For Android, we passed an *androidAppId* as the argument for both *launchApp* and *launchMarket*, but in iOS we needed to pass *iosUrlScheme* for *launchApp* and *appStoreUrl* to *launchMarket*. Yay! We've successfully isolated the platform specific code to plugins!</p>

<p>Now for specifics on the native plugins. We leveraged the CDVPlugin and CordovaPlugin classes that we got from Cordova and implemented our two methods *launchApp* and *launchMarket*. Android adds some extra boilerplate, which required us to implement the *execute* method ourselves, but it's essentially just a controller method that calls the other methods. I chose to develop this solution such that instead of the plugin handling either launching the app or the market, the result of *launchApp* would return success or error back into our app. This allowed us to handle the state inside of our app instead of inside the plugin. On error, we launch our *_askToDownload* message. I am glad this code lives inside our app and not inside of a native plugin, as we won't need to update this code in 2 places when we want to change the confirmation message or any other behavior.</p>

<h3>Epilogue</h3>

<p>Personally, I am unhappy with PhoneGap/Cordova as a solution for mobile development. However, it does have its place where cross-platform is an immediate goal, budget is a consideration, and the app doesn't require too much functionality. I was surprised to find so many examples of PhoneGap developers who only develop for one platform - why aren't they doing native development?</p>

<p>When I began working on this problem, I couldn't find a single example of how to launch an external app using PhoneGap that gave any consideration toward multiple platforms. Hopefully my post helps fill this void and you have found it useful.</p>

<p><em>Originally posted on the <a href="http://www.mutuallyhuman.com/blog/2013/11/12/open-download-native-apps-with-a-phonegap-cordova-plugin/">MHS Blog</a></em></p>
