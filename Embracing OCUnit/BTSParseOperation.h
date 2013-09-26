//
//  Copyright (c) 2012 Brian Coyner. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BTSParseOperationParseBlock)(NSString *line, NSUInteger lineNumber);

@interface BTSParseOperation : NSOperation

- (id)initWithString:(NSString *)string;

@property (nonatomic, copy, readwrite) BTSParseOperationParseBlock lineParsedBlock;

@end
