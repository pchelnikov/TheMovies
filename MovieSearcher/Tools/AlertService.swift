//
//  AlertService.swift
//  MovieSearcher
//
//  Created by Mikhail Pchelnikov on 11/06/2018.
//  Copyright © 2018 Michael Pchelnikov. All rights reserved.
//

import UIKit

public enum AlertYesNoActionType {
    case yes, no
}

public enum AlertAction {
    case cancel, destructive, other(Int), yesNo(AlertYesNoActionType)
}

public enum AlertStyle {
    case one(String), many([String]), cancelable([String]), destructive(String), yesNo, none
}

public typealias AlertResult = (AlertAction) -> Void

/**
 Convenient factory method for UIAlertController usage.
 
 - parameter parent: The parent View Controller, where we want to show an alert.
 - parameter title: Alert title.
 - parameter message: Main alert message.
 - parameter style: Custom alert style (like cancelable, yes/no etc.)
 - parameter preferredStyle: UIAlertControllerStyle
 - parameter isPreferredFirstAction: Define preferredAction of an UIAlertController.
 - parameter handler: Callback result handler.
 */
public func showAlertController(_ parent: UIViewController, title: String?, message: String?, style: AlertStyle, preferredStyle: UIAlertController.Style = .alert, isPreferredFirstAction: Bool = false, handler: AlertResult?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
    
    var actions = [UIAlertAction]()
    
    let cancel = UIAlertAction(title: "Отмена", style: .cancel) { _ in
        handler?(.cancel)
    }
    
    switch style {
    case let .one(title):
        let action = UIAlertAction(title: title, style: .default, handler: { _ in
            handler?(.cancel)
        })
        actions.append(action)
    case let .many(titles):
        for i in 0..<titles.count {
            let title = titles[i]
            let action = UIAlertAction(title: title, style: .default) { _ in
                handler?(.other(i))
            }
            actions.append(action)
        }
    case let .cancelable(titles):
        for i in 0..<titles.count {
            let title = titles[i]
            let action = UIAlertAction(title: title, style: .default) { _ in
                handler?(.other(i))
            }
            actions.append(action)
        }
        
        actions.append(cancel)
    case let .destructive(title):
        actions.append(cancel)
        
        let remove = UIAlertAction(title: title, style: .destructive) { _ in
            handler?(.destructive)
        }
        actions.append(remove)
    case .yesNo:
        for i in 0..<2 {
            let action = UIAlertAction(title: i == 0 ? "Yes" : "No", style: .default) { _ in
                handler?(i == 0 ? .yesNo(.yes) : .yesNo(.no))
            }
            actions.append(action)
        }
    case .none: break
    }
    
    actions.forEach(alert.addAction)
    
    if isPreferredFirstAction && actions.count > 0 {
        alert.preferredAction = actions[0]
    }
    
    parent.present(alert, animated: true, completion: nil)
}
