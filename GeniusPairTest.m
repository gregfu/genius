//
//  GeniusPairTest.m
//  Genius
//
//  Created by Chris Miner on 13.11.07.
//  Copyright 2007-2008 Chris Miner. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>
#import "GeniusPair.h"

@interface GeniusPairTest : SenTestCase {
    GeniusPair *geniusPair; //!< The object under test.
}

@end

//! A collection of GeniusPair tests.
@implementation GeniusPairTest

//! Instanciate a genius instance for each test.
- (void) setUp
{
    geniusPair = [[GeniusPair alloc] init];
}

//! Releases genius instance from each test.
- (void) tearDown
{
    [geniusPair release];
    geniusPair = nil;
}

//! Test that encoding fails without a keyed archiver.
- (void) testEncodingFailure
{    
    STAssertThrowsSpecificNamed([NSArchiver archivedDataWithRootObject:geniusPair], NSException, NSInternalInconsistencyException, nil);
}

//! Test that encoding and decoding archives group, notes, type, and importance.
- (void) testEncoding
{   
    [geniusPair setCustomGroupString:@"my group"];
    [geniusPair setCustomTypeString:@"my type"];
    [geniusPair setNotesString:@"my notes"];
    [geniusPair setImportance:42];

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:geniusPair];
    GeniusPair *newPair = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    STAssertEqualObjects([geniusPair customGroupString], @"my group", nil);    
    STAssertEqualObjects([geniusPair customTypeString], @"my type", nil);    
    STAssertEqualObjects([geniusPair notesString], @"my notes", nil);    
    STAssertEquals([geniusPair importance], 42, nil);    
}

@end
