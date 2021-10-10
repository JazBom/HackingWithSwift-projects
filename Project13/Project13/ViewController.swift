//
//  ViewController.swift
//  Project13
//
//  Created by Jessica Bommer on 27/9/21.
//
import CoreImage
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var intensity: UISlider!
    var currentImage: UIImage!

    var context: CIContext!
    var currentFilter: CIFilter!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Insta-filter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
    }

    @objc func importPicture(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        currentImage = image

        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

        applyProcessing()
    }

    @IBAction func changeFilter(_ sender: Any) {
        let alert = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
           alert.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
           alert.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
           alert.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
           alert.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
           alert.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
           alert.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
           alert.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
           alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
           present(alert, animated: true)
    }

    @IBAction func save(_ sender: Any) {
        guard let image = imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self,
            #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @IBAction func intensityChanged(_ sender: Any) {
        applyProcessing()
    }

    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

         if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey) }

         if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey) }

         if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey) }

         if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey) }

         if let cgImage = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
             let processedImage = UIImage(cgImage: cgImage)
             self.imageView.image = processedImage
         }
    }

    func setFilter(action: UIAlertAction) {
        guard currentImage != nil else { return }
        guard let actionTitle = action.title else { return }
        currentFilter = CIFilter(name: actionTitle)
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alert = UIAlertController(title: "Save error",
                message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
        } else {
            let alert = UIAlertController(title: "Saved!",
                message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}

