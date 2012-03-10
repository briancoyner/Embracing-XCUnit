//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SenTestingKit/SenTestingKit.h>

@interface ___FILEBASENAMEASIDENTIFIER___ : SenTestCase

@end

@implementation ___FILEBASENAMEASIDENTIFIER___

- (void)testApp
{
    id yourApplicationDelegate = [NSApplication sharedApplication];
    STAssertNotNil(yourApplicationDelegate, @"NSApplication failed to find the shared application");
}

@end
