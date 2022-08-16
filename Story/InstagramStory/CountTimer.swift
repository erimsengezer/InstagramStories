//
//  CountTimer.swift
//  Instagram_Stories
//
//  Created by Erim Şengezer on 11.08.2022.
//

import Foundation
import Combine


class CountTimer: ObservableObject {
    @Published var progress: Double
    var dismiss: (() -> Void)?
    private var interval: TimeInterval
    private var max: Int
    private let publisher: Timer.TimerPublisher
    private var cancellable: Cancellable?
    
    init(items: Int, interval: TimeInterval, dismiss: (() -> Void)?) {
        self.max = items
        self.progress = 0
        self.interval = interval
        self.publisher = Timer.publish(every: 0.1, on: .main, in: .default)
        self.dismiss = dismiss
    }
    
    func start() {
        self.cancellable = self.publisher.autoconnect().sink(receiveValue: {_ in
            var newProgres = self.progress + (0.1 / self.interval)
            if Int(newProgres) >= self.max {
                newProgres = 0
                self.dismiss!()
            }
            self.progress = newProgres
        })
    }
    
    func advancePage(by number: Int) {
        let newProgress = Swift.max((Int(self.progress) + number) % self.max, 0)
        self.progress = Double(newProgress)
    }
}
