//
//  DataPersistenceManager.swift
//  Netflix Clone
//
//  Created by Aleksa Stojiljkovic on 23.3.22..
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToDelete
    }
    static let shared = DataPersistenceManager()
    
    
    func downloadTitle(model: Title, completion: @escaping(Result<Void,Error>) -> Void){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = TItleItem(context: context)
        
        item.original_title = model.original_title
        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = model.vote_average
        
        do{
           try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(DatabaseError.failedToSaveData))
        }
        
        
        
    }
    
    func fetchingTitlesFromDataBase(completion: @escaping(Result<[TItleItem],Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TItleItem>
        
        request = TItleItem.fetchRequest()
        
        do{
            //povuci iz baze sa ovim requstom
            let titles = try context.fetch(request)
            completion(.success(titles))
        }catch{
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    func deleteTitleWith(model: TItleItem,completion: @escaping (Result<Void,Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model) // bita database manager da obrise objekat
        
        do {
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(DatabaseError.failedToDelete))
        }
    }
}
