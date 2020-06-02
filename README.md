# CreditCardViewSwift
This is a fully functional Card View that provides validated card data which is ready to use. Supports Credit, Debit, Master Card Etc.

## Main features

*  Name Validation
*  Credit/Debit/Master card validation through luhn algorithm
*  Card Expiry Validation
*  Properly formatted UI
*  Very easy integration through storyboards or programmatically.

### For detailed guide, please visit
https://medium.com/@osamakhan_92979/easy-credit-debit-card-ui-in-swift-with-creditcardviewswift-8e41c5999f17

## Installation
```
You want to add pod 'CreditCardViewSwift', '~> 1.0' to your Podfile. It should look something similar to this.
target 'MyApp' do
  pod 'CreditCardViewSwift', '~> 1.0'
end
Then run a pod install inside your terminal
```

### Implementation looks something like this

```
import UIKit
import CreditCardViewSwift

class ViewController: UIViewController {

    @IBOutlet weak var creditCardView: CreditCardViewSwift!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creditCardView.delegate = self
    }
}

extension ViewController: CreditCardViewSwiftDelegate {
    func cardDataValidated(name: String, cardNumber: String, cardExpiry: String, cvvNumber: String) {
        //Once Validated, this delegate method will return all the validated data
    }
}
```
