//
//  Encryption.h
//  SkyDemo
//
//  Created by 하늘나무 on 2015. 2. 12..
//  Copyright (c) 2015년 Skytree Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptedMethod : NSObject  {
    NSString* algorithm;
}
@property (nonatomic,retain) NSString *algorithm;
@end;


@interface RetrievalMethod : NSObject {
    NSString* uri;
    NSString* type;
}
@property (nonatomic, retain) NSString *uri;
@property (nonatomic, retain) NSString *type;
@end

@interface CipherData : NSObject {
    NSString* cipherReference;
    NSString* cipherValue;
}
@property (nonatomic, retain) NSString *cipherReference;
@property (nonatomic, retain) NSString *cipherValue;
@end


@interface KeyInfo : NSObject {
    NSString* resource;
    RetrievalMethod* retrievalMethod;
    NSString* keyName;
}
@property (nonatomic, retain) NSString* resource;
@property (nonatomic, retain) NSString* keyName;
@property (nonatomic, retain) RetrievalMethod* retrievalMethod;
@end;


@interface EncryptedData : NSObject {
    
    NSString* identification;
    EncryptedMethod* encryptedMethod;
    KeyInfo* keyInfo;
    CipherData* cipherData;
}

@property (nonatomic,retain)    EncryptedMethod* encryptedMethod;
@property (nonatomic,retain)    KeyInfo* keyInfo;
@property (nonatomic,retain)    CipherData* cipherData;
@property (nonatomic,retain)    NSString* identification;
@end


@interface EncryptedKey : NSObject {
    
    NSString* identification;
    EncryptedMethod* encryptedMethod;
    KeyInfo* keyInfo;
    CipherData* cipherData;
}

@property (nonatomic,retain)    EncryptedMethod* encryptedMethod;
@property (nonatomic,retain)    KeyInfo* keyInfo;
@property (nonatomic,retain)    CipherData* cipherData;
@property (nonatomic,retain)    NSString* identification;
@end


@interface Encryption : NSObject {
    NSMutableArray *encryptedDatas;
    NSMutableArray *encryptedKeys;
}
@property (nonatomic, retain) NSMutableArray *encryptedDatas;
@property (nonatomic, retain) NSMutableArray *encryptedKeys;
@end






