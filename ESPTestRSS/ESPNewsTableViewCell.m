//
//  ESPNewsTableViewCell.m
//  ESPTestRSS
//
//  Created by Admin on 18.12.16.
//  Copyright © 2016 Test. All rights reserved.
//

#import "ESPNewsTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface ESPNewsTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descrLabel;
@property (strong, nonatomic) IBOutlet UIImageView *logoImage;


@end

@implementation ESPNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)setDictionary:(NSDictionary *)dictionary{
    _dictionary = dictionary;
    _titleLabel.text = [dictionary objectForKey:@"title"];
    _descrLabel.text = [dictionary objectForKey:@"description"];
    
    NSString* url =@"";
    if ([dictionary objectForKey:@"enclosure"] && [[dictionary objectForKey:@"enclosure"] isKindOfClass: [NSDictionary class]]) {
        NSDictionary* dictImage = [dictionary objectForKey:@"enclosure"];
        url =[dictImage objectForKey:@"_url"];
        
    }
    
    [_logoImage setImageWithURL:[NSURL URLWithString: url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
}


@end
