import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution=true
// Part 1-----

// Concurrency is executing multuiple task or event at the same time
/// We can achive currency through Time Slicing and Context Switching


// What is Dipatch(GCD)
/// Execute code concurrently on multicore hardware by submitting work to dispatch queues managed by the system.
///  GCD is the queue based API which allows to execute closures on workers pool in the FIFO order.
///  Suppose there tasks we submit thiose task to Queue then GCD take care of our task in FIFO order

// Dispatch Queue:- It is the abstraction layer on top of the queue.
/// GCD manages a collection of dispatch queues. They are usually referred as queues. The work or tasks submitted these dispatch queus is executed on a pool of threds
///  An application submit task to dispatch queue in the form of locks of either synchronously or asynchrounously
// Synchronous :- Means Block the current execution on thread untill this task completed
// Asynchronous
/// - Means continue the current execution that was happening keep doing it while this task which i am about to submit can be executed asynchronously
/// Synhcronus and Asynchronous are the manner of exetion which say how the task are gonna executed
// Serial vs Concurrent
/// Serial means one task at a time
/// Concurrent multiple task at a time
///

var count=0
DispatchQueue.main.async {  // main queue is serial Queu
    for i in 0...3{
        count=i
        print(count)
    }
}
for i in 4...6{
    count=i
    print(count)
}

DispatchQueue.main.async {
        count=9
        print(count)
}

//Output would be 4,5,6,0,1,2,3,9
/// Program start from line 29 we submit our task to main queue which is a serial queue in asynchronous manner meaning only one task at a time without blocking current execution, then
/// the normal loop executed normally giving the output 4,5,6 then another task submiited to main queue so total task in queue is 2, queue is a fifo order our first task dispatch first whcih
/// print 0,1,2,3 then second task dispatch whcih is 9
