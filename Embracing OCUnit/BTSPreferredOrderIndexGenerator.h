//
//  Copyright (c) 2012 Brian Coyner. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kBTSInvalidDate;

@interface BTSPreferredOrderIndexGenerator : NSObject

- (u_int64_t)generateFromDate:(NSDate *)date;

@end
