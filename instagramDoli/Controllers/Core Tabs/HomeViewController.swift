//
//  ViewController.swift
//  instagramDoli
//
//  Created by Nicolas Dolinkue on 25/03/2023.
//
import FirebaseAuth
import UIKit

struct HomeFeedReenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}


class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedReenderViewModel]()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHearderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHearderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        createMockModels()
    }
    
    private func createMockModels() {
        for x in 0..<5 {
            let user = User(username: "jose", bio: "", name: (first: "", last: ""), birthDate: Date(), gender: .male, counts: UserCount(followers: 1, followings: 1, post: 1), joinDate: Date(), profilePhoto: URL(string: "https://www.google.com")!)
            let post = UserPost(indentifier: "", postType: .photo, thumbnailImage: URL(string: "https://www.google.com")!, postURL: URL(string: "https://www.google.com")!, caption: nil, likeCount: [], comments: [], createDate: Date(), taggedUsers: [], owner: user)
            var commets = [PostComment]()
            for x in 0..<2 {
                commets.append(PostComment(identifier: "\(x)", username: "@nico", text: "el mejor", createdDate: Date(), likes: []))
            }
            let viewModel = HomeFeedReenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                     post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                     actions: PostRenderViewModel(renderType: .actions(provider: "")),
                                                     comments: PostRenderViewModel(renderType: .comments(comments: commets)))
            feedRenderModels.append(viewModel)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()

    }
    
    private func handleNotAuthenticated() {
        //chek auth status
        if Auth.auth().currentUser == nil {
            // show log in
            let loginVc = LoginViewController()
            loginVc.modalPresentationStyle = .fullScreen
            present(loginVc, animated: false)
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: HomeFeedReenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }

        let subSection = x % 4
        
        if subSection == 0 {
            // header
            return 1
        } else if subSection == 1 {
            // post
            return 1
        } else if subSection == 2 {
            //actions
            return 1
        } else if subSection == 3 {
            //comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments): return comments.count > 2 ? 2 : comments.count
            case .header, .actions, .primaryContent: return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedReenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            // header
            let headerModel = model.header
            switch headerModel.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHearderTableViewCell.identifier, for: indexPath) as! IGFeedPostHearderTableViewCell
                return cell
            case .comments, .actions, .primaryContent: return UITableViewCell()
            }
        } else if subSection == 1 {
            // post
            let postModel = model.post
            switch postModel.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                return cell
            case .comments, .actions, .header: return UITableViewCell()
            }
        } else if subSection == 2 {
            //actions
            let actionsModel = model.actions
            switch actionsModel.renderType {
            case .actions(let action):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                return cell
            case .comments, .primaryContent, .header: return UITableViewCell()
            }
        } else if subSection == 3 {
            //comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
            case .actions, .primaryContent, .header: return UITableViewCell()

            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let subSection = indexPath.section % 4
        
        if subSection == 0 {
            return 70
        }
        else if subSection == 1 {
            return tableView.width
        }
        else if subSection == 2 {
            return 60
        }
        else if subSection == 3 {
            return 50
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subSection = section % 4
        
        return subSection == 3 ? 70 : 0
    }
}
