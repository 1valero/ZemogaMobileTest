//
//  Utils.swift
//  ZemogaTest
//
//  Created by Jose Valero Vegazo on 6/06/22.
//

import Foundation
import UIKit


class Utils{
    
    static func dump(text:Any){
        print(text)
    }

}

extension UITableViewCell {
    func showAnimation()  {
        var transform = CGAffineTransform.identity
            transform = transform.scaledBy(x: 0.96, y: 0.96)
            UIView.animate(withDuration: 3.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
              self.transform = transform
        }, completion: nil)
    }
}
