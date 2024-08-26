//: [Previous](@previous)
// MARK: Problema: Implementa un sistema de autenticación seguro en una aplicación iOS que incluye almacenamiento de credenciales en el Keychain, protección de datos mediante Data Protection, y autenticación biométrica (Touch ID/Face ID) para acceder a datos sensibles.

//Requisitos:
//
//Almacenamiento Seguro de Credenciales:
//Las credenciales del usuario (nombre de usuario y contraseña) deben almacenarse en el Keychain de manera segura.
//Protección de Datos Sensibles:
//Debes proteger los datos sensibles (como notas privadas) utilizando Data Protection y asegurarte de que estén cifrados correctamente.
//Autenticación Biometrica:
//Implementa autenticación biométrica para acceder a los datos sensibles, de modo que sólo el usuario autorizado pueda ver la información.
//Tips:
//
//Utiliza la clase SecItem para interactuar con el Keychain.
//Asegúrate de manejar adecuadamente los errores en caso de que la autenticación biométrica falle.
//Prueba el comportamiento de la aplicación cuando el dispositivo está bloqueado o cuando se reinicia.

import UIKit
import LocalAuthentication
import Security

class SecureDataManager {
    
    enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unhandledError(status: OSStatus)
    }
    let server = "www.server.mx"
    
    // Función para guardar credenciales en el Keychain
    func saveCredentials(username: String, password: String) {
        // Implementar guardado en Keychain aquí
        let pass = password.data(using: String.Encoding.utf8)!
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecAttrServer as String: server,
            kSecValueData as String: pass
        ]
        var status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            KeychainError.unhandledError(status: status)
            return
        }
        print(status)
    }
    
    // Función para obtener credenciales desde el Keychain
    func retrieveCredentials() -> (username: String, password: String)? {
        // Implementar recuperación desde el Keychain aquí
        /// Primero se crea un diccionario de consulta
        var query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrServer as String: server,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        
        /// Se crea  el item y se hace la consulta. El item sirve para recuperar la información
        var item: CFTypeRef?
        var status = SecItemCopyMatching(query as CFDictionary, &item)
        guard let dataRecovery = item as? [String: Any],
              let passwordData = dataRecovery[kSecValueData as String] as? Data,
              let password = String(data: passwordData, encoding: String.Encoding.utf8),
              let user = dataRecovery[kSecAttrAccount as String] as? String
        else {
            KeychainError.unexpectedPasswordData
            print("Error en recuperar")
            return ("", "")
        }
        return (user, password)
    }
    
    // Función para proteger datos con Data Protection
    func protectSensitiveData(data: Data) -> Bool {
        // Implementar protección de datos aquí
        return false
    }
    
    // Función para autenticar al usuario usando Face ID/Touch ID
    func authenticateUser(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Acceso a información sensible") { success, authenticationError in
                DispatchQueue.main.async {
                    completion(success, authenticationError)
                }
            }
        } else {
            completion(false, error)
        }
    }
}

var keychain = SecureDataManager()

keychain.saveCredentials(username: "beto02001", password: "2001")

var (usuario, contrasena) = keychain.retrieveCredentials() ?? ("", "")

print(usuario, contrasena)

//: [Next](@next)
