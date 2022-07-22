//
//  Tv.swift
//  Thoughts
//
//  Created by pham.van.toanc on 22/07/2022.
//

import Foundation

struct TrendingTvResponse: Codable {
    let results: [Tv]
}


struct Tv : Codable {
    let id: Int
    let media_type: String?
    let original_name:String?
    let original_title:String?
    let poster_path: String?
    let overview:String?
    let vote_count:Int
    let release_date:String?
    let vote_average:Double
}

//adult = 0;
//"backdrop_path" = "/zIRssaKBGBitHXo4h680IGCJFIg.jpg";
//"first_air_date" = "2022-07-14";
//"genre_ids" =             (
//    18,
//    10765
//);
//id = 108296;
//"media_type" = tv;
//name = "Resident Evil";
//"origin_country" =             (
//    US
//);
//"original_language" = en;
//"original_name" = "Resident Evil";
//overview = "Nearly three decades after the discovery of the T-virus, an outbreak reveals the Umbrella Corporation's dark secrets. Based on the horror franchise.";
//popularity = "918.9400000000001";
//"poster_path" = "/q2IlzP9bQNDdGLlX9jtms5MaOCh.jpg";
//"vote_average" = "5.9";
//"vote_count" = 110;
//},
