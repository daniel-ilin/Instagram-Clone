//
//  UploadPostsController.swift
//  Instagram Clone
//
//  Created by Daniel Ilin on 13.12.2021.
//

import Foundation
import UIKit

protocol UploadPostsControllerDelegate: AnyObject {
    func controllerDidFinishUploadingPost(_ controller: UploadPostsController)
}

class UploadPostsController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: UploadPostsControllerDelegate?
    
    var currentUser: User?
    
    var selectedImage: UIImage?  {
        didSet {
            photoImageView.image = selectedImage
        }
    }
    
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var captionTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "Enter caption"
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.delegate = self
        return tv
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done,
                                                           target: self,
                                                           action: #selector(didTapShare))
        
        view.addSubview(photoImageView)
        photoImageView.setDimensions(height: 180, width: 180)
        photoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 10
        
        view.addSubview(captionTextView)
        captionTextView.anchor(top: photoImageView.bottomAnchor, left: view.leftAnchor,
                               right: view.rightAnchor, paddingTop: 16, paddingLeft: 12,
                               paddingRight: 12, height: 64)
        
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(top: captionTextView.bottomAnchor, right: view.rightAnchor,
                                   paddingBottom: -8, paddingRight: 12)
    }
    
    func checkMaxLength(_ textView: UITextView, maxLength: Int) {
        if textView.text.count > maxLength {
            textView.deleteBackward()
        }
    }
    
    // MARK: - Actions
    
    @objc func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapShare() {
        guard let image = selectedImage else { return }
        guard let caption = captionTextView.text else { return }
        guard let currentUser = currentUser else { return }

        
        showLoader(true)
        
        PostService.uploadPost(caption: caption, image: image, user: currentUser) { error in
            self.showLoader(false)
            if let error = error {
                print("DEBUG: Failed to upload post with error \(error.localizedDescription)")
                return
            }
                        
            self.delegate?.controllerDidFinishUploadingPost(self)
        }
    }
    
}

// MARK: - UITextFieldDelegate

extension UploadPostsController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView, maxLength: 100)
        let count = textView.text.count 
        characterCountLabel.text = ("\(count)/100")
    }
}
