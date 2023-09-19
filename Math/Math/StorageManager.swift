//
//  StorageManager.swift
//  Math
//
//  Created by vitasiy on 07/09/2023.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    private let playerKey = "players"
    
    func save(player: Player) {
        var players = fatchPlayers()
        players.append(player)
        guard let data = try? JSONEncoder().encode(players) else { return }
        userDefaults.set(data, forKey: playerKey)
    }
    
    func fatchPlayers() -> [Player] {
        guard let data = userDefaults.object(forKey: playerKey) as? Data else { return [] }
        guard let players = try? JSONDecoder().decode([Player].self, from: data) else { return [] }
        return players
    }
    
    func delete(at index: Int) {
        var players = fatchPlayers()
        players.remove(at: index)
        guard let data = try? JSONEncoder().encode(players) else { return }
        userDefaults.set(data, forKey: playerKey)
    }
    
    func deleteAll() {
        var players = fatchPlayers()
        players.removeAll()
        guard let data = try? JSONEncoder().encode(players) else { return }
        userDefaults.set(data, forKey: playerKey)
    }
    
}
