/********* navigation.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface navigation : CDVPlugin {
  // Member variables go here.
}

- (void)open:(CDVInvokedUrlCommand*)command;
@end

@implementation navigation

- (void)open:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSDictionary* dataSource = [command.arguments objectAtIndex:0];
        CLLocationCoordinate2D coordinate;
        //获取当前位置
        MKMapItem *mylocation = [MKMapItem mapItemForCurrentLocation];
        
        //当前经维度
        float currentLatitude=mylocation.placemark.location.coordinate.latitude;
        float currentLongitude=mylocation.placemark.location.coordinate.longitude;
        
        CLLocationCoordinate2D coords1 = CLLocationCoordinate2DMake(currentLatitude,currentLongitude);
        
        //目的地位置
        coordinate.latitude=[[dataSource objectForKey:@"lat"] floatValue];
        
        coordinate.longitude=[[dataSource objectForKey:@"lng"] floatValue];
        
        CLLocationCoordinate2D coords2 = coordinate;
        
        
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            //目的地的位置
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords2 addressDictionary:nil]];
            
            toLocation.name = [dataSource objectForKey:@"name"];
        
            NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
            NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
            //打开苹果自身地图应用，并呈现特定的item
            [MKMapItem openMapsWithItems:items launchOptions:options];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
