//
//  CustumViewController.swift
//  memoApp
//
//  Created by 小松周平 on 2023/03/17.
//

import UIKit

class CustumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
//    let textArray = ["テーマカラーを変更","二つ目"]
    private let textArray = ["性別","好きな動物","好きなスポーツ"]
    
    
    @IBOutlet weak var firstTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTableView.dataSource = self
        firstTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = firstTableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath)
        
        cell.textLabel?.text = textArray[indexPath.row]
        cell.imageView?.image = UIImage(systemName: textArray[indexPath.row])
        
        return cell
    }
    
    
    class CustumViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource{
        
        //テーブルビュー
        private var tableView:UITableView!
        
        //ピッカービュー
        private var pickerView:UIPickerView!
        private let pickerViewHeight:CGFloat = 160
        
        //pickerViewの上にのせるtoolbar
        private var pickerToolbar:UIToolbar!
        private let toolbarHeight:CGFloat = 40.0
        
        //テーブルビューのテキストラベル
        private let textArray = ["性別","好きな動物","好きなスポーツ"]
        
        //ピッカービューの選択肢
        private let genderArray = ["男","女"]
        private let animalArray = ["猫","犬","ライオン","カバ","キリン","ゾウ"]
        private let sportsArray = ["野球","サッカー","バレーボール","テニス","水泳"]
        
        //ピッカービューに渡すIndexPath
        private var pickerIndexPath:IndexPath!
        
        //現在の値
        private var currentGender:String!
        private var currentAnimal:String!
        private var currentSports:String!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
            let width = self.view.frame.width
            let height = self.view.frame.height
            
            //初期値
            currentGender = genderArray[0]
            currentAnimal = animalArray[0]
            currentSports = sportsArray[0]
            
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
                self.tableView.contentOffset.y = 0
            }
            self.tableView.deselectRow(at: pickerIndexPath, animated: true)
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
                cell.rightLabel.text = currentGender
            case 1:
                cell.rightLabel.text = currentAnimal
            case 2:
                cell.rightLabel.text = currentSports
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
            
//            switch(indexPath.row){
//            case 0:
//                let index = genderArray.findIndex{$0 == cell.rightLabel.text}
//                if(index.count != 0){
//                    pickerView.selectRow(index[0],inComponent:0,animated:false)
//                }
//            case 1:
//                let index = animalArray.findIndex{$0 == cell.rightLabel.text}
//                if(index.count != 0){
//                    pickerView.selectRow(index[0],inComponent:0,animated:false)
//                }
//            case 2:
//                let index = sportsArray.findIndex{$0 == cell.rightLabel.text}
//                if(index.count != 0){
//                    pickerView.selectRow(index[0],inComponent:0,animated:false)
//                }
//            default:
//                pickerView.selectRow(0, inComponent: 0, animated: false)
//                
//            }
            
            
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
                    return genderArray.count
                case 1:
                    return animalArray.count
                case 2:
                    return sportsArray.count
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
                label.text = genderArray[row]
            case 1:
                label.text = animalArray[row]
            case 2:
                label.text = sportsArray[row]
            default:
                print("なし")
                
            }
            return label
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            let cell = tableView.cellForRow(at:pickerIndexPath) as! CustomTableViewCell
            switch(pickerIndexPath.row){
            case 0:
                cell.rightLabel.text = genderArray[row]
                currentGender = genderArray[row]
            case 1:
                cell.rightLabel.text = animalArray[row]
                currentAnimal = animalArray[row]
            case 2:
                cell.rightLabel.text = sportsArray[row]
                currentSports = sportsArray[row]
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
        
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}
