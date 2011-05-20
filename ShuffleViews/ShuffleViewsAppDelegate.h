//
//  ShuffleViewsAppDelegate.h
//  ShuffleViews
//
//  Created by Michael Smith on 3/3/11.
//  Copyright 2011 PikLips LLC. MIT Open Source License, see license.txt for details.
//

#import <UIKit/UIKit.h>

@class ShuffleViewsViewController;

@interface ShuffleViewsAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet ShuffleViewsViewController *viewController;

@end
