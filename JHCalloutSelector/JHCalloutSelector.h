//
//  JHCalloutSelector.h
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

#import <Foundation/Foundation.h>

@class JHCalloutSelector;

@protocol JHCalloutSelectorDelegate <NSObject>
@optional

// Called when a button is clicked. 
- (void)calloutSelector:(JHCalloutSelector *)calloutSelector clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface JHCalloutSelector : UIView {
	NSArray							*options;
	int								selectedOption;
	id<JHCalloutSelectorDelegate>	delegate;
	float							arrowPointXLocaton;
	BOOL							triangleTop;
}

@property(nonatomic,retain)id<JHCalloutSelectorDelegate> delegate;

-(id)initWithSourceFrame:(CGRect)frame andOptions:(NSArray *) options;
-(void) drawCalloutInRect:(CGRect)rect withColor:(CGColorRef) color;
-(void) drawDeviderLine:(float)location;

@end
