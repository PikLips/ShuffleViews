//
//  ShuffleViewsTests.m
//  ShuffleViewsTests
//
//  Created by Michael Smith on 3/3/11.
//  Copyright 2011 PikLips LLC. MIT Open Source License, see license.txt for details.
//

#import "ShuffleViewsTests.h"


@implementation ShuffleViewsTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    testAppDelegate = (ShuffleViewsAppDelegate *)[[UIApplication sharedApplication] delegate];  //PikLips: creates a separate instance for testing of the same Class as AppDelegate which includes UIGestureRecognizer delegate
    testViewController = testAppDelegate.viewController;  //PikLips: creates a separate instance for testing

}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}
-(void) spanTheTree: (UIView *) subview
{
    // PikLips: deal with the view, then report on the view hierarchy --
    STAssertNil(subview, @"This view %@ is the #%i subview of %@", subview, ([subview.superview.subviews indexOfObject: subview] + 1), subview.superview);
    
    // PikLips: now dig for the subviews --
    for (UIView *eachSubview in subview.subviews)
    {
        [self spanTheTree: eachSubview];
    }
}
- (void)testViews
{
    for (UIView *eachView in testAppDelegate.window.subviews)
    {
        [self spanTheTree:eachView];
    }
}

@end
