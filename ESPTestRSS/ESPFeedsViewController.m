//
//  ESPFeedsViewController.m
//  ESPTestRSS
//
//  Created by Admin on 19.12.16.
//  Copyright © 2016 Test. All rights reserved.
//

#import "ESPFeedsViewController.h"
#import "ESPFeed.h"

@interface ESPFeedsViewController ()  <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray* feedsArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ESPFeedsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFeeds)];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"feedsArray"];
    _feedsArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if ( ! _feedsArray) {
        _feedsArray = [NSMutableArray array];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _feedsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    ESPFeed* feed = [_feedsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = feed.titleFeeds;
    cell.detailTextLabel.text = feed.urlFeeds;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_feedsArray removeObjectAtIndex:indexPath.row];
        [self saveFeedsArray];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView endUpdates];
    }
}
-(void) addFeeds{
    
    NSLog(@"addFeeds");
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"New RSS feed"
                                          message:@"Add you url feed"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = @"Feed title";
     }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = @"Feed url";
         
     }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   UITextField *login = alertController.textFields.firstObject;
                                   UITextField *password = alertController.textFields.lastObject;
                                   ESPFeed*feed = [[ESPFeed alloc]init];
                                   feed.titleFeeds =login.text;
                                   feed.urlFeeds = password.text;
                                   [_feedsArray addObject:feed];
                                   [_tableView reloadData];
                                   [self saveFeedsArray];
                                   
                               }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
-(void)saveFeedsArray{
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_feedsArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"feedsArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
