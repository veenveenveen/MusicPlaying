//
//  ViewController.swift
//  MusicPlaying
//
//  Created by 黄启明 on 2016/10/15.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit
import KVNProgress
import Alamofire

let screenH = UIScreen.main.bounds.size.height
let screenW = UIScreen.main.bounds.size.width

class ViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var albumImageView: HMRadioImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var needleImageView: UIImageView!
    
    var isRoatating: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "http://api.fir.im/apps/latest/com.huatengIOT.MusicPlaying?api_token=fab39ed99d5d01c42372f11f06ef7fc0&type=ios"
        
        
        request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (data: DataResponse<Any>) in
            print(data)
        }
        //毛玻璃效果
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = view.bounds
        visualEffectView.alpha = 0.98
        backImageView.addSubview(visualEffectView)
        //唱片
        albumImageView.albumView?.image = UIImage(named: "aaa")
        albumImageView.startRoatating()
        //唱针
        needleImageView = UIImageView(frame: CGRect(x: screenW*0.5-110*0.28, y: 100-182*0.17, width: 110, height: 182))
        
        needleImageView.image = UIImage(named: "cm2_play_needle_play")
        setAnchorPoint(anchorPoint: CGPoint(x: 0.28, y: 0.16), forView: needleImageView)//修改锚点位置
        view.addSubview(needleImageView)
        //底部视图
        bottomView.backgroundColor = UIColor(white: 0.7, alpha: 0.3)
        
        view.bringSubview(toFront: topView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startOrStop(_ sender: AnyObject) {
        needleAnimation()
        if isRoatating {
            albumImageView.stopRoatating()
            isRoatating = false
        }
        else {
            albumImageView.resumeRoatating()
            isRoatating = true
        }
        
        
    }
    //唱针旋转动画
    func needleAnimation() {
        let angle = isRoatating ? -CGFloat.pi*0.2 : 0
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: { 
            self.needleImageView.transform = CGAffineTransform(rotationAngle: angle)
            }) { (finished) in
                
        }
    }
    //修改唱针锚点的方法
    func setAnchorPoint(anchorPoint: CGPoint , forView view: UIView) {
        let newPoint = CGPoint(x: view.bounds.size.width*anchorPoint.x, y: view.bounds.size.height*anchorPoint.y)
        let oldPoint = CGPoint(x: view.bounds.size.width*view.layer.anchorPoint.x, y: view.bounds.size.height*view.layer.anchorPoint.y)
        var position = view.layer.position
        position.x = position.x - oldPoint.x + newPoint.x
        position.y = position.y - oldPoint.y + newPoint.y
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }

}

