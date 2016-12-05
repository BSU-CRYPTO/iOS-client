//
//  ViewController.m
//  SKSecurityClient
//
//  Created by Katya Dvuzhilova on 11/7/16.
//
//

#import "ViewController.h"

// Libraries
#import "RSA.h"
#import "BBAES.h"

// Extensions
#import "NSData+Base64.h"

// Manager
#import "SKNetworkManager.h"

@interface ViewController ()

@property(weak, nonatomic) IBOutlet UITextField *loginTextField;
@property(weak, nonatomic) IBOutlet UITextField *passTextField;

@property(strong, nonatomic) NSString *sessionIdFromServer;
@property(strong, nonatomic) NSString *codeIdFromServer;
@property(strong, nonatomic) NSString *tokenFromServer;

@property(assign, nonatomic) SecKeyRef publicRSAKey;

@end

@implementation ViewController

#pragma mark - Lifecycle


- (void)viewDidLoad {
  [super viewDidLoad];

  // 1) Generate RSA public key

//  RSA *rsa = [RSA sharedInstance];
//  [rsa generateKeyPairRSACompleteBlock:^(void ) {
//    NSString *key = [rsa getServerPublicKey];
//  }];
//  [rsa setIdentifierForPublicKey:@"com.reejosamuel.publicKey"
//                      privateKey:@"com.reejosamuel.privateKey"
//                 serverPublicKey:@"com.reejosamuel.serverPublicKey"];
//  NSString *text = [rsa getPublicKeyAsBase64ForJavaServer];
//  NSString *text1 = [rsa getServerPublicKey];
//
//  // 2) Send RSA to server
//
//  [self sendRSA:text];

  // 3) Send Login-Pass to server with (AES) + sessionID

  // 4) Send Code (ARS) + sessionID

 [self addNumber:5 withNumber:7 andCompletionHandler:^(int result) {
        // We just log the result, no need to do anything else.
        NSLog(@"The result is %d", result);
    }];

}

-(void)addNumber:(int)number1 withNumber:(int)number2 andCompletionHandler:(void (^)(int result))completionHandler {
    int result = number1 + number2;
    completionHandler(result);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)sendLoginPassAction:(id)sender {
}

#pragma mark - Private

- (void)sendRSA:(NSString *)rsaKey {
  [[SKNetworkManager sharedManager] sendRSAKey:rsaKey
      withPostSendingEnabled:YES
      withDataCryptedEnabled:YES
      success:^(id responsedObject) {
        NSLog(@"%@", responsedObject);
      }
      failure:^(NSError *error) {
        NSLog(@"%@", error);
      }];
}



- (void)sendLogin:(NSString *)login
         password:(NSString *)password
        sessionId:(NSString *)sessionId {
  [[SKNetworkManager sharedManager] sendLogin:login
                                     password:password
                                    sessionId:sessionId
                                      success:^(id responsedObject) {
                                      }
                                      failure:^(NSError *error){

                                      }];
}

- (void)sendCode:(NSString *)code withSessionId:(NSString *)sessionId {
  [[SKNetworkManager sharedManager] sendCode:code
                                   sessionId:sessionId
                                     success:^(id responsedObject) {
                                     }
                                     failure:^(NSError *error){

                                     }];
}

@end

