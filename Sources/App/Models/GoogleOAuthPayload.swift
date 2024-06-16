//
//  GoogleOAuthPayload.swift
//  
//
//  Created by Desislav Adamov on 7.06.24.
//

import JWT

struct GoogleOAuthPayload: JWTPayload {
    enum CodingKeys: String, CodingKey {
        case issuer = "iss"
        case audience = "aud"
        case expiration = "exp"
        case issued = "iat"
    }

    var issuer: IssuerClaim
    var audience: AudienceClaim
    var expiration: ExpirationClaim
    var issued: IssuedAtClaim

    func verify(using algorithm: some JWTAlgorithm) async throws {
        try expiration.verifyNotExpired()
        try audience.verifyIntendedAudience(includes: "digitallibrary-e3242")

        guard issuer.value == "https://securetoken.google.com/digitallibrary-e3242" else {
            throw JWTError.invalidHeaderField(reason: "Issuer must be different one.")
        }
    }
}
