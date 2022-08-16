//
//  ViewController.swift
//  Story
//
//  Created by Erim Şengezer on 11.08.2022.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    let images = ["images1","images2","images3","images4"]
    let images2 = ["images4","images3","images2","images1"]
    
    var stories = [StoryModel]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentStoryIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        stories = [ StoryModel(name: "Kampanyalar", profileImage: "image1", images: images, isSeen: false),
                        StoryModel(name: "Otel", profileImage: "image1", images: images2, isSeen: false),
                        StoryModel(name: "Transfer", profileImage: "image1", images: images, isSeen: false),
                        StoryModel(name: "Uçuş", profileImage: "image1", images: images2, isSeen: false),
                        StoryModel(name: "Uçuş", profileImage: "image1", images: images, isSeen: false),
                        StoryModel(name: "Uçuş", profileImage: "image1", images: images2, isSeen: false),
                        StoryModel(name: "Uçuş", profileImage: "image1", images: images, isSeen: false)]
        
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(storyChange), name: NSNotification.Name.init("StoryChange"), object: nil)
    }

    private func configureCollectionView() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: "StoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoryCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc private func storyChange() {
        
    }
    
    private func presentStory(indexPath: IndexPath) {
        let contentView = ContentView(dismiss: nil, images: stories[indexPath.row].images, countTimer: CountTimer(items: stories[indexPath.row].images.count, interval: 4, dismiss: nil))
        let storyView = StoryViewController(contentView: contentView, title: stories[indexPath.row].name)
        storyView.modalPresentationStyle = .fullScreen
        storyView.delegate = self
        self.present(storyView, animated: true)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentStory(indexPath: indexPath)
        self.currentStoryIndex = indexPath.row
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as? StoryCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(imageString: self.stories[indexPath.row].images.first ?? "")
        return cell
    }
}

extension ViewController: StoryViewControllerDelegate {
    func countTimerDismiss() {
        let nextStoryIndex = currentStoryIndex + 1
        print("First Image Name: \(stories[currentStoryIndex].images.first), Next Index: \(nextStoryIndex)")
        if nextStoryIndex <= stories.count {
            let contentView = ContentView(dismiss: nil, images: stories[nextStoryIndex].images, countTimer: CountTimer(items: stories[nextStoryIndex].images.count, interval: 4, dismiss: nil))
            let storyView = StoryViewController(contentView: contentView, title: stories[nextStoryIndex].name)
            storyView.modalPresentationStyle = .fullScreen
            self.present(storyView, animated: true)
            currentStoryIndex += 1
        }
    }
}
