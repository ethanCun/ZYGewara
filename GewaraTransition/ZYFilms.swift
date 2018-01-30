//
//  ZYFilms.swift
//  GewaraTransition
//
//  Created by macOfEthan on 2018/1/29.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

struct ZYFilms {
    
    var films:[ZYFilm] = {
        
        var films:[ZYFilm] = [ZYFilm]()
        
        let imageUrls:[String] = ["http://pic8.qiyipic.com/image/20171226/67/e2/v_114397088_m_601_m1_180_236.jpg",
                                  "http://pic1.qiyipic.com/common/lego/20180128/5b474b679efd468098eaae53ca75b627.jpg",
                                  "http://pic0.qiyipic.com/common/lego/20180128/9eee97db4bd2446d80f0a422eee5ae2a.jpg",
                                  "http://pic3.qiyipic.com/common/lego/20180129/89a136855d4740efac2439c0aea9b4de.jpg",
                                  "http://pic0.qiyipic.com/common/lego/20180128/2de498955be54b6793a13c13933e0e30.jpg",
                                  "http://pic0.qiyipic.com/common/lego/20180128/89f61ddb7e834480bac9e331183eaa80.jpg",
                                  "http://pic1.qiyipic.com/common/lego/20180129/7931a5715a944a8487c3d12f56a58eff.jpg",
                                  "http://pic8.qiyipic.com/image/20171226/67/e2/v_114397088_m_601_m1_180_236.jpg",
                                  "http://pic8.qiyipic.com/image/20171226/67/e2/v_114397088_m_601_m1_180_236.jpg",
                                  "http://pic8.qiyipic.com/image/20171226/67/e2/v_114397088_m_601_m1_180_236.jpg",
                                  "http://pic8.qiyipic.com/image/20171226/67/e2/v_114397088_m_601_m1_180_236.jpg",
                                  "http://pic8.qiyipic.com/image/20171226/67/e2/v_114397088_m_601_m1_180_236.jpg",
                                  "http://pic8.qiyipic.com/image/20171226/67/e2/v_114397088_m_601_m1_180_236.jpg",
                                  "http://pic8.qiyipic.com/image/20171226/67/e2/v_114397088_m_601_m1_180_236.jpg",
                                  "http://pic8.qiyipic.com/image/20171226/67/e2/v_114397088_m_601_m1_180_236.jpg",
                                  "http://pic8.qiyipic.com/image/20171226/67/e2/v_114397088_m_601_m1_180_236.jpg",
                                  "http://pic8.qiyipic.com/image/20171226/67/e2/v_114397088_m_601_m1_180_236.jpg"]
        let coverUrls:[String] = imageUrls
        let filmNames:[String] = ["超级大山炮之海岛奇遇","三个院子","最强大脑燃烧季","声临其境","坑王驾到2：VIP独享","如果爱第4季","国家宝藏","超级大山炮之海岛奇遇","超级大山炮之海岛奇遇","超级大山炮之海岛奇遇","超级大山炮之海岛奇遇","超级大山炮之海岛奇遇","超级大山炮之海岛奇遇","超级大山炮之海岛奇遇","超级大山炮之海岛奇遇","超级大山炮之海岛奇遇","超级大山炮之海岛奇遇"]
        
        for i in 0...imageUrls.count-1{
            
            var film:ZYFilm = ZYFilm()
            film.imageUrl = imageUrls[i]
            film.coverUrl = coverUrls[i]
            film.filmName = filmNames[i]
            
            films.append(film)
        }
        
        return films
    }()
    
}

struct ZYFilm {
    
    var imageUrl:String?
    var coverUrl:String?
    var filmName:String?
}
