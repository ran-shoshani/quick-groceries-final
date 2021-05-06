//
//  GroceryListViewController.m
//  quick-groceries
//
//  Created by ran shoshani on 13/4/21.
//

// import header
#import "GroceryListViewController.h"
#import "Ingredient.h"



@interface GroceryListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>


@property (strong, nonatomic) IBOutlet UIView *EmptyListView;

@property (strong, nonatomic) IBOutlet UIView *LabelRow;

@property (strong, nonatomic) IBOutlet UIView *BottomView;

@end



@implementation GroceryListViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _allIngredients = [[NSMutableArray alloc] init];
    
    
    
    //[self prepareCollectionViewData];
    
    // function MutableArray allIngredients gets the data
    [self prepareIngredients];
    [self displayEmptyListView];
    
}



// display empty list message
- (void) displayEmptyListView{
    if (_allIngredients.count > 0){
        _EmptyListView.hidden = true;
    }
    else
    {
        _EmptyListView.hidden = false;
        _LabelRow.hidden = true;
        _BottomView.hidden = true;
    }
}





// for every  cell in the collection
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    Ingredient *currentIngredient = [[self allIngredients] objectAtIndex:indexPath.row];
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GroceryListItem" forIndexPath:indexPath];
    
    UILabel *IngredientLabel = (UILabel *)[cell viewWithTag:200];
    IngredientLabel.text = [currentIngredient name];
    
    UILabel *AmountLabel = (UILabel *)[cell viewWithTag:201];
    AmountLabel.text = [currentIngredient amount];
    
    UILabel *PriceLabel = (UILabel *)[cell viewWithTag:202];
    NSString *price = [NSString stringWithFormat:@"%@", [currentIngredient price]];
    PriceLabel.text = price;
    
    
    
    return cell;
}


// count the cells
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
        
    NSLog(@"numberOfItemsInSection %lu", [_allIngredients count]);
    return  [_allIngredients count];
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellWidth = collectionView.frame.size.width;
    CGFloat cellHeight = 120;
    
    return CGSizeMake(cellWidth, cellHeight);
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



// MutableArray allIngredients gets the data
- (void)prepareIngredients {
    
    NSEnumerator *mainCourseEnumerator = [[[self recipe] mainCourseIngredients] objectEnumerator];
    id mainCourseValue;
    while ((mainCourseValue = [mainCourseEnumerator nextObject])) {
        NSString *amount = mainCourseValue[@"amount"];
        NSString *name = mainCourseValue[@"name"];
        NSString *price = mainCourseValue[@"price"];
        Ingredient *ingredient = [[Ingredient alloc] initWithName:name amount:amount price:price category:@"mainCourse"];
        [_allIngredients addObject:ingredient];
        NSLog(@"ingredient: %@", ingredient.name);
    }
    NSEnumerator *sideDishEnumerator = [[[self recipe] sideDishIngredients] objectEnumerator];
    id sideDishValue;
    while ((sideDishValue = [sideDishEnumerator nextObject])) {
        NSString *amount = sideDishValue[@"amount"];
        NSString *name = sideDishValue[@"name"];
        NSString *price = sideDishValue[@"price"];
        Ingredient *ingredient = [[Ingredient alloc] initWithName:name amount:amount price:price category:@"sideDish"];
        [_allIngredients addObject:ingredient];
        NSLog(@"ingredient: %@", ingredient.name);
    }
    NSEnumerator *sideSauceEnumerator = [[[self recipe] sideSauceIngredients] objectEnumerator];
    id sideSauceValue;
    while ((sideSauceValue = [sideSauceEnumerator nextObject])) {
        NSString *amount = sideSauceValue[@"amount"];
        NSString *name = sideSauceValue[@"name"];
        NSString *price = sideSauceValue[@"price"];
        Ingredient *ingredient = [[Ingredient alloc] initWithName:name amount:amount price:price category:@"sideDish"];
        [_allIngredients addObject:ingredient];
        NSLog(@"ingredient: %@", ingredient.name);
    }
    
    
    NSLog(@"_allIngredients %@", _allIngredients);
    //    _mutableDictionaryIngredients = [_recipe mergeIngredientList:_recipe.mainCourseIngredients sideDish:_recipe.sideDishIngredients sideSauce:_recipe.sideSauceIngredients];
    [self.groceryListCollectionView reloadData];
    
    // call function total price
    [self calculateTotalPrice];

}


// clear list button
- (IBAction)ClearListBtnClicked:(id)sender {
    
    [[self allIngredients] removeAllObjects];
    
    [[self groceryListCollectionView]reloadData];
    
    // function check if empty
    [self displayEmptyListView];
    
}

-(void) calculateTotalPrice{
    double totalPrice = 0;
    for (Ingredient *ingredient in _allIngredients){
        totalPrice = totalPrice + [[ingredient price]floatValue];
    }
    
    NSLog(@"the ingredients total price : %f@", totalPrice);
    
    
    // display to total price label with convertion
    _totalPriceLabel.text = [NSString stringWithFormat:@"$ %.2f",totalPrice];
}



@end
