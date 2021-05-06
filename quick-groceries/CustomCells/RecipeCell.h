//
//  RecipeCell.h
//  quick-groceries
//
//  Created by student on 2/5/21.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"


NS_ASSUME_NONNULL_BEGIN

@interface RecipeCell : UICollectionViewCell


@property (strong, nonatomic) Recipe *recipe;
@property (strong, nonatomic) NSMutableDictionary *ingredientList;

- (IBAction)btnEditPriceClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

- (IBAction)btnAddToGroceryClicked:(id)sender;



@end

NS_ASSUME_NONNULL_END
