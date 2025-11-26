//
//  DashboardDummyView.swift
//  Peko
//
//  Created by Hardik Makwana on 29/08/24.
//

import UIKit

class DashboardDummyView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.xibSetup()
    }
    func xibSetup() {
        
        backgroundColor = UIColor.clear
        view = loadNib()
        // use bounds not frame or it'll be offset
        view.frame = bounds
        view.backgroundColor = .clear
        view.clipsToBounds = true
        // Adding custom subview on top of our view
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view!]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view!]))
        
        
        self.scrollView.showGradientSkeleton()
       
    }
    
    func loadNib() -> UIView {
        let nib = UINib(nibName: "DashboardDummyView", bundle: .module)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }

}
