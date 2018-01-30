//
//  ChooseSeatViewController.swift
//  GewaraTransition
//
//  Created by macOfEthan on 2018/1/30.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

@objcMembers
class ChooseSeatViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.customNav()
    }
    
    // MARK: - 自定义导航栏
    func customNav() -> Void {
        
        let navView:UIView = UIView.init(frame: CGRect.init(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: 44))
        navView.backgroundColor = UIColor.white
        
        let lineView:UIView = UIView.init(frame: CGRect.init(x: 0, y: 43, width: UIScreen.main.bounds.size.width, height: 1))
        lineView.backgroundColor = UIColor.lightGray
        navView.addSubview(lineView)
        
        let back:UIButton = UIButton(frame: CGRect.init(x: 20, y: 12, width: 20, height: 20))
        back.setImage(#imageLiteral(resourceName: "close.png"), for: .normal)
        back.addTarget(self, action: #selector(self.back), for: .touchUpInside)
        navView.addSubview(back)
        
        let title:UILabel = UILabel(frame: CGRect.init(x: (UIScreen.main.bounds.size.width-100)/2, y: 12, width: 100, height: 20))
        title.textColor = UIColor.red
        title.textAlignment = .center
        title.text = "选座"
        navView.addSubview(title)
        
        view.addSubview(navView)
    }
    
    func back() -> Void {
        
        let nav:ZYGewaraNaviController = self.navigationController as! ZYGewaraNaviController
        _ = nav.zy_pop(false)
    }

}
