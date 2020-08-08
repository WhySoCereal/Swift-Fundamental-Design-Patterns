/*:
 [Previous](@previous)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next](@next)
 
 # Model-view-controller (MVC)
 - - - - - - - - - -
 ![MVC Diagram](MVC_Diagram.png)
 
 The model-view-controller (MVC) pattern separates objects into three types: models, views and controllers.
 
 **Models** hold onto application data. They are usually structs or simple classes.
 
 **Views** display visual elements and controls on screen. They are usually subclasses of `UIView`.
 
 **Controllers** coordinate between models and views. They are usually subclasses of `UIViewController`.
 
 ## Code Example
 */
import UIKit // for UIView

// MARK: - MODEL: Address
public struct Address {
  public var street: String
  public var city: String
  public var state: String
  public var zipCode: String
}


// MARK: - VIEW: AddressView
public final class AddressView: UIView {
  @IBOutlet public var streetTextField: UITextField!
  @IBOutlet public var cityTextField: UITextField!
  @IBOutlet public var stateTextField: UITextField!
  @IBOutlet public var zipCodeTextField: UITextField!
}

// MARK: - VIEW CONTROLLER: AddressViewController
public final class AddressViewController: UIViewController {
    
  // MARK: - Properties
    // The view controller holds a strong reference to the view and model that it owns
  public var address: Address? {
    didSet {
      updateViewFromAddress()
    }
  }
  public var addressView: AddressView! {
    guard isViewLoaded else { return nil } // checks isViewLoaded to prevent creating the view before the view controller is presented on screen
    return (view as! AddressView) // if true cast to an AddressView
  }
  
  // MARK: - View Lifecycle
  public override func viewDidLoad() {
    super.viewDidLoad()
    updateViewFromAddress()
  }
  
    // Controller should update its
  private func updateViewFromAddress() {
    guard let addressView = addressView,
      let address = address else { return }
    addressView.streetTextField.text = address.street
    addressView.cityTextField.text = address.city
    addressView.stateTextField.text = address.state
    addressView.zipCodeTextField.text = address.zipCode
  }
  
  // MARK: - Actions
  @IBAction public func updateAddressFromView(_ sender: AnyObject) {
    guard let street = addressView.streetTextField.text, street.count > 0,
      let city = addressView.cityTextField.text, city.count > 0,
      let state = addressView.stateTextField.text, state.count > 0,
      let zipCode = addressView.zipCodeTextField.text, zipCode.count > 0
      else {
        // TO-DO: show an error message, handle the error, etc
        return
    }
    address = Address(street: street, city: city,
                      state: state, zipCode: zipCode)
  }
}
