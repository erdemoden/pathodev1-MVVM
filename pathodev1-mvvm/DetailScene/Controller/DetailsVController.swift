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

class DetailsVController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var ActorLbl: UILabel!
    @IBOutlet weak var DateOfBirthLbl: UILabel!
    @IBOutlet weak var FavouriteLbl: UILabel!
    @IBOutlet weak var HeartBut: UIButton!
    @IBOutlet weak var Image: UIImageView!
    
    // MARK: - Variables
    var DetailsViewModel:DetailsVModel?
    var Delegate : GoingBackFromDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Url = NSURL(string: DetailsViewModel!.HarryData!.image);
        Image.sd_setImage(with: Url as URL?, placeholderImage: UIImage(named:"select"), options: SDWebImageOptions.progressiveLoad, completed: nil)
        NameLbl.text = DetailsViewModel!.HarryData?.name
        ActorLbl.text = DetailsViewModel!.HarryData?.actor
        DateOfBirthLbl.text = DetailsViewModel!.HarryData?.dateOfBirth
        let Favs = Favourites(Character: DetailsViewModel?.HarryData?.name)
        if(DetailsViewModel!.FavArray!.contains(Favs)){
            FavouriteLbl.text = "It Is In Your Favourites"
            HeartBut.setImage(UIImage(named:"heart-red"), for: .normal)
        }
        else{
            FavouriteLbl.text = "It Is Not In Your Favourites"
            HeartBut.setImage(UIImage(named:"heart-empty"), for: .normal)
        }
        
    }
    
    
    // MARK: - Function to adding favourites to the coredata for HeartBut Button
    @IBAction func HeartButAction(_ sender: Any) {
        let Variable = DetailsViewModel!.Result(Name: NameLbl.text!)
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
        
        
    }
    
    // MARK: - Function for run the delegate and deleting childcoordinator
    override func viewWillDisappear(_ animated: Bool) {
        DetailsViewModel?.Disappear()
        Delegate?.UpdateTable()
    }
    
    
    
}
