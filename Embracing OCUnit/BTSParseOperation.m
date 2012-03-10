//
//  Copyright (c) 2012 Brian Coyner. All rights reserved.
//

#import "BTSParseOperation.h"

@interface BTSParseOperation () {
    NSString *_stringToParse;
}

- (void)doMain;

@end

@implementation BTSParseOperation

@synthesize lineParsedBlock = _lineParsedBlock;

- (id)initWithString:(NSString *)string
{
    self = [super init];
    if (self) {
        _stringToParse = [string copy];
    }

    return self;
}

- (void)main
{
    @try {
        @autoreleasepool {
            [self doMain];
        }
    }
    @catch (...) {
        // ignore for the demo.
    }
}

- (void)doMain
{
    // Set up a scanner to break up the input string based on the new line character
    NSScanner *scanner = [NSScanner scannerWithString:_stringToParse];

    NSCharacterSet *newLineCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSString *currentLine;
    NSUInteger currentLineNumber = 1;

    while (![self isCancelled] && [scanner isAtEnd] == NO) {

        [scanner scanUpToCharactersFromSet:newLineCharacterSet intoString:&currentLine];
        _lineParsedBlock([currentLine copy], currentLineNumber++);

        // really slow parsing... :-)
        sleep(3);
    }
}

@end
