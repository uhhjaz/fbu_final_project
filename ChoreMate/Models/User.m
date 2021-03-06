/**
 * User.h
 * ChoreMate
 *
 * Description: implementation of the User Model Class as a subclass of PFUser
 *
 * Created by Jasdeep Gill on 7/13/20.
 * Copyright © 2020 jazgill. All rights reserved.
 */


#import "User.h"
#import <Parse/Parse.h>

@implementation User

@dynamic name;
@dynamic profileImageView;
@dynamic household_id;
@dynamic fb_authenticated;


+ (User *)user {
    return (User *)[PFUser user];
}


+ (BOOL)isLoggedIn {
    return [User currentUser] ? YES: NO;
}


+ (void) updateUserProfileImage: ( UIImage * _Nullable )image withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    User *theUser = [User currentUser];
    theUser.profileImageView = [self getPFFileFromImage:image];
    [theUser saveInBackgroundWithBlock: completion];
    
}


+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}


    
+ (void) getUserFromObjectId:(NSString *)userObjectId completionHandler:(void (^)(User *user))completionHandler {

    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" equalTo:userObjectId]; 

    [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if(object != nil){
            User *theUser = (User *)object;
            completionHandler(theUser);
        }
    }];
}
    



@end
