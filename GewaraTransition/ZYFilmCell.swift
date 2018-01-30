//
//  ZYFilmCell.swift
//  GewaraTransition
//
//  Created by macOfEthan on 2018/1/29.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit
import Kingfisher

class ZYFilmCell: UICollectionViewCell {
    
    var filmImageView:ImageView?
    var filmNameLabel:UILabel?
    
    var film:ZYFilm?{
        
        didSet{
         
            let imageUrl:URL = URL(string:(film?.imageUrl)!)!
            
            //Resource只是一个协议，由cacheKey和downloadURL组成的，kingfisher默认是将url作为cacheKey，也可以自己定义一个cacheKey。
            self.filmImageView?.kf.setImage(with: ImageResource.init(downloadURL: imageUrl))
            
            self.filmNameLabel?.text = film?.filmName
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        self.filmCellInit()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func filmCellInit() -> Void {
        
        filmImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height*0.7))
        filmImageView?.backgroundColor = UIColor.lightGray
        self.addSubview(filmImageView!)
        
        filmNameLabel = UILabel.init(frame: CGRect.init(x: 0, y: self.bounds.size.height*0.7, width: self.bounds.size.width, height: self.bounds.size.height*0.3))
        filmNameLabel?.backgroundColor = UIColor.white
        filmNameLabel?.font = UIFont.systemFont(ofSize: 12)
        filmNameLabel?.textAlignment = .center
        self.addSubview(filmNameLabel!)
    }
}
