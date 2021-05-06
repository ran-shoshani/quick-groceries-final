//
//  Ingredient.m
//  quick-groceries
//
//  Created by ran shoshani on 3/5/21.
//

#import "Ingredient.h"

@implementation Ingredient


- (instancetype)init
{
    self = [super init];
    
    return self;
}
 
- (instancetype)initWithName: (NSString*) name
                      amount:  (NSString*) amount
                       price:  (NSString*) price
                    category: (NSString *) category
{
    self = [super init];
    if (self) {
        _name = name;
        _amount  = amount;
        _price = price;
        _category = category;
    }
    return self;
}




@end
