//
//  CustomError.swift
//  BlindIDStudyCase
//
//  Created by Selcuk on 21.05.2025.
//

import Foundation

enum CustomError: LocalizedError {
    case tokenNotFound
    case invalidJSONBody
    case invalidURL
    case networkError(String)
    case unexpectedResponse
    case httpError(statusCode: Int)
    case noDataReceived
    case invalidResponseFormat
    case jsonParsingFailed(String)
    case unauthorized
    case decodingError(String)
    case invalidParameters
    case invalidResponse
    case encodingFailed
    case decodingFailed
    case serializationError(description: String)
    case serverError
    case notFound
    
    var errorDescription: String? {
        switch self {
        case .tokenNotFound: return "Authorization token not found."
        case .invalidJSONBody: return "Failed to serialize request body."
        case .invalidURL: return "Invalid endpoint URL."
        case .networkError(let description): return "Network error: \(description)"
        case .decodingError(let description): return "Decoding error: \(description)"
        case .unexpectedResponse: return "Unexpected response from server."
        case .httpError(let statusCode): return "HTTP error with status code \(statusCode)."
        case .noDataReceived: return "No data received from server."
        case .invalidResponseFormat: return "Invalid response format received."
        case .invalidResponse: return "Invalid response received."
        case .jsonParsingFailed(let description): return "Failed to parse JSON: \(description)"
        case .unauthorized: return "Unauthorized User"
        case .invalidParameters: return "Invalid Parameters"
        case .encodingFailed: return "Encoding Failed"
        case .decodingFailed: return "Decoding Failed"
        case .serializationError(let description): return "\(description)"
        case .serverError: return "Server Error"
        case .notFound: return "Not Found"
        }
    }
}
