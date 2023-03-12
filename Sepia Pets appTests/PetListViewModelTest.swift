//
//  PetListViewModelTest.swift
//  Sepia Pets appTests
//
//  Created by vipin on 3/12/23.
//

import XCTest
@testable import Sepia_Pets_app

final class PetListViewModelTest: XCTestCase {
    var apiNetWork: NetworkManager!
    var viewModel:PetListViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        apiNetWork = NetworkManager()
        viewModel = PetListViewModel(apiNetWork: apiNetWork)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        apiNetWork = nil
        viewModel = nil
    }
    
    func testPetList_Success(){
        
        viewModel.getPetListData(nameFile: Constant.petsList)
        XCTAssertNotNil(viewModel.petList)
    }
    
    func testPetList_failure(){
        
        viewModel.getPetListData(nameFile: "abc")
        XCTAssert(viewModel.petList.count == 0)
    }

    func testConfig_Success(){
        
        viewModel.getPetConfigData(nameFile: Constant.config)
        XCTAssert(viewModel.errorConfig == nil)
    }
    
    func testConfig_Failure(){
        
        viewModel.getPetConfigData(nameFile: "abc")
        XCTAssert(viewModel.isWorkingHours == false)
    }
    
    func testIsWorkingHour_failure(){
        viewModel.startAndEndTime(configTime: "M-F 9:00 - 9:00")
        XCTAssert(viewModel.isWorkingHours == false)
    }
    
    func testIsWorkingHour_Success(){
        viewModel.startAndEndTime(configTime: "M-F 1:00 - 23:59")
        XCTAssert(viewModel.isWorkingHours == true)
    }
}
