//
//  MissionsCollectionViewController.m
//  Mission Health
//
//  Created by Connor Krupp on 3/1/17.
//  Copyright © 2017 Connor Krupp. All rights reserved.
//

#import "MissionsCollectionViewController.h"
#import "MissionsCollectionViewCell.h"

#import "GroupManager.h"

@interface MissionsCollectionViewController () <GroupManagerDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) GroupManager *groupManager;

@end

@implementation MissionsCollectionViewController

static NSString * const reuseIdentifier = @"GroupCell";

- (instancetype)init {
    UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    self = [self initWithCollectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[MissionsCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.title = @"Missions";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    
    self.groupManager = [[GroupManager alloc] init];
    self.groupManager.delegate = self;
    [self.groupManager getGroups];
    
    return self;
}

#pragma mark <GroupManagerDelegate>

- (void)groupManagerDidLoadGroups:(GroupManager *)groupManager {
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.groupManager.groups.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MissionsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    MHGroup *group = self.groupManager.groups[indexPath.row];
    NSLog(@"%d", group.groupId);
    
    cell.missionsLabel.text = group.name;
    cell.backgroundColor = [UIColor orangeColor];
    
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect container = self.view.frame;
    float cellWidth = container.size.width / 2.0 - 15;
    
    return CGSizeMake(cellWidth, cellWidth);
}

@end