//
//  CircularBuffer.h
//  CircularBuffer
//
//  Created by Brian Dolhansky on 7/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CircularBuffer : NSObject {
	float* buffer;
	int bufferSize;
	int startLoc;
	int readLoc;
	int writeLoc;
	int endLoc;
}

- (id)initWithBufferSize:(int) bufferSize;

- (float)readValFromBuffer;
- (void)writeValToBuffer:(float) val;

- (void)offsetReadLocation:(int) offset;
- (void)offsetWriteLocation:(int) offset;

- (void)zeroBuffer;

@end
