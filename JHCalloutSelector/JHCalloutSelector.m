//
//  JHCalloutSelector.m
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

#import "JHCalloutSelector.h"


#define kTriangleHeight 18.0f
#define kTriangleWidth  30.0f

#define kBorderWidth 2.0
#define kHorizontalPadding 10.0
#define kVerticalPadding 15.0
#define kButtonVerticalPadding 10.0
#define kDefaultFontSize 15.0
#define	kCalloutAlpha 0.8

@implementation JHCalloutSelector
@synthesize delegate;

-(id)initWithSourceFrame:(CGRect)frame andOptions:(NSArray *) anOptions{
	if(self = [super initWithFrame:CGRectZero])
	{
		self.opaque = FALSE;
		options = [anOptions copy];
		selectedOption = -1;
		
		float height = kVerticalPadding*2 + kTriangleHeight;
		float width = 0.0;
		
		UIFont *sysFont = [UIFont systemFontOfSize:kDefaultFontSize];
		for(NSString *string in options)
		{
			CGSize size = [string sizeWithFont:sysFont];
			
			height += size.height + kButtonVerticalPadding*2;
			if((size.width + kHorizontalPadding*2) > width)
				width = (size.width + kHorizontalPadding*2);
		}
		
		height -= kButtonVerticalPadding*2;
		
		arrowPointXLocaton = frame.size.width;
		
		float rectX = frame.origin.x + (frame.size.width - width)/2;
		float rectY = frame.origin.y + (frame.size.height/2) - height;
		triangleTop = FALSE;
		
		if (rectX < 0) rectX = 5.0;
		if ((rectX + width) > 320.0) rectX = 320.0 - 5.0 - width;
		
		if(rectY <0)
		{
			rectY = frame.origin.y + frame.size.height*2;
			triangleTop = TRUE;

		}
		
		self.frame = CGRectMake(rectX, rectY, width, height);
	}
	return self;
}



-(void)drawRect:(CGRect)aRect{
	CGRect rect = self.bounds;
	[self drawCalloutInRect:rect withColor:[[UIColor colorWithWhite:1.0 alpha:kCalloutAlpha] CGColor]];
	CGRect smallerRect = CGRectMake(rect.origin.x+kBorderWidth, rect.origin.y+kBorderWidth, rect.size.width-kBorderWidth*2, rect.size.height-kBorderWidth*2);
	[self drawCalloutInRect:smallerRect withColor:[[UIColor colorWithWhite:0.2 alpha:kCalloutAlpha] CGColor]];
	

	CGContextRef context = UIGraphicsGetCurrentContext();   
	

	
	CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
	CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);

	//Draw Options
	
	float top = self.bounds.origin.y + kVerticalPadding;
	if(triangleTop)
		top += kTriangleHeight;
	UIFont *sysFont = [UIFont systemFontOfSize:kDefaultFontSize];

	for(int i=0; i < [options count]; i++)
	{
		NSString *string = [options objectAtIndex:i];
		CGPoint p = CGPointMake(self.bounds.origin.x + kHorizontalPadding, top);
		
		if(selectedOption == i)
		{
			CGContextSetFillColorWithColor(context, [[UIColor blueColor] CGColor]);
			CGRect selectedFrame = CGRectMake(p.x-kHorizontalPadding/2, p.y-kButtonVerticalPadding/2, self.bounds.size.width - kHorizontalPadding, [string sizeWithFont:sysFont].height + kButtonVerticalPadding);
			CGContextBeginPath(context);
			CGContextAddRect(context, selectedFrame);
			CGContextClosePath(context);
			CGContextFillPath(context);
			CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);

		}
		
		[string drawAtPoint:p withFont:sysFont];
		
		top += [string sizeWithFont:sysFont].height + kButtonVerticalPadding;
		
		if(i < [options count]-1)
			[self drawDeviderLine:top];
		
		top += kButtonVerticalPadding;
	}

}

-(void) drawDeviderLine:(float)location
{
	CGContextRef context = UIGraphicsGetCurrentContext();   
	
	CGContextBeginPath(context);
	
	CGContextMoveToPoint(context, self.bounds.origin.x + kHorizontalPadding, location);
	CGContextAddLineToPoint(context, self.bounds.origin.x + self.bounds.size.width - kHorizontalPadding, location);

	CGContextStrokePath(context);
	CGContextClosePath(context);
}

-(void) drawCalloutInRect:(CGRect)rect withColor:(CGColorRef) color
{
	float radius = 8.0f;
	CGContextRef context = UIGraphicsGetCurrentContext();   
	
	CGContextBeginPath(context);
	CGContextSetFillColorWithColor(context, color);
	
	if(triangleTop)
	{
		CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + radius + kTriangleHeight);
		CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - radius);
		
		CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + rect.size.height - radius, 
						radius, M_PI / 4, M_PI / 2, 1);
		
		
		CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height);

		CGContextAddArc(context, rect.origin.x + rect.size.width - radius, 
						rect.origin.y + rect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
		CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + radius + kTriangleHeight);
		CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius + kTriangleHeight, 
						radius, 0.0f, -M_PI / 2, 1);
		
		//Top Line
		//Right side to triangle top right
		CGContextAddLineToPoint(context, arrowPointXLocaton + kTriangleWidth/2, rect.origin.y +kTriangleHeight);
		
		//triangle top right to point
		CGContextAddLineToPoint(context, arrowPointXLocaton, rect.origin.y);
		
		//triangle point to top left
		CGContextAddLineToPoint(context, arrowPointXLocaton - kTriangleWidth/2, rect.origin.y + kTriangleHeight);
		
		//triangle top right to right side
		CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y + kTriangleHeight);		
		
		
		CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + radius + kTriangleHeight, radius, 
						-M_PI / 2, M_PI, 1);	
	}
	else{
		
		CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + radius);
		CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - radius - kTriangleHeight);
		CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + rect.size.height - radius - kTriangleHeight, 
						radius, M_PI / 4, M_PI / 2, 1);
		
		//Bottom Line
		//Left side to triangle top left
		CGContextAddLineToPoint(context, arrowPointXLocaton - kTriangleWidth/2, 
								rect.origin.y + rect.size.height - kTriangleHeight);
		
		//triangle top left to point
		CGContextAddLineToPoint(context, arrowPointXLocaton, 
								rect.origin.y + rect.size.height);
		
		//triangle point to top right
		CGContextAddLineToPoint(context, arrowPointXLocaton + kTriangleWidth/2, 
								rect.origin.y + rect.size.height - kTriangleHeight);
		
		//triangle top right to right side
		CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius, 
								rect.origin.y + rect.size.height - kTriangleHeight);
		
		
		
		CGContextAddArc(context, rect.origin.x + rect.size.width - radius, 
						rect.origin.y + rect.size.height - radius - kTriangleHeight, radius, M_PI / 2, 0.0f, 1);
		CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + radius);
		CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius, 
						radius, 0.0f, -M_PI / 2, 1);
		CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y);
		CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + radius, radius, 
						-M_PI / 2, M_PI, 1);	
	}
	//CGContextStrokePath(context);
	CGContextClosePath(context);
	CGContextFillPath(context);
	
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:self];
	
	float top = kVerticalPadding;
	
	UIFont *sysFont = [UIFont systemFontOfSize:kDefaultFontSize];
	for(int i=0; i < [options count]; i++)
	{
		NSString *string = [options objectAtIndex:i];
		CGSize size = [string sizeWithFont:sysFont];
		float prevTop = top;
		top += size.height + kButtonVerticalPadding*2;
		
		if(location.y > prevTop && location.y < top)
			selectedOption = i;
	}
	[self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:self];
	
	float top = kVerticalPadding;
	
	UIFont *sysFont = [UIFont systemFontOfSize:kDefaultFontSize];
	for(int i=0; i < [options count]; i++)
	{
		NSString *string = [options objectAtIndex:i];
		CGSize size = [string sizeWithFont:sysFont];
		float prevTop = top;
		top += size.height + kButtonVerticalPadding*2;
		
		if(location.y > prevTop && location.y < top)
			selectedOption = i;
	}
	
	[self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	CGPoint location = [touch locationInView:self];
		
	if(CGRectContainsPoint(self.bounds, location))
	{
		if(delegate != nil && [delegate respondsToSelector:@selector(calloutSelector:clickedButtonAtIndex:)])
			[delegate calloutSelector:self clickedButtonAtIndex:selectedOption];
	}
	
	selectedOption = -1;
	
	[self setNeedsDisplay];
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
