//
//  Recipe.h
//  quick-groceries
//
//  Created by ran shoshani on 2/5/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Recipe : NSObject



@property NSString* title;
@property NSString* mainCourseName;
@property NSString* sideDishName;
@property NSString* sideSauceName;

@property NSMutableDictionary* mainCourseIngredients;
@property NSMutableDictionary* sideDishIngredients;
@property NSMutableDictionary* sideSauceIngredients;


-(instancetype)initWithTitle: (NSString*) title
              mainCourseName: (NSString*) mainCourseName
                sideDishName:  (NSString*) sideDishName
               sideSauceName:  (NSString*) sideSauceName
       mainCourseIngredients: (NSMutableDictionary*)mainCourseIngredients
         sideDishIngredients: (NSMutableDictionary*)sideDishIngredients
        sideSauceIngredients: (NSMutableDictionary*) sideSauceIngredients;
              


-(NSMutableDictionary *) mergeIngredientList: (NSMutableDictionary*) mainCourse
                                            sideDish:(NSMutableDictionary*) sideDish
                                   sideSauce:(NSMutableDictionary*) sideSauce;


@end

NS_ASSUME_NONNULL_END
