/*:
 # iOS Concurrency Workshop "Concurrency is Hard"
 ## 360|iDev 2016
 ## Sam Davies · [@iwantmyrealname](https://twitter.com/iwantmyrealname)
 
 This playground forms the basis of a workshop presented at 360|iDev 2016.
 
 The following represents the pages contained within this playground
 
 - [NSOperation](NSOperation)
 - [NSOperationQueue](NSOperationQueue)
 - [Wrapping Aysnc Functions in NSOperation](Async%20Operations)
 - [Inter-Operation Dependencies](Operation%20Dependencies)
 - [Operations in Practice](Operations%20in%20Practice)
 - [Grand Central Dispatch](GCD)
 - [Dispatch Groups](Dispatch%20Groups)
 - [Dispatch Barriers](Dispatch%20Barriers)
 - [Futures](Futures)
 
 ---
 
 ## [NS]Operation
 
 `Operation` is a high-level abstraction that represents _"a unit of work"_. You can use this to wrap some sort of functionality, and then pass this off to be executed concurrently.
 */
//Built on to of GCD
//Compared to GCD
//Cancelable
//Has felixibility to manage: Chainable, maxNumber of concurreny operations

import UIKit

//: `tiltShift(image:)` is a function that applies a tilt-shift-like filter to a `UIImage`, and as such it's rather (artificially) slow.

let image = UIImage(named: "dark_road_small.jpg")
duration {
  let result = tiltShift(image: image)
}


var outputImage: UIImage?

//: You can use the `BlockOperation` subclass of `Operation` to easily wrap some functionality.
let myFirstOperation = BlockOperation { //check InvocationOperation
  outputImage = tiltShift(image: image)
}
//: You can then execute this operation with the `start()` method:
duration {
    myFirstOperation.start()
}



outputImage


/*:
 Although `BlockOperation` has a very low bar for entry, it's not especially flexible. It's more usual to subclass `Operation` directly, and specialise it to particular functionality.
 
 When subclassing, create properties for input and output objects, and then override the `main()` method to perform the work.
 */
// Custom Operations

class TiltShiftOperation: Operation {
  var inputImage: UIImage?
  var outputImage: UIImage?
  
  override func main() {
    outputImage = tiltShift(image: inputImage)
  }
}

let mySecondOperation = TiltShiftOperation()
mySecondOperation.inputImage = image



/*:
 Once you've created an instance of the operation, and set the input value, you can go ahead and call `start()` to kick off the execution.
 
 - note:
 Calling `start()` might seem a little strange, but don't worry - you won't be doing it for long...
 
 */
mySecondOperation.start()

mySecondOperation.outputImage


//: [➡NSOperationQueue](NSOperationQueue)

