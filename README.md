- Setup you fire base ios App / download and add the **GoogleService-Info.plist** 
- Fire base Console : setup cloud messaging  [ upload .p8 file , team ID , key] that you will get from the Apple App connect when registering for APNs
- Create an app on the app-store-connect make sure to connect it to the same Bundle Identifier
- Project > TARGETS > Signing & Capabilities > add [backGround Mode (background fetch , remote notifications ) ] 

![Screen Shot 2020-10-19 at 12.47.47 PM](/Users/abdalmagidnew/Desktop/Projects/Components/Project/FireBaseConnectivity/README Photos/Screen Shot 2020-10-19 at 12.47.47 PM.png)

- Project > TARGETS > Info, the link that you will add hear you find it in the **GoogleService-Info.plist** under the name ```REVERSED_CLIENT_ID```  

![Screen Shot 2020-10-19 at 12.47.59 PM](/Users/abdalmagidnew/Desktop/Projects/Components/Project/FireBaseConnectivity/README Photos/Screen Shot 2020-10-19 at 12.47.59 PM.png)

- Add **NotificationController** file
- setup **AppDelegate** as in the example file



```swift

```

