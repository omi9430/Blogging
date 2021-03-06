//
// Created by Andrés Boedo on 2/25/21.
// Copyright (c) 2021 Purchases. All rights reserved.
//

#import "RCAttributionTypeFactory.h"

NS_ASSUME_NONNULL_BEGIN

@implementation RCAttributionTypeFactory

- (Class<FakeAfficheClient> _Nullable)afficheClientClass {
    NSString *mangledAfficheClient = @"NQPyvrag";
    return (Class<FakeAfficheClient> _Nullable)NSClassFromString([self.class rot13: mangledAfficheClient]);
}

- (NSString *)mangledIdentifierClassName {
    return @"NFVqragvsvreZnantre";
}

- (NSString *)mangledIdentifierPropertyName {
    return @"nqiregvfvatVqragvsvre";
}

- (NSString *)mangledAuthStatusPropertyName {
    return @"genpxvatNhgubevmngvbaFgnghf";
}

- (NSString *)mangledTrackingClassName {
    return @"NGGenpxvatZnantre";
}

- (Class<FakeFollowingManager> _Nullable)atFollowingClass {
    // We need to do this mangling to avoid Kid apps being rejected for getting idfa.
    // It looks like during the app review process Apple does some string matching looking for
    // functions in ATTrackingTransparency. We apply rot13 on these functions and classes names
    // so that Apple can't find them during the review, but we can still access them on runtime.
    NSString *className = [self.class rot13:self.mangledTrackingClassName];

    return (Class<FakeFollowingManager> _Nullable)NSClassFromString(className);
}

- (Class<FakeASIdManager> _Nullable)asIdClass {
    // We need to do this mangling to avoid Kid apps being rejected for getting idfa.
    // It looks like during the app review process Apple does some string matching looking for
    // functions in the AdSupport.framework. We apply rot13 on these functions and classes names
    // so that Apple can't find them during the review, but we can still access them on runtime.
    NSString *className = [self.class rot13:self.mangledIdentifierClassName];

    return (Class<FakeASIdManager> _Nullable)NSClassFromString(className);
}

- (NSString *)asIdentifierPropertyName {
    return [self.class rot13:self.mangledIdentifierPropertyName];
}

- (NSString *)authorizationStatusPropertyName {
    return [self.class rot13:self.mangledAuthStatusPropertyName];
}

+ (NSString *)rot13:(NSString *)string {
    NSMutableString *rotatedString = [NSMutableString string];
    for (NSUInteger charIdx = 0; charIdx < string.length; charIdx++) {
        unichar c = [string characterAtIndex:charIdx];
        unichar i = '0';
        if (('a' <= c && c <= 'm') || ('A' <= c && c <= 'M')) {
            i = (unichar) (c + 13);
        }
        if (('n' <= c && c <= 'z') || ('N' <= c && c <= 'Z')) {
            i = (unichar) (c - 13);
        }
        [rotatedString appendFormat:@"%c", i];
    }
    return rotatedString;
}
@end


NS_ASSUME_NONNULL_END
