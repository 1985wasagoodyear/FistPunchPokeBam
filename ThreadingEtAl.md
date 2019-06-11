#  Threading

In iOS, we have a basic interface for threads

Grand Central Dispatch (GCD)

1. Don't bother with threads
2. We do not create/destroy/handle/etc threads, ourselves

Threads <--> Tasks

Send threads to CPU cores to do work.

GCD manages threads for us.
We only need to describe what we want to do.


Dispatch'ing work.
Queue-like structure.

DispatchQueue.< 'main' / 'global()' >

main - main thread
global - from global thread pool

UIKit - not threadsafe.
- all work must be done on the main thread
- can cause slow-behavior, unexpected-behavior, crashing
otherwise

sync - synchronous - work that must be done in order

async - asynchronous - work that isn't necessarily done in order


A, B, C, D
synchronous order: A, B, C, D (in-order)
asynchronous order: B, D, A, C (out-of-order)


synchronous thread: A is done, then B starts, 
then B is done, then C starts,

asynchronous thread: A can start, be paused, 
put off to the side, 
then eventually be done 2 tasks later

DispatchWorkItem
NSOperations



