//
//  JHCalloutSelectorButtonSampleProjectViewController.m
//  JHCalloutSelectorButtonSampleProject
//
//  Created by Joshua Halickman on 9/14/09.
//  Copyright (c) 2009 Joshua Halickman
//  All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//
//	*Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//	*Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer 
//		in the documentation and/or other materials provided with the distribution.
//	*Neither the name of the the project's author nor the names of its contributors may be used to endorse or promote products derived from this software 
//		without specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, 
// BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT 
// SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
// OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "JHCalloutSelectorButtonSampleProjectViewController.h"

@implementation JHCalloutSelectorButtonSampleProjectViewController

@synthesize button;
@synthesize button2;


//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc {
    [button release], button = nil;
	[button2 release], button2 = nil;
    [buttonOptions release], buttonOptions = nil;

    [super dealloc];
}



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	buttonOptions = [NSArray arrayWithObjects:@"Button 1", @"Button 2", @"Button 3", @"Button longer text", @"Button 4", nil];
	button.options = buttonOptions;
	button.delegate = self;
	button2.options = buttonOptions;
	button2.delegate = self;
}

- (void)calloutSelectorButton:(JHCalloutSelectorButton *)calloutSelectorButton clickedButtonAtIndex:(NSInteger)buttonIndex
{
	UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Button Clicked" message:[buttonOptions objectAtIndex:buttonIndex] 
												delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[av show];
	[av release];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


@end
