//
//  OWLMasterViewController.m
//  LatinOWL4iPad
//
//  Created by Scot Mcphee on 30/03/13.
//  Copyright (c) 2013 Scot Mcphee. All rights reserved.
//

#import "OWLMasterViewController.h"

#import "OWLDetailViewController.h"

@interface OWLMasterViewController () {
        NSMutableArray *_objects;
    }
@end


@implementation OWLMasterViewController {
        __weak UIPopoverController *searchPopover;
    }

    - (void)awakeFromNib {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        [super awakeFromNib];
    }


    - (void)viewDidLoad {
        [super viewDidLoad];
        self.navigationController.toolbarHidden = NO;
        self.detailViewController = (OWLDetailViewController *) [[self.splitViewController.viewControllers lastObject] topViewController];

        _objects = [NSMutableArray arrayWithObjects:@"Row 1", @"Row 2", @"Row 3", @"Row 4", @"Row 5", nil];
    }


    - (void)didReceiveMemoryWarning {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }


    - (void)insertNewObject:(id)sender {
        if (!_objects) {
            _objects = [[NSMutableArray alloc] init];
        }
        [_objects insertObject:[NSDate date] atIndex:0];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }


#pragma mark - OWLSearchViewControllerProtocol

    - (void)dismissSearch:(NSString *)value {
        NSLog(@"Cancelling the search %@", value);
        [self dismissPopover:self];
    }


    - (void)doSearch:(NSString *)value {
        NSLog(@"Doing the search %@", value);
        [self dismissPopover:self];
    }

#pragma mark - Segues

    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        // we have completed the search and pressed enter.
        NSLog(@"segue %@", segue.identifier);
        if ([segue.identifier isEqualToString:@"searchFormSegue"]) {
            UIStoryboardPopoverSegue *popoverSegue = (UIStoryboardPopoverSegue *) segue;
            searchPopover = [popoverSegue popoverController];
            OWLSearchViewController *searchController = (OWLSearchViewController *) [segue destinationViewController];
            [searchController setDelegate:self];
        } else if ([segue.identifier isEqualToString:@"no"]) {
        }
    }


    - (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {

        if ([identifier isEqualToString:@"searchFormSegue"]) {
            if (searchPopover) {
                // already showing.
                NSLog(@"already showing");
                [self dismissPopover:self];
                return NO;
            } else {
                NSLog(@"not showing");
                return YES;
            }
        }
        return YES;
    }

#pragma mark - popover delegate

    - (void)dismissPopover:(id)sender {
        [searchPopover dismissPopoverAnimated:YES];
    }


#pragma mark - Table View

    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        return _objects.count;
    }


    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 2;
    }


    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LemmaTableCell" forIndexPath:indexPath];

        NSString *object = _objects[indexPath.row];
        cell.textLabel.text = [object description];
        return cell;
    }


    - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
        return NO;
    }


    - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [_objects removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        } else if (editingStyle == UITableViewCellEditingStyleInsert) {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
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

    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }


    - (void)viewDidUnload {
        // [self setToolBar:nil];
        [super viewDidUnload];
    }

@end
