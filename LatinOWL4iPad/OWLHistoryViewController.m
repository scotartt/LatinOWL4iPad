//
// Created by smcphee on 31/03/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "OWLHistoryViewController.h"
#import "OWLHistoryTableCell.h"


@implementation OWLHistoryViewController

    @synthesize history;
    @synthesize delegate;


    - (void)viewDidLoad {
        NSLog(@"view did load with %d items of history", [history count]);
        [super viewDidLoad];
        self.navigationController.toolbarHidden = YES;
        self.title = @"History";
        [[self tableView] reloadData];
    }


    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        int row = [indexPath row];
        NSString *searchHistoryItem = [self.history objectAtIndex:(NSUInteger) row];
        //NSLog(@"Start item %@ for row %d", searchHistoryItem, row);

        NSString *cellIdentifier = @"Cell";
        OWLHistoryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[OWLHistoryTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell.historyItem setText:searchHistoryItem];
        NSLog(@"Load cell item %@ for row %d", searchHistoryItem, row);
        return cell;
    }


    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return 1;
    }


    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return [self.history count];
    }


    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        int row = [indexPath row];
        NSString *searchHistoryItem = [self.history objectAtIndex:(NSUInteger) row];
        NSLog(@"selected history at %@ for %@", indexPath, searchHistoryItem);
        // the below will load in the background, and the data will be available when you flip back.
        [self.delegate doSearchFromHistory:searchHistoryItem];
    }

@end
