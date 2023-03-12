//
//  PetListCell.swift
//  Sepia Pets app
//
//  Created by vipin on 3/11/23.
//

import SwiftUI

struct PetListCell: View {
    var pet:Pet
    var body: some View {
        
        NavigationLink(destination: PetDetailView(pet: pet)){
            HStack{
                AsyncImage(url: URL(string: pet.imageURL)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(width: 100.0, height: 100, alignment: .center)
                            .cornerRadius(10)
                    }
                    else {
                        Image(uiImage: UIImage(named: "pets")!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100.0, height: 100, alignment: .center)
                            .cornerRadius(10)
                    }
                }
                
                Text(" Pet: \(pet.title)")
                    .font(.title)
                    .bold()
            }
        }
    
      }
}
