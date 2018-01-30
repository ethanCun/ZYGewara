//
//  ZYDetailFilmsViewController.swift
//  GewaraTransition
//
//  Created by macOfEthan on 2018/1/29.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit
import Kingfisher

@objcMembers
class ZYDetailFilmsViewController: UIViewController {

    var film:ZYFilm = ZYFilm()
    var chooseSeat:UIButton = UIButton(type: UIButtonType.custom)
    var coverImageView:UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: 200))
    var filmImageView:UIImageView = UIImageView.init(frame: CGRect.init(x: 20, y: 150, width: 100, height: 80))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置背景颜色
        self.view.backgroundColor = UIColor.white
        
        chooseSeat.frame = CGRect.init(x: UIScreen.main.bounds.size.width/2-50, y: UIScreen.main.bounds.size.height/2-15, width: 100, height: 30)
        chooseSeat.setTitle("在线选座", for: .normal)
        chooseSeat.addTarget(self, action: #selector(self.goChooseSeat), for: .touchUpInside)
        chooseSeat.setTitleColor(UIColor.red, for: .normal)
        
        let coverUrl:URL = URL.init(string: self.film.coverUrl!)!
        let filmUrl:URL = URL.init(string: self.film.imageUrl!)!
        
        coverImageView.kf.setImage(with: ImageResource.init(downloadURL: coverUrl))
        filmImageView.kf.setImage(with: ImageResource.init(downloadURL: filmUrl))
        
        self.view.addSubview(chooseSeat)
        self.view.addSubview(coverImageView)
        self.view.addSubview(filmImageView)
        
        let back:UIButton = UIButton(frame: CGRect.init(x: 20, y: 20, width: 20, height: 20))
        back.setImage(#imageLiteral(resourceName: "close.png"), for: .normal)
        back.addTarget(self, action: #selector(self.back), for: .touchUpInside)
        self.coverImageView.addSubview(back)
        
        self.coverImageView.isUserInteractionEnabled = true
        self.filmImageView.isUserInteractionEnabled = true
    }

    func back() -> Void {
        
        let currentNav:ZYGewaraNaviController = (self.navigationController as! ZYGewaraNaviController)
        
        _ = currentNav.zy_pop(true)
    }
    
    func goChooseSeat() -> Void {
        
        let chooseSeat:ChooseSeatViewController = ChooseSeatViewController()
        
        let nav:ZYGewaraNaviController = self.navigationController as! ZYGewaraNaviController
        nav.zy_push(chooseSeat, nil, nil, false)
    }
}
