//
//  PetListView.swift
//  Sepia Pets app
//
//  Created by vipin on 3/11/23.
//

import SwiftUI
import Combine

struct PetListView: View {
    @ObservedObject var viewModel = PetListViewModel(apiNetWork: NetworkManager())
    private var cancellables:Set<AnyCancellable> = []
    @State private var error: MyError? = .basic
    var body: some View {
        NavigationView{
            if !viewModel.isWorkingHours{
                Text("Data will be visible during working hours.")
                    .errorAlert($error)
            }else{
                List(viewModel.petList, id: \.title) { item in
                    PetListCell(pet: item)
                }
                .listStyle(.plain)
                .navigationTitle("Pet list")
            }
        }
        .onAppear{
            viewModel.getPetConfigData(nameFile: Constant.config)
            if viewModel.isWorkingHours{
                viewModel.getPetListData(nameFile: Constant.petsList)
            }
        }
    }
}

struct PetListView_Previews: PreviewProvider {
    static var previews: some View {
        PetListView()
    }
}
