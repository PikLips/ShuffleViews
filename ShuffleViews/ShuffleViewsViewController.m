//
//  ShuffleViewsViewController.m
//  ShuffleViews
//
//  Created by Michael Smith on 3/3/11.
//  Copyright 2011 PikLips LLC. MIT Open Source License, see license.txt for details.
//

#import "ShuffleViewsViewController.h"

@implementation ShuffleViewsViewController
@synthesize sVTapGesture; // PikLips: demo instance 
- (void)dealloc
{
    [sVTapGesture release]; // PikLips: memory management
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
/* PikLips: Make A Subview
 * This creates a subview for our example that includes the view properties needed
 * to demonstrate the shuffle --
 * - backgroundColor
 * - frame size and position
 * 
 * Since this application merely demonstrates three subviews being shuffled, each
 * new subview created here needs to have a proper origin to be seen and a distictive
 * color to set it off from the other two views.  In order to illustrate this, we
 * create a view with the correct properties by keeping track of what the other two look like.
 * 
 */
- (UIView *) makeSubview: (NSInteger) oldTag atX: (CGFloat) x atY: (CGFloat) y withColor: (UIColor *) myBGColor{

    UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(x, y, 160, 230)];
    newView.backgroundColor = myBGColor;
    newView.tag = oldTag;
    return [newView autorelease];
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
 /* PikLips
 * Create a tap gesture recognizer for the subview.
 */
    UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] 
                                   initWithTarget:self 
                                   action:@selector(handleTapGesture:)]; // PikLips: assign our method
    [self.view addGestureRecognizer:tapGesture]; // PikLips: add to view
    self.sVTapGesture = (UITapGestureRecognizer *)tapGesture; // PikLips: make public
    tapGesture.delegate = self; // PikLips: make this class be the delegate 
    [tapGesture release]; // PikLips: then release it
}

/* PikLips:
 * This shuffles the subviews using various UIView methods.
 */

NSInteger tag = 1; // PikLips: views are tagged, starting with 1
- (IBAction) handleTapGesture:(UITapGestureRecognizer *)sender {
    
    /* PikLips:
     * These will rotate through any number of sibling subviews under self.view.
     * It will cycle front-to-back (RGB in this example) or back to front.  Since
     * Views are reordered instead of removed, They will cycle forever without changing
     * memory allocations.
     */
    
    // PikLips: These two behave the same (RGB) --
    // [self.view bringSubviewToFront: [self.view.subviews objectAtIndex:(NSUInteger) 0] ]; // PikLips: this will shuffle RGB
    // [self.view insertSubview: [self.view.subviews objectAtIndex:(NSUInteger) 0] aboveSubview:[self.view.subviews lastObject] ]; // PikLips: this will shuffle RGB

    // PikLips: These two behave the same (BGR) --
    // [self.view sendSubviewToBack: [self.view.subviews lastObject] ]; // PikLips: this will shuffle backwards - BGR
    // [self.view insertSubview:[self.view.subviews lastObject]  belowSubview:[self.view.subviews objectAtIndex:(NSUInteger) 0] ]; // PikLips: this will shuffle backwards - BGR

    /* PikLips: 
     * This adds an animation to the change.  Any change order can be used from above by
     * just replacing the code after "animation:^{" with any one above.
     *
     [UIView transitionWithView:self.view
                            duration:1.0 
                            options:UIViewAnimationOptionTransitionCurlDown
                    animations:^{ [self.view bringSubviewToFront: [self.view.subviews objectAtIndex:(NSUInteger) 0] ];} 
                                    completion:NULL];
     */

    /* PikLips: Animation options include --
     * These cn be combined by OR'ing them together. Most will only influence
     * other changes such as fading a hide or easing a turn --
     *    UIViewAnimationOptionLayoutSubviews 
     *    UIViewAnimationOptionAllowUserInteraction 
     *    UIViewAnimationOptionBeginFromCurrentState 
     *    UIViewAnimationOptionRepeat  
     *    UIViewAnimationOptionAutoreverse  
     *    UIViewAnimationOptionOverrideInheritedDuration 
     *    UIViewAnimationOptionOverrideInheritedCurve 
     *    UIViewAnimationOptionAllowAnimatedContent 
     *    UIViewAnimationOptionShowHideTransitionViews
     *    UIViewAnimationOptionCurveEaseInOut  
     *    UIViewAnimationOptionCurveEaseIn  
     *    UIViewAnimationOptionCurveEaseOut 
     *    UIViewAnimationOptionCurveLinear  
     *    UIViewAnimationOptionTransitionNone
     * Only these will have a visible affect in this example --
     *    UIViewAnimationOptionTransitionFlipFromLeft 
     *    UIViewAnimationOptionTransitionFlipFromRight
     *    UIViewAnimationOptionTransitionCurlUp 
     *    UIViewAnimationOptionTransitionCurlDown  
     */
    
    /* PikLips:
     * Many apps deal out views like MacDonalds sells hamburgers.  This trick is keeping track 
     * of the inventory.  This shows how to churn out views like hamburgers without slipping
     * on the grease.
     * This changes the views by removing one an addind a new one-
     */
    // [[self.view viewWithTag: tag] removeFromSuperview]; // PikLips: removes each color view
    // [self.view addSubview:[self makeSubview: tagatX: currentPosition.origin.x atY: currentPosition.origin.y withColor: currentColor]]; // PikLips: adds new view.  The same could be done with a subclass of UIView and didAddSubview
    /* PikLips:
     * a fancier way to implement it --
     */
    CGRect currentPosition = [[self.view viewWithTag:tag] frame ];  
    UIColor *currentColor = [[self.view viewWithTag:tag] backgroundColor ];
    [UIView transitionWithView:self.view
                      duration:1.0 
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{ [[self.view viewWithTag: tag] removeFromSuperview];
                        [self.view addSubview:[self makeSubview: tag atX: currentPosition.origin.x atY: currentPosition.origin.y withColor: currentColor]];} 
                    completion:nil];
    if (++tag == 3) tag = 0;
}
/* PikLips: 
 * These are used to demnstrate the methods that handle changes to the view and its subviews.
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    NSLog(@"View Did Appear");
}

// PikLips: code ends

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
