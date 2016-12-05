//
//  SKNetworkManager.m
//  SKSecurityClient
//
//  Created by Katya Dvuzhilova on 11/7/16.
//
//

#import "SKNetworkManager.h"

NSString *const kBaseUrl = @"https://seorgy-15283.herokuapp.com";
NSString *const kAPISignInPath = @"/login";
NSString *const kAPIRSAKeyPath = @"/rsakey";
NSString *const kAPITokenKeyPath = @"/token";

NSString *const kAPIEncriptionKey = @"encryption";
NSString *const kAPIPostKey = @"postCode";
NSString *const kAPIRSAKey = @"rsaKey";

#warning code path
NSString *const kAPICodeKeyPath = @"/";

@implementation SKNetworkManager

+ (instancetype)sharedManager {
  static SKNetworkManager *_sharedManager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{

    _sharedManager = [[SKNetworkManager alloc] init];
  });

  return _sharedManager;
}

+ (NSString *)requestWithPath:(NSString *)path {
  return [NSString stringWithFormat:@"%@%@", kBaseUrl, path];
}

- (instancetype)initWithBaseURL:(NSURL *)url {
  self = [super initWithBaseURL:url];
  if (self) {
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
  }
  return self;
}

- (void)getRequestWithService:(NSString *)service
                      dataKey:(NSString *)dataKey
                   parameters:(NSDictionary *)parameters
                      success:(ASNetworkSuccessBlock)success
                      failure:(ASNetworkFailedBlock)failure {
  [self GET:service
      parameters:parameters
      success:^(NSURLSessionDataTask *task, id responseObject) {
        if (![self validateResponse:responseObject byKey:dataKey]) {
          NSError *error = [NSError
              errorWithDomain:kBaseUrl
                         code:303
                     userInfo:@{
                       NSLocalizedDescriptionKey :
                           NSLocalizedString(@"key.error.responseInvalid", nil)
                     }];
          failure(error);
          return;
        }
        if (dataKey) {
          success(responseObject[dataKey]);
        } else {
          success(responseObject);
        }
      }
      failure:^(NSURLSessionDataTask *task, NSError *error) {

        failure(error);
      }];
}

- (void)postRequestWithService:(NSString *)service
                       dataKey:(NSString *)dataKey
                    parameters:(NSDictionary *)parameters
                       success:(ASNetworkSuccessBlock)success
                       failure:(ASNetworkFailedBlock)failure {
  [self POST:service
      parameters:parameters
      success:^(NSURLSessionDataTask *task, id responseObject) {
        if (![self validateResponse:responseObject byKey:dataKey]) {
          NSError *error = [NSError
              errorWithDomain:kBaseUrl
                         code:303
                     userInfo:@{
                       NSLocalizedDescriptionKey :
                           NSLocalizedString(@"key.error.responseInvalid", nil)
                     }];
          failure(error);
          return;
        }
        if (dataKey) {
          success(responseObject[dataKey]);
        } else {
          success(responseObject);
        }
      }
      failure:^(NSURLSessionDataTask *task, NSError *error) {

        failure(error);
      }];
}

- (BOOL)validateResponse:(id)responseObject byKey:(NSString *)key {
  if (!key) return YES;
  if ([responseObject isKindOfClass:[NSDictionary class]]) {
    NSDictionary *response = (NSDictionary *)responseObject;
    NSArray *allKeys = response.allKeys;
    if ([allKeys containsObject:key]) {
      return YES;
    };
  }
  return NO;
}

- (void)sendLogin:(NSString *)email
         password:(NSString *)password
        sessionId:(NSString *)sessionId
          success:(ASNetworkSuccessBlock)success
          failure:(ASNetworkFailedBlock)failure {
  NSString *requestPath = [SKNetworkManager requestWithPath:kAPISignInPath];
  NSDictionary *parameters = @{

  };

  [self postRequestWithService:requestPath
                       dataKey:nil
                    parameters:parameters
                       success:success
                       failure:failure];
}

- (void)sendRSAKey:(NSString *)rsaKey
    withPostSendingEnabled:(BOOL)enablePostSending
    withDataCryptedEnabled:(BOOL)enableDataCrypting
                   success:(ASNetworkSuccessBlock)success
                   failure:(ASNetworkFailedBlock)failure {
  NSString *requestPath = [SKNetworkManager requestWithPath:kAPIRSAKeyPath];
  NSDictionary *parameters = @{
    kAPIEncriptionKey : @(enableDataCrypting),
    kAPIPostKey : @(enablePostSending),
    kAPIRSAKey : @""
  };
  [self postRequestWithService:requestPath
                       dataKey:nil
                    parameters:parameters
                       success:success
                       failure:failure];
}

- (void)sendCode:(NSString *)code
       sessionId:(NSString *)sessionId
         success:(ASNetworkSuccessBlock)success
         failure:(ASNetworkFailedBlock)failure {
  NSString *requestPath = [SKNetworkManager requestWithPath:kAPICodeKeyPath];
  NSDictionary *parameters = @{};

  [self postRequestWithService:requestPath
                       dataKey:nil
                    parameters:parameters
                       success:success
                       failure:failure];
}

@end
