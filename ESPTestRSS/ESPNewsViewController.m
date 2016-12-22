//
//  ESPNewsViewController.m
//  ESPTestRSS
//
//  Created by Admin on 19.12.16.
//  Copyright © 2016 Test. All rights reserved.
//

#import "ESPNewsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ESPNewsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *descrTextView;
@property (strong, nonatomic) IBOutlet UIImageView *logoNews;

@end

@implementation ESPNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleLabel.text = [_news objectForKey:@"title"];
    _descrTextView.text = [_news objectForKey:@"description"];
    NSString* url =@"";
    if ([_news objectForKey:@"enclosure"] && [[_news objectForKey:@"enclosure"] isKindOfClass: [NSDictionary class]]) {
        NSDictionary* dictImage = [_news objectForKey:@"enclosure"];
    url =[dictImage objectForKey:@"_url"];
    }
    [_logoNews setImageWithURL:[NSURL URLWithString: url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
