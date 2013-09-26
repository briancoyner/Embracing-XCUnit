//
//  Copyright (c) 2012 Brian Coyner. All rights reserved.
//

#import <XCTest/XCTest.h>
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

@interface BTSPreferredOrderIndexGeneratorTest : XCTestCase {
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
    XCTAssertEqual(201001010000000000lu, [_generator generateFromDate:date]);
}


- (void)testGenerateFromDate_January_9_2010
{
    NSDate *date = BTSCreateDate(2010, 1, 9);
    XCTAssertEqual(201001090000000000lu, [_generator generateFromDate:date]);
}

- (void)testGenerateFromDate_January_10_2010
{
    NSDate *date = BTSCreateDate(2010, 1, 10);
    XCTAssertEqual(201001100000000000lu, [_generator generateFromDate:date]);
}

- (void)testGenerateFromDate_January_11_2010
{
    NSDate *date = BTSCreateDate(2010, 1, 11);
    XCTAssertEqual(201001110000000000lu, [_generator generateFromDate:date]);
}

- (void)testGenerateFromDate_October_9_2010
{
    NSDate *date = BTSCreateDate(2010, 10, 9);
    XCTAssertEqual(201010090000000000lu, [_generator generateFromDate:date]);
}

- (void)testGenerateFromDate_October_10_2010
{
    NSDate *date = BTSCreateDate(2010, 10, 10);
    XCTAssertEqual(201010100000000000lu, [_generator generateFromDate:date]);
}

- (void)testGenerateFromDate_October_11_2010
{
    NSDate *date = BTSCreateDate(2010, 10, 11);
    XCTAssertEqual(201010110000000000lu, [_generator generateFromDate:date]);
}

- (void)testGenerateFromDate_December_31_9999
{
    NSDate *date = BTSCreateDate(9999, 12, 31);
    XCTAssertEqual(999912310000000000lu, [_generator generateFromDate:date]);
}

- (void)testNilDateThrows
{
    @try {
        [_generator generateFromDate:nil];
        XCTFail(@"Generator should raise exception when given a nil date.");
    }
    @catch (NSException *exception) {
        // You should test the exception however it makes sense in your application...
        XCTAssertEqualObjects([NSException class], [exception class]);
        XCTAssertEqualObjects(kBTSInvalidDate, [exception name]);
        XCTAssertEqualObjects(@"date is nil", [exception reason]);
    }
}

@end















