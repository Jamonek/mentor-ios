//
//  UserManager.swift
//  Mehe
//
//  Created by Jamone Alexander Kelly on 3/2/16.
//  Copyright © 2016 Mehe. All rights reserved.
//

import RxSwift
import Moya
 
enum AuthState {
   case Success
    case Error(String)
    case None
}
 
struct UserManager {
    
    let userStatus = Variable(AuthState.None)
    
    static func credCheck(credentials: [NSObject: AnyObject]) -> Observable<AuthState?> {
        let jsonData = try! NSJSONSerialization.dataWithJSONObject(credentials, options: NSJSONWritingOptions.PrettyPrinted)
        return Observable.create { observe in
            MeheProvider.request(.XAuth(credentials: jsonData)).subscribe { (event) -> Void in
                switch event {
                case .Next(let response):
                    print(response.data)
                    observe.on(.Next(nil))
                case .Error(let msg):
                    print(msg)
                case .Completed:
                    print("Complete")
                }
            }
        }
    }
    
    static func login(number: String) -> Observable<AuthState> {
        return Observable.create { observe in
            MeheProvider.request(MeheAPI.AuthWithNumber(number: number)).subscribe { event -> Void in
                
                switch event {
                case .Next(_):
                    print("Mehe login next")
                case .Error(_):
                    print("Mehe login error")
                case .Completed:
                    print("Mehe login completed")
                }
            }
        }
    }
    
    static func signup(name: String, email: String, number: String, photo: UIImage? = nil) -> Observable<AuthState> {
        return Observable.create { observe in
            
            MeheProvider.request(MeheAPI.SignupWithNumber(name: name, email: email, number: number, photo: nil)).subscribe { event -> Void in
                
                switch event {
                case .Next(_):
                    print("Mehe signup next")
                case .Error(_):
                    print("Mehe signup error")
                case .Completed:
                    print("Mehe signup complete")
                }
            }
        }
    }
}
