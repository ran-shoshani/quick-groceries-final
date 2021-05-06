//
//  RecipeCell.m
//  quick-groceries
//
//  Created by student on 2/5/21.
//

#import "RecipeCell.h"

@implementation RecipeCell

- (IBAction)btnEditPriceClicked:(id)sender {
    
    NSLog(@" edit price btn clicked %@", _lblTitle.text);

}



- (IBAction)btnAddToGroceryClicked:(id)sender {
    
    NSLog(@" add to grocery btn clicked %@", _lblTitle.text);
    
    
    // merge all three ingredient lists from the recipe before it can be passed to the other view controll
    [[self recipe] mergeIngredientList:[[self recipe] mainCourseIngredients] sideDish:[[self recipe]sideDishIngredients] sideSauce:[[self recipe] sideDishIngredients]];
    
}


@end
