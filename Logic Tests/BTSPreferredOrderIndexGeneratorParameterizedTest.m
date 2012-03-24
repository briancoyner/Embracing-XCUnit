//
//  Copyright (c) 2012 Brian Coyner. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "BTSPreferredOrderIndexGenerator.h"

static NSDate *BTSCreateDate(NSInteger year, NSInteger month, NSInteger day) {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:year];
    [dateComponents setMonth:month];
    [dateComponents setDay:day];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateFromComponents:dateComponents];
}

@interface BTSPreferredOrderIndexGeneratorParameterizedTest : SenTestCase {
    BTSPreferredOrderIndexGenerator *_generator;

    u_int64_t _expectedValue;
    NSDate *_date;
    NSException *_expectedException;
}

@end

@implementation BTSPreferredOrderIndexGeneratorParameterizedTest

- (id)initWithInvocation:(NSInvocation *)testInvocation expectedValue:(u_int64_t)value date:(NSDate *)inputDate expectedException:(NSException *)exception
{
    self = [super initWithInvocation:testInvocation];
    if (self) {
        _expectedValue = value;
        _date = inputDate;
        _expectedException = exception;
    }

    return self;
}


#pragma mark - Test Life Cycle Methods

- (void)setUp
{
    _generator = [[BTSPreferredOrderIndexGenerator alloc] init];
}

- (void)tearDown
{
    _generator = nil;
}

#pragma mark Default Suite
+ (id)defaultTestSuite
{
    SenTestSuite *testSuite = [[SenTestSuite alloc] initWithName:NSStringFromClass(self)];
    [self addTestWithExpectedValue:201001010000000000ul date:BTSCreateDate(2010, 1, 1) expectedException:nil toTestSuite:testSuite];
    [self addTestWithExpectedValue:201001090000000000ul date:BTSCreateDate(2010, 1, 9) expectedException:nil toTestSuite:testSuite];
    [self addTestWithExpectedValue:201001100000000000ul date:BTSCreateDate(2010, 1, 10) expectedException:nil toTestSuite:testSuite];
    [self addTestWithExpectedValue:201001110000000000ul date:BTSCreateDate(2010, 1, 11) expectedException:nil toTestSuite:testSuite];
    [self addTestWithExpectedValue:201010090000000000ul date:BTSCreateDate(2010, 10, 9) expectedException:nil toTestSuite:testSuite];
    [self addTestWithExpectedValue:201010100000000000ul date:BTSCreateDate(2010, 10, 10) expectedException:nil toTestSuite:testSuite];
    [self addTestWithExpectedValue:201010110000000000ul date:BTSCreateDate(2010, 10, 11) expectedException:nil toTestSuite:testSuite];
    [self addTestWithExpectedValue:101010000000000ul date:BTSCreateDate(1, 1, 1) expectedException:nil toTestSuite:testSuite];
    [self addTestWithExpectedValue:999912310000000000ul date:BTSCreateDate(9999, 12, 31) expectedException:nil toTestSuite:testSuite];

    { // nil date should throw an exception
        NSException *expectedException = [[NSException alloc] initWithName:kBTSInvalidDate reason:@"date is nil" userInfo:nil];
        [self addTestWithExpectedValue:-1 date:nil expectedException:expectedException toTestSuite:testSuite];
    }

    return testSuite;
}

+ (void)addTestWithExpectedValue:(u_int64_t)expectedValue date:(NSDate *)date expectedException:(NSException *)expectedException toTestSuite:(SenTestSuite *)testSuite
{
    NSArray *testInvocations = [self testInvocations];
    for (NSInvocation *testInvocation in testInvocations) {
        SenTestCase *test = [[BTSPreferredOrderIndexGeneratorParameterizedTest alloc]
                initWithInvocation:testInvocation
                     expectedValue:expectedValue
                              date:date
                 expectedException:expectedException];
        [testSuite addTest:test];
    }
}

#pragma mark Test Methods

- (void)testGenerateFromDate
{
    if (_expectedException == nil) {
        STAssertEquals(_expectedValue, [_generator generateFromDate:_date], @"Generated Preferred Order Index");
    } else {
        @try {
            [_generator generateFromDate:_date];
            STFail(@"Generator should raise exception.");
        }
        @catch (NSException *exception) {
            // You should test the exception however it makes sense in your application...
            STAssertEqualObjects([_expectedException class], [exception class], @"Exception Class.");
            STAssertEqualObjects([_expectedException name], [exception name], @"Exception Name.");
            STAssertEqualObjects([_expectedException reason], [exception reason], @"Exception reason.");
        }
    }
}
@end