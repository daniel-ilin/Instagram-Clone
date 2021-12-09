//
//  ImagerUploader.swift
//  Instagram Clone
//
//  Created by Daniel Ilin on 04.12.2021.
//

import Foundation
import FirebaseStorage
import UIKit

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) { 
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("DEBUG: Failed to upload image \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL(completion: { (url, error) in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            })
        }
    }
}
