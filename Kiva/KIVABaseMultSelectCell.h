//
//  KIVABaseMultiSelectCell.h
//  Kiva
//
//  Created by Ronald Mannak on 6/14/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KIVABaseMultiSelectCell;
@protocol KIVAMultiselectCellDelegate <NSObject>
- (void)multiSelectCell:(KIVABaseMultiSelectCell *)cell
        didSelectButton:(UIButton *)button;
@end

@interface KIVABaseMultiSelectCell : UICollectionViewCell

/**
 *  YES if the first button in the cell is All or Any.
 *  Tapping All or Any will select all buttons in the cell
 */
@property (nonatomic, readonly) BOOL firstButtonIsAll;

/**
 *  Core Data entity name (use for NSPredicate)
 */
@property (nonatomic, readonly) NSString *entityName;

/**
 *  Array of NSStrings with buttons names.
 *  Make sure button names match the attributes
 *  in the database to use the results in an NSPredicate.
 */
@property (nonatomic, readonly) NSSet *selectedButtons;

/**
 *  Selects all buttons in the cell. Should be called
 */
- (void)selectAllButtons;

- (void)buttonTapped:(UIButton *)sender;

@end
