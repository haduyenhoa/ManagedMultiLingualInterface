//
//  LanguageManagement.m
//  Multilingue
//
//  Created by Duyen Hoa Ha on 11/07/2014.
//  Copyright (c) 2014 Duyen-Hoa HA. All rights reserved.
//

#import "LanguageManagement.h"
static LanguageManagement *_sharedLM;
@implementation LanguageManagement

#pragma mark MULTILANGUAGE
+(LanguageManagement*)sharedLM {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedLM = [[LanguageManagement alloc] init];
        [_sharedLM reloadBundle]; //update language dictionary
        
    });
    return _sharedLM;
}

/**
 @discussion        Reload language bundle. Remember to clean project after add/modify texts in your Language Bundle.
 
 */
-(void)reloadBundle {
    
    if (self.dictLangueBundle == nil) {
        self.dictLangueBundle = [[NSMutableDictionary alloc] init];
    }

    [self.dictLangueBundle removeAllObjects];
    
    NSString *bundlePath = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/langs/Languages.bundle/"];
    
    NSArray *listSubFolder = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:bundlePath error:nil];
    if (listSubFolder) {
        for (NSString *subFolder in listSubFolder) {
            NSArray *componants = [subFolder componentsSeparatedByString:@"."];
            if (componants && componants.count == 2 && [[componants objectAtIndex:1] isEqual:@"lproj"]) {
                NSBundle *aBundle = [NSBundle bundleWithURL:[NSURL fileURLWithPath:[bundlePath stringByAppendingPathComponent:subFolder]]];
                if (aBundle) {
                    [self.dictLangueBundle setValue:aBundle forKey:[componants objectAtIndex:0]];
                }
            }
        }
    }
}

/**
 @discussion    Use this function to search for a text of selectedLanguage. For a multilingual application, I use this function at viewWillAppear to update automatically all displayable composants on the screen. The language of application should be registered in NSUserDefault.
 @param         key key for searching text (defined in LanguageKeyContances
                selectedLanguage    language of text to search
                tableName           use this if we have more than 1 text dictionnaries. For example: GeneralTexts.string for general texts, ErrorTexts.string for all error message
 */
-(NSString*) myLocalizedStringForKey:(NSString*) key forLang:(NSString*)selectedLanguage ofTable:(NSString*)tableName {
    //verification here ...
    if (selectedLanguage == nil) {
        selectedLanguage = @"en";
    }

    //then search for localized text
    NSString *langBundleNew = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/langs/Languages.bundle/%@.lproj/",selectedLanguage];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:langBundleNew]) {
        NSBundle *aBundle = (NSBundle*)[self.dictLangueBundle objectForKey:selectedLanguage];
        
        NSString* str=[aBundle localizedStringForKey:key value:@"[string not defined]" table:tableName];
        return str;
    } else {
        return @"[]";
    }
}

#pragma -

@end
