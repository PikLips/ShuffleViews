//
//  ShuffleViewsTests.h
//  ShuffleViewsTests
//
//  Created by Michael Smith on 3/3/11.
//  Copyright 2011 PikLips LLC. MIT Open Source License, see license.txt for details.
//

#import <SenTestingKit/SenTestingKit.h>

#import "ShuffleViewsAppDelegate.h" // PikLips: the app delegate, which includes the viewController and Subview 
#import "ShuffleViewsViewController.h" // PikLips: the viewController and its view 

@interface ShuffleViewsTests : SenTestCase {
@private
    ShuffleViewsAppDelegate       *testAppDelegate; // PikLips: this is our test instance of the app delegate, including the window
    ShuffleViewsViewController    *testViewController; //PikLips: this is the test instance of the view, created by IB
    
}

@end
