//
//  LanguageManagement.h
//  Multilingue
//
//  Created by Duyen Hoa Ha on 11/07/2014.
//  Copyright (c) 2014 Duyen-Hoa HA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageManagement : NSObject

@property (nonatomic) NSMutableDictionary* dictLangueBundle;

+(LanguageManagement*)sharedLM;
-(NSString*) myLocalizedStringForKey:(NSString*) key forLang:(NSString*)selectedLanguage ofTable:(NSString*)tableName;
@end
