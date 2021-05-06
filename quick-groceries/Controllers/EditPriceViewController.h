//
//  EditPriceViewController.h
//  quick-groceries
//
//  Created by ran shoshani on 9/4/21.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
#import "Ingredient.h"

@import FirebaseFirestore;


NS_ASSUME_NONNULL_BEGIN

@interface EditPriceViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *editPriceCollectionView;


@property (strong, nonatomic) NSMutableArray *allIngredients;

@property (strong,nonatomic) Recipe *recipe;

@property (strong, nonatomic) FIRFirestore *db;


- (IBAction)saveBtnClicked:(id)sender;

@property (strong, nonatomic) Ingredient *pickedIngredient;


@end

NS_ASSUME_NONNULL_END
