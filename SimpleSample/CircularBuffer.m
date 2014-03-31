//
//  CircularBuffer.m
//  CircularBuffer
//
//  Created by Brian Dolhansky on 7/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CircularBuffer.h"


@implementation CircularBuffer

- (id)initWithBufferSize:(int)newBufferSize {
	if (self=[super init]) {
		bufferSize = newBufferSize;
		buffer = (float *)calloc( bufferSize, sizeof(float) );
		startLoc = 0;
		readLoc = 0;
		writeLoc = 0;
		endLoc = bufferSize-1;
	}
	
	return self;
}

- (float)readValFromBuffer {
	float val = buffer[readLoc];
	(readLoc == endLoc) ? (readLoc = 0) : (readLoc++);
	return val;
}

- (void)writeValToBuffer:(float) val {
	buffer[writeLoc] = val;
	(writeLoc == endLoc) ? (writeLoc = 0) : (writeLoc++);
}

- (void)offsetReadLocation:(int)offset {
	readLoc += offset;
	if (readLoc > bufferSize)
		readLoc = readLoc % bufferSize;
}

- (void)offsetWriteLocation:(int)offset {
	writeLoc += offset;
	if (writeLoc > bufferSize)
		writeLoc = writeLoc % bufferSize;
}

- (void)zeroBuffer {
	for (int i=0; i<bufferSize; i++)
		buffer[i] = 0.0;
	startLoc = 0;
	writeLoc = 0;
	endLoc = bufferSize-1;
}

- (void)dealloc {
	if (buffer != NULL) {
		free(buffer);
	}
	
	//[super dealloc];
}

@end
