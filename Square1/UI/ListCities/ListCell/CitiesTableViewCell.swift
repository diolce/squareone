//
//  CitiesTableViewCell.swift
//  Square1
//
//  Created by Diego Olmo Cejudo on 31/10/21.
//

import UIKit

class CitiesTableViewCell: UITableViewCell {
    var viewModel:ItemCitiesModelView = ItemCitiesModelView() {
        didSet {
            // Initialization code
            self.nameCity.text = viewModel.name
            self.latitude.text = viewModel.lat
            self.longitude.text = viewModel.log
            self.createdAt.text = viewModel.created
            self.updatedAt.text = viewModel.updated
            
                buttonGetCountry.isHidden = viewModel.hasCountry
                countryStack.isHidden = !viewModel.hasCountry
                self.nameCountry.text = viewModel.nameCountry
                self.code_country.text = viewModel.codeCountry
                self.createdCountryAt.text = viewModel.createdCountry
                self.updatedCountryAt.text = viewModel.updatedCountry
            
            self.viewModel.reloadViewClosure = {
                DispatchQueue.main.async {
                    // Initialization code
                    self.nameCity.text = self.viewModel.name
                    self.latitude.text = self.viewModel.lat
                    self.longitude.text = self.viewModel.log
                    self.createdAt.text = self.viewModel.created
                    self.updatedAt.text = self.viewModel.updated
                    
                    self.buttonGetCountry.isHidden = self.viewModel.hasCountry
                    self.countryStack.isHidden = !self.viewModel.hasCountry
                    self.nameCountry.text = self.viewModel.nameCountry
                    self.code_country.text = self.viewModel.codeCountry
                    self.createdCountryAt.text = self.viewModel.createdCountry
                    self.updatedCountryAt.text = self.viewModel.updatedCountry
                }
            }
        }
    }
        
    //MARK:- @IBOutlet
    @IBOutlet weak var buttonGetCountry: UIButton!
    @IBOutlet weak var nameCity: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var updatedAt: UILabel!
    @IBOutlet weak var countryStack: UIStackView!
    @IBOutlet weak var nameCountry: UILabel!
    @IBOutlet weak var code_country: UILabel!
    @IBOutlet weak var createdCountryAt: UILabel!
    @IBOutlet weak var updatedCountryAt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- @IBAction
    @IBAction func tappedGetCountry(_ sender: Any) {
        self.viewModel.countryForItem(city: self.viewModel.name)
    }
}
