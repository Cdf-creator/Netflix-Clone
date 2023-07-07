//
//  Movie.swift
//  Netflix Clone
//
//  Created by Olanrewaju Olakunle  on 08/11/2022.
//

import Foundation

struct TrendingTitleResponse: Codable {
    
    let results: [Title]
    
}

struct Title : Codable {
    
    let id: Int
    let media_type: String?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let release_date: String?
    let vote_count: Int
    let vote_average: Double
    
}

/*
 {
adult = 0;
"backdrop_path" = "/trvBpyiWtAUXeys2Muevf8i1bhO.jpg";
"genre_ids" =             (
 18
);
id = 595586;
"media_type" = movie;
"original_language" = en;
"original_title" = Causeway;
overview = "A US soldier suffers a traumatic brain injury while fighting in Afghanistan and struggles to adjust to life back home in New Orleans. When she meets local mechanic James, the pair begin to forge an unexpected bond.";
popularity = "100.411";
"poster_path" = "/bUzKIqFIS05Ss31zRTfZfHJIgDP.jpg";
"release_date" = "2022-10-28";
title = Causeway;
video = 0;
"vote_average" = "6.974";
"vote_count" = 57;
},

 */
