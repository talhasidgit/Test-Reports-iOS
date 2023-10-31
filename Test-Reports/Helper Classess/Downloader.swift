//
//  Downloader.swift
//  QRI App
//
//  Created by Mazhar on 09/08/2021.
//

import Foundation
class Downloader {
    class func load(URL: URL) {
        let sessionConfig = URLSessionConfiguration.default
        let session = Foundation.URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        let task = session.downloadTask(with: request) { (url, response, error) in
            guard let origionalUrl = url else {
                return
            }
        }
        task.resume()
    }
    func URLSession(session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        // println("download task did write data")

        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)

        DispatchQueue.main.async {
            print(progress)
        }
    }
}
