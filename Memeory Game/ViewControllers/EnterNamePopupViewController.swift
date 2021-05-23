import CoreLocation
import MapKit
import UIKit

class EnterNamePopupViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var nameTextField: UITextField!

    let locationManager = CLLocationManager()
    var lat:Double = 0
    var long:Double = 0

    let stepsKey = "steps"
    
    var steps:Int! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readSteps()
        initLocationManager()
    }
    
    @IBAction func submitScore(){
        if nameTextField.text == "" {
            
            //MAKE TEXTFIELD SHAKE ANIMATION
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.07
            animation.repeatCount = 4
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: nameTextField.center.x - 10, y: nameTextField.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: nameTextField.center.x + 10, y: nameTextField.center.y))
            nameTextField.layer.add(animation, forKey: "position")
            
            
        }else {
            let topTenScores = TopTenScores()
            let newScore = TopScore(steps: steps, name: nameTextField.text!,lat: lat,long: long)

            topTenScores.addScoreToBoard(newScore: newScore)
            
            print(topTenScores.toString())
            
            self.dismiss(animated: true, completion: {
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            })
            
        }
    }
    
    func readSteps(){
        let preferences = UserDefaults.standard

        if preferences.object(forKey: stepsKey) == nil {
            //  Doesn't exist
        } else {
            steps = preferences.integer(forKey: stepsKey)
        }
    }

    func initLocationManager(){
        locationManager.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        //locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locations[0].coordinate, span: span)
        
        lat = region.center.latitude
        long = region.center.longitude
        
    }
    

    //Orientation utils
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
       AppUtility.lockOrientation(.portrait)
       // Or to rotate and lock
       // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
       
   }

   override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       
       // Don't forget to reset when view is being removed
       AppUtility.lockOrientation(.all)
   }

}
