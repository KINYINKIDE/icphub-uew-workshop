import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Float "mo:base/Float";
import Array "mo:base/Array";
import Time "mo:base/Time";

actor Project {
  // Decentralized Banking System
  // State variables
  stable var balance : Float = 100;
  stable var transactions : [Transaction] = [];
  stable var transactionId : Nat = 0;

  type Transaction = {
    id: Nat;
    message: Text;
    timeStamp: Time.Time;
  };

  // Helper function to record transactions
  func recordTransactions(message : Text) {
    let transaction : Transaction = {
      id = transactionId;
      message = message;
      timeStamp = Time.now(); 
    };
    transactions := Array.append(transactions, [transaction]);
    transactionId += 1;
  };

  // Check account balance
  public func checkBalance() : async Text {
    let message = "Your balance is " # Float.toText(balance);
    recordTransactions(message);
    return message;
  };

  // Add funds to account
  public func topUp(amount : Float) : async Text {
    balance := balance + amount;
    let message = "You deposited: " # Float.toText(amount);
    recordTransactions(message);
    return message;
  };

  // Withdraw funds from account
  public func withdrawalBalance(amount : Float) : async Text {
    if (amount > balance) {
      return "Insufficient balance";
    } else {
      balance := balance - amount;
      let message = "You withdrew: " # Float.toText(amount);
      recordTransactions(message);
      return message;
    }
  };

  // Get transaction history
  public func getTransactions() : async [Transaction] {
    return transactions;
  }
}
