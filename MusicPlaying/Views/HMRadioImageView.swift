//
//  HMRadioImageView.swift
//  MusicPlaying
//
//  Created by 黄启明 on 2016/10/15.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//

import UIKit

class HMRadioImageView: UIImageView {
    
    //内部专辑图片的尺寸
    private let albumW: CGFloat = 176
    private let albumH: CGFloat = 176
    //内部的专辑图片
    var albumView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        albumView = UIImageView(frame: CGRect(x: (frame.size.width-albumW)*0.5, y: (frame.size.height-albumH)*0.5, width: albumW, height: albumH))
        albumView?.layer.cornerRadius = albumW * 0.5
        albumView?.clipsToBounds = true
        albumView?.image = UIImage(named: "aaa")
        addSubview(albumView!)
        
    }
    //动画
    func startRoatating() {
        let rotateAnim = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnim.fromValue = 0.0
        rotateAnim.toValue = CGFloat.pi * 2.0
        rotateAnim.duration = 20.0
        rotateAnim.repeatCount = MAXFLOAT
        layer.add(rotateAnim, forKey: nil)
    }
    func stopRoatating() {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    func resumeRoatating() {
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = CACurrentMediaTime() - pausedTime
    }
}
