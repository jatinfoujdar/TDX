//
//  SearchHistoryManager.swift
//  TDX
//
//  Created by jatin foujdar on 26/11/25.
//

import Foundation

class SearchHistoryManager {
    
    static let shared = SearchHistoryManager()
    private let key = "recent search"
    
    func getRecentSearches() -> [String]{
        return UserDefaults.standard.stringArray(forKey: key) ?? []
    }
    
    func addSearch(_ term: String){
        
        var current = getRecentSearches()
        
        if let index = current.firstIndex(of: term){
            current.remove(at: index)
        }
        current.insert(term, at: 0)
        
        if current.count >= 10{
            current = Array(current.prefix(10))
        }
        UserDefaults.standard.set(current, forKey: key)
    }
    func clearHistory(){
        UserDefaults.standard.removeObject(forKey: key)
    }
}
    
