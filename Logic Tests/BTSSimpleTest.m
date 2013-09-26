//
//  Copyright (c) 2012 Brian Coyner. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface BTSSimpleTest : XCTestCase
@end

@implementation BTSSimpleTest

- (void)testMath
{
    int a = 1;
    int b = 1;
    int sum = a + b;
    
    XCTAssertTrue(sum == 2, @"Bad Day, eh?");
}

@end