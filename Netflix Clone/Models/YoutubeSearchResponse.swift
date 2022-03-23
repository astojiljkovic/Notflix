//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Aleksa Stojiljkovic on 22.3.22..
//

import Foundation

/*
 items =     (
             {
         etag = XhNhNV5XEqZjPuvSjzv5ubxnpdY;
         id =             {
             kind = "youtube#video";
             videoId = j7uKW8SJfLg;
         };
         kind = "youtube#searchResult";
     },
 */

struct YoutubeSearchResponse: Codable{
    let items: [VideoElement]
}

struct VideoElement: Codable {
 
    let id: IdVideoElement
    
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
