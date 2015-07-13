//
//  RMRecommendationRequestMediaItem.m
//  JSQMessages
//
//  Created by Vlad Zagorodnyuk on 7/13/15.
//  Copyright (c) 2015 Hexed Bits. All rights reserved.
//

#import "RMRecommendationRequestMediaItem.h"

#import "UIColor+JSQMessages.h"
#import "JSQMessagesMediaPlaceholderView.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"

@interface RMRecommendationRequestMediaItem ()

@property (strong , nonatomic) UIView * recommendationRequestView;

@end

@implementation RMRecommendationRequestMediaItem


- (instancetype) initWithString:(NSString *)recommendationRequestString
{
    self = [super init];
    
    if (self) {
        _recommendationRequestView = nil;
        _recommendationRequestString = [recommendationRequestString copy];
    }
    
    return self;
}


- (void) dealloc
{
    _recommendationRequestView = nil;
    _recommendationRequestString = nil;
}


#pragma mark - Setters


- (void) setRecommendationRequestString:(NSString *)recommendationRequestString
{
    _recommendationRequestString = [recommendationRequestString copy];
}


- (UIView *) mediaView
{
    if (!self.recommendationRequestString || self.recommendationRequestString.length == 0) {
        return nil;
    }
    
    if (!self.recommendationRequestView) {
        CGSize size = CGSizeMake(200.0f, 100.0f);
        UIView * recommendationRequestView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        recommendationRequestView.backgroundColor = [UIColor jsq_messageBubbleLightGrayColor];
        
        UILabel * label = [UILabel new];
        label.numberOfLines = 0;
        label.frame = CGRectMake(20, 0, size.width, size.height - 30.0f);
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont fontWithName:@"Futura" size:12.0];
        label.text = self.recommendationRequestString;
        [recommendationRequestView addSubview:label];
        
        UIButton * leftButton = [[UIButton alloc] initWithFrame:CGRectMake(20.0, label.frame.origin.y + label.frame.size.height - 10, 80, 20)];
        leftButton.backgroundColor = [UIColor lightGrayColor];
        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:11.0];
        [leftButton setTitle:@"Yes, show me" forState:UIControlStateNormal];
        [recommendationRequestView addSubview:leftButton];
        
        UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(leftButton.frame.origin.x + leftButton.frame.size.width + 5, label.frame.origin.y + label.frame.size.height - 10, 80, 20)];
        rightButton.backgroundColor = [UIColor lightGrayColor];
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont fontWithName:@"Futura" size:11.0];
        [rightButton setTitle:@"No,not now" forState:UIControlStateNormal];
        [recommendationRequestView addSubview:rightButton];
        
        [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:recommendationRequestView isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        self.recommendationRequestView = recommendationRequestView;
    }
    
    return self.recommendationRequestView;
}


- (UIView *)mediaPlaceholderView
{
    if (self.cachedPlaceholderView == nil) {
        CGSize size = CGSizeMake(200.0f, 100.0f);
        
        UIView *view = [JSQMessagesMediaPlaceholderView viewWithActivityIndicator];
        view.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        
        [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:view isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        
        self.cachedPlaceholderView = view;
    }
    
    return self.cachedPlaceholderView;
}


- (NSUInteger)mediaHash
{
    return self.hash;
}


#pragma mark - NSObject


- (NSUInteger)hash
{
    return super.hash ^ self.recommendationRequestString.hash;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: recommendationRequestString=%@, appliesMediaViewMaskAsOutgoing=%@>",
            [self class], self.recommendationRequestString, @(self.appliesMediaViewMaskAsOutgoing)];
}


#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _recommendationRequestString = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(recommendationRequestString))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.recommendationRequestString forKey:NSStringFromSelector(@selector(image))];
}

#pragma mark - NSCopying


- (instancetype)copyWithZone:(NSZone *)zone
{
    RMRecommendationRequestMediaItem * copy = [[[self class] allocWithZone:zone] initWithString:self.recommendationRequestString];
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}


@end
