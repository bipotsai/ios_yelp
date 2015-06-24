//
//  ConfigurationViewController.h
//  
//
//  Created by Bipo Tsai on 6/21/15.
//
//

#import <UIKit/UIKit.h>
@class ConfigurationViewController;

@protocol ConfigurationViewControllerDelegate <NSObject>

- (void) configurationViewController:(ConfigurationViewController *)configurationViewController didChangeFilters:(NSDictionary *)filters;

@end

@interface ConfigurationViewController : UIViewController
@property (nonatomic, weak) id<ConfigurationViewControllerDelegate> delegate;
@end
