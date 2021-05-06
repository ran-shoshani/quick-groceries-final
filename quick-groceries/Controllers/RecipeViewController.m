//
//  RecipeViewController.m
//  quick-groceries
//
//  Created by ran shoshani on 9/4/21.
//

// importing header files
#import "Recipe.h"
#import "RecipeCell.h"
#import "GroceryListViewController.h"
#import "EditPriceViewController.h"
#import "RecipeViewController.h"
#import "GroceryListViewController.h"

// importing modules
@import FirebaseAuth;
@import FirebaseFirestore;



@interface RecipeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

// for prototype only, finished app will have firebase data



@end

@implementation RecipeViewController

@synthesize recipeCollectionView;
@synthesize pickedRecipe;

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
   
}



- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    // Do any additional setup after loading the view
    _allRecipesArray = [[NSMutableArray alloc] init];
    
    self.db = [FIRFirestore firestore];
    [self getRecipeCollection];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



// sign out user button
- (IBAction)signOut:(id)sender {
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    
    if(!status){
        NSLog(@"\n Error signing out: %@", signOutError);
    }
    else{
        NSLog(@"Sign out successful");
        [self dismissViewControllerAnimated:true completion:nil];
    }
}


    // this method gives the cell their content
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    // using custom cell
    RecipeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"recipeCell" forIndexPath:indexPath];
    
    // object of the recipe class used to access the values of each recipe for each cell
    Recipe* currentRecipe = [[self allRecipesArray] objectAtIndex:indexPath.row];
    [cell setRecipe:currentRecipe];
    
    // access the label property of the cell, call the method setText to modifiy the test value
    //pass the value of the title property of the currentRecipe object as the parameter to setText.
    [[cell lblTitle] setText:[currentRecipe title]];
    
//
//
//    UILabel *Label = (UILabel *)[cell viewWithTag:666];
//    NSString *documentID = [_recipeDictionary allKeys][indexPath.row];
//    NSString *recipeTitle = _recipeDictionary[documentID][@"title"];
//
//    Label.text = recipeTitle;
    
    return cell;
}




- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSLog(@" numberOfItemsinSection _recipeDictionary.count =  %lu", (unsigned long)[_allRecipesArray count]);
    return  [_allRecipesArray count];
}



// size of cell
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellWidth = collectionView.frame.size.width;
    CGFloat cellHeight = 180;
    
    return CGSizeMake(cellWidth, cellHeight);
}
 


// testing
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self setPickedRecipe:[[self allRecipesArray] objectAtIndex:indexPath.row]];
    NSLog(@"**** didSelectItemAtIndexPath %@", pickedRecipe.title);
}




// get deta from firebase/database
-(void) getRecipeCollection{
    
    [[self.db collectionWithPath:@"recipes"]getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError *_Nullable error){
        
        if(error != nil){
            NSLog(@"*******error getting Documents:%@", error);
        }
        else{
            
            
            // firestore/database 
            for(FIRDocumentSnapshot *document in snapshot.documents){
                
                // create an object of the recipe class for each recipe in the database
                Recipe* recipe = [[Recipe alloc] initWithTitle:document.data[@"title"] mainCourseName:document.data[@"mainCourseName"] sideDishName:document.data[@"sideDishName"] sideSauceName:document.data[@"sideSauceName"] mainCourseIngredients:document.data[@"mainCourseIngredients"] sideDishIngredients:document.data[@"sideDishIngredients"] sideSauceIngredients:document.data[@"sideSauceIngredients"]];
                                 
                
                NSLog(@"recipe %@",[recipe title]);
                [[self allRecipesArray] addObject:recipe];
            }
        }
        
        // NSLog(@"*****recipe dictionary = %@", self->_recipeDictionary);
        NSLog(@"\n getRecipeCollection _recipeDictionary.count =  %lu", (unsigned long)[self->_allRecipesArray count]);
        [self.recipeCollectionView reloadData];
    }];
}



// prepare to segue to pass data
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    // if the destination is the EditPriceViewController
    if ([[segue destinationViewController] isKindOfClass:[EditPriceViewController class]]){
        
        
        EditPriceViewController* editPriceViewController = [segue destinationViewController];
        
        NSMutableDictionary* ingredientList = [[NSMutableDictionary alloc] init];
        
        ingredientList = [pickedRecipe mergeIngredientList:pickedRecipe.mainCourseIngredients sideDish:pickedRecipe.sideDishIngredients sideSauce:pickedRecipe.sideSauceIngredients];
        
        [editPriceViewController setRecipe:pickedRecipe];
        
        
    } // if the destination is the groceriesListViewController
    else if ([[segue destinationViewController] isKindOfClass:[GroceryListViewController class]]){

        GroceryListViewController* groceryListViewController = [segue destinationViewController];

        NSMutableDictionary* tempGroceryList = [[NSMutableDictionary alloc]init];
        // add to groceryList
        tempGroceryList  = [pickedRecipe mergeIngredientList:pickedRecipe.mainCourseIngredients sideDish:pickedRecipe.sideDishIngredients sideSauce:pickedRecipe.sideSauceIngredients];

        [groceryListViewController setRecipe:pickedRecipe];

    }
    
    
    
}


@end
