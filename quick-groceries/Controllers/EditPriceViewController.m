//
//  EditPriceViewController.m
//  quick-groceries
//
//  Created by ran shoshani on 9/4/21.
//



// importing header files
#import "Recipe.h"
#import "EditPriceViewController.h"
#import "EditPriceCell.h"



@interface EditPriceViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>


@end

@implementation EditPriceViewController

@synthesize  editPriceCollectionView;

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"RECEIVED RECIPE: %@", _recipe.title);
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.db = [FIRFirestore firestore];
    
    _allIngredients = [[NSMutableArray alloc]init];
    [self prepareIngredients];
    
    
    
}


// for every  cell in the collection 
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    // using custom cell
    EditPriceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EditPriceCell" forIndexPath:indexPath];
    
    
    Ingredient *currentIngredient = [[self allIngredients] objectAtIndex:indexPath.row];
        
    
    
    
    // display information in the EditPriceCell cell
    [[cell ingredientLabel] setText: [currentIngredient name]];
    [[cell amountLabel] setText:[currentIngredient amount]];
    
     
    // convert number to string
    NSString *price = [NSString stringWithFormat:@"%@", [currentIngredient price]];
    [[cell priceTextBox] setText:price];
    
    
    
    
    return cell;
}


// size of collection
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

        
    NSLog(@"numberOfItemsInSection %lu", [_allIngredients count]);
    return  [_allIngredients count];
    
    
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellWidth = collectionView.frame.size.width;
    CGFloat cellHeight = 120;
    
    return CGSizeMake(cellWidth, cellHeight);
}






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
    
    [self.editPriceCollectionView reloadData];
    

}

// save button - save to database
- (IBAction)saveBtnClicked:(id)sender {
    
    FIRDocumentReference *recipeRef = [[self.db collectionWithPath:@"recipes"]documentWithPath:_recipe.title];
    [recipeRef updateData:@{ @"mainCourseIngredients": _recipe.mainCourseIngredients,@"sideDishIngredients": _recipe.sideDishIngredients, @"sideSauceIngredients": _recipe.sideSauceIngredients} completion:^(NSError * _Nullable error) {
        if (error != nil) {
          NSLog(@"Error updating document: %@", error);
        } else {
          NSLog(@"Document successfully updated");
        }}];
    
    
    [self.editPriceCollectionView reloadData];
}




@end
