//
//  MCViewController.m
//  Maroc
//
//  Created by liunina on 10/11/2022.
//  Copyright (c) 2022 liunina. All rights reserved.
//

#import "Consts.h"
#import "MCHomeServiceProtocol.h"
#import "MCTrackServiceProtocol.h"
#import "MCUserServiceProtocol.h"
#import "MCViewController.h"
#import "NSString+encode.h"
enum MALineCapType {
    kMALineCapButt,   ///< 普通头
    kMALineCapSquare, ///< 扩展头
    kMALineCapArrow,  ///< 箭头
    kMALineCapRound   ///< 圆形头
};
typedef enum MALineCapType MALineCapType;

@interface MCViewController ()
@property (nonatomic, strong) NSString *testName1;
@property (nonatomic, strong) NSString *testName;
@end

@implementation MCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //    id<MCUserServiceProtocol> userService = [[Maroc shareInstance]
    //    createService:@protocol(MCUserServiceProtocol)];

    id<MCUserServiceProtocol> userService = MAROC(MCUserServiceProtocol);
    [userService wantToGoWorld:@"helloworld!"];

    id<MCTrackServiceProtocol> trackService = [[Maroc shareInstance] createService:@protocol(MCTrackServiceProtocol)];
    [trackService trackEvent:@"MCViewController!"];

    id<MCHomeServiceProtocol> homeService = [[Maroc shareInstance] createService:@protocol(MCHomeServiceProtocol)];
    [homeService run];

    [self callServiceByURLs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)doSome:(NSInteger)num hello:(NSString *)h {
    MALineCapType capType = kMALineCapButt;
    switch (capType) {
    case kMALineCapButt:
        NSLog(@"111");
        break;
    case kMALineCapSquare: {
        NSLog(@"111");
    } break;

    case kMALineCapArrow: {
        NSLog(@"111");
        NSLog(@"111");
    } break;

    default:
        break;
    }
}

- (void)callServiceByURLs {
    NSDictionary *params = @{@"MCTrackService" : @{@"eventName" : @"789"}};
    NSString *json = [[self jsonForDict:params] urlencode];

    NSString *urlCall = [NSString
        stringWithFormat:@"hellomacro://call.service.maroc/MCTrackService.MCTrackServiceProtocol.trackEvent:?params=%@",
                         json];
    [MCRouter openURL:[NSURL URLWithString:urlCall]
           withParams:nil
              andThen:^(NSString *pathComponentKey, id obj, id returnValue){

              }];
    NSDictionary *params1 = @{orderPathComponentKey : @{@"productName" : @"矿泉水"}};
    NSString *json1 = [[self jsonForDict:params1] urlencode];
    NSString *urlCall1 = [NSString
        stringWithFormat:
            @"hellomacro://call.service.maroc/order.MCOrderServiceProtocol.createOrderByProductName:?params=%@", json1];
    NSString *urlCall11 = @"hellomacro://call.service.maroc/order.MCOrderServiceProtocol.createOrderByProductName:";
    [MCRouter openURL:[NSURL URLWithString:urlCall1]
           withParams:params1
              andThen:^(NSString *pathComponentKey, id obj, id returnValue){

              }];
}

- (NSString *)jsonForDict:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData =
        [NSJSONSerialization dataWithJSONObject:dict
                                        options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the
                                                                           // readability of the generated string
                                          error:&error];

    if (!jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    return nil;
}
@end
