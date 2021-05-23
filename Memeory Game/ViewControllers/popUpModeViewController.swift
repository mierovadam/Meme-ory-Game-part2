import UIKit

class popUpModeViewController: UIViewController {
    @IBOutlet weak var viewToRound: UIView!
    
    var mode:Int!
    let preferences = UserDefaults.standard
    let modeKey = "mode"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //round corners view
        viewToRound.layer.cornerRadius = 10
        viewToRound.clipsToBounds = true

    }
    
    @IBAction func chooseMode(sender: UIButton) {
        if sender.tag == 1 {
            //easy 4x4
            mode = 0
        }else{
            //hard 4x5
            mode = 1
        }
        
        //SAVE MODE TO PASS TO GAME VIEWCONTROLLER
        preferences.set(mode, forKey: modeKey)
        _ = preferences.synchronize()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "gameViewControllerID")
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
        
        //NEED TO ADD DISSMISING THE MENU VIEW CONTROLLER SO IT WILL NOT BE LEFT OPENED WHEN STARTING THE GAME
                
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
