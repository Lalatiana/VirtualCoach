//
//  MovementDataEngine.h
//  VirtualCoach
//
//  Created by Lalatiana Rakotomanana on 06/06/2016.
//  Copyright © 2016 itzseven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovementDAO.h"
#import "MovementDO.h"

@interface MovementDataEngine : NSObject

@property (nonatomic) MovementDAO *movementDAO;

//INSERT
-(id)insertMovment:(MovementDO*)movementDO andIdVideo:(int) idVideo;

@end
