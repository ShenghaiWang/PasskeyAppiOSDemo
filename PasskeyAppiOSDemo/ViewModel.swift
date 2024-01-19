//
//  ViewModel.swift
//  PasskeyAppiOSDemo
//
//  Created by Tim Wang on 20/1/2024.
//

import Foundation
import AuthenticationServices

@Observable
class ViewModel: NSObject {
    let domain = "passkey.timwang.au"
    var userName = "Tim Wang"

    var user: User {
        User(name: userName)
    }

    func register() {
        let publicKeyCredentialProvider = ASAuthorizationPlatformPublicKeyCredentialProvider(relyingPartyIdentifier: domain)
        let challenge = Challenge(user: user).challenge // Note: Demo only. Should call register/start api to get this challenge
        let userID = Data(user.id.utf8)
        let registrationRequest = publicKeyCredentialProvider.createCredentialRegistrationRequest(challenge: challenge,
                                                                                                  name: userName, 
                                                                                                  userID: userID)
        let authController = ASAuthorizationController(authorizationRequests: [registrationRequest])
        authController.delegate = self
        authController.presentationContextProvider = self
        authController.performRequests()
    }

    func signIn() {
        let publicKeyCredentialProvider = ASAuthorizationPlatformPublicKeyCredentialProvider(relyingPartyIdentifier: domain)
        let challenge = Challenge(user: user).challenge // Note: Demo only. Should call authentication/start api to get this challenge
        let assertionRequest = publicKeyCredentialProvider.createCredentialAssertionRequest(challenge: challenge)
        let authController = ASAuthorizationController(authorizationRequests: [assertionRequest])
        authController.delegate = self
        authController.presentationContextProvider = self
        authController.performRequests()
    }

    func autoFillAssistedPasskeySignIn() {
        let publicKeyCredentialProvider = ASAuthorizationPlatformPublicKeyCredentialProvider(relyingPartyIdentifier: domain)
        let challenge = Challenge(user: user).challenge // Note: Demo only. Should call authentication/start api to get this challenge
        let assertionRequest = publicKeyCredentialProvider.createCredentialAssertionRequest(challenge: challenge)
        let authController = ASAuthorizationController(authorizationRequests: [assertionRequest])
        authController.delegate = self
        authController.presentationContextProvider = self
        authController.performAutoFillAssistedRequests()
    }
}

extension ViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, 
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationPlatformPublicKeyCredentialRegistration {
            // Call register/finish api to verify the attestationObject and clientDataJSON of credential
            // save attestationObject(the public key) to server and sign in the user with the new account if passed verification
        } else if let credential = authorization.credential as? ASAuthorizationPlatformPublicKeyCredentialAssertion {
            // Call authentication/finish api to verify the signature and clientDataJSON on the server for the given userID.
            // Sign in the user with the new account if passed verification
        } else {
            print("Other logging in cases such as Sign in with Apple etc.")
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error) // Handle error
    }
}

extension ViewModel: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
            fatalError("No Anchor for the app!")
        }
        return window!
    }
}
