//
//  NetworkManager.swift
//  Sepia Pets app
//
//  Created by vipin on 3/11/23.
//

import Foundation
import Combine

class NetworkManager {
    
    private var cancellables = Set<AnyCancellable>()
    
    func getPets_list<T:Decodable>(nameFile:String,type:T.Type)->Future<T,Error>{
        
        return Future<T,Error>{ promise in
            guard let path =  Bundle.main.path(forResource: nameFile, ofType: "json")else{
                return promise(.failure(NetworkError.invalidURL))
            }
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path),options: .mappedIfSafe)
                let petResult = try JSONDecoder().decode(T.self, from: data)
                promise(.success(petResult))
            }catch{
                promise(.failure(NetworkError.unknown))
            }
        }
    }
}


