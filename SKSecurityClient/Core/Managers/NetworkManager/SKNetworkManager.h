//
//  SKNetworkManager.h
//  SKSecurityClient
//
//  Created by Katya Dvuzhilova on 11/7/16.
//
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

typedef void (^ASNetworkFailedBlock)(NSError *error);
typedef void (^ASNetworkSuccessBlock)(id responsedObject);

@interface SKNetworkManager : AFHTTPSessionManager

+ (instancetype)sharedManager;
+ (NSString *)requestWithPath:(NSString *)path;

- (void)sendCode:(NSString *)code
       sessionId:(NSString *)sessionId
         success:(ASNetworkSuccessBlock)success
         failure:(ASNetworkFailedBlock)failure;
         
- (void)sendRSAKey:(NSString *)rsaKey
    withPostSendingEnabled:(BOOL)enablePostSending
    withDataCryptedEnabled:(BOOL)enableDataCrypting
                   success:(ASNetworkSuccessBlock)success
                   failure:(ASNetworkFailedBlock)failure;

- (void)sendLogin:(NSString *)email
               password:(NSString *)password
              sessionId:(NSString *)sessionId
                success:(ASNetworkSuccessBlock)success
                failure:(ASNetworkFailedBlock)failure;
           

@end
