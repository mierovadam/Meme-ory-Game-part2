import Foundation

class TopScore : Encodable,Decodable {
    var steps = 0
    var name = ""
    var lat = 0.0
    var long = 0.0
    
    init(steps:Int, name:String, lat:Double, long:Double) {
        self.steps = steps
        self.name = name
        self.lat = lat
        self.long = long
    }
    
    
}
