import Foundation

class TopTenScores{
    var SCOREBOARD_KEY = "topTenScores"
    var topTen = [TopScore]()
    
    init (){
        readScores()
    }
    
    func readScores(){
        let topTenJson = UserDefaults.standard.string(forKey: SCOREBOARD_KEY)
        if let safeTopTenJson = topTenJson {
            let decoder = JSONDecoder()
            let data = Data(safeTopTenJson.utf8)
            do {
                topTen = try decoder.decode([TopScore].self, from: data)
                print(topTen)
            } catch {}
        }
    }
    
    func writeScores(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(topTen)
        let topTenJson: String = String(data:data, encoding: .utf8)!
        UserDefaults.standard.setValue(topTenJson, forKey: SCOREBOARD_KEY)
    }
    
    func checkIfScoreBroken(steps:Int) -> Bool{
        if topTen.count < 10 {
            return true
        }
        
        for i in topTen {
            if steps < i.steps {
                return true
            }
        }
        return false
    }
    
    func addScoreToBoard(newScore:TopScore){
        if topTen.count < 10 {
            topTen.append(newScore)
            topTen.sort(by: { $0.steps < $1.steps})
        } else {
            topTen.removeLast()
            topTen.append(newScore)
            topTen.sort(by: { $0.steps < $1.steps})
        }
        writeScores()
    }
    
    func toString()->String{
        var str = ""
        
        for i in topTen {
            str.append("\(i.name) \(i.steps) \n")
        }
        str.append("\nRound:\n")
        return str
    }
}
