//
//  AppDelegate.m
//  Vocabulary
//
//  Created by vingleo on 16/10/19.
//  Copyright © 2016年 Vingleo. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// Write and read text file from /TMP folder
#pragma mark - Write and Read from file

-(BOOL) writeText:(NSString *)paramText toPath:(NSString *)paramPath {
    return [paramText writeToFile:paramPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

-(NSString *) readTextFromPath:(NSString *)paramPath {
    return [[NSString alloc]initWithContentsOfFile:paramPath encoding:NSUTF8StringEncoding error:nil];
}

-(BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //string
    NSString *filePath = [NSTemporaryDirectory()stringByAppendingPathComponent:@"MyFile.txt"];
    
    if ([self writeText:@"Hello,world" toPath:filePath]) {
        NSString *readText = [self readTextFromPath:filePath];
        if ([readText length] > 0) {
            NSLog(@"Text read from disk = %@",readText);
        } else {
            NSLog(@"Failed to read the text from disk.");
        }
    } else {
        NSLog(@"Failed to write the file");
    }
    
    //array
    NSString *arrayFilePath = [NSTemporaryDirectory()stringByAppendingPathComponent:@"MyArray.txt"];
    NSArray *arrayOfNames = @[@"Steve",@"John",@"Edward"];
    if ([arrayOfNames writeToFile:arrayFilePath atomically:YES]) {
        NSArray *readArray = [[NSArray alloc]initWithContentsOfFile:arrayFilePath];
        if ([readArray count] == [arrayOfNames count]) {
            NSLog(@"Read the array back from disk just fine.");
        } else {
            NSLog(@"Failed to read the array back from disk.");
        }
    } else {
        NSLog(@"Failed to save the array to disk");
    }
    
    //dictionary
    NSString *dicFilePath = [NSTemporaryDirectory()stringByAppendingPathComponent:@"MyDictionary.txt"];
    NSDictionary *dict = @{
                           @"first name":@"Steven",
                           @"middle name":@"Paul",
                           @"last name":@"Jobs",
                           };
    if ([dict writeToFile:dicFilePath atomically:YES]) {
        NSDictionary *readDictionary = [[NSDictionary alloc]initWithContentsOfFile:dicFilePath];
        if ([readDictionary isEqualToDictionary:dict]) {
            NSLog(@"The file we read is the sme one as the one we saved.");
        } else {
            NSLog(@"Failed to read the dictionary from disk.");
        }
    }else {
        NSLog(@"Failed to write the dictionary to disk.");
    }
    
    //character
    char bytes[4] = {'a','b','c','d'};
    NSString *charFilePath = [NSTemporaryDirectory()stringByAppendingPathComponent:@"MyCharFile.txt"];
    
    NSData *dataFromBytes =[[NSData alloc] initWithBytes:bytes length:sizeof(bytes)];
    
    if ([dataFromBytes writeToFile:charFilePath atomically:YES]) {
        NSData *readData = [[NSData alloc]initWithContentsOfFile:charFilePath];
        if ([readData isEqualToData:dataFromBytes]) {
            NSLog(@"The data read is the same data as was writen to disk.");
        }else {
            NSLog(@"Failed to read the data from disk.");
        }
    }else {
        NSLog(@"Failed to save the data to disk");
    }
    
    
    return YES;
}


@end
