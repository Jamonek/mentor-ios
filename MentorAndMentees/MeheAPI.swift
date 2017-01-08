//
//  MeheAPI.swift
//  Mehe
//
//  Created by Jamone Alexander Kelly on 3/5/16.
//  Copyright © 2016 Mehe. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire

private func JSONResponseDataFormatter(data: NSData) -> NSData {
    do {
        let dataAsJSON = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        let prettyData =  try NSJSONSerialization.dataWithJSONObject(dataAsJSON, options: .PrettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

var endpointClosure = { (target: MeheAPI) -> Endpoint<MeheAPI> in
    let endpoint: Endpoint<MeheAPI> = Endpoint<MeheAPI>(URL: url(target), sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
    
    
    switch target {
    case .XAuth(let cred):
        return endpoint.endpointByAddingHTTPHeaderFields(["Authorization": "\(cred)"])
    default:
        print("Nothing")
    }
    
    return endpoint
}

let MeheProvider = RxMoyaProvider<MeheAPI>(endpointClosure: endpointClosure, plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

enum MeheAPI {
    // MARK: User
    case XAuth(credentials: NSData)
    case AuthWithNumber(number: String)
    case SignupWithNumber(name: String, email: String, number: String, photo: NSData?)
    case UpdateMe(name: String, email: String, token: String)
    
    // MARK: Groups
    case GroupList(token: String)
    case GroupJoin(groupID: String, token: String)
    case GroupFeed(groupID: String, token: String)
}

extension MeheAPI: TargetType {
    
    var baseURL: NSURL {
        return NSURL(string: "https://api.mehe.io")!
    }
    
    var path: String {
        switch self {
        case .XAuth(_):
            return "api/v1/auth/check_credentials"
        case .AuthWithNumber:
            return "/api/v1/auth/signin"
        case .SignupWithNumber:
            return "/api/v1/auth/signup"
        case .UpdateMe:
            return "/api/v1/user/update"
            
        case .GroupList:
            return "/api/v1/groups/list"
        case .GroupJoin:
            return "/api/v1/groups/join"
        case .GroupFeed(let groupID, _):
            return "api/v1/groups/feed/\(groupID)"
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .XAuth(let cred):
            return ["data": cred]
        case .AuthWithNumber(let number):
            return ["type": "phone",
                "number": number
            ]
        case .SignupWithNumber(let number, let name, let email, _):
            
            let data = ["type": "phone",
                "number": number,
                "name": name,
                "email": email
            ]
            /*
            if let profilePic = photo {
                data["photo"] = profilePic
            }
            */
            return data
        case .UpdateMe(let name, let email, let token):
            return ["name": name,
            "email": email,
            "token": token
            ]
            
        case .GroupFeed(_, let token):
            return ["token": token]
        case .GroupList(let token):
            return ["token": token]
        case .GroupJoin(let groupID, let token):
            return ["groupID": groupID,
                "token": token
            ]
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .POST
        }
    }
    
    var sampleData: NSData {
        switch self {
        default:
            return NSData()
        }
    }
}

private extension String {
    var URLEscapedString: String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
    }
}

func url(route: TargetType) -> String {
    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
}