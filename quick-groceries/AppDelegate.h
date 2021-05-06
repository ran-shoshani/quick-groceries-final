//
//  AppDelegate.h
//  quick-groceries
//
//  Created by ran shoshani on 31/3/21.
//

#import <UIKit/UIKit.h>

// import modules
@import Firebase;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property FIRFirestore *db;

@end

