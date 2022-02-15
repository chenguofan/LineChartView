//
//  LineChartView.swift
//  wristBand
//
//  Created by suhengxian on 2021/12/17.
//

import UIKit

class LineChartView: UIView {
    var maxValue:CGFloat?{
        willSet{
            self.maxValue = newValue
        }
        didSet{
            self.setNeedsLayout()
        }
    }
    var titles:[String]?{
        willSet{
            self.titles = newValue
        }
        didSet{
            //构建基本的试图
            guard let count = self.titles?.count else{
                return
            }
            
            for sub in self.subviews {
                sub.removeFromSuperview()
            }
            
            for index in 0...count - 1 {
                let lab = UILabel()
                lab.text = self.titles![index]
                lab.textAlignment = .center
                lab.font = UIFont.systemFont(ofSize: 15)
                lab.textColor = UIColor.red
                lab.tag = 100 + index
                self.addSubview(lab)
                
                let lab2 = UILabel()
                lab2.textColor = UIColor.blue
                lab2.font = UIFont.systemFont(ofSize: 15)
                lab2.textAlignment = .center
                lab2.tag = 1000 + index
                self.addSubview(lab2)
                
                let btn = UIButton(type: .custom)
                btn.setBackgroundColor(color: UIColor.green, forState:.normal)
                btn.setBackgroundColor(color: UIColor.green, forState: .selected)
                btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
                btn.tag = 10000 + index
                self.addSubview(btn)
            }
        }
    }
    
    var values:[String]?{
        willSet{
            self.values = newValue
        }
        didSet{
            guard let count = self.values?.count else{
                return
            }
            
            guard (self.titles?.count) != nil else{
                return
            }
            
            for index in 0...count - 1{
                let lab:UILabel = self.viewWithTag(1000 + index) as! UILabel
                lab.text = self.values![index]
            }
        }
    }
    
    @objc func btnClick(_ sender:UIButton){
        
        guard let count = self.titles?.count else { return }
        guard (self.values?.count) != nil else { return }
        
        for index in 0...count - 1 {
            let btn:UIButton = self.viewWithTag(10000 + index) as! UIButton
            btn.isSelected = false
        }
        sender.isSelected = true
        
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
     
        guard let count = self.titles?.count else{
            return
        }
        
        guard let count2 = self.values?.count else{
            return
        }
        
        if count != count2 {
            print("数据错误")
            return
        }
        
        let leftSpace = 30.0
        let centerSpace = 2.0
        let top = 10.0
        let bottom = 10.0
        
        let labWidth:CGFloat = (self.frame.size.width - leftSpace * 2.0 - ((CGFloat)(count + 1)) * centerSpace)/((CGFloat)(count))
        
        let labeHeight = 30.0
        let btnWidth = 10.0
        
        for index in 0...count - 1 {
            let lab = self.viewWithTag(100 + index)
            lab?.frame = CGRect.init(x:leftSpace + centerSpace + (labWidth + centerSpace) * (CGFloat)(index), y: self.frame.size.height - labeHeight - bottom, width: labWidth, height: labeHeight)
            
            //计算柱子的高度
            if self.maxValue == nil || self.maxValue == 0{
                self.maxValue = CGFloat((self.values!.max()! as NSString).floatValue)
            }
            
            let value:CGFloat = CGFloat((self.values![index] as NSString).floatValue)

            let btnHeight:CGFloat = (value) * (self.frame.size.height - 10 * 2 - labeHeight * 2)/self.maxValue!
            
            let btnY = (self.frame.size.height - 10 * 2 - labeHeight * 2) - btnHeight
            let btn:UIButton = self.viewWithTag(10000 + index) as! UIButton
            btn.frame = CGRect.init(x:0, y:labeHeight + top + btnY, width: btnWidth, height:btnHeight)
            btn.centerX = lab?.centerX ?? 0.0
            
            let lab2:UILabel = self.viewWithTag(1000 + index) as! UILabel
            lab2.frame = CGRect.init(x:leftSpace + centerSpace + (labWidth + centerSpace) * (CGFloat)(index), y:top + btnY, width: labWidth, height: labeHeight)
            
        }
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}

extension UIView{
    public var x : CGFloat{
        get{
            return frame.origin.x
        }
        set{
            frame.origin.x = newValue
        }
    }
    public var y : CGFloat{
        get{
            return frame.origin.y
        }
        set{
            frame.origin.y = newValue
        }
    }
    public var width : CGFloat{
        get{
            return frame.size.width
        }
        set{
            frame.size.width = newValue
        }
    }
    public var height : CGFloat{
        get{
            return frame.size.height
        }
        set{
            frame.size.height = newValue
        }
    }
    
    public var size : CGSize{
        get{
            return frame.size
        }
        set{
            frame.size = newValue
        }
    }
    
    public var origin : CGPoint{
        get{
            return frame.origin
        }
        set{
            frame.origin = newValue
        }
    }
    
    public var centerX : CGFloat{
        get{
            return center.x
        }
        set{
            center.x = newValue
        }
    }
    
    public var centerY : CGFloat{
        get{
            return center.y
        }
        set{
            center.y = newValue
        }
    }
    
    var bottom:CGFloat{
        return frame.maxY
    }
    
    var right:CGFloat{
        return frame.width + frame.origin.x
    }
    
}

public extension UIView{
    func setCornerRadius(radius:CGFloat){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
