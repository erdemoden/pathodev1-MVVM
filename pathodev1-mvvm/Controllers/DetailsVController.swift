//
//  DetailsVController.swift
//  pathodev1-mvvm
//
//  Created by erdem öden on 16.08.2021.
//

import UIKit
import SDWebImage

//MARK: - PROTOCOL
protocol GoingBackFromDetail{
    func UpdateTable();
}

class DetailsVController: ViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var ActorLbl: UILabel!
    @IBOutlet weak var DateOfBirthLbl: UILabel!
    @IBOutlet weak var FavouriteLbl: UILabel!
    @IBOutlet weak var HeartBut: UIButton!
    @IBOutlet weak var Image: UIImageView!
    
    // MARK: - Variables
    var DetailsViewModel = DetailsVModel()
    var Name = ""
    var Actor = ""
    var ImageName = ""
    var Birth = ""
    var Fav = ""
    var HeartButImageName = ""
    var Delegate : GoingBackFromDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Url = NSURL(string: ImageName);
        Image.sd_setImage(with: Url as URL?, placeholderImage: UIImage(named:"select"), options: SDWebImageOptions.progressiveLoad, completed: nil)
        NameLbl.text = Name
        ActorLbl.text = Actor
        DateOfBirthLbl.text = Birth
        FavouriteLbl.text = Fav
        HeartBut.setImage(UIImage(named:HeartButImageName), for: .normal)
    }
    
    
    // MARK: - Function to adding favourites to the coredata for HeartBut Button
    @IBAction func HeartButAction(_ sender: Any) {
        let Variable = DetailsViewModel.Result(Name: NameLbl.text!)
        if(Variable > 0){
            
            UIView.animate(withDuration: 0.5, animations: { [self] in
                            HeartBut.transform = CGAffineTransform(scaleX: 2, y: 2)
                            HeartBut.setImage(UIImage(named: "heart-empty"), for: .normal)
                        }, completion: {
                            done in
                            if done {
                                UIView.animate(withDuration: 0.5, animations: { [self] in
                                    HeartBut.transform = CGAffineTransform.identity
                                })
            
                            }
                        })
            FavouriteLbl.text = "it is not in your favourites"
        }
        else if(Variable == 0){
            print("ne oluyor")
            UIView.animate(withDuration: 0.5, animations: { [self] in
                            HeartBut.transform = CGAffineTransform(scaleX: 2, y: 2)
                            HeartBut.setImage(UIImage(named: "heart-red"), for: .normal)
                        }, completion: {
                            done in
                            if done {
                                UIView.animate(withDuration: 0.5, animations: { [self] in
                                    HeartBut.transform = CGAffineTransform.identity
                                })
            
                            }
                        })
            FavouriteLbl.text = "it is in your favourites"
        }
        print(Variable)
            
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        Delegate.UpdateTable()
    }
    
    
}
