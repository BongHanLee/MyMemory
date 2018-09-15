//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by bongMac on 2018. 9. 16..
//  Copyright © 2018년 bongMac. All rights reserved.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet var contents: UITextView!
    @IBOutlet var preview: UIImageView!
    
    var subject: String!
    
    //저장 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func save(_ sender: Any) {
        // 내용을 입력하지 않았을 경우, 경고한다.
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        //MemoData 객체를 생성하고, 데이터를 담는다.
        let data = MemoData()
        
        data.Title = self.subject
        data.contents = self.contents.text
        data.image = self.preview.image
        data.regdate = Date()
        
        //앱 델리게이트 객체를 일겅온 다음, memolist 배열에 MemoData 객체를 추가한다.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        //작성폼 화면을 종료하고, 이전 화면으로 되돌아간다.
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    // 카메라 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func pick(_ sender: Any) {
        //이미지 피커 인스턴스를 생성한다.
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        // 이미지 피커 화면을 표시한다.
        self.present(picker, animated: false)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //선택된 이미지를 미리보기에 표시한다.
        self.preview.image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        //이미지 피커 컨트롤러를 닫는다.
        picker.dismiss(animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.contents.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func textViewDidChange(_ textView: UITextView) {
        // 내용의 최대 15자리까지 읽어 subject 변수에 저장한다.
        let contents = textView.text as NSString
        let length = ( ( contents.length > 15 ) ? 15 : contents.length )
        self.subject = contents.substring( with: NSRange(location: 0, length: length ) )
        
        // 내비게이션 타이틀에 표시한다.
        self.navigationItem.title = subject
        
    }

}
