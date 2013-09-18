//
//  ViewController.h
//  SocketIo
//
//  Created by Enrique on 9/12/13.
//  Copyright (c) 2013 Enrique. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketIO.h"

@interface ViewController : UIViewController <SocketIODelegate>{
    SocketIO *socketIO;
}

@end
