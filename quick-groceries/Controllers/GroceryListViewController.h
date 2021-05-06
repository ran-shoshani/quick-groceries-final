//
//  GroceryListViewController.h
//  quick-groceries
//
//  Created by ran shoshani on 9/4/21.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
#import "Ingredient.h"


NS_ASSUME_NONNULL_BEGIN

@interface GroceryListViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>


//
@property (strong, nonatomic) NSMutableDictionary *allGroceries;


@property (strong,nonatomic) Recipe *recipe;


@property (strong, nonatomic) IBOutlet UICollectionView *groceryListCollectionView;


@property (strong,nonatomic) NSMutableArray *allIngredients;

@property (strong, nonatomic) IBOutlet UILabel *totalPriceLabel;

- (IBAction)ClearListBtnClicked:(id)sender;


@end

NS_ASSUME_NONNULL_END
