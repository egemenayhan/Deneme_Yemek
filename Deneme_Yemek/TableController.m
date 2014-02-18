//
//  TableController.m
//  Deneme_Yemek
//
//  Created by Egemen AYHAN on 15.02.2014.
//  Copyright (c) 2014 Egemen AYHAN. All rights reserved.
//

#import "TableController.h"
#import "DetailView.h"
#import "TableCell.h"
#import "Tarif.h"

@implementation TableController

@synthesize recipes;

@synthesize pageTitle;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //recipes = [NSArray arrayWithObjects:obj,obj,obj,obj, nil];
	// Do any additional setup after loading the view, typically from a nib.
    }

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recipes count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"PrototypeCell";
    TableCell *cell = (TableCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    Tarif *recipe = [recipes objectAtIndex:indexPath.row];
    cell.nameLbl.text = recipe.name;
    cell.imageView.image = [UIImage imageNamed:recipe.image];
    cell.prepTimeLbl.text = recipe.prepTime;
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailView *dt = [sb instantiateViewControllerWithIdentifier:@"Detail"];
    dt.tarif = [recipes objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:dt animated:YES];
}



















@end
