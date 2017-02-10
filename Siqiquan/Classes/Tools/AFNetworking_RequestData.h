//
//  AFNetworking_RequestData.h
//  AFNetworking_RequestData
//
//  Created by lxh on 2016/10/31.
//  Copyright © 2016年 lxh. All rights reserved.
//



#import <Foundation/Foundation.h>
typedef void(^Success)(id responseObject);
typedef void(^Failure)(NSError *error);
@interface AFNetworking_RequestData : NSObject
@property(nonatomic , copy) Success requestSuccess; //请求成功
@property(nonatomic , copy) Failure requestFailure; //请求失败

//注: 使用前  先倒入 第三方库“AFNetworking”  引入头文件AFNetworking.h

#pragma GET请求--------------
+(void)requestMethodGetUrl:(NSString*)url
                       dic:(NSDictionary*)dic
                    Succed:(Success)succed
                   failure:(Failure)failure;

#pragma POST请求--------------
+(void)requestMethodPOSTUrl:(NSString*)url
                  dic:(NSDictionary*)dic
               Succed:(Success)succed
              failure:(Failure)failure;
@end
