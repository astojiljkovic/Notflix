//
//  Movie.swift
//  Netflix Clone
//
//  Created by Aleksa Stojiljkovic on 19.3.22..
//

import Foundation

//codable se koristi za codable i decodable
struct TrendingTitlesResponse: Codable {
    let results:[Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
//adult = 0;
//"backdrop_path" = "/qswImgf57wBf2i8Fv6K2O2BdMoe.jpg";
//"genre_ids" =             (
//    18,
//    53,
//    10749,
//    9648
//);
//id = 619979;
//"media_type" = movie;
//"original_language" = en;
//"original_title" = "Deep Water";
//overview = "Vic and Melinda Van Allen are a couple in the small town of Little Wesley. Their loveless marriage is held together only by a precarious arrangement whereby, in order to avoid the messiness of divorce, Melinda is allowed to take any number of lovers as long as she does not desert her family.";
//popularity = "156.059";
//"poster_path" = "/6yRMyWwjuhKg6IU66uiZIGhaSc8.jpg";
//"release_date" = "2022-03-18";
//title = "Deep Water";
//video = 0;
//"vote_average" = "5.8";
//"vote_count" = 31;
//},
