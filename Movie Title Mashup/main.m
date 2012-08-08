//
//  main.m
//  Movie Title Mashup
//
//  Created by Ran Tao on 8.7.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.//

#import <Foundation/Foundation.h>


NSMutableArray* wordsInTitle(NSString *title)
{
    NSArray *titleWords = [title componentsSeparatedByString:@" "];
    //NSLog(@"%@", titleWords);
    NSMutableArray *mutableWords = [NSMutableArray arrayWithArray:titleWords];
    //NSLog(@"%@", mutableWords);

    return mutableWords;
}

NSString* lastWord(NSString *title)
{
    NSMutableArray *titleWords = wordsInTitle(title);
    long wordsCount = [titleWords count] -1;
//    if (wordsCount <1) {
//        NSLog(@"word is %@: %ld",title, wordsCount);
//    }
    NSString *last = [titleWords objectAtIndex:wordsCount];
    return last;
}

NSString* firstWord(NSString *title)
{
    NSArray *titleWords = wordsInTitle(title);
    NSString *first = [titleWords objectAtIndex:0];
    return first;
}



int main (int argc, const char * argv[])
{
    
    @autoreleasepool {
                
        NSString *fullPath = @"/Users/ran/src/FirstObjectiveCProject/obj-c-data/movies3.txt";
        NSString *movieTitles = [NSString stringWithContentsOfFile:fullPath
                                                          encoding:NSUTF8StringEncoding
                                                             error:NULL];
        
        NSArray *movieList = [movieTitles componentsSeparatedByString:@"\n"];
        NSUInteger movieCount = [movieList count]-1;
        NSMutableArray *newMovieList = [[NSMutableArray alloc]init];
        
        for (int k = 1; k <= movieCount; k++) {
            NSString *checkTitle = [movieList objectAtIndex:k];
            checkTitle = [checkTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSMutableArray *arrayTitle = wordsInTitle(checkTitle);

            if ([arrayTitle count]>1) {
                [newMovieList addObject:checkTitle];
            }
        }
        
        // NSLog(@"%@", newMovieList);
        long newMovieCount = [newMovieList count]-1;
        //NSLog(@"%ld", newMovieCount);
        NSMutableArray *mashupTitles = [[NSMutableArray alloc]init];
        
        
        
        for (int i=0; i<=newMovieCount; i++) {
            NSString *title = [newMovieList objectAtIndex:i];
            NSMutableArray *firstTitle = wordsInTitle(title);
            NSString *matchLastWord = lastWord(title);
            for (int j = 0; j<=newMovieCount; j++) {
                    NSString *matchTitle = [newMovieList objectAtIndex:j];
                    NSMutableArray *secondTitle = wordsInTitle(matchTitle);
                    NSString *matchWord = firstWord(matchTitle);
                    if ([matchWord isEqual:matchLastWord]){
                        [secondTitle removeObjectAtIndex:0];
                        NSString *part1 = [firstTitle componentsJoinedByString:@" "];
                        NSString *part2 = [secondTitle componentsJoinedByString:@" "];
                        NSString *mashupPart = [NSString stringWithFormat:@"%@ %@", part1, part2];
                        [mashupTitles addObject:mashupPart];
                        NSLog(@"%@", mashupPart);
                    }
                    [secondTitle release];
            }
            [firstTitle release];

            NSLog(@"we got to: %d", i);

        }
        
//        NSLog(@"%@", fullPath);
//        NSLog(@"%@", movieTitles);
//        NSLog(@"%@", movieList);
        NSLog(@"%@", mashupTitles);
        [mashupTitles writeToFile:@"/Users/ran/Desktop/mashup_movies.txt" atomically:YES];
        
        
    }
    return 0;
}