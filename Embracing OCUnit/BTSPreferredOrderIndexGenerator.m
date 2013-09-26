//
//  Copyright (c) 2012 Brian Coyner. All rights reserved.
//

#import "BTSPreferredOrderIndexGenerator.h"

NSString * const kBTSInvalidDate = @"BTSInvalidDate";

@implementation BTSPreferredOrderIndexGenerator

- (u_int64_t)generateFromDate:(NSDate *)date
{
    if (date == nil) {
        @throw [NSException exceptionWithName:kBTSInvalidDate reason:@"date is nil" userInfo:nil];
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger dateComponents = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
    NSDateComponents *components = [calendar components:dateComponents fromDate:date];
    
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];

    return (u_int64_t) (((year * 10000) + (month * 100) + (day)) * 10000000000);
}

@end
