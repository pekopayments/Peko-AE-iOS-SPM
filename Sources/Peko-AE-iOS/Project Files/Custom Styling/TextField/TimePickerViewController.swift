//
//  TimePickerViewController.swift
//  Peko
//
//  Created by Hardik Makwana on 21/06/24.
//

import UIKit

class TimePickerViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    
    private var timePicker: RealTimePickerView = {
        let view = RealTimePickerView(format: .h24)
        view.showUnitSeparator = true
        view.rowHeight = 40 // default row height is 60
        view.timeLabelFont = .bold(size: 25) //UIFont.systemFont(ofSize: 32, weight: .semibold) // default size
        view.colonLabelFont = .bold(size: 25 * 0.75)  //UIFont.systemFont(ofSize: 32 * 0.75, weight: .bold) // default size
        view.formatLabelFont = .bold(size: 15) //UIFont.systemFont(ofSize: 20, weight: .semibold) // default size
        view.backgroundColor = UIColor.white // .withAlphaComponent(0.9)
        view.layer.cornerRadius = 0
        view.showCurrentTime = true
       
        return view
    }()
    
    var completionBlock:((_ selectedTime: String) -> Void)?
  var selectedTime = ""
    
    static func storyboardInstance() -> TimePickerViewController? {
        let alert = TimePickerViewController(nibName: "TimePickerViewController", bundle: .module)
        return alert
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black.withAlphaComponent(0.3)
        
        self.containerView.addSubview(timePicker)
        timePicker.translatesAutoresizingMaskIntoConstraints = false
       
        timePicker.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        timePicker.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
        timePicker.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
        
        timePicker.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 1.0).isActive = true
        
        timePicker.onNumberTimePicked = { hour, minute in
          
//            self.selectedTime = [hour, minute].compactMap {
//                String(format: "%02d", $0)
//            }.joined(separator: ":")
            
            
        }
        timePicker.onDateTimePicked = { date in
          
            self.selectedTime = date.formate(format: "HH:mm")
            /*
            [hour, minute].compactMap {
                String(format: "%02d", $0)
            }.joined(separator: ":")
            */
            
        }
    }
    
    
    // MARK: -
    
    @IBAction func closeButtonClick(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func selectButtonClick(_ sender: Any) {
        
        if self.completionBlock != nil {
            self.completionBlock!(self.selectedTime)
        }
        self.dismiss(animated: false)
    }
}

