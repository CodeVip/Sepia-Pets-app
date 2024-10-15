//
//  PetListViewModel.swift
//  Sepia Pets app
//
//  Created by vipin on 3/11/23.
//

import Foundation
import Combine

class PetListViewModel:ObservableObject{
    let apiNetWork:NetworkManager!
    @Published var errorList:String?
    @Published var errorConfig:String?
    @Published var petList = [Pet]()
    @Published var isWorkingHours = true
    private var cancellables = Set<AnyCancellable>()
    init(apiNetWork: NetworkManager!, error: String? = nil) {
        self.apiNetWork = apiNetWork
    }
    
    func getPetListData(nameFile:String){
        apiNetWork.getPets_list(nameFile: nameFile, type: PetListModel.self).sink { completion in
            switch completion {
            case .failure(let err):
                self.errorList = err.localizedDescription
                print("Error is \(err.localizedDescription)")
               print("on UAt branch")
            case .finished:
                print("Finished")
               break
            }
        } receiveValue: { [weak self]  listPet in
            self?.petList = listPet.pets
        }.store(in: &cancellables)

    }
    
    func getPetConfigData(nameFile:String){
        apiNetWork.getPets_list(nameFile: nameFile, type: ConfigModel.self).sink { comletion in
            switch comletion{
            case .failure(let err):
                self.errorConfig = err.localizedDescription
                print("Error is \(err.localizedDescription)")
                print("on UAt branch")
               // break
            case .finished:
                print("Finished")
              
                break
                
            }
            
        } receiveValue: { [weak self]  configDetail in
          self?.startAndEndTime(configTime: configDetail.settings.workHours)
        }.store(in: &cancellables)
    }
    
    func startAndEndTime(configTime:String){
        let response =   configTime
        let pattern = "^[A-Z]-[A-Z]\\s{1}(\\d{1,2}:\\d{2})\\s{1}-\\s{1}(\\d{1,2}:\\d{2})$"
        let regex = try! NSRegularExpression(pattern: pattern)
        if let match = regex.matches(in: response, range: .init(response.startIndex..., in: response)).first,
           match.numberOfRanges == 3 {
            let start = match.range(at: 1)
            print(response[Range(start, in: response)!])
            let end = match.range(at: 2)
            print(response[Range(end, in: response)!])
            let startTime = "\(response[Range(start, in: response)!])"
            let endTime = "\(response[Range(end, in: response)!])"
          //  isWorkingHours = checkIfCurrentTimeIsBetween(startTime: startTime, endTime: endTime)
        }
    }
    
    func checkIfCurrentTimeIsBetween(startTime: String, endTime: String) -> Bool {
        guard let start = Formatter.today.date(from: startTime),
              let end = Formatter.today.date(from: endTime) else {
            return false
        }
        return DateInterval(start: start, end: end).contains(Date())
    }
}
