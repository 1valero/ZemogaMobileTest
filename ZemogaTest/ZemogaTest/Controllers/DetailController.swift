//
//  DetailController.swift
//  ZemogaTest
//
//  Created by Jose Valero Vegazo on 6/06/22.
//

import UIKit

class DetailController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let manager = CoreDataManager()
    var postSelected:Posts!
    var commentsArray:[Comment] = []
    var profiles:Profiles = Profiles()

    @IBOutlet weak var tableViewComments: UITableView!
    @IBOutlet weak var txtViewPlainDescription: UITextView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lbblPhone: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startView()
    }
    
    func startView(){
        setNavigation()
        let data = self.manager.fetchCommentXId(id: postSelected.id)
        for dat in data {
            var com = Comment()
            com.id = Int(dat.id)
            com.body = dat.body ?? ""
            commentsArray.append(com)
        }
        
        let dataPro = self.manager.fetchProfiletXName(name: postSelected.author)
        for dat in dataPro {
            profiles.name = dat.name ?? ""
            profiles.email = dat.email ?? ""
            profiles.phone = dat.phone ?? ""
            profiles.website = dat.website ?? ""
        }
        
        txtViewPlainDescription.text = postSelected.body
        lblName.text = profiles.name
        lblEmail.text = profiles.email
        lbblPhone.text = profiles.phone
        lblWebsite.text = profiles.website
        
        tableViewComments.reloadData()
        
    }

    func setNavigation(){
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        var img = "star"
        if postSelected.favorite {
           img = "star.fill"
        }
        let starButton = UIBarButtonItem(image: UIImage(systemName: img) , style: .plain, target: self, action: #selector(addTappedStar(_:)))
        let trashButton = UIBarButtonItem(image: UIImage(systemName: "trash") , style: .plain, target: self, action: #selector(addTappedTrash(_:)))
        
        self.navigationItem.rightBarButtonItems = [starButton, trashButton]
    }
    
    @objc func addTappedStar(_ sender: UIBarButtonItem){
        postSelected.favorite = !postSelected.favorite
        var img = "star"
        if postSelected.favorite {
           img = "star.fill"
        }
        sender.image =  UIImage(systemName: img)
        manager.updatePost(posts: postSelected, completion: {})
    }
    
    @objc func addTappedTrash(_ sender: UIBarButtonItem){
        
        let alert = UIAlertController(title: "Delete", message: "Do you want to delete this post?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            switch action.style{
                case .default:
                    self.manager.deletePost(posts: self.postSelected, completion: { isDelete in
                        if isDelete{
                            self.navigationController?.popViewController(animated: true)
                        }else{
                            alert.dismiss(animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewComments", for: indexPath) as! CommentsTableViewCell
             
        let com = commentsArray[indexPath.row]
         
        cell.lblComment?.text = com.body
         
        return cell
    }
    
}
