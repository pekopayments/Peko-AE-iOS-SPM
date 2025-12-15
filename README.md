## ⚙️ iOS Setup
# Setup Instructions

## Step-by-Step Instructions
1. **Add the Package:**
   - In Xcode, select the **Pods** project in the Project Navigator (left sidebar)
   - Select the target
   - Go to the **"Package Dependencies"** tab (or "General" tab > "Frameworks, Libraries, and Embedded Content")
   - Click the **"+"** button
   - Enter the package URL: `https://github.com/pekopayments/Peko-AE-iOS-SPM.git`
   - Click **"Add Package"**
   - Select version: **"Up to Next Major Version"** with minimum **1.0.9**
   
2. **Resolve Packages:**
   - Go to **File > Packages > Resolve Package Versions**
   - Wait for Xcode to download and resolve the package

3. **import & Init:**
  
   ```
     import PekoSDK

     let objPekoAppearance = PekoAppearance()

    // PRIMARY THEME colorScheme
     objPekoAppearance.primaryThemeColor = UIColor(red: 205/255.0, green: 167/255.0, blue: 44/255.0, alpha: 1.0)
     objPekoAppearance.lightPrimaryThemeColor = UIColor(red: 255/255.0, green: 251/255.0, blue: 240/255.0, alpha: 1.0)
        
     let objPekoSDK = PekoSDKManager.sharedInstance
     objPekoSDK.appearance = objPekoAppearance
        
     let token = "" // ACESS token
     let rootViewController = // ROOT viewController
 
     objPekoSDK.userLogin(token: token, viewController: rootViewController)

4. **Clean and Build:**
   - Press `Cmd + Shift + K` to clean
   - Press `Cmd + B` to build
