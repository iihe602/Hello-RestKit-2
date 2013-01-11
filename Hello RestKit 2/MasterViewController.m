//
//  MasterViewController.m
//  Hello RestKit 2
//
//  Created by wangyongqi on 1/10/13.
//  Copyright (c) 2013 wyq. All rights reserved.
//

#define kCLIENTID "AIQF31DJE4AOG4TEORSJX1QJFQHMQKMNT5UO5M5DPS0KTB4W"
#define kCLIENTSECRET "WFJY4HK4DXMDAZDX3PGUMBYOIKYSJVRFJYLONPGMZRSKIQQG"
#define kBASE_URL @"https://api.Foursquare.com/v2"
#define kRESOURCE_PATH @"/venues/search"

#import "MasterViewController.h"
#import "DetailViewController.h"

#import <RestKit/RestKit.h>
#import <RestKit/RKURL.h>

#import "Venue.h"
#import "Location.h"
#import "VenueCell.h"
#import "Stats.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    
    RKURL *baseURL = [RKURL URLWithBaseURLString:kBASE_URL];
    RKObjectManager *objectManager = [RKObjectManager objectManagerWithBaseURL:baseURL];

    RKObjectMapping *venueMapping = [RKObjectMapping mappingForClass:[Venue class]];
    [venueMapping mapKeyPathsToAttributes:
         @"id", @"id",
         @"name", @"name",
         @"contact", @"contact",
//         @"location", @"location",
         @"canonicalUrl", @"canonicalUrl",
//         @"categories", @"categories",
         @"verified", @"verified",
         @"restricted", @"restricted",
//         @"stats", @"stats",
//         @"likes", @"likes",
//         @"specials", @"specials",
//         @"hereNow", @"hereNow",
         @"referralId", @"referralId",
     nil];
    [objectManager.mappingProvider setMapping:venueMapping forKeyPath:@"response.venues"];
    
    RKObjectMapping *locationMapping = [RKObjectMapping mappingForClass:[Location class]];
    [locationMapping mapKeyPathsToAttributes:
         @"address", @"address",
         @"lat", @"lat",
         @"lng", @"lng",
         @"distance", @"distance",
         @"postalCode", @"postalCode",
         @"city", @"city",
         @"state", @"state",
         @"country", @"country",
         @"cc", @"cc",
     nil];
    [venueMapping mapRelationship:@"location" withMapping:locationMapping];
    [objectManager.mappingProvider setMapping:locationMapping forKeyPath:@"location"];
    
    RKObjectMapping *statsMapping = [RKObjectMapping mappingForClass:[Stats class]];
    [statsMapping mapKeyPathsToAttributes:
         @"checkinsCount",@"checkinsCount",
         @"usersCount", @"usersCount",
         @"tipCount", @"tipCount",
     nil];
    [venueMapping mapRelationship:@"stats" withMapping:statsMapping];
    [objectManager.mappingProvider setMapping:statsMapping forKeyPath:@"stats"];    
    
    [self sendRequest];
}

//test:
//https://api.Foursquare.com/v2/venues/search?client_secret=WFJY4HK4DXMDAZDX3PGUMBYOIKYSJVRFJYLONPGMZRSKIQQG&client_id=AIQF31DJE4AOG4TEORSJX1QJFQHMQKMNT5UO5M5DPS0KTB4W&query=coffee&v=20120602&ll=37.33%2C-122.03

-(void)sendRequest
{

    NSString *latLon = @"37.33,-122.03";
    NSString *clientID = [NSString stringWithUTF8String:kCLIENTID];
    NSString *clientSecret = [NSString stringWithUTF8String:kCLIENTSECRET];

    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    NSDictionary *queryParameters = [NSDictionary dictionaryWithKeysAndObjects:
                                     @"client_secret", clientSecret,
                                     @"client_id", clientID,
                                     @"query", @"coffee",
                                     @"v", @"20120602",
                                     @"ll", latLon,
                                     nil];
    RKURL *url = [RKURL URLWithBaseURLString:kBASE_URL resourcePath:kRESOURCE_PATH queryParameters:queryParameters];
    NSLog(@"\nresourcePath: %@;\n\n", [url resourcePath]);
    NSLog(@"\nabsoluteString: %@;\n\n", [url absoluteString]);
    NSLog(@"\nquery: %@;\n\n", [url query]);
    NSLog(@"\nresourcePath 2: %@;\n\n", [NSString stringWithFormat:@"%@?%@", [url resourcePath], [url query]]);
    
    
//    NSLog(@"url: %@\n", [url description]);
    [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [url resourcePath], [url query]] delegate:self];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VenueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

//    NSDate *object = _objects[indexPath.row];
//    cell.textLabel.text = [object description];
    
    Venue *venue = _objects[indexPath.row];
    cell.nameLabel.text = venue.name;
    cell.distanceLabel.text = [NSString stringWithFormat:@"%d m", venue.location.distance];
    cell.checkinsLabel.text = [NSString stringWithFormat:@"%d checkins", venue.stats.checkinsCount];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma make - RKObjectLoaderDelegate

/**
 * Sent when an object loaded failed to load the collection due to an error
 */
- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"%@\n", [error localizedDescription]);
}

/**
 When implemented, sent to the delegate when the object laoder has completed successfully
 and loaded a collection of objects. All objects mapped from the remote payload will be returned
 as a single array.
 */
- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    _objects = [NSMutableArray arrayWithArray:objects];
    
    [self.tableView reloadData];
}


@end
