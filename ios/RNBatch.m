
#import "RNBatch.h"

@implementation RNBatch

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

- (id)init {
    self = [super init];

    if (self != nil) {
        NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
        NSString *batchAPIKey;

        #ifdef DEBUG
            batchAPIKey = [info objectForKey:@"BatchAPIKeyDev"];
        #else
            batchAPIKey = [info objectForKey:@"BatchAPIKeyProd"];
        #endif

        [Batch startWithAPIKey:batchAPIKey];
    }

    return self;
}

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

RCT_EXPORT_METHOD(registerForRemoteNotifications)
{
    [BatchPush registerForRemoteNotifications];
}

RCT_EXPORT_METHOD(login:(nullable NSString*)userID)
{
    BatchUserDataEditor *editor = [BatchUser editor];
    [editor setIdentifier:userID];
    [editor save];
}

RCT_EXPORT_METHOD(logout)
{
    BatchUserDataEditor *editor = [BatchUser editor];
    [editor setIdentifier:nil];
    [editor save];
}

@end
