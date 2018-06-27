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

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data, options: [])
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

var endpointClosure = { (target: MeheAPI) -> Endpoint<MeheAPI> in
    let endpoint: Endpoint<MeheAPI> = Endpoint<MeheAPI>(URL: url(target), sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
    
    
    switch target {
    case .xAuth(let cred):
        return endpoint.endpointByAddingHTTPHeaderFields(["Authorization": "\(cred)"])
    default:
        print("Nothing")
    }
    
    return endpoint
}

let MeheProvider = RxMoyaProvider<MeheAPI>(endpointClosure: endpointClosure, plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

enum MeheAPI {
    // MARK: User
    case xAuth(credentials: Data)
    case authWithNumber(number: String)
    case signupWithNumber(name: String, email: String, number: String, photo: Data?)
    case updateMe(name: String, email: String, token: String)
    
    // MARK: Groups
    case groupList(token: String)
    case groupJoin(groupID: String, token: String)
    case groupFeed(groupID: String, token: String)
}

extension MeheAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.mehe.io")!
    }
    
    var path: String {
        switch self {
        case .xAuth(_):
            return "api/v1/auth/check_credentials"
        case .authWithNumber:
            return "/api/v1/auth/signin"
        case .signupWithNumber:
            return "/api/v1/auth/signup"
        case .updateMe:
            return "/api/v1/user/update"
            
        case .groupList:
            return "/api/v1/groups/list"
        case .groupJoin:
            return "/api/v1/groups/join"
        case .groupFeed(let groupID, _):
            return "api/v1/groups/feed/\(groupID)"
        }
    }
    
    var parameters: [String: AnyObject]? {
        switch self {
        case .xAuth(let cred):
            return ["data": cred as AnyObject]
        case .authWithNumber(let number):
            return ["type": "phone" as AnyObject,
                "number": number as AnyObject
            ]
        case .signupWithNumber(let number, let name, let email, _):
            
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
            return data as [String : AnyObject]
        case .updateMe(let name, let email, let token):
            return ["name": name as AnyObject,
            "email": email as AnyObject,
            "token": token as AnyObject
            ]
            
        case .groupFeed(_, let token):
            return ["token": token as AnyObject]
        case .groupList(let token):
            return ["token": token as AnyObject]
        case .groupJoin(let groupID, let token):
            return ["groupID": groupID as AnyObject,
                "token": token as AnyObject
            ]
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .POST
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

func url(_ route: TargetType) -> String {
    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
}
