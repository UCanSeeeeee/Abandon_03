//
//  ViewController.swift
//  Calculator
//
//  Created by 王杰 on 2022/4/13.
//

import UIKit
import SnapKit

class ViewController: UIViewController, BoardButtonInputDelegate {
    let board = Board()
    let screen = Screen()
    let calculator = CalculatorEngine()
    var isNew = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installUI()
        // Do any additional setup after loading the view.
    }
    
    func installUI() {
        self.view.addSubview(board)
        self.view.addSubview(screen)
        //设置代理
        board.delegate = self
        board.snp.makeConstraints { (maker) in
            maker.left.right.bottom.equalTo(0)
            maker.height.equalTo(board.superview!.snp.height).multipliedBy(2/3.0)
        }
        screen.snp.makeConstraints { (maker) in
            maker.left.right.top.equalTo(0)
            maker.bottom.equalTo(board.snp.top)
        }
    }
    
    func boardButtonClick(content: String) {
        if content == "AC" || content == "Delete" || content == "=" {
            //进行功能逻辑
            switch content {
            case "AC":
                screen.clearContent()
                screen.refreshHistory()
            case "Delete":
                screen.deleteInput()
            case "=":
                let result = calculator.calculatEquation(equation: screen.inputString)
                //先刷新历史
                screen.refreshHistory()
                //清除输入的内容
                screen.clearContent()
                //将结果输入
                screen.inputContent(content: String(result))
                isNew = true
            default:
                screen.refreshHistory()
            }
            
        } else {
            if isNew {
                screen.clearContent()
                isNew = false
            }
            screen.inputContent(content: content)
        }
    }
}

