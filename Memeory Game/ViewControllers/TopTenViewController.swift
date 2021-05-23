import UIKit
import CoreLocation
import MapKit

class TopTenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    let topTen = TopTenScores()
    
    //PIN ON MAP TO ADD/REMOVE
    var annotation:MKPointAnnotation! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        myTableView.backgroundColor = UIColor(red: 0.68, green: 0.88, blue: 0.96, alpha: 1.00)
    }
    
    //SETS TABLEVIEW LENGTH
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topTen.topTen.count
    }
    
    //DEVINES EVERY CELL IN TABLEVIEW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! scoreTableCell
        
        //CELL PROPERTIES
        cell.backgroundColor = UIColor.systemTeal
        cell.layer.cornerRadius = 12
        cell.backgroundColor = UIColor.systemTeal
        cell.placeLabel.text = String(indexPath.row + 1)
        cell.nameLabel.text = "Name: " + topTen.topTen[indexPath.row].name
        cell.scoreLabel.text = "Steps: " + String(topTen.topTen[indexPath.row].steps)

        return cell
    }
    
    //SHOW SELECTED TABLEVIEW CELL ON MAP
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //REMOVE PREVIOUS ANNOTATION IF THERE IS
        if annotation != nil {
            mapView.removeAnnotation(annotation)
        }
        
        let noLocation = CLLocationCoordinate2D(latitude: topTen.topTen[indexPath.row].lat,longitude: topTen.topTen[indexPath.row].long)

        annotation = MKPointAnnotation()
        annotation.title = topTen.topTen[indexPath.row].name
        annotation.coordinate = noLocation
        mapView.addAnnotation(annotation)
        
        UIView.animate(withDuration: 1.0) {
            self.annotation.coordinate = noLocation
        }
        
        //Zoom to user location
        let viewRegion = MKCoordinateRegion(center: noLocation, latitudinalMeters: 200, longitudinalMeters: 200)
        mapView.setRegion(viewRegion, animated: true)

    }
    
    
}

class scoreTableCell: UITableViewCell {
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //spacing between cells
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 5
            super.frame = frame
        }
      }
    
    
}
