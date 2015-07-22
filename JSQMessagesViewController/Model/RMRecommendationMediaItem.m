//
//  RMRecommendationMediaItem.m
//  JSQMessages
//
//  Created by Vlad Zagorodnyuk on 7/13/15.
//  Copyright (c) 2015 Hexed Bits. All rights reserved.
//

#import "RMRecommendationMediaItem.h"

#import "UIColor+JSQMessages.h"
#import "JSQMessagesMediaPlaceholderView.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"

#import <QuartzCore/QuartzCore.h>

@interface RMRecommendationMediaItem ()

@property (strong , nonatomic) UIView * recommendationView;

@end

@implementation RMRecommendationMediaItem


- (instancetype) initWithString:(NSString *)recommendationRequestString
{
    self = [super init];
    
    if (self) {
        _recommendationRequestString = nil;
        _recommendationRequestString = [recommendationRequestString copy];
    }
    
    return self;
}


- (void) dealloc
{
    _recommendationRequestString = nil;
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
    
    if (!self.recommendationView) {
        CGSize size = CGSizeMake(200.0f, 200.0);
        UIView * recommendationRequestView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        recommendationRequestView.backgroundColor = [UIColor colorWithRed:(242.0/255.0) green:(242.0/255.0) blue:(242.0/255.0) alpha:1.0];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, 80.0)];
        imageView.image = [UIImage imageNamed:@"hero"];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [recommendationRequestView addSubview:imageView];
        
        UILabel * label = [UILabel new];
        label.numberOfLines = 0;
        label.frame = CGRectMake(15, imageView.frame.size.height, 320.0f, 30.0f);
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont fontWithName:@"Gotham-Book" size:14.0];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.recommendationRequestString];
        NSMutableParagraphStyle *paragrahStyle = [NSMutableParagraphStyle new];
        [paragrahStyle setLineSpacing:3];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, attributedString.length)];
        
        label.attributedText = attributedString;
        
        [recommendationRequestView addSubview:label];
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(105.0, 10, 80, 15.0f)];
        button.backgroundColor = [UIColor colorWithRed:(242.0/255.0) green:(242.0/255.0) blue:(242.0/255.0) alpha:1.0];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"Gotham-Book" size:8.0];
        [button setTitle:@"OPTION ON HOLD" forState:UIControlStateNormal];

        button.layer.cornerRadius = 4;
        button.layer.borderWidth = 0.2;
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        [recommendationRequestView addSubview:button];
        
        UIImageView * info = [[UIImageView alloc] initWithFrame:CGRectMake(170.0, label.frame.origin.y + 7, 15, 15)];
        info.image = [UIImage imageNamed:@"info"];
        info.contentMode = UIViewContentModeScaleToFill;
        [recommendationRequestView addSubview:info];
        
        
        UIImageView * clock = [[UIImageView alloc] initWithFrame:CGRectMake(15, label.frame.origin.y + 30, 15, 15)];
        clock.image = [UIImage imageNamed:@"clock"];
        clock.contentMode = UIViewContentModeScaleToFill;
        [recommendationRequestView addSubview:clock];
        
        UILabel * label2 = [UILabel new];
        label2.numberOfLines = 0;
        label2.frame = CGRectMake(clock.frame.origin.x + clock.frame.size.width + 10, label.frame.origin.y + 13, 320.0f, 50);
        label2.textAlignment = NSTextAlignmentLeft;
        label2.font = [UIFont fontWithName:@"Gotham-Book" size:12.0];
        label2.text = @"6:00 pm";
        [recommendationRequestView addSubview:label2];
        
        UIButton * leftButton = [[UIButton alloc] initWithFrame:CGRectMake(15.0, label2.frame.origin.y + label2.frame.size.height - 10, 80, 25)];
        leftButton.backgroundColor = [UIColor colorWithRed:(172.0/255.0) green:(148.0/255.0) blue:(86.0/255.0) alpha:1.0];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont fontWithName:@"Gotham-Book" size:10.0];
        [leftButton setTitle:@"Reserve now" forState:UIControlStateNormal];
        
        leftButton.layer.cornerRadius = 4;
        leftButton.layer.borderWidth = 0.2;
        leftButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        [recommendationRequestView addSubview:leftButton];
        
        UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(leftButton.frame.origin.x + leftButton.frame.size.width + 5, label2.frame.origin.y + label2.frame.size.height - 10, 80, 25)];
        rightButton.backgroundColor = [UIColor whiteColor];
        [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont fontWithName:@"Gotham-Book" size:10.0];
        [rightButton setTitle:@"No thanks" forState:UIControlStateNormal];
        
        rightButton.layer.cornerRadius = 4;
        rightButton.layer.borderWidth = 0.2;
        rightButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        [recommendationRequestView addSubview:rightButton];
        
        UIProgressView * offerProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(15, rightButton.frame.origin.y + rightButton.frame.size.height + 10, 163.0, 20.0)];
        offerProgressView.progress = 0.8;
        offerProgressView.progressTintColor = [UIColor colorWithRed:162.0/255.0 green:201.0/255.0 blue:112.0/255.0 alpha:1.0];
        [recommendationRequestView addSubview:offerProgressView];
        
        UILabel * label3 = [UILabel new];
        label3.numberOfLines = 0;
        label3.frame = CGRectMake(15, label.frame.origin.y + 80, 320.0f, 50);
        label3.textAlignment = NSTextAlignmentLeft;
        label3.font = [UIFont fontWithName:@"Gotham-Book" size:12.0];
        label3.text = @"Offer expires in: 24m";
        [recommendationRequestView addSubview:label3];
        
        [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:recommendationRequestView isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        self.recommendationView = recommendationRequestView;
    }
    
    return self.recommendationView;
}


- (UIView *)mediaPlaceholderView
{
    if (self.cachedPlaceholderView == nil) {
        CGSize size = CGSizeMake(200.0f, 200.0);
        
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
    RMRecommendationMediaItem * copy = [[[self class] allocWithZone:zone] initWithString:self.recommendationRequestString];
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}



@end
