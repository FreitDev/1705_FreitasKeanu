Installation instructions:
1. Download the file, unzip the file and run the xcode project.
2. Clean the project in xcode and run build it.
3. Use the iPhone 7+ stimulator to test the application.
4. Run the project stimulator.
5. There is only four Views that I have been focusing on this week. LoginView, MapView, ListView and DetailsView.

Hardware considerations and requirements:
- 10.3 software. So make sure that your device is updated.
- This is only in portrait mode for now.
- And this is not for universal devices. Only iPhones. 
- I have not used contraints for all views yet so it may look different on other devices that is not an iPhone 7+.

Any login requirements for testing:
- There is a skip button at the login page if you choose not to log in.
- If you do want to try the login part for the application, you can use your own Facebook credentials to login.
- It will ask you for an email or phone number and then your Facebook password.

List of known bugs:
- Falling back to storing access token in NSUserDefaults because of simulator bug.
- WARNING: Output of vertex shader 'v_gradient' not read by fragment shader.
- When I was doing research on these bugs I found out that they are common when using the stimulator.  
- But if using a device these bugs should disappear.

Any other special requirements and considerations for testing:
- No other special requirements and considerations for testing at this time.
