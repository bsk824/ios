//
//  KeyboardMonitor.swift
//  test
//
//  Created by 백승기 on 2022/03/26.
//

import Foundation
import Combine
import UIKit

final class KeyboardMonitor : ObservableObject {
    enum Status {
        case show, hide
        var description : String {
            switch self {
            case .show: return "show"
            case .hide: return "hide"
            }
        }
    }
    var subscriptions = Set<AnyCancellable>()
    
    @Published var updatedKeyboardStatusAction : Status = .hide
    @Published var keyboardHeight : CGFloat = 0.0
    
    init() {        
        NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
            .sink{ (noti : Notification) in
                self.updatedKeyboardStatusAction = .show
            }
            .store(in: &subscriptions)
        
        NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
            .sink{ (noti : Notification) in
                self.updatedKeyboardStatusAction = .hide
                self.keyboardHeight = 0.0
            }
            .store(in: &subscriptions)

        NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillChangeFrameNotification)
            .sink{ (noti : Notification) in
                let keyboard = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                
                self.keyboardHeight = keyboard.height
            }
            .store(in: &subscriptions)
    }
}
