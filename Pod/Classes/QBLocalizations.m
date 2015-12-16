//
//  QBLocalizations.m
//  QBImagePickerControllerDemo
//
//  Created by Andrew Gubanov on 16/12/15.
//  Copyright © 2015 Katsuma Tanaka. All rights reserved.
//

#import "QBLocalizations.h"

static inline NSBundle *QBResourceBundle(void) 
{
    static NSBundle *sBundle = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NSString *frameworkBundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"QBResources.bundle"];
        sBundle = [NSBundle bundleWithPath:frameworkBundlePath];
    });
    return sBundle;
}


NSString *QBLocalizedString(NSString *aToken)
{
    if (aToken == 0) 
    {
        return @"";
    }
    
    NSString *overridenString = NSLocalizedString(aToken, @"");
    if (overridenString && ![aToken isEqualToString:overridenString]) 
    {
        return overridenString;
    } 
    else if (QBResourceBundle() != nil) 
    {
        NSString *localizedString = NSLocalizedStringFromTableInBundle(aToken, @"QBImagePickerController", QBResourceBundle(), @"");
        if (localizedString != nil)
        {
            return localizedString;
        }
        return aToken;
    } 
    else 
    {
        return aToken;
    }
}