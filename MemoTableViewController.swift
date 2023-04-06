//
//  MemoTableViewController.swift
//  MemosApp
//
//  Created by 小松周平 on 2023/02/16.
//

import UIKit

class MemoTableViewController: UITableViewController {
    
    let memoUserDefaults = UserDefaults.standard
    var switchFlg:Bool = false
    var memos = [String]()
    
    var myTableViewCell: UITableViewCell?

    
    
    @IBOutlet var memoTableView: UITableView!
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.memoUserDefaults.object(forKey: "memos") != nil {
            self.memos = self.memoUserDefaults.stringArray(forKey: "memos")!
        }

        leftBarButton.tintColor = .black
        // falseの場合は単一選択になる
        tableView.allowsSelectionDuringEditing = true
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.leftBarButtonItem = editButtonItem
        print("aaaR")
        self.navigationItem.title = "メモ一覧"
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
        self.tableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
        tableView.isEditing = editing
    }
    //並び替えを可能にする
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //並び替えのハンドリング
        let itemToMove = memos.remove(at: sourceIndexPath.row)
        memos.insert(itemToMove, at: destinationIndexPath.row)
    }
    //     Override to support editing the table view.メモの消去
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            self.memos.remove(at: indexPath.row)
            self.memoUserDefaults.set(self.memos, forKey: "memos")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // 新規メモ実装ボタン
    @IBAction func unwindToMemoList(sender: UIStoryboardSegue) {
        guard let sourceVC = sender.source as? MemoViewController,
              let memo = sourceVC.memo else {
            return
        }
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow{
            self.memos[selectedIndexPath.row] = memo
        }  else {
            self.memos.append(memo)
        }
        self.memoUserDefaults.set(self.memos, forKey: "memos")
        self.tableView.reloadData()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //cellの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memos.count
    }
    
    //メモの内容をcellに表示させる
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoTableViewCell", for: indexPath)

        cell.textLabel?.text = self.memos[indexPath.row]
        switch UserDefaults.standard.string(forKey: "themeColor") {
        case "white":
            cell.backgroundColor = UIColor.systemGray5
            cell.textLabel?.textColor = UIColor.black
        case "red":
            cell.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 204/255, alpha: 1)
            cell.textLabel?.textColor = UIColor.black
        case "blue":
            cell.backgroundColor = UIColor(red: 204/255, green: 213/255, blue: 255/255, alpha: 1)
            cell.textLabel?.textColor = UIColor.black
        case "yellow":
            cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 179/255, alpha: 1)
            cell.textLabel?.textColor = UIColor.black
        case "purple":
            cell.backgroundColor = UIColor(red: 230/255, green: 204/255, blue: 255/255, alpha: 1)
            cell.textLabel?.textColor = UIColor.black
        case "brown":
            cell.backgroundColor = UIColor(red: 230/255, green: 207/255, blue: 184/255, alpha: 1)
            cell.textLabel?.textColor = UIColor.black
        case "black":
            cell.backgroundColor = UIColor.systemGray2
            cell.textLabel?.textColor = UIColor.black
        default:
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.black
        }

         return cell
        
    }
    
    // section title (グループ毎に書かれる文字)
    /*
     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     return
     }
     */
    //メモの内容を編集
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let identifier = segue.identifier else {
            return
        }
        if identifier == "editMemo" {
            let memoVC = segue.destination as! MemoViewController
            memoVC.memo = self.memos[(self.tableView.indexPathForSelectedRow?.row)!]
        }

    }
    
}
