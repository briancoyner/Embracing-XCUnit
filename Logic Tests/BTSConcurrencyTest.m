//
//  Copyright (c) 2012 Brian Coyner. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "BTSParseOperation.h"

@interface BTSConcurrencyTest : SenTestCase
@end

@implementation BTSConcurrencyTest

- (void)testConcurrentParser_UsingOperationQueueCompletionBlockToSignal
{
    NSString *inputValues = @"Hello\nMy Name Is\nBrian Coyner";
    BTSParseOperation *parser = [[BTSParseOperation alloc] initWithString:inputValues];

    NSMutableArray *parsedStrings = [NSMutableArray arrayWithCapacity:3];
    [parser setLineParsedBlock:^(NSString *line, NSUInteger lineNumber) {
        [parsedStrings addObject:line];
    }];

    dispatch_semaphore_t latch = dispatch_semaphore_create(0);

    [parser setCompletionBlock:^{
        dispatch_semaphore_signal(latch);
    }];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:parser];

    long success = dispatch_semaphore_wait(latch, dispatch_walltime(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC));
    dispatch_release(latch);

    STAssertEquals(0L, success, @"Background task did not finish in time.");

    NSArray *expectedValues = [NSArray arrayWithObjects:@"Hello", @"My Name Is", @"Brian Coyner", nil];
    STAssertEqualObjects(expectedValues, parsedStrings, @"Parsed Strings");
}

- (void)testConcurrentParser_UsingSerialQueueBlockOperationToSignal
{
    NSString *input = @"Hello\nMy Name Is\nBrian Coyner";
    BTSParseOperation *parser = [[BTSParseOperation alloc] initWithString:input];

    NSMutableArray *parsedStrings = [NSMutableArray arrayWithCapacity:3];
    [parser setLineParsedBlock:^(NSString *line, NSUInteger lineNumber) {
        [parsedStrings addObject:line];
    }];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue setMaxConcurrentOperationCount:1];
    [queue addOperation:parser];

    // In this example, we want to use a separate operation to help us signal when the 
    // parse operation completes. We may need to use this technique if we are unable to 
    // set a completion block on an operation task (ostensibly because one already exists).
    dispatch_semaphore_t latch = dispatch_semaphore_create(0);

    [queue addOperationWithBlock:^{
        dispatch_semaphore_signal(latch);
    }];

    long success = dispatch_semaphore_wait(latch, dispatch_walltime(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC));
    dispatch_release(latch);

    STAssertEquals(0L, success, @"Background task did not finish in time.");

    NSArray *expectedValues = [NSArray arrayWithObjects:@"Hello", @"My Name Is", @"Brian Coyner", nil];
    STAssertEqualObjects(expectedValues, parsedStrings, @"Parsed Strings");
}

- (void)testConcurrentParser_BlockDelegationManuallyStartParserAndSignalsCompletion
{
    NSOperationQueue *concurrentQueue = [[NSOperationQueue alloc] init];

    NSString *input = @"Hello\nMy Name Is\nBrian Coyner";
    BTSParseOperation *parser = [[BTSParseOperation alloc] initWithString:input];

    NSMutableArray *parsedStrings = [NSMutableArray arrayWithCapacity:3];
    [parser setLineParsedBlock:^(NSString *line, NSUInteger lineNumber) {
        [parsedStrings addObject:line];
    }];

    // In this example, we assume that the 'concurrentQueue' cannot be turned into a 'serial queue'. Therefore,
    // we simply start the parser manually and signal when the operation completes. This all happens in a single
    // operation (that may or may not execute concurrently with other tasks).
    dispatch_semaphore_t latch = dispatch_semaphore_create(0);

    [concurrentQueue addOperationWithBlock:^{
        [parser start];
        dispatch_semaphore_signal(latch);
    }];

    long success = dispatch_semaphore_wait(latch, dispatch_walltime(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC));
    dispatch_release(latch);

    STAssertEquals(0L, success, @"Background task did not finish in time.");

    NSArray *expectedValues = [NSArray arrayWithObjects:@"Hello", @"My Name Is", @"Brian Coyner", nil];
    STAssertEqualObjects(expectedValues, parsedStrings, @"Parsed Strings");
}

@end