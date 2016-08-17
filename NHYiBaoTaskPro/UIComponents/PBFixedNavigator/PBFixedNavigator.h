//
//  PBFixedNavigator.h
//  NHYiBaoTaskPro
//
//  Created by hu jiaju on 16/8/17.
//  Copyright © 2016年 Nanhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PBFixedNavigatorDelegate;
@interface PBFixedNavigator : UIView

/*weak delegate*/
@property (nonatomic, weak) id<PBFixedNavigatorDelegate> delegate;

/**
 *  @brief init method
 *
 *  @param frame  the frame
 *  @param titles the titles for display
 *
 *  @return the instance
 */
- (id)initWithFrame:(CGRect)frame withTitles:(NSArray *)titles;

/**
 *  @brief update item's title's suffix
 *
 *  @param mCount suffix count
 *  @param index  item's index
 */
- (void)updateSuffix:(NSUInteger)mCount forIndex:(NSUInteger)index;

/**
 *  @brief update flag with scroller's content offset
 *
 *  @param offset the offset for scroller
 */
- (void)updateFlagWithContentOffset:(CGFloat)offset;

/**
 *  @brief select index
 *
 *  @param index the item's index
 */
- (void)selected2Index:(NSUInteger)index;

@end


@protocol PBFixedNavigatorDelegate <NSObject>

@optional
/**
 *  @brief navigator's selected method
 *
 *  @param navigator the navigator
 *  @param index     the selected index
 */
- (void)fixedNavigator:(PBFixedNavigator *)navigator didSelectIndex:(NSUInteger)index;

NS_ASSUME_NONNULL_END

@end

FOUNDATION_EXPORT int const mSubNavigatorHeight;