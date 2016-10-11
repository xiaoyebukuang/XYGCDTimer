//
//  MyModel.h
//  GCD timer
//
//  Created by cyp on 16/5/27.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModel : NSObject
@property (nonatomic ,assign)int time;

@property (nonatomic ,copy) NSString* message;

@property (nonatomic ,strong)dispatch_source_t timer;
@end
