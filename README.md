- Setup you fire base ios App / download and add the **GoogleService-Info.plist** 
- Fire base Console : setup cloud messaging  [ upload .p8 file , team ID , key] that you will get from the Apple App connect when registering for APNs
- Create an app on the app-store-connect make sure to connect it to the same Bundle Identifier
- Project > TARGETS > Signing & Capabilities > add [backGround Mode (background fetch , remote notifications ) ] 

![alt text](https://github.com/Zeglaty/Connectivity/blob/master/README%20Photos/Screen%20Shot%202020-10-19%20at%2012.47.47%20PM.png)

- Project > TARGETS > Info, the link that you will add hear you find it in the **GoogleService-Info.plist** under the name ```REVERSED_CLIENT_ID```  

![alt text](https://github.com/Zeglaty/Connectivity/blob/master/README%20Photos/Screen%20Shot%202020-10-19%20at%2012.47.59%20PM.png)

- Add **NotificationController** file
- setup **AppDelegate** as in the example file



```swift

```

