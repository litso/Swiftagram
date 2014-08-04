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
            switch Response(response: result) {
            case .Data(let dataArray):
                let images = ISImage.imagesFromArray(dataArray) as [AnyObject] as [ISImage]
                onSuccess(images)
            case .Error(let error):
                onError(error)
            }
            },
            failure: {task, error in
                onError(error)
            })
    }
    enum Response {
        case Data([AnyObject])
        case Error(NSError)
        
        init (response: AnyObject?) {
            let unknownErrorUserInfo: [String: String] = [NSLocalizedFailureReasonErrorKey: "Unexpected server error"]
            func getError(code: Int, userInfo: [String: String]) -> NSError {
                return NSError.errorWithDomain("SwiftagramDomain", code: code, userInfo: userInfo)
            }
            func getErrorCode(dictionary: DictionaryWrap) -> Int {
                if let errorCode = dictionary.dictionary("meta")?.int("code") {
                    return errorCode
                }
                else {
                    return -1
                }
            }
            func getUserInfo(dictionary: DictionaryWrap) -> [String: String] {
                var result: [String: String] = [:]
                if let errorMessage = dictionary.dictionary("meta")?.string("error_message") {
                    result[NSLocalizedFailureReasonErrorKey] = errorMessage
                }
                if let errorType = dictionary.dictionary("meta")?.string("error_type") {
                    result["error_type"] = errorType
                }
                return result
            }
            if let responseDictionary = response as? [String: AnyObject] {
                let wrappedResponse = DictionaryWrap(dict: responseDictionary)
                let errorCode = getErrorCode(wrappedResponse)
                if errorCode == 200 {
                    // Now get the data
                    if let dataArray = wrappedResponse.array("data")?.originalArray {
                        self = .Data(dataArray)
                    }
                    else {
                        // Correct error code but no data...
                        self = .Error(getError(-1, unknownErrorUserInfo))
                    }
                }
                else {
                    self = .Error(getError(errorCode, getUserInfo(wrappedResponse)))
                }
            }
            else {
                self = .Error(getError(-1, unknownErrorUserInfo))
            }
        }
    }
}
