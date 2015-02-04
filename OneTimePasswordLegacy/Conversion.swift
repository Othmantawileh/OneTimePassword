//
//  Conversion.swift
//  OneTimePassword
//
//  Created by Matt Rubin on 2/3/15.
//  Copyright (c) 2015 Matt Rubin. All rights reserved.
//

import OneTimePassword

internal func otpAlgorithm(generatorAlgorithm: Generator.Algorithm) -> OTPAlgorithm {
    switch generatorAlgorithm {
    case .SHA1:   return .SHA1
    case .SHA256: return .SHA256
    case .SHA512: return .SHA512
    }
}


internal func tokenForOTPToken(token: OTPToken) -> Token? {
    if let generator = generatorForOTPToken(token) {
        return Token(name: token.name, issuer: token.issuer, core: generator)
    }
    return nil
}

private func generatorForOTPToken(token: OTPToken) -> Generator? {
    return Generator(
        factor: factorForOTPToken(token),
        secret: token.secret,
        algorithm: algorithmForOTPAlgorithm(token.algorithm),
        digits: Int(token.digits)
    )
}

private func factorForOTPToken(token: OTPToken) -> Generator.Factor {
    switch token.type {
    case .Counter:
        return .Counter(token.counter)
    case .Timer:
        return .Timer(period: token.period)
    }
}

private func algorithmForOTPAlgorithm(algorithm: OTPAlgorithm) -> Generator.Algorithm {
    switch algorithm {
    case .SHA1:   return .SHA1
    case .SHA256: return .SHA256
    case .SHA512: return .SHA512
    }
}
