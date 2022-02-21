import Foundation

// Runnable Demo: https://swiftfiddle.com/jh7l2ozuvbh7foh6mvzwzj5zem

/// Car Interface - Defines all the necessary functions of a Car
protocol Car {

	var carEngine : CarEngine { get }
	var carStereo : CarStereo { get }
	func start()
	func lockDoors()
	func unlockDoors()
	func stop()
	func accelarate()
	func checkSeatBelt()
	func checkDoorLock()
	func autoHeadLamp()
  
}

/// Car Engine Interface - Defines all the necessary functions of a Car Engine
protocol CarEngine {

	func start()
	func stop()
	func accelarate()

}

/// Car Stereo Interface - Defines all the necessary functions of a Car Stereo
protocol CarStereo {

	func play()
	func pause()
	func volume(value : Int)
	func powerOn()
	func powerOff()

}

/// Concrete implementation of Car Engine Interface
class CarEngineImpl : CarEngine {
  
	func start(){
		print("Engine Started")
	}

	func stop(){
		print("Engine Stopped")
	}

	func accelarate(){
		print("Engine Accelarating")
	}

}

/// Concrete implementation of Car Stereo Interface
class CarStereoImpl : CarStereo {

	func play(){
		print("Stereo Playing")
	}
	func pause(){
		print("Stereo Paused")
	}
	
	func volume(value : Int){
		print("Stereo Volume: ",value)
	}
	
	func powerOn(){
		print("Stereo Power On")
	}
	
	func powerOff(){
		print("Stereo Power Off")
	}
}

/// Abstract implementation of Car Interface
/// With Constructor DI
class AbstractBaseCarImpl : Car {

	var carEngine : CarEngine
	var carStereo : CarStereo

	init(carEngine : CarEngine = CarEngineImpl(), carStereo : CarStereo = CarStereoImpl()){
		self.carEngine = carEngine
		self.carStereo = carStereo
	}

	func start(){
		print("Car Started")
		carEngine.start()
		carStereo.powerOn()
	}

	func stop(){
		carStereo.powerOff()
		carEngine.stop()
		print("Car Stopped")
	}
	
	func accelarate(){
		print("Car Accelarating")
		carEngine.accelarate()
	}

	func lockDoors(){
		print("Car Locked Door")
	}
	
	func unlockDoors(){
		print("Car Unlocked")
	}

	func checkSeatBelt(){
		print("Car Checked Seatbelt")
	}
	
	func checkDoorLock(){
		print("Car Checked Doors")
	}
	
	func autoHeadLamp(){
		print("Car Auto Head Lamp Enabled")
	}

}

/// Concrete implementation of Car Stereo Interface
class SonyCarStereoImpl : CarStereoImpl {

	override func play(){
		print("Sony Stereo Playing")
	}
	
	override func pause(){
		print("Sony Stereo Paused")
	}
	
	override func volume(value : Int){
		print("Sony Stereo Volume: ",value)
	}

}

/// Concrete implementation of Apple Car reusing the core functions of AbstractBaseCarImpl
class AppleCar : AbstractBaseCarImpl {
	
	override func start() {
		checkDoorLock()
		checkSeatBelt()
		super.start()
		autoHeadLamp()
	}

}

// Constructor based DI
var car : Car = AppleCar(carStereo: SonyCarStereoImpl())

car.start()
car.accelarate()
car.carStereo.play()
car.carStereo.volume(value: 10)
car.stop()
