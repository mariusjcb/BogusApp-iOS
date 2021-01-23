//
//  EndpointsProvider.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 22/01/2021.
//

import Foundation

public enum DefaultTargetsServiceEndpoints {
    case targets(ids: [UUID])
}

// MARK: - Configuration

extension DefaultTargetsServiceEndpoints: EndpointConfigurable {
    public var path: String {
        switch self {
        case .targets(ids: _): return "targets"
        }
    }
    
    public var isFullPath: Bool {
        switch self {
        case .targets(ids: _): return false
        }
    }
    
    public var method: HTTPMethodType {
        switch self {
        case .targets(ids: _): return .get
        }
    }
    
    public var headers: [String : String] {
        switch self {
        case .targets(ids: _): return [:]
        }
    }
    
    public var queryEncodableObject: Encodable? {
        switch self {
        case .targets(ids: _): return nil
        }
    }
    
    public var queryParams: [String : Any] {
        switch self {
        case .targets(ids: let ids): return ["id": ids]
        }
    }
    
    public var bodyEncodableObject: Encodable? {
        switch self {
        case .targets(ids: _): return nil
        }
    }
    
    public var bodyParams: [String : Any] {
        switch self {
        case .targets(ids: _): return [:]
        }
    }
    
    public var bodyEncoding: BodyEncoding {
        switch self {
        case .targets(ids: _): return .jsonSerializationData
        }
    }
    
    public var responseDecoder: ResponseDecoder {
        return JSONResponseDecoder()
    }
}
