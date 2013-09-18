//
//  ViewController.m
//  SocketIo
//
//  Created by Enrique on 9/12/13.
//  Copyright (c) 2013 Enrique. All rights reserved.
//

#import "ViewController.h"
#import "SocketIOPacket.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)loadView
{
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view.backgroundColor = [UIColor grayColor];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    NSLog(@"%f", width);
    NSLog(@"%f", height);
    
    UIButton *connectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [connectBtn addTarget:self
               action:@selector(connectSocket:)
     forControlEvents:UIControlEventTouchDown];
    [connectBtn setTitle:@"Connect" forState:UIControlStateNormal];
    connectBtn.frame = CGRectMake(width/4.0, height/2.5, 160.0, 40.0);
    [self.view addSubview:connectBtn];
    
    UIButton *disconnectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [disconnectBtn addTarget:self
                   action:@selector(disconnectSocket:)
         forControlEvents:UIControlEventTouchDown];
    [disconnectBtn setTitle:@"Disconnect" forState:UIControlStateNormal];
    disconnectBtn.frame = CGRectMake(width/4.0, height/2.0, 160.0, 40.0);
    [self.view addSubview:disconnectBtn];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sendBtn addTarget:self
                      action:@selector(sendSocket:)
            forControlEvents:UIControlEventTouchDown];
    [sendBtn setTitle:@"Send" forState:UIControlStateNormal];
    sendBtn.frame = CGRectMake(width/4.0, height/1.5, 160.0, 40.0);
    [self.view addSubview:sendBtn];
    
    
}
-(void)sendSocket:(id)sender {
    NSLog(@"Send Socket io Clicked");
    [socketIO sendEvent:@"receive" withData:@"Iphone Client: says What sup!"];
}
-(void)connectSocket:(id)sender {
    NSLog(@"Connect Socket io Clicked");
    // Do any additional setup after loading the view, typically from a nib.
    // create socket.io client instance
    socketIO = [[SocketIO alloc] initWithDelegate:self];
    
    // you can update the resource name of the handshake URL
    // see https://github.com/pkyeck/socket.IO-objc/pull/80
    // [socketIO setResourceName:@"whatever"];
    
    // if you want to use https instead of http
    // socketIO.useSecure = YES;
    
    // connect to the socket.io server that is running locally at port 3000
    [socketIO connectToHost:@"localhost" onPort:3000];
}
-(void)disconnectSocket:(id)sender {
    NSLog(@"Disconnect Socket io Clicked");
    [socketIO disconnectForced];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
# pragma mark -
# pragma mark socket.IO-objc delegate methods

- (void) socketIODidConnect:(SocketIO *)socket
{
    NSLog(@"socket.io connected.");
}

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSLog(@"didReceiveEvent()");
    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData: [packet.data dataUsingEncoding: NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error:NULL];
    
    //Alert all message from other client
    NSString *eventMessage = [JSON objectForKey:@"name"];
    NSLog(@"%@",eventMessage );

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Server" message:eventMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    

   
}
- (void) socketIO:(SocketIO *)socket didReceiveMessage:(SocketIOPacket *)packet
{
    NSLog(@"didReceiveMessage()");

    NSLog(@"%@", packet.data);
    //Alert all message from other client
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Server"
                                                    message:packet.data
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}
- (void) socketIO:(SocketIO *)socket onError:(NSError *)error
{
    NSLog(@"onError() %@", error);
}


- (void) socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    NSLog(@"socket.io disconnected. did error occur? %@", error);
}

# pragma mark -

- (void) viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
