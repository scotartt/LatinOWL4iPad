//
// Created by smcphee on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol OWLHistoryViewControllerDelegate;


@interface OWLHistoryViewController : UITableViewController <UITableViewDelegate>

    @property NSArray *history;
    @property(weak) id <OWLHistoryViewControllerDelegate> delegate;

@end


@protocol OWLHistoryViewControllerDelegate <NSObject>
@required
    - (void)doSearchFromHistory:(NSString *)value;
@end
