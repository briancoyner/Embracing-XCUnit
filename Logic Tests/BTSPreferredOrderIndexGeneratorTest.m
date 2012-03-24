//
//  Copyright (c) 2012 Brian Coyner. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "BTSPreferredOrderIndexGenerator.h"

static NSDate* BTSCreateDate(NSInteger year, NSInteger month, NSInteger day)
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:year];
    [dateComponents setMonth:month];
    [dateComponents setDay:day];

    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    return [currentCalendar dateFromComponents:dateComponents];
}

@interface BTSPreferredOrderIndexGeneratorTest : SenTestCase {
    BTSPreferredOrderIndexGenerator *_generator;
}
@end

@implementation BTSPreferredOrderIndexGeneratorTest

- (void)setUp
{
    _generator = [[BTSPreferredOrderIndexGenerator alloc] init];
}

- (void)tearDown
{
    _generator = nil;
}

- (void)testGenerateFromDate_January_1_2010
{
    NSDate *date = BTSCreateDate(2010, 1, 1);
    STAssertEquals(201001010000000000lu, [_generator generateFromDate:date], nil);
}


- (void)testGenerateFromDate_January_9_2010
{
    NSDate *date = BTSCreateDate(2010, 1, 9);
    STAssertEquals(201001090000000000lu, [_generator generateFromDate:date], nil);
}

- (void)testGenerateFromDate_January_10_2010
{
    NSDate *date = BTSCreateDate(2010, 1, 10);
    STAssertEquals(201001100000000000lu, [_generator generateFromDate:date], nil);
}

- (void)testGenerateFromDate_January_11_2010
{
    NSDate *date = BTSCreateDate(2010, 1, 11);
    STAssertEquals(201001110000000000lu, [_generator generateFromDate:date], nil);
}

- (void)testGenerateFromDate_October_9_2010
{
    NSDate *date = BTSCreateDate(2010, 10, 9);
    STAssertEquals(201010090000000000lu, [_generator generateFromDate:date], nil);
}

- (void)testGenerateFromDate_October_10_2010
{
    NSDate *date = BTSCreateDate(2010, 10, 10);
    STAssertEquals(201010100000000000lu, [_generator generateFromDate:date], nil);
}

- (void)testGenerateFromDate_October_11_2010
{
    NSDate *date = BTSCreateDate(2010, 10, 11);
    STAssertEquals(201010110000000000lu, [_generator generateFromDate:date], nil);
}

- (void)testGenerateFromDate_December_31_9999
{
    NSDate *date = BTSCreateDate(9999, 12, 31);
    STAssertEquals(999912310000000000lu, [_generator generateFromDate:date], nil);
}

- (void)testNilDateThrows
{
    @try {
        [_generator generateFromDate:nil];
        STFail(@"Generator should raise exception when given a nil date.");
    }
    @catch (NSException *exception) {
        // You should test the exception however it makes sense in your application...
        STAssertEqualObjects([NSException class], [exception class], nil);
        STAssertEqualObjects(kBTSInvalidDate, [exception name], nil);
        STAssertEqualObjects(@"date is nil", [exception reason], nil);
    }
}

@end















