//
//  NSString+RSAExpand.m
//  NetWorkModule
//
//  Created by Owen on 2020/5/27.
//  Copyright © 2020 Owen. All rights reserved.
//

#import "NSString+RSAExpand.h"
#import "SSRSAModule.h"
@implementation NSString (RSAExpand)

/**rsa加密*/
+ (NSString *)getEncryptStringfrom:(NSArray *)objects;
{
    NSMutableString *string = [NSMutableString string];

    for (int i = 0; i < objects.count; i++) {
        [string appendFormat:@"%@", objects[i]];
    }

    NSString *targetString = [SSRSAModule encryptString:string publicKey:NewPUBKEY];

    return targetString;
}

@end
