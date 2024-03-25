// Import libraries
import Icrc1Ledger "canister:icrc1_ledger_canister"; // Manages financial transactions like token transfers between accounts
import Debug "mo:base/Debug"; // Used for debugging operations
import Result "mo:base/Result"; // Used to return success or failure status of functions
import Option "mo:base/Option"; // Used to return optional values from functions
import Blob "mo:base/Blob"; // Used to manipulate data blobs in functions
import Error "mo:base/Error"; // Used to handle error situations in functions

// Define the Actor
actor {

  // Define the Account data type
  type Account = {
    owner : Principal; // Principal ID of the account owner
    subaccount : ?[Nat8]; // Optional sub-account ID (may not always be present)
  };

  // Define the TransferArgs data type
  type TransferArgs = {
    amount : Nat;          // Amount of tokens to transfer
    toAccount : Account;   // Information about the target account
  };

  // Transfer function - performs the transfer operation
  public shared ({ caller }) func transfer(args : TransferArgs) : async Result.Result<Icrc1Ledger.BlockIndex, Text> {

    // Debug output showing what the transfer is doing
    Debug.print(
      "Transferring "
      # debug_show (args.amount) // Show the transfer amount using debug_show
      # " tokens to account"
      # debug_show (args.toAccount) // Show the target account using debug_show
    );

    // Create arguments for the Icrc1Ledger canister transfer call
    let transferArgs : Icrc1Ledger.TransferArg = {
      memo = null;                  // Note: Not specified yet
      amount = args.amount;         // Amount to transfer
      from_subaccount = null;       // Source sub-account: Not specified yet
      fee = null;                   // Fee: Not specified yet
      to = args.toAccount;          // Target account
      created_at_time = null;       // Transaction creation time: Not specified yet
    };

    // Perform the transfer operation
    try {
      let transferResult = await Icrc1Ledger.icrc1_transfer(transferArgs);

      // Handle the transfer result
      switch (transferResult) {
        case (#Err(transferError)) { // Transfer failed
          // Return error message with details
          return #err("Couldn't transfer funds:\n" # debug_show (transferError));
        };
        case (#Ok(blockIndex)) {  // Transfer successful
          // Return the block index where the transaction is recorded
          return #ok blockIndex 
        };
      };
    } catch (error : Error) { // Error during transfer
      // Return error message
      return #err("Reject message: " # Error.message(error));
    };
  };
};
