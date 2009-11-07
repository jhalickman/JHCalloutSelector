//
//  JHCalloutSelectorBarButtonItem.m
//  JHCalloutSelectorButtonSampleProject
//
//  Created by Joshua Halickman on 9/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "JHCalloutSelectorBarButtonItem.h"


@implementation JHCalloutSelectorBarButtonItem

@synthesize options;
@synthesize delegate;

- (id) initWithCoder:(NSCoder *) coder
{
	if(self = [super initWithCoder:coder])
	{
		self.action = @selector(toggleCallout);
		self.target = self;
		options = [[NSArray alloc] init];
	}
	return self;
}

-(id)initWithFrame:(CGRect)frameRect andOptions:(NSArray *)someOptions{
	if(self = [super initWithFrame:frameRect])
	{
		self.action = @selector(toggleCallout);
		self.target = self;
		options = [someOptions copy];
	}
	return self;
}


-(IBAction)toggleCallout{
	if(selector == nil)
	{
		selector= [[JHCalloutSelector alloc] initWithSourceFrame:self.customView.frame andOptions:options];
		selector.delegate = self;
		[[[[UIApplication sharedApplication] delegate] window] addSubview:selector];
				
	}
	else {
		[selector removeFromSuperview];
		[selector release];
		selector = nil;
	}
	
}

- (void)calloutSelector:(JHCalloutSelector *)calloutSelector clickedButtonAtIndex:(NSInteger)buttonIndex
{
	[selector removeFromSuperview];
	[selector release];
	selector = nil;
	
	if(delegate != nil && [delegate respondsToSelector:@selector(calloutSelectorButton:clickedButtonAtIndex:)])
		[delegate calloutSelectorButton:self clickedButtonAtIndex:buttonIndex];
}


//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc {
    [options release], options = nil;
	[delegate release], delegate = nil;
	
    [super dealloc];
}
@end
