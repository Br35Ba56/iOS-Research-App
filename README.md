# Breast Feeding NFP
An iOS Research App built off of Apple's ResearchKit and Amazon Web Services.

This ResearchKit based study aims to solidify the relationship between breast feeding and post-partum return to cycle for women who have recently gave birth.

## Example

To run this project, clone iOS-Research-App, my forked ResearchKit project (this version of ResearchKit is different from the stable version from Apple which is at v2.), and https://github.com/Br35Ba56/iOS-Research-App-AWS-Config.git   Open the project using 'Breast Feeding NFP.xcworkspace' In the podfile, change the path of ResearchKit to the path of ResearchKit you cloned from my fork.
for example: ```pod 'ResearchKit', :path => "/YourPath/ResearchKit-Master/"``` then run `pod install` from your iOS-Research-App directory.

Next you'll need an AWS account, the AWS CLI, and terraform.

To install terraform, follow the instructions at this link:  https://www.terraform.io/intro/getting-started/install.html

Using a terminal navigate to the directory where the cloned terraform.tf is located and execute the following

```  
terraform init
terraform apply
```
Be sure to enter your default region and type yes to have the infrastructure built in your AWS account.

Next you need to retrieve some information about what you just built in your AWS account.  In a terminal type the following commands and note the output:

This command will get cognito pool and app client information needed later, save the output.
```  
terraform state show aws_cognito_user_pool_client.client | grep -E 'user_pool_id|client_secret|^id'
```

This should output the following:
```
id = XXXX //poolID
client_secret = XXXX  //appClientSecret
user_pool_id = XXXX   //appClientID
```
This command will get the cognito identity pool id needed later, save the output

```
terraform state show aws_cognito_identity_pool.main | grep '^id '
```
Which should output the following:
```
id = xxxx  //identityPoolID
```

This command will get the s3 bucket information where surveys and consent documents are stored, save the output.

```
terraform state show aws_s3_bucket.survey | grep '^id'
```
This should output the following:

```
id = nfpbreastfeedingsurveybucket-xxxxxxx //bucket
```
Finally, create a file in your app called DoNotCommit.swift or similar (You don't want to commit access keys) and structure it like the following:
```  
import Foundation
import AWSCore

struct AWSConstants {
  static let poolID = "YourCognitoPoolID"
  static let appClientID = "YourAppClientID"
  static let appClientSecret = "YourAppClientSecret"
  static let identityPoolID = "YouIdentityPoolID"
  static let region = AWSRegionType.USEast1 //Which ever region your resources are held.
  static let bucket = "YourS3BucketName"
  static let mobileAnalyticsAppId = "ID" //You need to create this manually in amazon pinpoint and add the app id.  Wil be scripted out                                          //later.
}
  ```
Note: You'll need to change your AWS Region app if you aren't using USEast1

If you have set everything up correctly you should be able to select 'Join Study', when you finish the onboarding process you should see a user in your Cognito User Pool and you should see files in your S3 bucket.

## Contributing

Feel free to contribute to this project, please follow https://github.com/raywenderlich/swift-style-guide for code style.  I am constantly adding notes in the projects sections so feel free to help with any of those.

## Requirements

Xcode version 9, Swift 4, and an AWS account.

## Author

Anthony Schneider

## License

Breast Feeding NFP is available under the GNU General Public License.
