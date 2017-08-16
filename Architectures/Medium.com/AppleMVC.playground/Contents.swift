import UIKit

// https://medium.com/ios-os-x-development/ios-architecture-patterns-ecba4c38de52

struct Person { // Model
    let firstName: String
    let lastName: String
}

class GreetingViewController : UIViewController { // View + Controller
    var person: Person!
    let showGreetingButton = UIButton()
    let greetingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showGreetingButton.addTarget(self, action: Selector(("didTapButton:")), for: .touchUpInside)
    }
    
    func didTapButton(button: UIButton) {
        let greeting = "Hello" + " " + self.person.firstName + " " + self.person.lastName
        self.greetingLabel.text = greeting
        
    }
    // layout code goes here
}

// Assembling of MVC
let model = Person(firstName: "David", lastName: "Szurma")
let view = GreetingViewController()
view.person = model;

print(view.person.lastName)
