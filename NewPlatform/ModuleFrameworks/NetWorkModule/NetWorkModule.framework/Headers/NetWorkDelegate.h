//
//  NetWorkDelegate.h
//  NetWorkModule
//
//  Created by Owen on 2020/5/26.
//  Copyright © 2020 Owen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NetWorkProtocol <NSObject>

@optional

/**网络请求回调*/
- (void) requestSucceedBack:(id)responseResult
                withApiName:(NSString *)apiName;

- (void) requestFailBack:(id)errorResult
             withApiName:(NSString *)apiName;

@end

@interface NetWorkDelegate : NSObject

@property (nonatomic,weak) id<NetWorkProtocol>delegate;

@end

NS_ASSUME_NONNULL_END
