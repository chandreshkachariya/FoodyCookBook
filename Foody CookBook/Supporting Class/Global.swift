//
//  Global.swift
//  Video Tutor
//
//  Created by Chandresh Kachariya on 14/08/19.
//  Copyright © 2019 Chandresh Kachariya. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

class Global: NSObject {

}

extension CALayer {
    func roundCorners(cornerRadius: Double) {
        self.cornerRadius = CGFloat(cornerRadius)
        self.masksToBounds = true
    }
    
    func roundBorder(cornerRadius: Double, color: UIColor) {
        self.cornerRadius = CGFloat(cornerRadius)
        self.borderColor = color.cgColor;
        self.borderWidth = 1.0
        self.masksToBounds = true
    }
    
    func roundBorder(cornerRadius: Double, color: UIColor, borderWith: Double) {
        self.cornerRadius = CGFloat(cornerRadius)
        self.borderColor = color.cgColor;
        self.borderWidth = CGFloat(borderWith)
        self.masksToBounds = true
    }
}

// MARK : - Extention
public extension String {
    var isEmptyStr:Bool{
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty
    }
    var trimmed:String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var escapedString:String{
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func toDate( dateFormat formate : String ) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate;//"yyyy-MM-dd' 'HH:mm:ss"
        return dateFormatter.date(from: self)!
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    var firstCharacterOfEachWord: String {
        
        let stringInput = self
        let stringInputArr = stringInput.components(separatedBy: " ")
        var stringNeed = ""

        for string in stringInputArr {
            stringNeed = stringNeed + String(string.first!)
        }

        print(stringNeed)
        return stringNeed
    }
    
}

extension Date {
    
    func toString( dateFormat format  : String ) -> String
    {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: Date(timeInterval: seconds, since: self))
    }
    
    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    /*
     // Try it
     let utcDate = Date().toGlobalTime()
     let localDate = utcDate.toLocalTime()
     
     print("utcDate - (utcDate)")
     print("localDate - (localDate)")
     */
}

// MARK : - UIScrollView
extension UIScrollView {
    func scrollsToBottom(animated: Bool) {
        if #available(iOS 11.0, *) {
            let bottomOffset = CGPoint(x: contentOffset.x,
                                       y: contentSize.height - bounds.height + adjustedContentInset.bottom)
            setContentOffset(bottomOffset, animated: animated)
        } else {
            // Fallback on earlier versions
            let bottomOffset: CGPoint = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height + self.contentInset.bottom)
            self.setContentOffset(bottomOffset, animated: true)

        }
    }
}

// MARK : - delay thread
public func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void) {
    let dispatchTime = DispatchTime.now() + seconds
    dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
}
public enum DispatchLevel {
    case main, userInteractive, userInitiated, utility, background
    var dispatchQueue: DispatchQueue {
        switch self {
        case .main:                 return DispatchQueue.main
        case .userInteractive:      return DispatchQueue.global(qos: .userInteractive)
        case .userInitiated:        return DispatchQueue.global(qos: .userInitiated)
        case .utility:              return DispatchQueue.global(qos: .utility)
        case .background:           return DispatchQueue.global(qos: .background)
        }
    }
}


// MARK : - Font
public func getFont(fontName: String, fontSize: CGFloat) -> UIFont {
    return UIFont(name: fontName, size: fontSize)!
}

// MARK : - Email
public func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

public func openLinkInSafari(url: URL) {
    UIApplication.shared.open(url)
}

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size

    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height

    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }

    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage!
}

func getTimesAgo(fromDate: Date, toDate: Date) -> String {

    let difference = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: fromDate, to: toDate)
    
    if difference.year != 0 {
        return String(difference.year!) + " year ago"
    }else if difference.month != 0 {
        return String(difference.month!) + " month ago"
    }else if difference.day != 0 {
        return String(difference.day!) + " day ago"
    }else if difference.hour != 0 {
        return String(difference.hour!) + " hour ago"
    }else if difference.minute != 0 {
        return String(difference.minute!) + " minute ago"
    }else {
        return "Just now"
    }
}

let _str_today = "today"
let _str_yesterday = "yesterday"

public func getLastSeenTodayOrYesterday(messageDate: Date) -> String {
 
    var strLastSeen = ""
    
    let today = Date()
    let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())

    if messageDate.toString(dateFormat: "yyyy-MM-dd").elementsEqual(today.toString(dateFormat: "yyyy-MM-dd")) {
        strLastSeen = "today"
    }else if messageDate.toString(dateFormat: "yyyy-MM-dd").elementsEqual(yesterday!.toString(dateFormat: "yyyy-MM-dd")) {
        strLastSeen = "yesterday"
    }
    
    return strLastSeen
}

func requestAuthorization(completion: @escaping ()->Void) {
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (status) in
                DispatchQueue.main.async {
                    completion()
                }
            }
        } else if PHPhotoLibrary.authorizationStatus() == .authorized{
            completion()
        }
    }



func saveVideoToAlbum(_ outputURL: URL, _ completion: ((Error?) -> Void)?) {
    requestAuthorization {
        
        showProgress()
        
        delay(bySeconds: 0.3) {
            if let url = URL(string: outputURL.absoluteString), let urlData = NSData(contentsOf: url) {
            let galleryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
            let filePath="\(galleryPath)/nameX.mp4"

            urlData.write(toFile: filePath, atomically: true)
                PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL:
                URL(fileURLWithPath: filePath))
            }) {
                success, error in
                    delay(bySeconds: 0.3) {
                        closeProgress()
                    }
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        print("Saved successfully")
                    }
                    completion?(error)
                }
            }
        }
    }
}

func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
    DispatchQueue.global().async { //1
        let asset = AVAsset(url: url) //2
        let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
        avAssetImageGenerator.appliesPreferredTrackTransform = true //4
        let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
        do {
            let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
            let thumbImage = UIImage(cgImage: cgThumbImage) //7
            DispatchQueue.main.async { //8
                completion(thumbImage) //9
            }
        } catch {
            print(error.localizedDescription) //10
            DispatchQueue.main.async {
                completion(nil) //11
            }
        }
    }
}

// MARK: - Merge Video With Audio

func mergeVideoWithAudio(videoUrl: URL,
                                audioUrl: URL,
                                success: @escaping ((URL) -> Void),
                                failure: @escaping ((Error?) -> Void)) {

       let mixComposition: AVMutableComposition = AVMutableComposition()
       var mutableCompositionVideoTrack: [AVMutableCompositionTrack] = []
       var mutableCompositionAudioTrack: [AVMutableCompositionTrack] = []
       let totalVideoCompositionInstruction: AVMutableVideoCompositionInstruction = AVMutableVideoCompositionInstruction()

       let aVideoAsset: AVAsset = AVAsset(url: videoUrl)
       let aAudioAsset: AVAsset = AVAsset(url: audioUrl)

       if let videoTrack = mixComposition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid), let audioTrack = mixComposition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid) {
           mutableCompositionVideoTrack.append( videoTrack )
           mutableCompositionAudioTrack.append( audioTrack )

           if let aVideoAssetTrack: AVAssetTrack = aVideoAsset.tracks(withMediaType: .video).first, let aAudioAssetTrack: AVAssetTrack = aAudioAsset.tracks(withMediaType: .audio).first {
               do {
                   try mutableCompositionVideoTrack.first?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: aVideoAssetTrack.timeRange.duration), of: aVideoAssetTrack, at: CMTime.zero)

                   let videoDuration = aVideoAsset.duration
                   if CMTimeCompare(videoDuration, aAudioAsset.duration) == -1 {
                       try mutableCompositionAudioTrack.first?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: aVideoAssetTrack.timeRange.duration), of: aAudioAssetTrack, at: CMTime.zero)
                   } else if CMTimeCompare(videoDuration, aAudioAsset.duration) == 1 {
                       var currentTime = CMTime.zero
                       while true {
                           var audioDuration = aAudioAsset.duration
                           let totalDuration = CMTimeAdd(currentTime, audioDuration)
                           if CMTimeCompare(totalDuration, videoDuration) == 1 {
                               audioDuration = CMTimeSubtract(totalDuration, videoDuration)
                           }
                           try mutableCompositionAudioTrack.first?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: aVideoAssetTrack.timeRange.duration), of: aAudioAssetTrack, at: currentTime)

                           currentTime = CMTimeAdd(currentTime, audioDuration)
                           if CMTimeCompare(currentTime, videoDuration) == 1 || CMTimeCompare(currentTime, videoDuration) == 0 {
                               break
                           }
                       }
                   }
                   videoTrack.preferredTransform = aVideoAssetTrack.preferredTransform

               } catch {
                   print(error)
               }

               totalVideoCompositionInstruction.timeRange = CMTimeRangeMake(start: CMTime.zero, duration: aVideoAssetTrack.timeRange.duration)
           }
       }

       let mutableVideoComposition: AVMutableVideoComposition = AVMutableVideoComposition()
       mutableVideoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
       mutableVideoComposition.renderSize = CGSize(width: 480, height: 640)

       if let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
           let outputURL = URL(fileURLWithPath: documentsPath).appendingPathComponent("\("fileName").m4v")

           do {
               if FileManager.default.fileExists(atPath: outputURL.path) {

                   try FileManager.default.removeItem(at: outputURL)
               }
           } catch { }

           if let exportSession = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality) {
               exportSession.outputURL = outputURL
               exportSession.outputFileType = AVFileType.mp4
               exportSession.shouldOptimizeForNetworkUse = true

               // try to export the file and handle the status cases
               exportSession.exportAsynchronously(completionHandler: {
                   switch exportSession.status {
                   case .failed:
                       if let error = exportSession.error {
                           failure(error)
                       }

                   case .cancelled:
                       if let error = exportSession.error {
                           failure(error)
                       }

                   default:
                       print("finished")
                       success(outputURL)
                   }
               })
           } else {
               failure(nil)
           }
       }
   }

// MARK: - Extract Audio From Video

func extractAudiofromVideo(videoUrl: URL,
                                success: @escaping ((URL) -> Void),
                                failure: @escaping ((Error?) -> Void)) {
    
    if let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
        let outputURL = URL(fileURLWithPath: documentsPath).appendingPathComponent("\("fileName").m4a")

        do {
            if FileManager.default.fileExists(atPath: outputURL.path) {

                try FileManager.default.removeItem(at: outputURL)
            }
        } catch { }

        let asset = AVURLAsset(url: videoUrl.absoluteURL, options: nil)
        let pathWhereToSave = outputURL.absoluteString
        asset.writeAudioTrackToURL(URL.init(string: pathWhereToSave)!) { (succeed, error) -> () in
            if !succeed {
                print(error as Any)
                failure(error)
            }else {
                success(outputURL)
            }
        }
        
    }
    
}
