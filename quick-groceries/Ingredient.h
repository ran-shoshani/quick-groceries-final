//
//  Ingredient.h
//  quick-groceries
//
//  Created by ran shoshani on 3/5/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Ingredient : NSObject

@property NSString* name;
@property NSString* amount;
@property NSString* price;
@property NSString* category;
 
- (instancetype)initWithName: (NSString*) name
                      amount:  (NSString*) amount
                       price:  (NSString*) price
                    category: (NSString *)category;



@end

NS_ASSUME_NONNULL_END
