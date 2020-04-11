//
//  NSDate+FD.m
//  FDFoundationObjC
//
//  Created by fandongtongxue on 2020/2/29.
//

#import "NSDate+FD.h"

@implementation NSDate (FD)

- (NSString *)fd_currentTimestamp{
    long timestamp = [self timeIntervalSince1970];
    return [NSString stringWithFormat:@"%ld",timestamp];
}

@end
