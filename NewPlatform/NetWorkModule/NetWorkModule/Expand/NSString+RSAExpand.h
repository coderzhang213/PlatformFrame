//
//  NSString+RSAExpand.h
//  NetWorkModule
//
//  Created by Owen on 2020/5/27.
//  Copyright © 2020 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (RSAExpand)

/**rsa加密(顺序填写)*/
+ (NSString *)getEncryptStringfrom:(NSArray*)objects;

@end

NS_ASSUME_NONNULL_END
