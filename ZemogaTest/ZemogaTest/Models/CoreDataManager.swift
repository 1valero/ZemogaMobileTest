//
//  CoreData.swift
//  ZemogaTest
//
//  Created by Jose Valero Vegazo on 6/06/22.
//

import UIKit
import CoreData

class CoreDataManager{
    
    private let container : NSPersistentContainer!

    init() {
        container = NSPersistentContainer(name: "ModelDB")
        setupDB()
        
    }
    
    private func setupDB(){
        container.loadPersistentStores { (desc, error) in
                if let error = error {
                    print("Error loading store \(desc) — \(error)")
                    return
                }
                print("Database ready!")
            
        }
    }
    
    
    func insertPost(posts:Posts, completion: @escaping()-> Void){
        
        let context = container.viewContext
          
        let post = Post(context: context)
        post.id = Int16(posts.id)
        post.title = posts.title
        post.author = posts.author
        post.body = posts.body
        post.favorite = posts.favorite
        
        do {
            try context.save()
            completion()
        } catch {
            Utils.dump(text: error)
        }
        
    }
    
    func insertComment(comment:Comment, completion: @escaping()-> Void){
        
        let context = container.viewContext
          
        let com = Comments(context: context)
        com.id = Int16(comment.id)
        com.body = comment.body
        com.postId = Int16(comment.postId)
        
        do {
            try context.save()
            completion()
        } catch {
            Utils.dump(text: error)
        }
        
    }
    
    func insertProfile(profiles:Profiles, completion: @escaping()-> Void){
        
        let context = container.viewContext
          
        let pro = Profile(context: context)
        pro.name = profiles.name
        pro.email = profiles.email
        pro.phone = profiles.phone
        pro.website = profiles.website
        
        do {
            try context.save()
            completion()
        } catch {
            Utils.dump(text: error)
        }
        
    }
    
    func updatePost(posts:Posts, completion: @escaping()-> Void){
        let context = container.viewContext
        let fetchRequest : NSFetchRequest<Post> = Post.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %i", posts.id)

        do{
            let results = try context.fetch(fetchRequest)
                if results.count != 0 {
                    let update = results[0]
                    update.favorite =  posts.favorite
                    try context.save()
                        completion()
                }
        } catch{
            Utils.dump(text: error)
        }
    }
    
    func deletePost(posts:Posts, completion: @escaping(Bool)-> ()){
        let context = container.viewContext
        let fetchRequest : NSFetchRequest<Post> = Post.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %i", posts.id)

        do{
            let results = try context.fetch(fetchRequest)
                if results.count != 0 {
                    let delete = results[0]
                    context.delete(delete)
                    try context.save()
                        completion(true)
                }
        } catch{
            Utils.dump(text: error)
        }
        completion(false)
    }
    
    func deleteAllPost(completion: @escaping(Bool)-> ()){
        let context = container.viewContext
        let fetchRequest : NSFetchRequest<Post> = Post.fetchRequest()
        do{
            let results = try context.fetch(fetchRequest)
                if results.count != 0 {
                    for res in results {
                        context.delete(res)
                    }
                    try context.save()
                    completion(true)
                }
        } catch{
            Utils.dump(text: error)
        }
        completion(false)
    }
    
    func fetchPost() -> [Post] {
        let fetchRequest : NSFetchRequest<Post> = Post.fetchRequest()
        let favorite = NSSortDescriptor(key:"favorite", ascending:false)
        fetchRequest.sortDescriptors = [favorite]
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            return result
        } catch {
            print(error)
         }
         return []
    }
    
    func fetchComment() -> [Comments] {
        let fetchRequest : NSFetchRequest<Comments> = Comments.fetchRequest()
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            return result
        } catch {
            print(error)
         }
         return []
    }
    
    func fetchProfiles() -> [Profile] {
        let fetchRequest : NSFetchRequest<Profile> = Profile.fetchRequest()
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            return result
        } catch {
            print(error)
         }
         return []
    }
    
    func fetchCommentXId(id:Int) -> [Comments] {
        let fetchRequest : NSFetchRequest<Comments> = Comments.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "postId == %i", id)

        do {
            let result = try container.viewContext.fetch(fetchRequest)
            return result
        } catch {
            print(error)
         }
         return []
    }
    
    func fetchProfiletXName(name:String) -> [Profile] {
        //1
        let fetchRequest : NSFetchRequest<Profile> = Profile.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)

        do {
            let result = try container.viewContext.fetch(fetchRequest)
            return result
        } catch {
            print(error)
         }
         return []
    }
}
