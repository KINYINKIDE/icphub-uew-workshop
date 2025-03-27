import Nat64 "mo:base/Nat64";

actor Calculator {
  public func add(x: Nat64, y: Nat64): async ?Nat64 {
    // Check for potential overflow
    if (x > Nat64.maximumValue - y) {
      return null; // Would overflow
    };
    return ?(x + y);
  };

  public func sub(x: Nat64, y: Nat64): async ?Nat64 {
    // Handle potential underflow by returning null when y > x
    if (y > x) {
      return null; // Would underflow
    };
    return ?(x - y);
  };

  public func mul(x: Nat64, y: Nat64): async ?Nat64 {
    // Check for potential overflow
    if (y != 0 && x > Nat64.maximumValue / y) {
      return null; // Would overflow
    };
    return ?(x * y);
  };

  public func div(x: Nat64, y: Nat64): async ?Nat64 {
    if (y == 0) {
      return null; // Division by zero
    };
    return ?(x / y);
  };
}
