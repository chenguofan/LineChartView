//
//  ViewController.swift
//  LineChartView
//
//  Created by suhengxian on 2022/2/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let lineChartView = LineChartView.init(frame: CGRect.init(x: 0, y: 300.0, width:UIScreen.main.bounds.size.width, height: 300))
        
        lineChartView.titles = ["11.1-11.7","11.1-11.7","11.1-11.7","11.1-11.7","11.1-11.7"]
        lineChartView.values = ["240","300","180","420","800"];
        lineChartView.maxValue = 1440
        
        self.view.addSubview(lineChartView)
    }
}

