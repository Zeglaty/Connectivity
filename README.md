- Setup you fire base ios App / download and add the **GoogleService-Info.plist** 
- Fire base Console : setup cloud messaging  [ upload .p8 file , team ID , key] that you will get from the Apple App connect when registering for APNs
- Create an app on the app-store-connect make sure to connect it to the same Bundle Identifier
- Project > TARGETS > Signing & Capabilities > add [backGround Mode (background fetch , remote notifications ) ] 

![Screen Shot 2020-10-19 at 11.11.43 AM](/Users/abdalmagidnew/Library/Application Support/typora-user-images/Screen Shot 2020-10-19 at 11.11.43 AM.png)

- Project > TARGETS > Info, the link that you will add hear you find it in the **GoogleService-Info.plist** under the name ```REVERSED_CLIENT_ID```  

![Screen Shot 2020-10-19 at 11.12.35 AM](/Users/abdalmagidnew/Library/Application Support/typora-user-images/Screen Shot 2020-10-19 at 11.12.35 AM.png)

- Add **NotificationController** file
- setup **AppDelegate** as in the example file



```swift

```

