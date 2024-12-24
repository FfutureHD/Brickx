# Brickx

![Brickx Logo](https://github.com/FfutureHD/Brickx/blob/master/textures/brickx-logo.png)

# About this Project:
An Arkanoid-style game for a WearOS Smart Watch   
might not perform good, I just want to try this because I can


# About me:
My name is Fabrice, I'm a student in Germany and working on this as a hobby in my spare time.  
I used to love a similar Game on the iPod and thought the rotary Input of my smart watch would be perfect for a Game like this.


# How to install the downloaded .apk on your smart watch:

## Activate Developer Options

Before you can sideload an app to your watch, first you'll need to activate Developer Options:  
- Open the `Settings`-App
- Scroll down to `About watch` and select it
- Scroll down to `Software information` and select it
- Quckly tap on `Software Version` until you see the message `Developer mode turned on.`

Now you can access the Developer Options if you scroll all the way down in the Settings.  
  
Follow the next steps depending on your device.

## Using a PC or Laptop:

<details>
<summary>Using Windows:</summary>

### Using Windows:
- head to the official [Android SDK Platform Tools](https://developer.android.com/studio/releases/platform-tools)
- Download SDK Platform-Tools for Windows
- Extract the Downloaded .zip file
- In your Smart Watch `Developer Options`, open `Wireless Debugging` and turn it on
- Make sure your Watch and your PC are connected to the same network
- Select `+ Pair new device` on your Watch
- On Windows, open the Android SDK platform tools folder
- Click the address bar and type cmd
- Press `Enter` to open the folder in the command line tool
- Paste the following into the Terminal and replace the X's with the IP adress and Port shown on your Watch:
#####
    adb pair XXX.XXX.X.XX:XXXXX
- Press `Enter`
- Enter the pairing code shown on your Watch
- Paste the following into the Terminal and replace the X's with the IP adress and Port (note that the Port has changed) shown on your Watch:
#####
    adb connect XXX.XXX.X.XX:XXXXX
- Press `Enter`
- Paste the following and drag the downloaded .apk file into the Terminal to add its path
#####
    adb install 
- The Terminal should start installing the Game onto your Watch

</details>
<details>
<summary>Using Linux:</summary>

### Using Linux:
- head to the official [Android SDK Platform Tools](https://developer.android.com/studio/releases/platform-tools)
- Download SDK Platform-Tools for Linux
- Extract the Downloaded .zip file
- In your Smart Watch `Developer Options`, open `Wireless Debugging` and turn it on
- Make sure your Watch and your PC are connected to the same network
- Select `+ Pair new device` on your Watch
- Open the `Terminal` app in Linux
- Type cd followed by a space and drag the extracted Android SDK platform-tools folder into the Terminal to add its path
- Press `Enter`
- Paste the following into the Terminal and replace the X's with the IP adress and Port shown on your Watch:
#####
    ./adb pair XXX.XXX.X.XX:XXXXX
- Press `Enter`
- Enter the pairing code shown on your Watch
- Paste the following into the Terminal and replace the X's with the IP adress and Port (note that the Port has changed) shown on your Watch:
#####
    ./adb connect XXX.XXX.X.XX:XXXXX
- Press `Enter`
- Paste the following and drag the downloaded .apk file into the Terminal to add its path
#####
    ./adb install 
- The Terminal should start installing the Game onto your Watch

</details>
<details>
<summary>Using MacOS:</summary>

### Using MacOS:
- head to the official [Android SDK Platform Tools](https://developer.android.com/studio/releases/platform-tools)
- Download SDK Platform-Tools for Mac
- Extract the Downloaded .zip file
- In your Smart Watch `Developer Options`, open `Wireless Debugging` and turn it on
- Make sure your Watch and your Mac are connected to the same network
- Select `+ Pair new device` on your Watch
- Open the `Terminal` app on your Mac
- Type cd followed by a space and drag the extracted Android SDK platform-tools folder into the Terminal to add its path
- Press `Enter`
- Paste the following into the Terminal and replace the X's with the IP adress and Port shown on your Watch:
#####
    ./adb pair XXX.XXX.X.XX:XXXXX
- Press `Enter`
- Enter the pairing code shown on your Watch
- Paste the following into the Terminal and replace the X's with the IP adress and Port (note that the Port has changed) shown on your Watch:
#####
    ./adb connect XXX.XXX.X.XX:XXXXX
- Press `Enter`
- Paste the following and drag the downloaded .apk file into the Terminal to add its path
#####
    ./adb install 
- The Terminal should start installing the Game onto your Watch

</details>
<details>
<summary>Using ChromeOS:</summary>

### Using ChromeOS:
- head to the official [Android SDK Platform Tools](https://developer.android.com/studio/releases/platform-tools)
- Download SDK Platform-Tools for Linux
- Extract the Downloaded .zip file
- Open the `Settings` app
- Navigate to `Advanced > Developers`
- Click the `Turn on` button for Linux development environment
- Click the `Next` button to get started
- Follow the on-screen instructions and wait for the installation to finish. You can name the terminal anything you want, then leave everything else at the default settings.
- A new window appears with text and a dark-themed screen. It has the same name you gave it during the installation process. This new window is your Linux terminal.
- In your Smart Watch `Developer Options`, open `Wireless Debugging` and turn it on
- Make sure your Watch and your Mac are connected to the same network.
- Select `+ Pair new device` on your Watch
- If you already installed the Linux development environment, open the `Terminal` app on your Chromebook
- Type cd followed by a space and drag the extracted Android SDK platform-tools folder into the Terminal to add its path
- Press `Enter`
- Paste the following into the Terminal and replace the X's with the IP adress and Port shown on your Watch:
#####
    ./adb pair XXX.XXX.X.XX:XXXXX
- Press `Enter`
- Enter the pairing code shown on your Watch
- Paste the following into the Terminal and replace the X's with the IP adress and Port (note that the Port has changed) shown on your Watch:
#####
    ./adb connect XXX.XXX.X.XX:XXXXX
- Press `Enter`
- Paste the following and drag the downloaded .apk file into the Terminal to add its path
#####
    ./adb install 
- The Terminal should start installing the Game onto your Watch

</details>


  
## Using your Smartphone:

<details>
<summary>Using Android:</summary>

### Using Android:

- Install [`Bugjaeger Mobile ADB - USB OTG`](https://play.google.com/store/apps/details?id=eu.sisik.hackendebug)
- In your Smart Watch `Developer Options`, open `Wireless Debugging` and turn it on.
- Make sure your Watch and your Smartphone are connected to the same network.
- Select `+ Pair new device` on your Watch
- Open the Bugjaeger App on your Smartphone
- Tap on the top right icon that looks like an AC power plug with a plus sign in front of it
- Tap on `<> PAIR`
- Enter the IP address, port, and pairing code from your Watch into the Bugjaeger App
- Select `PAIR`
- Select `CONNECT`
- Swipe Right until you reach the `Packages` tab
- Tap on the bottom right `+` Button
- Select `Select APK File` and tap on `OK`
- Navigate to the downloaded .apk file and select it
- The Bugjaeger App should start installing the Game onto your Watch

</details>
<details>
<summary>Using iOS:</summary>

### Using iOS:

- Install [`Bugjaeger - Mobile ADB`](https://apps.apple.com/us/app/bugjaeger-mobile-adb/id6463413200)
- In your Smart Watch `Developer Options`, open `Wireless Debugging` and turn it on.
- Make sure your Watch and your Smartphone are connected to the same network.
- Select `+ Pair new device` on your Watch
- Open the Bugjaeger App on your Smartphone
- Select `Connect new device wirelessly`
- Select `Pair new device`
- Enter the IP address, port, and pairing code from your Watch into the Bugjaeger App
- Select `PAIR`
- Enter the IP adress and port from your Watch into the Bugjaeger App (note that the Port has changed)
- Select `CONNECT`
- Swipe Right until you reach the `Packages` tab
- Tap on the bottom right `+` Button
- Navigate to the downloaded .apk file and select it
- Tap on `Open` in the top right corner
- The Bugjaeger App should start installing the Game onto your Watch

</summary>
