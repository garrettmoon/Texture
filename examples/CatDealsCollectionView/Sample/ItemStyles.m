//
//  ItemStyles.m
//  Sample
//
//  Created by Samuel Stow on 12/30/15.
//
//  Copyright (c) 2014-present, Facebook, Inc.  All rights reserved.
//  This source code is licensed under the BSD-style license found in the
//  LICENSE file in the /ASDK-Licenses directory of this source tree. An additional
//  grant of patent rights can be found in the PATENTS file in the same directory.
//
//  Modifications to this file made after 4/13/2017 are: Copyright (c) 2017-present,
//  Pinterest, Inc.  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
//  FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
//  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "ItemStyles.h"

const CGFloat kTitleFontSize = 20.0;
const CGFloat kInfoFontSize = 14.0;

UIColor *kTitleColor;
UIColor *kInfoColor;
UIColor *kFinalPriceColor;
UIFont *kTitleFont;
UIFont *kInfoFont;

@implementation ItemStyles

+ (void)initialize {
  if (self == [ItemStyles class]) {
    kTitleColor = [UIColor darkGrayColor];
    kInfoColor = [UIColor grayColor];
    kFinalPriceColor = [UIColor greenColor];
    kTitleFont = [UIFont boldSystemFontOfSize:kTitleFontSize];
    kInfoFont = [UIFont systemFontOfSize:kInfoFontSize];
  }
}

+ (NSDictionary *)titleStyle {
  // Title Label
  return @{ NSFontAttributeName:kTitleFont,
            NSForegroundColorAttributeName:kTitleColor };
}

+ (NSDictionary *)subtitleStyle {
  // First Subtitle
  return @{ NSFontAttributeName:kInfoFont,
            NSForegroundColorAttributeName:kInfoColor };
}

+ (NSDictionary *)distanceStyle {
  // Distance Label
  return @{ NSFontAttributeName:kInfoFont,
            NSForegroundColorAttributeName:kInfoColor};
}

+ (NSDictionary *)secondInfoStyle {
  // Second Subtitle
  return @{ NSFontAttributeName:kInfoFont,
            NSForegroundColorAttributeName:kInfoColor};
}

+ (NSDictionary *)originalPriceStyle {
  // Original price
  return @{ NSFontAttributeName:kInfoFont,
            NSForegroundColorAttributeName:kInfoColor,
            NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle)};
}

+ (NSDictionary *)finalPriceStyle {
  //     Discounted / Claimable price label
  return @{ NSFontAttributeName:kTitleFont,
            NSForegroundColorAttributeName:kFinalPriceColor};
}

+ (NSDictionary *)soldOutStyle {
  // Setup Sold Out Label
  return @{ NSFontAttributeName:kTitleFont,
            NSForegroundColorAttributeName:kTitleColor};
}

+ (NSDictionary *)badgeStyle {
  // Setup Sold Out Label
  return @{ NSFontAttributeName:kTitleFont,
            NSForegroundColorAttributeName:[UIColor whiteColor]};
}

+ (UIColor *)badgeColor {
  return [[UIColor purpleColor] colorWithAlphaComponent:0.4];
}

+ (UIImage *)placeholderImage {
  static UIImage *__catFace = nil;
  if (!__catFace) {
    __catFace = [UIImage imageNamed:@"cat_face"];
  }
  return __catFace;
}

@end
