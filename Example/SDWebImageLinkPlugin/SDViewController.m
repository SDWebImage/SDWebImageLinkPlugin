/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDViewController.h"
#import <SDWebImage/SDWebImage.h>
#import <SDWebImageLinkPlugin/SDWebImageLinkPlugin.h>
#import <SafariServices/SafariServices.h>

@interface LinkTableViewCell : UITableViewCell

@property (nonatomic, strong) LPLinkView *linkView;

@end

@implementation LinkTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        LPLinkMetadata *metadata = [LPLinkMetadata new]; // We must pass empty metadata here, or will cause Cell-reusing issues on iOS 13.1.
        _linkView = [[LPLinkView alloc] initWithMetadata:metadata];
        [self.contentView addSubview:_linkView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.linkView.frame = CGRectInset(self.bounds, 20, 20);
}

@end

@interface ImageTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *hostLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *customImageView;

@end

@implementation ImageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _customImageView = [[UIImageView alloc] init];
        _customImageView.contentMode = UIViewContentModeScaleAspectFill;
        _customImageView.clipsToBounds = YES;
        _customImageView.layer.cornerRadius = 10;
        [self.contentView addSubview:_customImageView];
        _hostLabel = [[UILabel alloc] init];
        _hostLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_hostLabel];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightBold];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.customImageView.frame = CGRectInset(self.bounds, 20, 40);
    self.hostLabel.frame = CGRectMake(30, self.bounds.size.height - 20, self.bounds.size.width - 2 * 30, 20);
    self.titleLabel.frame = CGRectMake(30, self.bounds.size.height - 40, self.bounds.size.width - 2 * 30, 20);
    
}

@end

@interface SDViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) BOOL useLinkView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *objects;

@end

@implementation SDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SDWebImage";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithTitle:@"Clear Cache"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(flushCache)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem.alloc initWithTitle:@"Switch View"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(switchView)];
    self.useLinkView = YES;
    self.objects = [NSArray arrayWithObjects:
                    @"https://www.apple.com/",
                    @"https://www.apple.com/music/",
                    @"https://www.apple.com/apple-news/",
                    @"https://www.icloud.com/",
                    @"https://developer.apple.com/xcode/",
                    @"https://developer.apple.com/swift/",
                    @"https://developer.apple.com/testflight/",
                    @"https://www.mozilla.org/en-US/firefox/",
                    @"https://bing.com/",
                    @"https://webkit.org/",
                    nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (void)switchView {
    self.useLinkView = !self.useLinkView;
    [self.tableView reloadData];
}

- (void)flushCache {
    [SDWebImageManager.sharedManager.imageCache clearWithCacheType:SDImageCacheTypeAll completion:nil];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    NSURL *url = [NSURL URLWithString:self.objects[indexPath.row]];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (self.useLinkView) {
        if (![cell isKindOfClass:LinkTableViewCell.class]) {
            cell = [[LinkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ((LinkTableViewCell *)cell).linkView.sd_imageTransition = SDWebImageTransition.fadeTransition;
        [((LinkTableViewCell *)cell).linkView sd_setImageWithURL:url];
    } else {
        if (![cell isKindOfClass:ImageTableViewCell.class]) {
            cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        ((ImageTableViewCell *)cell).hostLabel.text = url.host;
        ((ImageTableViewCell *)cell).titleLabel.text = nil;
        ((ImageTableViewCell *)cell).customImageView.sd_imageTransition = SDWebImageTransition.fadeTransition;
        [((ImageTableViewCell *)cell).customImageView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image) {
                if ([image.sd_extendedObject isKindOfClass:LPLinkMetadata.class]) {
                    LPLinkMetadata *metadata = (LPLinkMetadata *)image.sd_extendedObject;
                    ((ImageTableViewCell *)cell).titleLabel.text = metadata.title;
                    ((ImageTableViewCell *)cell).hostLabel.text = metadata.URL.host;
                }
            }
        }];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSURL *url = [NSURL URLWithString:self.objects[indexPath.row]];
    
    SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:url];
    [self presentViewController:safariVC animated:YES completion:nil];
}

@end
