//
//  ViewController.swift
//  pathodev1-mvvm
//
//  Created by erdem öden on 13.08.2021.
//

import UIKit
import SDWebImage
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    // MARK: - IBOutlets
    @IBOutlet weak var TableView: UITableView!
    //MARK: - Variables
    var VModel = VControllerVModel()
    var Row = 0;
    // MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        VModel.Proto = self
        if(self.TableView != nil){
            VModel.ApiCall()
        }
        
        //NavigationBar Title
        if let navigationBar = self.navigationController?.navigationBar {
            let firstFrame = CGRect(x: navigationBar.frame.width/2-120, y: navigationBar.frame.height/2-15, width: 240, height: 30)
            
            let firstLabel = UILabel(frame: firstFrame)
            firstLabel.text = "HARRY POTTER"
            firstLabel.font = UIFont.systemFont(ofSize:30,weight: .black)
            navigationBar.addSubview(firstLabel)
        }
        
        
        
    }
    // MARK: - TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        VModel.HarryArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = TableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CellTableViewCell
        
        if(VModel.HarryArray.count > 0){
            let Url = NSURL(string: VModel.HarryArray[indexPath.row].image);
            Cell?.CharacterImage.sd_setImage(with: Url as URL?, placeholderImage: UIImage(named:"select"), options: SDWebImageOptions.progressiveLoad, completed: nil)
            Cell?.Name.text = VModel.HarryArray[indexPath.row].name
            Cell?.DateOfBirth.text = VModel.HarryArray[indexPath.row].dateOfBirth
            Cell?.ActorName.text = VModel.HarryArray[indexPath.row].actor
            Cell?.HeartBut.Character = VModel.HarryArray[indexPath.row].name
            
            let Sender = Favourites(Character: Cell?.HeartBut.Character)
            if VModel.FavArray.contains(Sender){
                Cell?.HeartBut.setImage(UIImage(named: "heart-red"), for: .normal)
            }
            else{
                Cell?.HeartBut.setImage(UIImage(named: "heart-empty"), for: .normal)
            }
            
            
            Cell?.HeartBut.addTarget(self, action: #selector(Clicked), for: .touchUpInside)
        }
        return Cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Row = indexPath.row
        VModel.Coordinator?.startAddEvent(HarryData: VModel.HarryArray[Row], FavArray: VModel.FavArray)
        TableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Clicked function for heart buttons in tableview cell
    @objc func Clicked(Sender:SubClassedUIButton){
        let Favs = Favourites(Character: Sender.Character)
        let Index = VModel.FavArray.firstIndex(of: Favs)
        if(VModel.FavArray.count > 0 ){
            if(VModel.FavArray.contains(Favs)){
                VModel.Clicked(Index: Index!,Character: Sender.Character)
                UIView.animate(withDuration: 0.5, animations: {
                    Sender.transform = CGAffineTransform(scaleX: 2, y: 2)
                    Sender.setImage(UIImage(named: "heart-empty"), for: .normal)
                }, completion: {
                    done in
                    if done {
                        UIView.animate(withDuration: 0.5, animations: {
                            Sender.transform = CGAffineTransform.identity
                        })
                        
                    }
                })
            }
            else{
                VModel.Clicked(Character: Sender.Character)
                
                UIView.animate(withDuration: 0.5, animations: {
                    Sender.transform = CGAffineTransform(scaleX: 2, y: 2)
                    Sender.setImage(UIImage(named: "heart-red"), for: .normal)
                }, completion: {
                    done in
                    if done {
                        UIView.animate(withDuration: 0.5, animations: {
                            Sender.transform = CGAffineTransform.identity
                        })
                        
                    }
                })
                
            }
            
            
        }
        else{
            VModel.Clicked(Character: Sender.Character)
            
            UIView.animate(withDuration: 0.5, animations: {
                Sender.transform = CGAffineTransform(scaleX: 2, y: 2)
                Sender.setImage(UIImage(named: "heart-red"), for: .normal)
            }, completion: {
                done in
                if done {
                    UIView.animate(withDuration: 0.5, animations: {
                        Sender.transform = CGAffineTransform.identity
                    })
                    
                }
            })
        }
    }
    
}
// MARK: - After going back to DetailsVController updating the table and FavAray in VModel with using protocol
extension ViewController:GoingBackFromDetail,UpdateTableView{
    func ReloadTableView() {
        self.TableView.reloadData()
    }
    
    func UpdateTable() {
        self.VModel.FavArray.removeAll()
        self.VModel.ApiCall()
        
    }
    
}

