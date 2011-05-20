//
//  ShuffleViewsViewController.h
//  ShuffleViews
//
//  Created by Michael Smith on 3/3/11.
//  Copyright 2011 PikLips LLC. MIT Open Source License, see license.txt for details.
//

#import <UIKit/UIKit.h>

@interface ShuffleViewsViewController : UIViewController  /* PikLips */ <UIGestureRecognizerDelegate> /* PikLips */ {
    UITapGestureRecognizer *sVTapGesture; // PikLips: lets the user hide the view
}
@property (nonatomic, retain) UITapGestureRecognizer *sVTapGesture; // PikLips: demo instance method

@end
