//
//  Recipe.m
//  quick-groceries
//
//  Created by ran shoshani on 2/5/21.
//

#import "Recipe.h"

@implementation Recipe


-(instancetype)initWithTitle: (NSString*) title
              mainCourseName: (NSString*) mainCourseName
                sideDishName:  (NSString*) sideDishName
               sideSauceName:  (NSString*) sideSauceName
       mainCourseIngredients: (NSMutableDictionary*)mainCourseIngredients
         sideDishIngredients: (NSMutableDictionary*)sideDishIngredients
        sideSauceIngredients: (NSMutableDictionary*) sideSauceIngredients

{
    self = [super init];
    if (self){
        
        _title = title;
        _mainCourseName = mainCourseName;
        _sideDishName = sideDishName;
        _sideSauceName = sideSauceName;
        _mainCourseIngredients = mainCourseIngredients;
        _sideDishIngredients = sideDishIngredients;
        _sideSauceIngredients = sideSauceIngredients;
        
        
    }
    return  self;
}


// merge the ingredients list from the mainCourse, sideDish & sideSauce
-(NSMutableDictionary *) mergeIngredientList: (NSMutableDictionary*) mainCourse
                                    sideDish:(NSMutableDictionary*) sideDish
                                   sideSauce:(NSMutableDictionary*) sideSauce
{
    
    // create an index for the new key
    long index = 0;
    NSMutableDictionary *allIngredients = [[NSMutableDictionary alloc] init];
    
    for(id key in mainCourse){
        // object to store in the new dictionary
        id object = [mainCourse objectForKey: key];
        // need to create a new key inorder to enable to separate the ingredient list again
        NSString *newKey = [NSString stringWithFormat:@"%@-%ld", @"mainCourse", index];
        // store the object with the new key in new dictionary
        [allIngredients setObject:object forKey:newKey];
        index++;
    }
    
    // reset the index beweetn loops, so it always start at 0 for the next ingredient group
    index = 0;
    for(id key in sideDish){
        // object to store in the new dictionary
        id object = [sideDish objectForKey: key];
        // need to create a new key inorder to enable to separate the ingredient list again
        NSString *newKey = [NSString stringWithFormat:@"%@-%ld", @"sideDish", index];
        // store the object with the new key in new dictionary
        [allIngredients setObject:object forKey:newKey];
        index++;
    }
    
    
    // reset the index beweetn loops, so it always start at 0 for the next ingredient group
    index = 0;
    for(id key in sideSauce){
        // object to store in the new dictionary
        id object = [sideSauce objectForKey: key];
        // need to create a new key inorder to enable to separate the ingredient list again
        NSString *newKey = [NSString stringWithFormat:@"%@-%ld", @"sideSauce", index];
        // store the object with the new key in new dictionary
        [allIngredients setObject:object forKey:newKey];
        index++;
    }
    
    NSLog(@"allIngredients %@", allIngredients);
    return  allIngredients;
}

@end
