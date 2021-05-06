//
//  LoginViewController.h
//  quick-groceries
//
//  Created by ran shoshani on 23/4/21.
//


#import <UIKit/UIKit.h>

// import modules
@import Firebase;
@import FirebaseUI;

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController <FUIAuthDelegate>

@property FIRFirestore *db;

@end

NS_ASSUME_NONNULL_END
