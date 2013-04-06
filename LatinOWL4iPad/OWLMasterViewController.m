//
//  OWLMasterViewController.m
//  LatinOWL4iPad
//
//  Created by Scot Mcphee on 30/03/13.
//  Copyright (c) 2013 Scot Mcphee. All rights reserved.
//

#import "OWLMasterViewController.h"

#import "OWLDetailViewController.h"
#import "OWLMorphData.h"
#import "OWLLemmaTableCell.h"
#import "OWLMorphDefinitionCell.h"


@implementation OWLMasterViewController {
        __weak UIPopoverController *searchPopover;
    }
    @synthesize lastSearch;
    @synthesize useLastSearch;


    - (void)awakeFromNib {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        [super awakeFromNib];
        [self setHistory:[NSMutableArray array]];
    }


    - (void)viewDidLoad {
        [super viewDidLoad];
        self.navigationController.toolbarHidden = YES;
        self.detailViewController = (OWLDetailViewController *) [[self.splitViewController.viewControllers lastObject] topViewController];
        [self performSegueWithIdentifier:@"searchFormSegue" sender:self];
    }


    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
        [self setHistory:[NSMutableArray array]];
        [self setLastSearch:nil];
        [self setLatinMorphData:nil];
        [self setUseLastSearch:NO];
    }


#pragma mark - OWLSearchViewControllerProtocol

    - (void)dismissSearch:(NSString *)value {
        NSLog(@"Cancelling the search %@", value);
        [self dismissPopover:self];
    }

#pragma mark - Search
    - (void)doSearch:(NSString *)value {
        NSLog(@"Doing the search %@", value);
        //once submitted, don't redisplay unless error.
        self.useLastSearch = NO;
        self.lastSearch = value;
        [self dismissPopover:self];
        [self handleSearch:value];
        // only add to the history when from popover
        [self.history addObject:value];
    }


    - (void)doSearchFromHistory:(NSString *)value {
        NSLog(@"Doing the search %@", value);
        //after history, we want the value to repopulate the dialog.
        self.useLastSearch = YES;
        self.lastSearch = value;
        [self handleSearch:value];
        // don't add the value to the history as we got it from the history.
    }


    - (void)handleSearch:(NSString *)value {
        [self.activityIndicator startAnimating];
        OWLMorphData *searchLatinMorphData = [OWLMorphData data];
        [self setLatinMorphData:searchLatinMorphData];
        [self.tableView reloadData];
        NSLog(@"User searched for '%@'", value);
        [searchLatinMorphData searchLatin:value withObserver:self];
    }

#pragma mark - Segues

    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        NSLog(@"segue %@", segue.identifier);
        if ([segue.identifier isEqualToString:@"searchFormSegue"]) {
            // we have completed the search and pressed enter.
            UIStoryboardPopoverSegue *popoverSegue = (UIStoryboardPopoverSegue *) segue;
            searchPopover = [popoverSegue popoverController];
            OWLSearchViewController *searchController = (OWLSearchViewController *) [segue destinationViewController];
            [searchController setDelegate:self];
        } else if ([segue.identifier isEqualToString:@"historySegue"]) {
            OWLHistoryViewController *historyController = (OWLHistoryViewController *) [segue destinationViewController];
            [historyController setDelegate:self];
            [historyController setHistory:[self history]];
        }
    }


    - (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
        NSLog(@"should do segue? %@", identifier);
        if ([identifier isEqualToString:@"searchFormSegue"]) {
            if (searchPopover) {
                // already showing.
                NSLog(@"already showing %@, dismissing it.", [searchPopover description]);
                self.useLastSearch = YES;
                [self dismissPopover:self];
                return NO;
            } else {
                NSLog(@"not showing a searchPopover, therefore ok to show.");
                return YES;
            }
        }
        return YES;
    }

#pragma mark - popover delegate

    - (void)dismissPopover:(id)sender {
        [searchPopover dismissPopoverAnimated:YES];
    }

#pragma OWLMorphDataObserver methods

    - (void)refreshViewData:(OWLMorphData *)latinMorph {
        if (latinMorph == [self latinMorphData]) {
            NSLog(@"refreshViewData called from URL %@", latinMorph.urlString);
            [self.activityIndicator stopAnimating];
            [self.tableView reloadData];
        }
    }


    - (void)showError:(NSError *)error forConnection:(NSURLConnection *)connection fromData:(OWLMorphData *)morphData {
        NSLog(@"Connection Error = %@", error);
        if ([self isLoadedAndVisible]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection error"
                                                            message:error.localizedDescription
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }


    - (void)showError:(NSException *)exception forSearchURL:(NSString *)searchURL fromData:(OWLMorphData *)morphData {
        NSLog(@"For search url=%@ - got error = %@", searchURL, [exception description]);
        [self.history removeObject:morphData.searchTerm];
        NSLog(@"removed '%@' from history; history count is now: %d with %@", searchURL, [self.history count], self.history);

        if ([self isLoadedAndVisible]) {
            NSLog(@"view is not hidden, showing alert and search form");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:(NSString *) [exception.userInfo objectForKey:@"title"]
                                                            message:(NSString *) [exception.userInfo objectForKey:@"message"]
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            self.useLastSearch = YES;
            [self performSegueWithIdentifier:@"searchFormSegue" sender:self];
        } else {
            NSLog(@"view is hidden, cannot showing alert and search form");
        }
    }


    - (BOOL)isLoadedAndVisible {
        return self.isViewLoaded && self.view.window;
    }
#pragma mark - Table View
    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        NSLog(@"selected cell:%@", indexPath);
        int section = [indexPath section];
        NSString *lemmaId = [[[self latinMorphData] lemmas] objectAtIndex:section];
        [self.detailViewController setTitle:lemmaId];
        NSLog(@"Selected lemma:%@", lemmaId);
        NSString *url = [self.latinMorphData theLewisAndShortURL:lemmaId];
        NSLog(@"Dictionary URL:%@", url);
        [self.detailViewController setDetailItem:url];
    }


    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        NSLog(@"called numberOfSectionsInTableView:%@", tableView);
        return [[[self latinMorphData] lemmas] count];
    }


    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        NSLog(@"called numberOfRowsInSection:%d", section);
        // Number of rows is the number of found items for each lemma.
        NSString *lemmaId = [[[self latinMorphData] lemmas] objectAtIndex:(NSUInteger) section];
        NSDictionary *definitions = [[self latinMorphData] definitions];
        if (definitions != nil) {
            NSDictionary *lemmaData = [definitions objectForKey:lemmaId];
            if (lemmaData != nil) {
                NSArray *formTable = [lemmaData objectForKey:KEY_TABLE];
                if (formTable != nil && [formTable count] > 0) {
                    return [formTable count] + 1;
                }
            }
        }
        return 0;
    }


    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        int row = [indexPath row];
        int section = [indexPath section];
        NSString *lemmaId = [[[self latinMorphData] lemmas] objectAtIndex:section];
        NSLog(@"called cellForRowAtIndexPath:%d,%d %@", section, row, lemmaId);
        if (row == 0) {
            NSString *cellIdentifier = @"LemmaTableCell";
            OWLLemmaTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[OWLLemmaTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }

            NSString *titleText = [self.latinMorphData theHeaderString:lemmaId];
            UILabel *titleLabel = [cell lemmaTitle];
            [titleLabel setText:titleText];
            NSString *meaningText = [self.latinMorphData theMeaning:lemmaId];
            UILabel *meaningCell = [cell lemmaMeaning];
            [meaningCell setText:meaningText];
            NSLog(@"%@ means %@", titleText, meaningText);
            return cell;
        } else if (row < [self tableView:tableView numberOfRowsInSection:section]) {
            NSString *cellIdentifier = @"MorphTableCell";
            OWLMorphDefinitionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[OWLMorphDefinitionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            int indexId = row - 1; // the meaning of the lemma is at the first cell position, therefore subtract one from the row number.
            NSString *form = [self.latinMorphData theForm:lemmaId ofIndex:indexId];
            NSString *parsed = [self.latinMorphData theFormParsed:lemmaId ofIndex:indexId];
            if (form == nil || parsed == nil || [form isEqualToString:@""] || [parsed isEqualToString:@""]) {
                return cell;
            }
            UILabel *morphTitleLabel = [cell morphTitle];
            [morphTitleLabel setText:form];
            UILabel *morphParsing = [cell morphParsing];
            [morphParsing setText:parsed];
            return cell;
        } else {
            return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"empty"];
        }
    }


    - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
        return NO;
    }

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


    - (void)viewDidUnload {
        // [self setToolBar:nil];
        [super viewDidUnload];
    }

@end
