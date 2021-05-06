//
//  LoginViewController.m
//  quick-groceries
//
//  Created by ran shoshani on 23/4/21.
//


// import header
#import "LoginViewController.h"
#import "NavigationViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//If you enabled Google or Facebook sign-in, implement a handler for the result of the Google and Facebook sign-up flows:
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options {
  NSString *sourceApplication = options[UIApplicationOpenURLOptionsSourceApplicationKey];
  return [[FUIAuth defaultAuthUI] handleOpenURL:url sourceApplication:sourceApplication];
}


//After you present the authentication view and the user signs in, the result is returned to the FirebaseUI Auth delegate in the didSignInWithUser:error: method:
- (void)authUI:(FUIAuth *)authUI
didSignInWithAuthDataResult:(nullable FIRUser *)user
         error:(nullable NSError *)error {
// Implement this method to handle signed in user or error if any.
    
    if ( user == nil )
    {
        NSLog(@"login Unsuccessful------------------");
    }
    else
    {
        NSLog(@"login Successful------------------");
        [self showNavigationViewController];
    }
    
}




- (IBAction)loginClicked:(id)sender {
    // check for current user
    if([[[FIRAuth auth]currentUser]uid] != nil){
        // found current user
        [self showNavigationViewController];
    }
    else
    {
        // did not find current user
        [self firebaseLogin];
        
    }
    
}

-(void) firebaseLogin {
    
    FUIAuth *authUI = [FUIAuth defaultAuthUI];
    // You need to adopt a FUIAuthDelegate protocol to receive callback
    authUI.delegate = self;
    
    
    NSArray<id<FUIAuthProvider>> *providers = @[
      [[FUIEmailAuth alloc] init]
    ];
    authUI.providers = providers;
    
    UINavigationController *authViewController = [authUI authViewController];
    
    
    authViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:authViewController animated:YES completion:nil];
    
}


-(void) showNavigationViewController {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    NavigationViewController *navigationViewController = (NavigationViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"NavigationViewController"];

    navigationViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:navigationViewController animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
