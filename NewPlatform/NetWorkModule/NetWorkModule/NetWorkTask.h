//
//  NetWorkTask.h
//  NetWorkModule
//
//  Created by Owen on 2020/5/26.
//  Copyright © 2020 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkTask : NSObject

+ (BOOL)getRequestWithApiName:(NSString*)apiName
                        param:(NSMutableDictionary*)paramDictionary
                     delegate:(NetWorkDelegate*)netWorkDelegate;

/**发送post请求*/
+ (NSURLSessionDataTask *) postResquestWithApiName:(NSString *)apiName
                                           paraDic:(NSDictionary *)paraDic
                                          delegate:(NetWorkDelegate *)netWorkDelegate;

@end

NS_ASSUME_NONNULL_END
