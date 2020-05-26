//
//  NetWorkTask.m
//  NetWorkModule
//
//  Created by Owen on 2020/5/26.
//  Copyright © 2020 Owen. All rights reserved.
//

#import "NetWorkTask.h"
#import "AFNetworking.h"

@implementation NetWorkTask

+ (BOOL)getRequestWithApiName:(NSString *)apiName
                        param:(NSMutableDictionary *)paramDictionary
                     delegate:(NetWorkDelegate *)netWorkDelegate
{
    NSString *requestString = [NSString stringWithFormat:@"%@%@", NetWorkApiDomain, apiName];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    /***************/
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    [securityPolicy setAllowInvalidCertificates:YES];
    [securityPolicy setValidatesDomainName:YES];
    [manager setSecurityPolicy:securityPolicy];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/json",
                                                         @"text/javascript",
                                                         @"text/html",
                                                         @"text/plain",
                                                         nil];
    /*******************/
    [manager GET:requestString parameters:paramDictionary headers:nil progress:^(NSProgress *_Nonnull downloadProgress) {
        NSLog(@"%@ Network Request", apiName);
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        if ([netWorkDelegate.delegate respondsToSelector:@selector(requestSucceedBack:withApiName:)]) {
            [netWorkDelegate.delegate requestSucceedBack:responseObject withApiName:apiName];
        }
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        if ([netWorkDelegate.delegate respondsToSelector:@selector(requestFailBack:withApiName:)]) {
            [netWorkDelegate.delegate requestFailBack:error withApiName:apiName];
        }
    }];

    return YES;
}

+ (NSURLSessionDataTask *)postResquestWithApiName:(NSString *)apiName
                                          paraDic:(NSDictionary *)paraDic
                                         delegate:(NetWorkDelegate *)netWorkDelegate {
    NSString *requestString = [NSString stringWithFormat:@"%@%@", NetWorkApiDomain, apiName];

//    AFHTTPSessionManager *manager = [AFAppDotNetAPIClient sharedClient];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];

    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    [securityPolicy setAllowInvalidCertificates:YES];
    [securityPolicy setValidatesDomainName:NO];
    [manager setSecurityPolicy:securityPolicy];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/json",
                                                         @"text/javascript",
                                                         @"text/html",
                                                         @"text/plain",
                                                         nil];

    [manager.requestSerializer setValue:[[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"version"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@", [NSNumber numberWithInt:2]] forHTTPHeaderField:@"clientId"];

    __weak typeof(manager) weakManager = manager;
    NSURLSessionDataTask *task = [manager POST:requestString parameters:paraDic headers:nil progress:^(NSProgress *_Nonnull uploadProgress) {
        NSLog(@"%@ Network Request", apiName);
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        if ([netWorkDelegate.delegate respondsToSelector:@selector(requestSucceedBack:withApiName:)]) {
//            BaseResultObj *obj = [BaseResultObj getBaseObjFrom:responseObject];
//
//            if ([obj.retCode intValue] == 100216 || [obj.retCode intValue] == 100101) {
//                [[DataManager lightData] removeSkey];
//
//                [[DataManager lightData] removeGravatar];
//                [[DataManager lightData] removeMemberLevel];
//                [[DataManager lightData] removeMobile];
//                [[DataManager lightData] removeNickName];
//                [[DataManager lightData] removeUserId];
//                [[DataManager lightData] removeBirthday];
//                [[DataManager lightData] removeGender];
//                [[DataManager lightData] removeGravatar];
//
//                [SVProgressHUD showErrorWithStatus:retMsg0];
//                [VCManger mainVC].viewControllers = @[];
//                SSLoginNodeController *vc = [[SSLoginNodeController alloc] init];
//                [[VCManger mainVC] pushVC:vc animate:NO];
//                [[VCManger homeVC] replaceSetting:0];
//                [[VCManger secondHomeVC] replaceSecondSetting:0];
//            } else {
//                if ([obj.retCode intValue] != 0) {
//                    NSLog(@"&&&&&&&&&&&&&&&&&%@****%@", apiName, paraDic);
//                }
                [netWorkDelegate.delegate requestSucceedBack:responseObject withApiName:apiName];
//            }
        }
        [weakManager invalidateSessionCancelingTasks:YES resetSession:YES];
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        NSLog(@"requestFailBack=================%@***%@\n====error:%@", apiName, paraDic, error);

//        ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];

//        if (status == RealStatusNotReachable || error.code == -1001) {
//            if ([netWorkDelegate.delegate respondsToSelector:@selector(requestFailBack:withApiName:)]) {
                [netWorkDelegate.delegate requestFailBack:error withApiName:apiName];
//            }
//        } else {
//            if ([apiName isEqualToString:SSLiveOnlineUserNumber]) {
//                NSLog(@"在线人数接口:requestFailBack=================%@***%@\n====error:%@", apiName, paraDic, error);
//            } else {
//                NSLog(@"=======服务器宕机======\n%@***%@", error, apiName);
//                if ([NetWorkApiDomain isEqualToString:@"http://testmapi.sancell.top/"]) {
//                    [SVProgressHUD dismiss];
////                    SSNetworkStatusView *serverView = [[SSNetworkStatusView alloc] init];
////                    [[UIApplication sharedApplication].keyWindow addSubview:serverView];
////                    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:serverView];
//                } else {
//                    SSNetworkStatusView *serverView = [[SSNetworkStatusView alloc] init];
//                    [[UIApplication sharedApplication].keyWindow addSubview:serverView];
//                    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:serverView];
//                }
//            }
//        }
        [weakManager invalidateSessionCancelingTasks:YES resetSession:YES];
    }];

    return task;
}


@end
