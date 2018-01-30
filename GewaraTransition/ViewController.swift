//
//  ViewController.swift
//  GewaraTransition
//
//  Created by macOfEthan on 2018/1/29.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    var collectionView:UICollectionView?
    
    var films:ZYFilms = ZYFilms()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customNav()
        
        //设置背景颜色
        self.view.backgroundColor = UIColor.white
        
        let layOut:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layOut.minimumLineSpacing = 30
        layOut.minimumInteritemSpacing = 10
        layOut.scrollDirection = .vertical
        
        collectionView = UICollectionView.init(frame: CGRect.init(x: 10, y: 84, width: UIScreen.main.bounds.size.width-20, height: UIScreen.main.bounds.size.height-84-34), collectionViewLayout: layOut)
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor.white
        self.view.addSubview(collectionView!)
        
        collectionView?.register(ZYFilmCell.self, forCellWithReuseIdentifier: "film")
    }
    
    // MARK: - 自定义导航栏
    func customNav() -> Void {
        
        let navView:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64))
        navView.backgroundColor = UIColor.white
        
        let lineView:UIView = UIView.init(frame: CGRect.init(x: 0, y: 63, width: UIScreen.main.bounds.size.width, height: 1))
        lineView.backgroundColor = UIColor.lightGray
        navView.addSubview(lineView)
        
        view.addSubview(navView)
    }
    
    // MARK: -  UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:ZYFilmCell? = collectionView.dequeueReusableCell(withReuseIdentifier: "film", for: indexPath) as? ZYFilmCell
        
        cell?.film = self.films.films[indexPath.row]
        
        return cell!
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let currentCell:ZYFilmCell = collectionView.cellForItem(at: indexPath) as! ZYFilmCell
        
        let animationImageView:UIImageView = currentCell.filmImageView!
        
        let film:ZYFilm = self.films.films[indexPath.row]
        
        let detailFilmVc:ZYDetailFilmsViewController = ZYDetailFilmsViewController.init()
        detailFilmVc.film = film
        
        //当前自定义导航栏
        let currentNav:ZYGewaraNaviController = (self.navigationController as! ZYGewaraNaviController)

        //动画结束后图片停留区域
        let targetAnimationRect:CGRect = CGRect.init(x: 20, y: 150, width: 100, height: 80)
        
        //自定义push 最后一个参数是否使用动画
        currentNav.zy_push(detailFilmVc, animationImageView, targetAnimationRect, true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width:CGFloat = (UIScreen.main.bounds.size.width-4*10)/3
        let height:CGFloat = 140
        
        return CGSize.init(width: width, height: height)
    }
}

