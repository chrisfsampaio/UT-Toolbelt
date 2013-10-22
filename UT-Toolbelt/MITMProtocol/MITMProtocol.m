//
//  MITMProtocol.m
//  UT-ToolbeltDemo
//
//  Created by Christian Sampaio on 10/22/13.
//  Copyright (c) 2013 None. All rights reserved.
//

#import "MITMProtocol.h"

// Undocumented initializer obtained by class-dump - don't use this in production code destined for the App Store
@interface NSHTTPURLResponse(UndocumentedInitializer)
- (id)initWithURL:(NSURL*)URL statusCode:(NSInteger)statusCode headerFields:(NSDictionary*)headerFields requestTime:(double)requestTime;
@end

static void(^startLoadingBlock)(NSURLRequest *request) = nil;
static NSData *responseData = nil;
static NSDictionary *headers = nil;
static NSInteger statusCode = 200;
static NSError *error = nil;
static NSArray *supportedMethods = nil;
static NSArray *supportedSchemes = nil;
static NSURL *supportedBaseURL = nil;
static CGFloat responseDelay = 0;
static BOOL (^shouldInitWithRequest) (NSURLRequest *request)  = nil;


@implementation MITMProtocol

+ (void)setStartLoadingBlock:(void(^)(NSURLRequest *request))block
{
    startLoadingBlock = block;
}

+ (void)setShouldInitWithRequestBlock:(BOOL (^) (NSURLRequest *request))block
{
    shouldInitWithRequest = block;
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    
    BOOL canInit = YES;
    
    if (shouldInitWithRequest) {
        canInit = shouldInitWithRequest(request);
    } else {
        canInit = (
                   (!supportedBaseURL || [request.URL.absoluteString hasPrefix:supportedBaseURL.absoluteString]) &&
                   (!supportedMethods || [supportedMethods containsObject:request.HTTPMethod]) &&
                   (!supportedSchemes || [supportedSchemes containsObject:request.URL.scheme])
                   );
    }
    return canInit;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

+ (void)setHeaders:(NSDictionary*)newHeaders {
    if(newHeaders != headers) {
        headers = newHeaders;
    }
}

+ (void)setResponseData:(NSData*)data {
    if(data != responseData) {
        responseData = data;
    }
}

+ (void)setStatusCode:(NSInteger)newStatusCode {
    statusCode = newStatusCode;
}

+ (void)setError:(NSError*)newError {
    if(newError != error) {
        error = newError;
    }
}

- (NSCachedURLResponse *)cachedResponse {
    return nil;
}

+ (void)setSupportedMethods:(NSArray*)methods {
    if(methods != supportedMethods) {
        supportedMethods = methods;
    }
}

+ (void)setSupportedSchemes:(NSArray*)schemes {
    if(schemes != supportedSchemes) {
        supportedSchemes = schemes;
    }
}

+ (void)setSupportedBaseURL:(NSURL*)baseURL {
    if(baseURL != supportedBaseURL) {
        supportedBaseURL = baseURL;
    }
}

+ (void)setResponseDelay:(CGFloat)newResponseDelay {
    responseDelay = newResponseDelay;
}

- (void)startLoading {
    NSURLRequest *request = [self request];
    id<NSURLProtocolClient> client = [self client];
    
    if (startLoadingBlock) {
        startLoadingBlock(request);
    }
    
    
    if (error) {
        [client URLProtocol:self didFailWithError:error];
    } else {
        
        NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:[request URL]
                                                                  statusCode:statusCode
                                                                headerFields:headers
                                                                 requestTime:0.0];
        
        [NSThread sleepForTimeInterval:responseDelay];
        
        
        [client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [client URLProtocol:self didLoadData:responseData];
        [client URLProtocolDidFinishLoading:self];
    }
}

- (void)stopLoading
{

}

+ (void)startMocking
{
    [NSURLProtocol registerClass:[self class]];
}

+ (void)stopMocking
{
    [NSURLProtocol unregisterClass:[self class]];
}

@end
