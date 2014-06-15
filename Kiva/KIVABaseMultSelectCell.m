//
//  KIVABaseMultiSelectCell.m
//  Kiva
//
//  Created by Ronald Mannak on 6/14/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import "KIVABaseMultSelectCell.h"

static const NSInteger kFirstButtonTag = 1000;

@interface KIVABaseMultiSelectCell ()

@property (nonatomic, strong) NSMutableSet *selectedIndexes;
@property (nonatomic, readonly) BOOL  isAllSelected;

@end

@implementation KIVABaseMultiSelectCell

- (void)selectAllButtons
{
    NSInteger tag = kFirstButtonTag;
    while ([self viewWithTag:tag]) {
        UIButton *button = (UIButton *)[self viewWithTag:tag];
        button.selected = YES;
        tag++;
    }
}

- (void)restorePreviouslySelectedButtons
{
    NSInteger tag = kFirstButtonTag;
    while ([self viewWithTag:tag]) {
        UIButton *button = (UIButton *)[self viewWithTag:tag];
        button.selected = [self.selectedIndexes containsObject:@(tag)];
    }
}

- (void)buttonTapped:(UIButton *)sender
{
    if (sender.tag == kFirstButtonTag && self.firstButtonIsAll) {
        if (sender.isSelected) {
            [self restorePreviouslySelectedButtons];
            sender.selected = NO;
        } else {
            [self selectAllButtons];
        }
    } else {
        sender.selected = !sender.selected;
        if (sender.isSelected) {
            [self.selectedIndexes addObject:@(sender.tag)];
        } else {
            [self.selectedIndexes removeObject:@(sender.tag)];
        }
    }
}

#pragma mark - Getters and Setters

- (BOOL)isAllSelected
{
    UIButton *allButton = (UIButton *)[self viewWithTag:kFirstButtonTag];
    if (allButton.isSelected && self.firstButtonIsAll) {
        return YES;
    }
    return NO;
}

- (NSSet *)selectedButtons
{
    NSMutableSet *selectedButtons = [NSMutableSet new];
    NSInteger tag = kFirstButtonTag + (self.firstButtonIsAll? 1 : 0); // don't include All button
    while ([self viewWithTag:tag]) {
        UIButton *button = (UIButton *)[self viewWithTag:tag];
        if (button.isSelected) {
            [selectedButtons addObject:button.titleLabel.text];
        }
    }
    return selectedButtons.count? selectedButtons : nil;
}

@end
