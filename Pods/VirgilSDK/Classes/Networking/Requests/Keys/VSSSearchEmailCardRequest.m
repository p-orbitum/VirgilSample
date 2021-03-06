//
//  VSSSearchEmailCardRequest.m
//  VirgilSDK
//
//  Created by Pavel Gorb on 5/2/16.
//  Copyright © 2016 VirgilSecurity. All rights reserved.
//

#import "VSSSearchEmailCardRequest.h"
#import "VSSModelCommons.h"
#import "VSSCard.h"
#import "VSSPublicKey.h"
#import "NSObject+VSSUtils.h"

@interface VSSSearchEmailCardRequest ()

@property (nonatomic, strong, readwrite) NSArray <VSSCard *>* __nullable cards;

@end

@implementation VSSSearchEmailCardRequest

@synthesize cards = _cards;

- (instancetype)initWithContext:(VSSRequestContext *)context value:(NSString *)value {
    self = [super initWithContext:context];
    if (self == nil) {
        return nil;
    }
    
    if (value.length > 0) {
        [self setRequestBodyWithObject:@{ kVSSModelValue: value }];
    }
    return self;
}

- (instancetype)initWithContext:(VSSRequestContext *)context {
    return [self initWithContext:context value:@""];
}

#pragma mark - Overrides

- (NSString *)methodPath {
    return @"virgil-card/actions/search/email";
}

- (NSError *)handleResponse:(NSObject *)candidate {
    NSError *error = [super handleResponse:candidate];
    if (error != nil) {
        return error;
    }
    
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    for (NSDictionary *item in [candidate as:[NSArray class]]) {
        /// Deserialize actual card
        VSSCard *card = [VSSCard deserializeFrom:item];
        if (card != nil) {
            [cards addObject:card];
        }
    }
    if (cards.count > 0) {
        self.cards = cards;
    }
    return nil;
}


@end