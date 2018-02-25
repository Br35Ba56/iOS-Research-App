# Breast Feeding NFP
A iOS Research App built off of Apple's ResearchKit and Amazon Web Services.
This Research App is being created for a Doctorate Student's Disertation.  This ResearchKit based study aims to solidify the relationship between breast feeding and post partum return to cycle for women who have recently gave birth.

## Example

To run this project, clone iOS-Research-App and my forked ResearchKit project, this version of ResearchKit is different from the stable version from Apple.  Open the project using 'Breast Feeding NFP.xcworkspace' In the podfile, change the path of ResearchKit to the path of ResearchKit you cloned from my fork.
for example: ```pod 'ResearchKit', :path => "/YourPath/ResearchKit-Master/"``` then run `pod install` from your iOS-Research-App directory.

Next you'll need an AWS account, AWS free tier will suffice for now.  Create a Cognito User Pool (ensure to select "Email address or Phone number" so users can us either as a username) and link it to a Cognito Federated Identity.  Then you'll need an S3 Bucket to store user data.  Create this bucket and give your Cognito Federated Identity access to it via a IAM role.  

Finally, create a file in your app called DoNotCommit.swift or similar (You don't want to commit access keys) and structure it like the following:
```  
import Foundation
import AWSCore

struct AWSConstants {
  static let poolID = "YourCognitoPoolID"
  static let appClientID = "YourAppClientID"
  static let appClientSecret = "YourAppClientSecret"
  static let region = AWSRegionType.USEast1 //Which ever region your resources are held.
}
  ```
Note: You'll need to change your AWS Region throughout the app if you aren't using USEast1

If you have set everything up correctly, when test the app and you finish the onboarding, you'll see a user in your Cognito User Pool and you should see files in your S3 bucket.  If not, check your IAM roles and make sure Federated Identities is using the correct unauthenticated and authenticated roles.

## Contributing

Feel free to contribute to this project, please follow https://github.com/raywenderlich/swift-style-guide for code style.  I'm in process of adding to the Projects section of this repo so stay tuned.

## Requirements

Xcode version 9, Swift 4, and an AWS account.

## Author

Anthony Schneider

## License

Breast Feeding NFP is available under the GNU General Public License.
