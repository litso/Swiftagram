//
//  HttpClient.swift
//  Swiftagram
//
//  Created by Robert Manson on 8/1/14.
//  Copyright (c) 2014 Robert Manson. All rights reserved.
//

import UIKit

// Class variables not yet supported
let _HttpClientSharedInstance = HttpClient()

class HttpClient: AFHTTPSessionManager {
    class var sharedInstance : HttpClient {
    return _HttpClientSharedInstance
    }
    init(baseURL url: NSURL!) {
        super.init(baseURL: url, sessionConfiguration: nil)
        self.responseSerializer = AFJSONResponseSerializer()
        self.requestSerializer = AFJSONRequestSerializer()
    }
    convenience init() {
        let apiUrl = NSURL.URLWithString("https://api.instagram.com/v1/")
        self.init(baseURL: apiUrl)
    }
    func imagesAtLat(lat: Float, lng: Float, onError: ((NSError) -> Void), onSuccess:(([ISImage]) -> Void)) {
        let params = [
            "client_id": Secrets.clientId,
            "lat": "\(lat)",
            "lng": "\(lng)",
            "distance": "8.0"
        ]
        self.GET("media/search", parameters: params, success: {task, result in
                onSuccess([])
            }, failure: {task, error in
                onError(error)
            })
    }
}
