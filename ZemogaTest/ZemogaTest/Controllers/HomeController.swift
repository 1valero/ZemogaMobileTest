//
//  HomeController.swift
//  ZemogaTest
//
//  Created by Jose Valero Vegazo on 6/06/22.
//

import UIKit

class HomeController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let manager = CoreDataManager()
    var postArray:[Posts] = []
    var postSelected:Posts = Posts()
    var commentArray:[Comment] = []
    var profilesArray:[Profiles] = []

    @IBOutlet weak var tableViewPosts: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startView()
    }
    
    func startView(){
        setNavigation()
        getFechPost()
    }
    
    func getFechPost(){
        postArray = []
        let data = self.manager.fetchPost()
        for dat in data {
            var post = Posts()
            post.id = Int(dat.id)
            post.title = dat.title ?? ""
            post.author = dat.author ?? ""
            post.body = dat.body ?? ""
            post.favorite = dat.favorite
            postArray.append(post)
        }
    }
    func setNavigation(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise") , style: .plain, target: self, action: #selector(addTappedLoad(_:)))
    }
    
    func loadData(){
        let group = DispatchGroup()
        group.enter()
        Services.requestArray(url: Constants.URL_GET_POSTS, method: Constants.GET) {data in
            for dat in data{
                let id = dat["id"] as! Int
                if self.postArray.contains(where: {$0.id == id}) {
                }else{
                    var post = Posts()
                    post.id = dat["id"] as! Int
                    post.title = dat["title"] as! String
                    post.author = dat["author"] as! String
                    post.body = dat["body"] as! String
                    post.favorite = false
                    self.manager.insertPost(posts: post) {}
                }
            }
            group.leave()

        }
        
        let data = self.manager.fetchProfiles()
        for dat in data {
            var pro = Profiles()
            pro.name = dat.name ?? ""
            pro.email = dat.email ?? ""
            pro.phone = dat.phone ?? ""
            pro.website = dat.website ?? ""
            profilesArray.append(pro)
        }
        
        group.enter()
        Services.requestArray(url: Constants.URL_GET_PROFILE, method: Constants.GET) {data in
            for dat in data{
                let name = dat["name"] as! String
                if self.profilesArray.contains(where: {$0.name == name}) {
                }else{
                    var pro = Profiles()
                    pro.name = dat["name"] as! String
                    pro.email = dat["email"] as! String
                    pro.phone = dat["phone"] as! String
                    pro.website = dat["website"] as! String
                    self.manager.insertProfile(profiles: pro){}
                }
            }
            group.leave()
        }
        
        let dataCom = self.manager.fetchComment()
        for dat in dataCom {
            var com = Comment()
            com.id = Int(dat.id)
            com.body = dat.body ?? ""
            com.postId = Int(dat.postId)
            commentArray.append(com)
        }
        
        group.enter()
        Services.requestArray(url: Constants.URL_GET_COMMENTS, method: Constants.GET) {data in
            for dat in data{
                let id = dat["id"] as! Int
                if self.commentArray.contains(where: {$0.id == id}) {
                }else{
                    var com = Comment()
                    com.id = dat["id"] as! Int
                    com.body = dat["body"] as! String
                    com.postId = dat["postId"] as! Int
                    self.manager.insertComment(comment: com) {}
                }
            }
            group.leave()

        }
        
        group.notify(queue: .main){
            self.getFechPost()
            self.tableViewPosts.reloadData()
        }
        
        
    }
    
    @objc func addTappedLoad(_ sender: UIBarButtonItem){
        loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewPosts", for: indexPath) as! PostTableViewCell
        let post = postArray[indexPath.row]
        cell.lblTitle?.text = post.title
        if post.favorite {
            cell.imgView.image = UIImage(systemName: "star.fill")
        }else{
            cell.imgView.image = UIImage(systemName: "circle.fill")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        postSelected = postArray[indexPath.row]
        self.performSegue(withIdentifier: "HomeToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "HomeToDetail") {
            let detailController = segue.destination as? DetailController
            detailController?.postSelected = postSelected
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFechPost()
        tableViewPosts.reloadData()
    }
    
    @IBAction func btnDeleteAll(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete All", message: "Do you want to delete all posts?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            switch action.style{
                case .default:
                    self.manager.deleteAllPost(completion: { isDelete in
                        if isDelete {
                            self.getFechPost()
                            self.tableViewPosts.reloadData()
                        }
                        
                    })
            case .cancel:
                Utils.dump(text: "cancel")
            case .destructive:
                Utils.dump(text: "destructive")
            @unknown default:
                Utils.dump(text: "error")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
       
    }
    
}
