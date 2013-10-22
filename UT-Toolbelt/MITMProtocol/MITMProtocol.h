//
//  MITMProtocol.h
//  UT-ToolbeltDemo
//
//  Created by Christian Sampaio on 10/22/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import <Foundation/Foundation.h>


// Forked from Claus Broch's ILCannedURLProtocol http://www.infinite-loop.dk/blog/2011/09/using-nsurlprotocol-for-injecting-test-data/


@interface MITMProtocol : NSURLProtocol

+ (void)setStartLoadingBlock:(void(^)(NSURLRequest *request))block;
+ (void)setShouldInitWithRequestBlock:(BOOL (^) (NSURLRequest *request))block;
+ (void)setHeaders:(NSDictionary*)headers;
+ (void)setResponseData:(NSData*)data;
+ (void)setStatusCode:(NSInteger)statusCode;
+ (void)setError:(NSError*)error;
+ (void)setSupportedMethods:(NSArray*)methods;
+ (void)setSupportedSchemes:(NSArray*)schemes;
+ (void)setSupportedBaseURL:(NSURL*)baseURL;
+ (void)setResponseDelay:(CGFloat)responseDelay;

@end
