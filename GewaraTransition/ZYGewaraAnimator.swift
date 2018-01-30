//
//  ZYGewaraAnimator.swift
//  GewaraTransition
//
//  Created by macOfEthan on 2018/1/29.
//  Copyright © 2018年 macOfEthan. All rights reserved.
//

import UIKit

class ZYGewaraAnimator: NSObject , UIViewControllerAnimatedTransitioning, CAAnimationDelegate{

    //push/pop
    var isPush:Bool?
    //动画imageview
    var animatedImageView:UIImageView?
    //动画图片
    var animatedImage:UIImage?
    //起始区域
    var originalAnimationRect:CGRect?
    //目标区域
    var targetAnimationRect:CGRect?
    //转场上下文
    var transitionContext:UIViewControllerContextTransitioning?
    //动画背景视图
    var animationBgView:UIView? = {
        
        let animationBgView:UIView = UIView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        animationBgView.backgroundColor = UIColor.white
        
        let topView:UIView? = UIView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200))
        topView?.backgroundColor = UIColor.lightGray
        animationBgView.addSubview(topView!)
        
        animationBgView.tag = 1001
        
        return animationBgView
    }()
    
    
    // MARK: - UIViewControllerAnimatedTransitioning
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        
        if self.isPush!{
            
            self.pushAnimation()
        }else{
            
            self.popAnimation()
        }
    }

  
    
    // MARK: - push animation
    //分析动画过程：先有背景视图 然后图片移动  移动过程中先变大后缩小 移动完成后图片添加了白色的边框 并有圆角 图片动画完成后目标控制器的视图以图片中点为圆圈扩散开来
    func pushAnimation() -> Void {
        
        let containerView = self.transitionContext?.containerView
        
        //添加背景视图
        containerView?.addSubview(self.animationBgView!)
        
        let toVc:UIViewController = (self.transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.to))!
        
        //重新创建一张imageview
        let animateImageV:UIImageView = UIImageView.init()
        animateImageV.frame = self.originalAnimationRect!
        animateImageV.image = self.animatedImage
        containerView?.addSubview(animateImageV)
        
        UIView.animate(withDuration: 0.5, animations: {
            
            //改变scale
            animateImageV.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
           
        }) { (_ complete:Bool) in
            
            UIView.animate(withDuration: 0.5, animations: {
                
                //复原
                animateImageV.transform = CGAffineTransform.identity
                
                //改变frame
                animateImageV.frame = self.targetAnimationRect!
                
            }, completion: { (_ complete:Bool) in
                
                //添加到containerview
                containerView?.addSubview(toVc.view)
                
                //添加白色的边
                animateImageV.layer.borderWidth = 2
                animateImageV.layer.borderColor = UIColor.white.cgColor
                
                //将该图片放到最前面挡住
                containerView?.bringSubview(toFront: animateImageV)
                
                //添加圆圈动画
                self.pushCircleAnimation()
            })
        }
    }
    
    
    // MARK: - popAnimation
    func popAnimation() -> Void {
        
        //圆圈收起动画
        self.popCircleAnimation()
        
    }
    
    // MARK: - 圆圈扩散动画
    func circleAnimation(_ startPath:UIBezierPath, _ endPath:UIBezierPath, _ animationKey:String?) -> Void {
        
        let targetVc:UIViewController

        if self.isPush!{
            
            targetVc = (self.transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.to))!
        }else{
            
            targetVc = (self.transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.from))!
        }
        
        //path动画
        let pathAnimation:CABasicAnimation = CABasicAnimation.init(keyPath: "path")
        pathAnimation.fromValue = startPath.cgPath
        pathAnimation.toValue = endPath.cgPath
        pathAnimation.repeatCount = 1
        pathAnimation.duration = 1.0
        pathAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        pathAnimation.delegate = self
        
        let layer:CAShapeLayer = CAShapeLayer.init()
        layer.path = endPath.cgPath
        layer.add(pathAnimation, forKey: animationKey!)
        
        //设置蒙层为endPath对应的layer
        targetVc.view.layer.mask = layer
    }
    
    func pushCircleAnimation() -> Void {
        
        //半径 取最大值
        let radiusX:CGFloat = UIScreen.main.bounds.size.width-(self.originalAnimationRect?.origin.x)!
        let radiusY:CGFloat = UIScreen.main.bounds.size.height-(self.originalAnimationRect?.origin.y)!
        let radius:CGFloat = max(radiusX, radiusY)
        
        //中心点
        let center:CGPoint = CGPoint.init(x: (self.targetAnimationRect?.origin.x)!+(self.targetAnimationRect?.size.width)!/2, y: (self.targetAnimationRect?.origin.y)!+(self.targetAnimationRect?.size.height)!/2)
        
        let startPath:UIBezierPath = UIBezierPath.init(arcCenter: center, radius: 0, startAngle: 0, endAngle: CGFloat(Float.pi*2), clockwise: true)
        let endPath:UIBezierPath = UIBezierPath.init(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(Float.pi*2), clockwise: true)
        
        self.circleAnimation(startPath, endPath, "push")
    }
    
    func popCircleAnimation() -> Void {
        
        //半径 取最大值
        let radiusX:CGFloat = UIScreen.main.bounds.size.width-(self.originalAnimationRect?.origin.x)!
        let radiusY:CGFloat = UIScreen.main.bounds.size.height-(self.originalAnimationRect?.origin.y)!
        let radius:CGFloat = max(radiusX, radiusY)
        
        //中心点
        let center:CGPoint = CGPoint.init(x: (self.targetAnimationRect?.origin.x)!+(self.targetAnimationRect?.size.width)!/2, y: (self.targetAnimationRect?.origin.y)!+(self.targetAnimationRect?.size.height)!/2)
        
        let startPath:UIBezierPath = UIBezierPath.init(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(Float.pi*2), clockwise: true)
        let endPath:UIBezierPath = UIBezierPath.init(arcCenter: center, radius: 0, startAngle: 0, endAngle: CGFloat(Float.pi*2), clockwise: true)
        
        self.circleAnimation(startPath, endPath, "pop")
    }

    
    // MARK: - CAAnimationDelegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if self.isPush! {
            
            //通知push转场已经完成 可以pop了
            self.transitionContext?.completeTransition(true)
            self.transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.to)?.view.layer.mask = nil
            self.transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.from)?.view.layer.mask = nil
        }else{
            
            //圆圈动画收起之后进行
            if flag{
                
                //pop to的控制器
                let toVc:UIViewController? = transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.to)
                
                //找到发生动画的imageview
                var animateImageView:UIImageView?
                for view:UIView in (self.transitionContext?.containerView.subviews)! {
                    
                    if view.isKind(of: UIImageView.self){
                        
                        animateImageView = view as? UIImageView
                    }
                }
                
                
                UIView.animate(withDuration: 0.5, animations: {
                    
                    //放大
                    animateImageView?.transform = CGAffineTransform.init(scaleX: 1.2, y: 1.2)
                    
                }, completion: { (_ complete:Bool?) in
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        
                        //改变frame
                        animateImageView?.frame = self.originalAnimationRect!
                        
                    }) { (_ complete:Bool?) in
                        
                        //复原
                        animateImageView?.transform = CGAffineTransform.identity
                        animateImageView?.layer.borderWidth = 0
                        
                        let animationBgV:UIView = (self.transitionContext?.containerView.viewWithTag(1001))!

                        UIView.animate(withDuration: 0.2, animations: {
                            
                            //改变alpha
                            animationBgV.alpha = 0
                            
                        }, completion: { (_ complete:Bool?) in
                       
                            animateImageView?.removeFromSuperview()
                            
                            animationBgV.removeFromSuperview()
                        self.transitionContext?.containerView.addSubview((toVc?.view)!)
                            //通知转场已经完成
                            self.transitionContext?.completeTransition(true)
                        })
                    }
                })
                
            }
        }
    }
}
