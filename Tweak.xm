#import <UIKit/UIKit.h>

@interface YTPlayerViewController : UIViewController
@property (nonatomic, assign, readwrite) NSString *contentVideoID;
@end

@interface YTQTMButton : UIButton
@property (nonatomic, assign, readwrite) UIImageView *imageView;
@end

@interface YTFormattedStringLabel : UILabel
@end

static YTPlayerViewController *playerControllerInstance;

%hook YTPlayerViewController
// Only works with older versions of YouTube
-(id)initWithParentResponder:(id)arg1 overlayFactory:(id)arg2 {
	playerControllerInstance = %orig;
	return playerControllerInstance;
}

// Only works with newer versions of YouTube
-(id)initWithServiceRegistryScope:(id)arg1 parentResponder:(id)arg2 overlayFactory:(id)arg3 {
	playerControllerInstance = %orig;
	return playerControllerInstance;
}
%end

%hook YTFormattedStringLabel
-(void)layoutSubviews {
	%orig;
	if ([self.attributedText.string isEqualToString:[[NSBundle mainBundle] localizedStringForKey:@"reel.player.share_video" value:@"Share" table:@"Localizable"]]) {
		UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleStockShareTap)];
		[self.superview addGestureRecognizer:tapGestureRecognizer];
	}
}
%new
-(void)handleStockShareTap {
	UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:@[[NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@", playerControllerInstance.contentVideoID]] applicationActivities:nil];
	[playerControllerInstance presentViewController:controller animated:YES completion:^{}];
}
%end
