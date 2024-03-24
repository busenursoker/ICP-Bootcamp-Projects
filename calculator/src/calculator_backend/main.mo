actor Calculator {  // More descriptive name for the actor

  var cell: Int = 0;  // Clearer variable name

  // Addition
  public func add(number: Int) : async Int {
    cell += number;
    return cell;
  };

  // Subtraction
  public func subtract(number: Int) : async Int {
    cell -= number;
    return cell;
  };

  // Multiplication
  public func multiply(number: Int) : async Int {
    cell *= number;
    return cell;
  };

  // Division
  public func divide(number: Int) : async ?Int {
    if (number == 0) {
      return null;  // Consistent use of nil for division by zero
    } else {
      cell /= number;
      return ?cell;
    };
  };

  // Clear
  public func clear() : async () {
    cell := 0;
  };
};

