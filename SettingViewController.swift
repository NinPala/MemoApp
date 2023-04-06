//
//  ViewController.swift
//  memoApp
//
//  Created by 小松周平 on 2023/03/18.
//

import UIKit


extension Array {
    func findIndex(includeElement: (Element) -> Bool) -> [Int] {
        var indexArray:[Int] = []
        for (index, element) in enumerated() {
            if includeElement(element) {
                indexArray.append(index)
            }
        }
        return indexArray
    }
}
class SettingViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource{
    
    //保存
    let settingUserDefaults = UserDefaults.standard
    
    //テーブルビュー
    private var tableView:UITableView!
    
    //ピッカービュー
    private var pickerView:UIPickerView!
    private let pickerViewHeight:CGFloat = 160
    
    //pickerViewの上にのせるtoolbar
    private var pickerToolbar:UIToolbar!
    private let toolbarHeight:CGFloat = 40.0
    
    //テーブルビューのテキストラベル
    private let textArray = ["テーマカラー"]
    
    //ピッカービューの選択肢
    private let colorArray = ["ホワイト", "レッド", "ブルー", "イエロー", "パープル", "ブラウン", "ダーク"]
    private let fontArray = ["ゴシック体", "明朝体"]
    
    //ピッカービューに渡すIndexPath
    private var pickerIndexPath:IndexPath!
    
    //現在の値
    private var currentColor:String!
    private var currentFont:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        //初期値
        currentColor = colorArray[0]
        currentFont = fontArray[0]
        
        //tableView
        tableView = UITableView(frame: CGRect(x:0,y:50,width:width,height:height - 50))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        //pickerView
        pickerView = UIPickerView(frame:CGRect(x:0,y:height + toolbarHeight,
                                               width:width,height:pickerViewHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.gray
        self.view.addSubview(pickerView)
        
        //pickerToolbar
        pickerToolbar = UIToolbar(frame:CGRect(x:0,y:height,width:width,height:toolbarHeight))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneBtn = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(self.doneTapped))
        pickerToolbar.items = [flexible,doneBtn]
        self.view.addSubview(pickerToolbar)
    }
    
    @objc func doneTapped(){
        UIView.animate(withDuration: 0.2){
            self.pickerToolbar.frame = CGRect(x:0,y:self.view.frame.height,
                                              width:self.view.frame.width,height:self.toolbarHeight)
            self.pickerView.frame = CGRect(x:0,y:self.view.frame.height + self.toolbarHeight,
                                           width:self.view.frame.width,height:self.pickerViewHeight)
        }
        self.tableView.deselectRow(at: pickerIndexPath, animated: true)
        guard let currentColor = currentColor else { return }
        print(currentColor)
        switch currentColor {
        case "ホワイト" :
            self.tableView.backgroundColor = .white
            self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .systemGroupedBackground
            UserDefaults.standard.set("white", forKey: "themeColor")
            
        case "レッド" :
            self.tableView.backgroundColor = UIColor(red: 139/255, green: 0, blue: 0, alpha: 1)
            self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 204/255, green: 0, blue: 0, alpha: 1)
            UserDefaults.standard.set("red", forKey: "themeColor")
        case "ブルー" :
            self.tableView.backgroundColor = UIColor(red: 0, green: 14/255, blue: 77/255, alpha: 1)
            self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 77/255, green: 86/255, blue: 128/255, alpha: 1)
            UserDefaults.standard.set("blue", forKey: "themeColor")
        case "イエロー" :
            self.tableView.backgroundColor = UIColor(red: 179/255, green: 179/255, blue: 89/255, alpha: 1)
            self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 102/255, alpha: 1)
            UserDefaults.standard.set("yellow", forKey: "themeColor")
        case "パープル" :
            self.tableView.backgroundColor = UIColor(red: 89/255, green: 51/255, blue: 128/255, alpha: 1)
            self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 161/255, green: 92/255, blue: 230/255, alpha: 1)
            UserDefaults.standard.set("purple", forKey: "themeColor")
        case "ブラウン" :
            self.tableView.backgroundColor = UIColor(red: 153/255, green: 91/255, blue: 29/255, alpha: 1)
            self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 255/255, green: 166/255, blue: 77/255, alpha: 1)
            UserDefaults.standard.set("brown", forKey: "themeColor")
        case "ダーク" :
            self.tableView.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
            self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
            UserDefaults.standard.set("black", forKey: "themeColor")
        default :
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let themeColor = UserDefaults.standard.string(forKey: "themeColor") {
            switch themeColor {
            case "white":
                self.tableView.backgroundColor = .white
                self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .systemGroupedBackground
            case "red":
                self.tableView.backgroundColor = UIColor(red: 139/255, green: 0, blue: 0, alpha: 1)
                self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 204/255, green: 0, blue: 0, alpha: 1)
            case "blue":
                self.tableView.backgroundColor = UIColor(red: 0, green: 14/255, blue: 77/255, alpha: 1)
                self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 77/255, green: 86/255, blue: 128/255, alpha: 1)
            case "yellow":
                self.tableView.backgroundColor = UIColor(red: 179/255, green: 179/255, blue: 89/255, alpha: 1)
                self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 102/255, alpha: 1)
            case "purple":
                self.tableView.backgroundColor = UIColor(red: 89/255, green: 51/255, blue: 128/255, alpha: 1)
                self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 161/255, green: 92/255, blue: 230/255, alpha: 1)
            case "brown":
                self.tableView.backgroundColor = UIColor(red: 153/255, green: 91/255, blue: 29/255, alpha: 1)
                self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 255/255, green: 166/255, blue: 77/255, alpha: 1)
            case "black":
                self.tableView.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
                self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
            default:
                break
            }
        }
    }
    
    /********************** TableView **********************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.textLabel?.text = textArray[indexPath.row]
        
        print(indexPath.row)
        //初期値
        switch(indexPath.row){
        case 0:
            cell.rightLabel.text = currentColor
        case 1:
            cell.rightLabel.text = currentFont
        default:
            cell.rightLabel.text = ""
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //ピッカービューとセルがかぶる時はスクロール
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        let cellLimit:CGFloat = cell.frame.origin.y + cell.frame.height
        let pickerViewLimit:CGFloat = pickerView.frame.height + toolbarHeight
        if(cellLimit >= pickerViewLimit){
            print("位置変えたい")
            UIView.animate(withDuration: 0.2) {
                tableView.contentOffset.y = cellLimit - pickerViewLimit
            }
        }
        
        switch(indexPath.row){
        case 0:
            let index = colorArray.findIndex{$0 == cell.rightLabel.text}
            if(index.count != 0){
                pickerView.selectRow(index[0],inComponent:0,animated:false)
            }
        case 1:
            let index = fontArray.findIndex{$0 == cell.rightLabel.text}
            if(index.count != 0){
                pickerView.selectRow(index[0],inComponent:0,animated:false)
            }
        default:
            pickerView.selectRow(0, inComponent: 0, animated: false)
            
        }
        
        
        pickerIndexPath = indexPath
        //ピッカービューをリロード
        pickerView.reloadAllComponents()
        //ピッカービューを表示
        UIView.animate(withDuration: 0.2) {
            self.pickerToolbar.frame = CGRect(x:0,y:self.view.frame.height - self.pickerViewHeight - self.toolbarHeight,
                                              width:self.view.frame.width,height:self.toolbarHeight)
            self.pickerView.frame = CGRect(x:0,y:self.view.frame.height - self.pickerViewHeight,
                                           width:self.view.frame.width,height:self.pickerViewHeight)
        }
    }
    
    /********************* PickerView ***********************/
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerIndexPath != nil){
            switch (pickerIndexPath.row){
            case 0:
                return colorArray.count
            case 1:
                return fontArray.count
            default:
                return 0
            }
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        switch(pickerIndexPath.row){
        case 0:
            label.text = colorArray[row]
        case 1:
            label.text = fontArray[row]
        default:
            print("なし")
            
        }
        return label
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let cell = tableView.cellForRow(at:pickerIndexPath) as! CustomTableViewCell
        switch(pickerIndexPath.row){
        case 0:
            cell.rightLabel.text = colorArray[row]
            currentColor = colorArray[row]
        case 1:
            cell.rightLabel.text = fontArray[row]
            currentFont = fontArray[row]
        default:
            print("何もなし")
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
}
