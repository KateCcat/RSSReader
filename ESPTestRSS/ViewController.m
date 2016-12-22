//
//  ViewController.m
//  ESPTestRSS
//
//  Created by Admin on 18.12.16.
//  Copyright © 2016 Test. All rights reserved.
//

#import "ViewController.h"
#import "ESPLoader.h"
#import "ESPNewsTableViewCell.h"
#import "ESPNewsViewController.h"
#import "ESPFeedsViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, ESPLoaderDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* arrayRss;
@property (strong, nonatomic) NSMutableArray* sectionTitle;
@property (strong, nonatomic) ESPLoader* loader;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _sectionTitle =[NSMutableArray array];
    _arrayRss = [NSMutableArray array];
    _loader = [[ESPLoader alloc] init];
    _loader.delegate = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Feeds" style:UIBarButtonItemStyleDone target: self action:@selector(addFeeds)];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_loader startLoading];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _arrayRss.count;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [_sectionTitle objectAtIndex:section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray*)[_arrayRss objectAtIndex:section]).count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* identifier = @"NewsCell";
    
    ESPNewsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ESPNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    cell.dictionary = [[_arrayRss objectAtIndex: indexPath.section] objectAtIndex: indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"didSelectRowAtIndexPath");
    
    ESPNewsViewController* createController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CreateController"];

    NSDictionary* news = [[_arrayRss objectAtIndex: indexPath.section] objectAtIndex: indexPath.row];
    createController.news = news;
    
    [self.navigationController pushViewController:createController animated:YES];
    
}


#pragma mark - ESPLoaderDelegate

-(void) handleRssArray:(NSArray *)array withTitle:(NSString *)title{
    
    [_sectionTitle addObject:title];
    [_arrayRss addObject:array];
    [_tableView reloadData];
    
}
-(void) addFeeds {
    //NSLog(@"feeds");
    ESPFeedsViewController* addFeedsController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"addFeedsController"];

    [self.navigationController pushViewController:addFeedsController animated:YES];
    
}

@end
