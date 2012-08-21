#import "TiUITabGroup+IsCustom.h"
#import "ImageLoader.h"

@implementation TiUITabGroup (IsCustom)



-(void)setTintColor_:(id)value
{
	[[UITabBar appearance] setSelectedImageTintColor:[[TiColor colorNamed:value] color]];
}


- (void)setCustomBackgroundImage_:(NSString *)background {
    UIImage* tabBarBackground = [[ImageLoader sharedLoader] loadImmediateImage:[TiUtils toURL:background proxy:self.proxy]];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
}

-(void)setIndicator_:(NSString *)indicator {
    UIImage* indicatorImg = [[ImageLoader sharedLoader] loadImmediateImage:[TiUtils toURL:indicator proxy:self.proxy]];
    [[UITabBar appearance] setSelectionIndicatorImage:indicatorImg];
}

@end
