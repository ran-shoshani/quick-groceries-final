//
//  RecipeViewController.h
//  quick-groceries
//
//  Created by ran shoshani on 9/4/21.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

// importing modules
@import FirebaseFirestore;


NS_ASSUME_NONNULL_BEGIN

@interface RecipeViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *recipeCollectionView;

@property (nonatomic, readwrite) FIRFirestore *db;

@property (strong,nonatomic) NSMutableArray *allRecipesArray;

@property (strong,nonatomic) Recipe *pickedRecipe;

@end

NS_ASSUME_NONNULL_END
