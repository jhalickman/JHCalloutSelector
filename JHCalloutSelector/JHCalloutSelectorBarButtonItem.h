//
//  JHCalloutSelectorBarButtonItem.h
//  JHCalloutSelectorButtonSampleProject
//
//  Created by Joshua Halickman on 9/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHCalloutSelector.h"

@class JHCalloutSelectorBarButtonItem;

@protocol JHCalloutSelectorButtonDelegate <NSObject>
@optional

// Called when a button is clicked. 
- (void)calloutSelectorButton:(JHCalloutSelectorBarButtonItem *)calloutSelectorButton clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface JHCalloutSelectorBarButtonItem : UIBarButtonItem <JHCalloutSelectorDelegate>{
	JHCalloutSelector							*selector;
	NSArray										*options;
	id<JHCalloutSelectorButtonDelegate>			delegate;
}

@property(nonatomic,copy)NSArray *options;
@property(nonatomic,retain)id<JHCalloutSelectorButtonDelegate> delegate;

-(IBAction)toggleCallout;

@end
