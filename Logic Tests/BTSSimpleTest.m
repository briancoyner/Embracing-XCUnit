//
//  Copyright (c) 2012 Brian Coyner. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

@interface BTSSimpleTest : SenTestCase
@end

@implementation BTSSimpleTest

- (void)testMath
{
    int a = 1;
    int b = 1;
    int sum = a + b;
    
    STAssertTrue(sum == 2, @"Bad Day, eh?");
}

@end