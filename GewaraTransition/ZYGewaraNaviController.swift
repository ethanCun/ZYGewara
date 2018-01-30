//
//  ZYGewaraNaviController.swift
//  GewaraTransition
//
//  Created by macOfEthan on 2018/1/29.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

class ZYGewaraNaviController: UINavigationController , UINavigationControllerDelegate{

    //目标控制器
    var targerViewController:UIViewController?
    //动画添加的imageview
    var animatedImageView:UIImageView?
    //动画其实区域
    var originalAnimationRect:CGRect?
    //动画结束区域
    var targetAnimationRect:CGRect?
    //是否动画
    var withAnimation:Bool?
    //push还是pop
    var isPush:Bool?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        //默认影藏导航栏
        self.navigationBar.isHidden = true
    }

    // MARK: - 自定义push
    
    /// 自定义push
    ///
    /// - Parameters:
    ///   - targerViewController: 目标控制器
    ///   - animatedImageView: 发生动画的图片
    ///   - targetAnimationRect: 图片动画结束后停留区域
    ///   - withAnimation: 是否使用自定义push动画
    public func zy_push(_ targerViewController:UIViewController?, _ animatedImageView:UIImageView?, _ targetAnimationRect:CGRect?, _ withAnimation:Bool?){
        
        //设置代理
        self.delegate = self

        self.withAnimation = withAnimation

        //如果不适用动画 直接返回
        guard self.withAnimation != false else {
            return super.pushViewController(targerViewController!, animated: true)
        }
        
        guard targetAnimationRect != nil else {
            return super.pushViewController(targerViewController!, animated: true)
        }
        
        //将坐标转换到导航栏的view上 并取得图片起始区域
        let originalAnimationRect:CGRect = (animatedImageView?.convert((animatedImageView?.frame)!, to: self.view))!
        self.originalAnimationRect = originalAnimationRect
        
        guard animatedImageView != nil else {
            return super.pushViewController(targerViewController!, animated: true)
        }
        
        self.animatedImageView = animatedImageView

        self.targerViewController = targerViewController
        self.targetAnimationRect = targetAnimationRect
        self.isPush = true
        
        super.pushViewController(targerViewController!, animated: true)
    }
    
    // MARK: - 自定义pop
    public func zy_pop(_ withAnimation:Bool?) -> UIViewController? {
        
        self.isPush = false
        self.withAnimation = withAnimation
        
        return super.popViewController(animated: true)
    }
    
   // MARK: - UINavigationControllerDelegate
    //返回一个遵守UIViewControllerAnimatedTransitioning协议的对象
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if !self.withAnimation! {
            return nil
        }
        
        let animator:ZYGewaraAnimator = ZYGewaraAnimator()
        animator.isPush = self.isPush
        animator.animatedImageView = self.animatedImageView
        animator.originalAnimationRect = self.originalAnimationRect
        animator.targetAnimationRect = self.targetAnimationRect
        animator.animatedImage = self.animatedImageView?.image
        
        return animator
    }
    
    
}


