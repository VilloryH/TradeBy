import Foundation

class LoginViewModel: ObservableObject {
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    func checkLogin(firstName: String) -> Bool {
        let defaults = UserDefaults.standard
        if firstName == defaults.string(forKey: "firstName") {
            return true
        } else {
            return false
        }
    }
    
    func saveLogin(firstName: String, lastName: String, email: String) {
        let defaults = UserDefaults.standard
        defaults.set(firstName, forKey: "firstName")
        defaults.set(lastName, forKey: "lastName")
        defaults.set(email, forKey: "email")
    }
    
    func checkSingin(firstName: String, lastName: String, email: String) -> Bool {
        let defaults = UserDefaults.standard
        if firstName == defaults.string(forKey: "firstName"), lastName == defaults.string(forKey: "lastName"), email == defaults.string(forKey: "email") {
            return true
        } else {
            return false
        }
    }
}
