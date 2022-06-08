//
//  ViewController.swift
//  ZemogaTest
//
//  Created by Jose Valero Vegazo on 5/06/22.
//

import UIKit

class StartController: UIViewController {
    
    private let manager = CoreDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        startView()
    }

    func startView(){
        
        let data = self.manager.fetchPost()
        if(data.count == 0){
            
            let group = DispatchGroup()
            group.enter()
            Services.requestArray(url: Constants.URL_GET_POSTS, method: Constants.GET) {data in
                for dat in data{
                    var post = Posts()
                    post.id = dat["id"] as! Int
                    post.title = dat["title"] as! String
                    post.author = dat["author"] as! String
                    post.body = dat["body"] as! String
                    post.favorite = false
                    self.manager.insertPost(posts: post) {}
                }
                group.leave()

            }
            
            group.enter()
            Services.requestArray(url: Constants.URL_GET_PROFILE, method: Constants.GET) {data in
                for dat in data{
                    var pro = Profiles()
                    pro.name = dat["name"] as! String
                    pro.email = dat["email"] as! String
                    pro.phone = dat["phone"] as! String
                    pro.website = dat["website"] as! String
                    self.manager.insertProfile(profiles: pro){}
                }
                group.leave()
            }
            
            group.enter()
            Services.requestArray(url: Constants.URL_GET_COMMENTS, method: Constants.GET) {data in
                for dat in data{
                    var com = Comment()
                    com.id = dat["id"] as! Int
                    com.body = dat["body"] as! String
                    com.postId = dat["postId"] as! Int
                    self.manager.insertComment(comment: com) {}
                }
                group.leave()

            }
            
            group.notify(queue: .main){
                self.performSegue(withIdentifier: "startToHome", sender: self)
                
            }
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.performSegue(withIdentifier: "startToHome", sender: self)
            }
        }
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "startToHome") {
            let Homecontroller = segue.destination as? HomeController
            Homecontroller?.dismiss(animated: false, completion: nil)
        }
    }*/
}

