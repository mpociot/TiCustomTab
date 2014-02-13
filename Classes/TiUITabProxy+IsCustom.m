#import "TiUITabProxy+IsCustom.h"
#import "ImageLoader.h"

@implementation TiUITabProxy (IsCustom)

-(void)updateTabBarItem
{
	if (controller == nil)
	{
		return;
	}
	ENSURE_UI_THREAD_0_ARGS;

	id badgeValue = [TiUtils stringValue:[self valueForKey:@"badge"]];
	id icon = [self valueForKey:@"icon"];
    id selected= [self valueForKey:@"selected"];
    id unselected= [self valueForKey:@"unselected"];

	if ([icon isKindOfClass:[NSNumber class]])
	{
		int value = [TiUtils intValue:icon];
		UITabBarItem *newItem = [[UITabBarItem alloc] initWithTabBarSystemItem:value tag:value];
		[newItem setBadgeValue:badgeValue];
		[controller setTabBarItem:newItem];
		[newItem release];
		systemTab = YES;
		return;
	}

	NSString * title = [TiUtils stringValue:[self valueForKey:@"title"]];

	UIImage *image;
    UIImage *selectedImg;
    UIImage *unselectedImg;
	if (icon == nil)
	{
		image = nil;
	}
	else
	{
        selectedImg = nil;
        unselectedImg = nil;
		// we might be inside a different context than our tab group and if so, he takes precendence in
		// url resolution
		TiProxy* currentWindow = [self.executionContext preloadForKey:@"currentWindow" name:@"UI"];
		if (currentWindow==nil)
		{
			// check our current window's context that we are owned by
			currentWindow = [self.pageContext preloadForKey:@"currentWindow" name:@"UI"];
		}
		if (currentWindow==nil)
		{
			currentWindow = self;
		}
		image = [[ImageLoader sharedLoader] loadImmediateImage:[TiUtils toURL:icon proxy:currentWindow]];
	}

    if( selected != nil && unselected != nil ){
        // we might be inside a different context than our tab group and if so, he takes precendence in
		// url resolution
		TiProxy* currentWindow = [self.executionContext preloadForKey:@"currentWindow" name:@"UI"];
		if (currentWindow==nil)
		{
			// check our current window's context that we are owned by
			currentWindow = [self.pageContext preloadForKey:@"currentWindow" name:@"UI"];
		}
		if (currentWindow==nil)
		{
			currentWindow = self;
		}
		selectedImg = [[ImageLoader sharedLoader] loadImmediateImage:[TiUtils toURL:selected proxy:currentWindow]];
        unselectedImg = [[ImageLoader sharedLoader] loadImmediateImage:[TiUtils toURL:unselected proxy:currentWindow]];
    }

	[controller setTitle:title];
	UITabBarItem *ourItem = nil;

	if (!systemTab)
	{
		ourItem = [controller tabBarItem];
		[ourItem setTitle:title];
		[ourItem setImage:image];
        if( selectedImg != nil ){
            [ourItem setFinishedSelectedImage:selectedImg
                  withFinishedUnselectedImage:unselectedImg];
        }
	}

	if(ourItem == nil)
	{
		systemTab = NO;
		ourItem = [[[UITabBarItem alloc] initWithTitle:title image:image tag:0] autorelease];
        if( selectedImg != nil ){
            [ourItem setFinishedSelectedImage:selectedImg
                  withFinishedUnselectedImage:unselectedImg];
        }
		[controller setTabBarItem:ourItem];
	}

	[ourItem setBadgeValue:badgeValue];
}

-(void)setImages:(id)args
{
    id selected;
    id unselected;
    if( args != nil ){
        if(
           [args objectForKey:@"selected"] != nil &&
           [args objectForKey:@"unselected"] != nil
        ){
            selected    = [args objectForKey:@"selected"];
            unselected  = [args objectForKey:@"unselected"];
        }
        if([selected isKindOfClass:[NSString class]])
        {
            // we might be inside a different context than our tab group and if so, he takes precendence in
            // url resolution
            TiProxy* currentWindow = [self.executionContext preloadForKey:@"currentWindow" name:@"UI"];
            if (currentWindow==nil)
            {
                // check our current window's context that we are owned by
                currentWindow = [self.pageContext preloadForKey:@"currentWindow" name:@"UI"];
            }
            if (currentWindow==nil)
            {
                currentWindow = self;
            }

            selected = [[TiUtils toURL:selected proxy:currentWindow] absoluteString];
        }
        if([unselected isKindOfClass:[NSString class]])
        {
            // we might be inside a different context than our tab group and if so, he takes precendence in
            // url resolution
            TiProxy* currentWindow = [self.executionContext preloadForKey:@"currentWindow" name:@"UI"];
            if (currentWindow==nil)
            {
                // check our current window's context that we are owned by
                currentWindow = [self.pageContext preloadForKey:@"currentWindow" name:@"UI"];
            }
            if (currentWindow==nil)
            {
                currentWindow = self;
            }

            unselected = [[TiUtils toURL:unselected proxy:currentWindow] absoluteString];
        }

        [self replaceValue:selected forKey:@"selected" notification:NO];
        [self replaceValue:unselected forKey:@"unselected" notification:NO];
        [self updateTabBarItem];
    }
}

@end
