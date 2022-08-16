//
//  StoryViewController.swift
//  Story
//
//  Created by Erim Şengezer on 11.08.2022.
//


import SwiftUI

protocol StoryViewControllerDelegate: AnyObject {
    func countTimerDismiss()
}

final class StoryViewController: UIHostingController<ContentView> {
    
    weak var delegate: StoryViewControllerDelegate?
    
    init(contentView: ContentView, title: String) {
        super.init(rootView: contentView)
        rootView.dismiss = dismiss
        rootView.countTimer.dismiss = countTimerDismiss
        rootView.title = title
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: ContentView())
        rootView.dismiss = dismiss
    }

    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func countTimerDismiss() {
        dismiss()
        delegate?.countTimerDismiss()
    }
}
