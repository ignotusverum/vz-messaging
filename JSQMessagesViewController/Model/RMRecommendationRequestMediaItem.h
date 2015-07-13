//
//  RMRecommendationRequestMediaItem.h
//  JSQMessages
//
//  Created by Vlad Zagorodnyuk on 7/13/15.
//  Copyright (c) 2015 Hexed Bits. All rights reserved.
//

#import "JSQMediaItem.h"

@interface RMRecommendationRequestMediaItem : JSQMediaItem <JSQMessageMediaData, NSCoding, NSCopying>

@property (copy, nonatomic) NSString * recommendationRequestString;

- (instancetype) initWithString:(NSString *)recommendationRequestString;

@end
