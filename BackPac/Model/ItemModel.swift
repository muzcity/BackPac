//
//  ItemModel.swift
//  BackPac
//
//  Created by roy2020 on 2020/06/20.
//  Copyright © 2020 muzcity. All rights reserved.
//

import Foundation

//MARK: -
//MARK: -
//MARK: - ViewModel

class ItemViewModel : ReducerDataModelProtocol {
    
    init(model : ItemModel?) {
        models = model?.results.map { ItemDetailViewModel(model:$0) }
    }
    
    var count : Int {
        return models?.count ?? 0
    }
    
    subscript(index:Int) -> ItemDetailViewModel? {
        guard count > index else {
            return nil
        }
        
        return models?[index]
    }
    
    func object(at index:Int) -> ItemDetailViewModel? {
        guard count > index else {
            return nil
        }
        
        return models?[index]
    }
    
    private var models : [ItemDetailViewModel]?
}


class ItemDetailViewModel : ReducerDataModelProtocol {
    
    var model : ItemDetailModel?
    init(model : ItemDetailModel) {
        self.model = model
    }
    
    var artistId: Int                                       { return model?.artistId ?? 0 }
    var artistName: String                                  { return model?.artistName ?? "" }
    var artistViewUrl: String                               { return model?.artistViewUrl ?? "" }
    var artworkUrl100: String                               { return model?.artworkUrl100 ?? "" }
    var artworkUrl512: String                               { return model?.artworkUrl512 ?? "" }
    var artworkUrl60: String                                { return model?.artworkUrl60 ?? "" }
    var averageUserRating: Double                           { return model?.averageUserRating ?? 0 }
    var averageUserRatingForCurrentVersion: Double          { return model?.averageUserRatingForCurrentVersion ?? 0 }
    var bundleId: String                                    { return model?.bundleId ?? "" }
    var contentAdvisoryRating: String                       { return model?.contentAdvisoryRating ?? "" }
    var currency: String                                    { return model?.currency ?? "" }
    var currentVersionReleaseDate: String                   { return model?.currentVersionReleaseDate ?? "" }
    var description: String                                 { return model?.description ?? "" }
    var features: [String]                                  { return model?.features ?? [] }
    var fileSizeBytes: String                               { return model?.fileSizeBytes ?? "" }
    var formattedPrice: String                              { return model?.formattedPrice ?? "" }
    var genreIds: [String]                                  { return model?.genreIds ?? [] }
    var genres: [String]                                    { return model?.genres ?? [] }
    var ipadScreenshotUrls: [String]                        { return model?.ipadScreenshotUrls ?? [] }
    var isGameCenterEnabled: Bool                           { return model?.isGameCenterEnabled ?? false }
    var isVppDeviceBasedLicensingEnabled: Bool              { return model?.isVppDeviceBasedLicensingEnabled ?? false }
    var kind: String                                        { return model?.kind ?? "" }
    var languageCodesISO2A: [String]                        { return model?.languageCodesISO2A ?? [] }
    var minimumOsVersion: String                            { return model?.minimumOsVersion ?? "" }
    var price: Double                                       { return model?.price ?? 0 }
    var primaryGenreId: Int                                 { return model?.primaryGenreId ?? 0 }
    var primaryGenreName: String                            { return model?.primaryGenreName ?? "" }
    var releaseDate: String                                 { return model?.releaseDate ?? "" }
    var releaseNotes: String                                { return model?.releaseNotes ?? "" }
    var screenshotUrls: [String]                            { return model?.screenshotUrls ?? [] }
    var sellerName: String                                  { return model?.sellerName ?? "" }
    var supportedDevices: [String]                          { return model?.supportedDevices ?? [] }
    var trackCensoredName: String                           { return model?.trackCensoredName ?? "" }
    var trackContentRating: String                          { return model?.trackContentRating ?? "" }
    var trackId: Int                                        { return model?.trackId ?? 0 }
    var trackName: String                                   { return model?.trackName ?? "" }
    var trackViewUrl: String                                { return model?.trackViewUrl ?? "" }
    var userRatingCount: Int                                { return model?.userRatingCount ?? 0 }
    var userRatingCountForCurrentVersion: Int               { return model?.userRatingCountForCurrentVersion ?? 0 }
    var version: String                                     { return model?.version ?? "" }
    var wrapperType: String                                 { return model?.wrapperType ?? "" }
    
    
}


//MARK: -
//MARK: -
//MARK: - Model

struct ItemModel: Codable , ReducerDataModelProtocol {
    let results: [ItemDetailModel]

    let resultCount: Int
}

struct ItemDetailModel: Codable , ReducerDataModelProtocol {

    let artistId: Int
    let artistName: String
    let artistViewUrl: String
    let artworkUrl100: String
    let artworkUrl512: String
    let artworkUrl60: String
    let averageUserRating: Double
    let averageUserRatingForCurrentVersion: Double
    let bundleId: String
    let contentAdvisoryRating: String
    let currency: String
    let currentVersionReleaseDate: String
    let description: String
    let features: [String]
    let fileSizeBytes: String
    let formattedPrice: String
    let genreIds: [String]
    let genres: [String]
    let ipadScreenshotUrls: [String]
    let isGameCenterEnabled: Bool
    let isVppDeviceBasedLicensingEnabled: Bool
    let kind: String
    let languageCodesISO2A: [String]
    let minimumOsVersion: String
    let price: Double
    let primaryGenreId: Int
    let primaryGenreName: String
    let releaseDate: String
    let releaseNotes: String?
    let screenshotUrls: [String]
    let sellerName: String
    let supportedDevices: [String]
    let trackCensoredName: String
    let trackContentRating: String
    let trackId: Int
    let trackName: String
    let trackViewUrl: String
    let userRatingCount: Int
    let userRatingCountForCurrentVersion: Int
    let version: String
    let wrapperType: String

}
