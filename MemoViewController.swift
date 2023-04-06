//
//  MemoViewController.swift
//  MemosApp
//
//  Created by 小松周平 on 2023/02/16.
//

import UIKit

class MemoViewController: UIViewController, UITextViewDelegate {
    
    var memo: String?
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        self.saveButton.isEnabled = false
        self.navigationItem.title = "新規メモ"
        
        if let memo = self.memo {
            self.textView.text = memo
            self.navigationItem.title = "内容を追加"
        }
        
        let memo = self.textView.text ?? ""
        self.saveButton.isEnabled = !memo.isEmpty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let themeColor = UserDefaults.standard.string(forKey: "themeColor") {
            switch themeColor {
            case "white":
                self.view.backgroundColor = .white
                self.textView.backgroundColor = .white
                self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .systemGray5
            case "red":
                self.view.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 204/255, alpha: 1)
                self.textView.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 204/255, alpha: 1)
                self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 204/255, green: 0, blue: 0, alpha: 1)
            case "blue":
                self.view.backgroundColor = UIColor(red: 204/255, green: 213/255, blue: 255/255, alpha: 1)
                self.textView.backgroundColor = UIColor(red: 204/255, green: 213/255, blue: 255/255, alpha: 1)
                self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 77/255, green: 86/255, blue: 128/255, alpha: 1)
            case "yellow":
                self.view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 179/255, alpha: 1)
                self.textView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 179/255, alpha: 1)
                self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 102/255, alpha: 1)
            case "purple":
                self.view.backgroundColor = UIColor(red: 230/255, green: 204/255, blue: 255/255, alpha: 1)
                self.textView.backgroundColor = UIColor(red: 230/255, green: 204/255, blue: 255/255, alpha: 1)
                self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 161/255, green: 92/255, blue: 230/255, alpha: 1)
            case "brown":
                self.view.backgroundColor = UIColor(red: 230/255, green: 207/255, blue: 184/255, alpha: 1)
                self.textView.backgroundColor = UIColor(red: 230/255, green: 207/255, blue: 184/255, alpha: 1)
                self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 255/255, green: 166/255, blue: 77/255, alpha: 1)
            case "black":
                self.view.backgroundColor = UIColor.systemGray2
                self.textView.backgroundColor = UIColor.systemGray2
                self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
            default:
                break
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let memo = self.textView.text ?? ""
        self.saveButton.isEnabled = !memo.isEmpty
    }
    
    @IBAction func cancel(_ sender: Any) {
        if self.presentingViewController is UINavigationController {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func clickShareSheet(_ sender: Any) {
        showShareSheet()
    }
    
    private func showShareSheet() {
        let memoText :String = textView.text
        let shareText = "\(memoText)"
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIBarButtonItem,  button === self.saveButton else {
            return
        }
        self.memo = self.textView.text ?? ""
    }
    
    
}
