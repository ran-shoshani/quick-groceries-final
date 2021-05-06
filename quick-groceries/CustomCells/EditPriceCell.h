//
//  EditPriceCell.h
//  quick-groceries
//
//  Created by student on 3/5/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface EditPriceCell : UICollectionViewCell



@property (strong, nonatomic) IBOutlet UILabel *ingredientLabel;

@property (strong, nonatomic) IBOutlet UILabel *amountLabel;


@property (strong, nonatomic) IBOutlet UITextField *priceTextBox;


- (IBAction)trashBtnClicked:(id)sender;


@end

NS_ASSUME_NONNULL_END
