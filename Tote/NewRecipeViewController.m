//
//  NewRecipeViewController.m
//  RecipeBook
//
//  Created by Simon on 10/8/13.
//
//

#import "NewRecipeViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>


@interface NewRecipeViewController ()

{
    NSArray *_pickerData;
}

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *cargoimageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *sectionTextField;
@property (weak, nonatomic) IBOutlet UITextField *soiTextField;
@property (weak, nonatomic) IBOutlet UITextField *detailTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;



@end

@implementation NewRecipeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _nameTextField.delegate = self;
    _sectionTextField.delegate = self;
    _soiTextField.delegate = self;
    _detailTextField.delegate = self;
    
    
    _pickerData = @[@"กระเป๋า", @"เสื้อผ้า", @"รองเท้า", @"ของแต่งบ้าน", @"5", @"6"];
    
    
    // Connect data
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self showPhotoLibary];
    }
    
}

- (void)showPhotoLibary
{
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)) {
        return;
    }
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // Displays saved pictures from the Camera Roll album.
    mediaUI.mediaTypes = @[(NSString*)kUTTypeImage];
    
    // Hides the controls for moving & scaling pictures
    mediaUI.allowsEditing = YES;
    
    mediaUI.delegate = self;
    
    [self.navigationController presentModalViewController: mediaUI animated: YES];
}

- (IBAction)save:(id)sender {
    // Create PFObject with recipe information
    PFObject *tote = [PFObject objectWithClassName:@"Cargo"];
    [tote setObject:_nameTextField.text forKey:@"name"];
    [tote setObject:_sectionTextField.text forKey:@"section"];
    [tote setObject:_soiTextField.text forKey:@"soi"];
    
    NSArray *detail = [_detailTextField.text componentsSeparatedByString: @","];
    [tote setObject:detail forKey:@"etc"];
    
    NSInteger row; //tag
    NSString *weightSelected;
    
    row = [_picker selectedRowInComponent:0];
    weightSelected = [_pickerData objectAtIndex:row];
    NSLog(@"%@", weightSelected);
    [tote setObject:weightSelected forKey:@"Type"];
    
    
    // Recipe image
    NSData *imageData = UIImageJPEGRepresentation(_cargoimageView.image, 0.8);
    NSString *filename = [NSString stringWithFormat:@"file%@.png", _nameTextField.text];
    PFFile *imageFile = [PFFile fileWithName:filename data:imageData];
    [tote setObject:imageFile forKey:@"imageFile"];
    
    
    // Show progress
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Uploading";
    [hud show:YES];
    
    // Upload recipe to Parse
    [tote saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [hud hide:YES];
        
        if(_nameTextField.text.length==0) {
            
        }
        if (!error) {
            // Show success message
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Complete" message:@"Successfully saved the cargo" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            // Notify table view to reload the recipes from Parse cloud
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
            
            // Dismiss the controller
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Failure" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
    }];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidUnload {
    [self setCargoimageView:nil];
    [self setNameTextField:nil];
    [self setSectionTextField:nil];
    [self setSoiTextField:nil];
    [self setDetailTextField:nil];
    [self setPicker:nil];
    [super viewDidUnload];
}


- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    UIImage *originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    self.cargoimageView.image = originalImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
