//lines that begin with // are comments which are ignored by the compiler, and are for humans to understand the contract
/*
we can also have multi line comemnts
by enclosing text between /* and
*/
//the first thing we do in a solidity smart contract is we specify our preference of compiler version
pragma solidity ^0.8.17;
//the ^ character indicates that we can use the specified solidity version OR NEWER
//all solidity statements end with a ; semicolon.


//we can import other programmer's code by using the import statement
import "@openzeppelin/contracts/access/Ownable.sol";


/*
This contract stores a data string (text) 
It makes the stored data string available for anyone to read
This version allows the stored data to be changed by the contract Owner
This version can be bought from the owner at a specified price
*/
contract MessageStore is Ownable{ //the 'is' keywrod tells the comiler to incorporate the indicated smart contract within our own (inheritance)
    //the contract keyword tells the compiler we're defining a new smart contract
    //there can be more than one contract defined in each .sol file
    //the smart contract definition (state + business logic) is contained between the {} braces

    //let's define some internal variables - this is the data that the smart contract knows about & remembers
    string private data; 
    //string is describing the type of information we're storing in this smart contract - string means text
    //private keyword means that this information will be 'hidden' from other accounts
    //"data" is simply a name that we invented for this piece of contract state (also called a variable or field)

    //add contract state to remember the price
    //uint is short for unsigned integer - a variable type that can store positive (or zero) whole numbers
    //public means that other accounts including smart contracts can READ the price directly as if there was a view function
    uint public price;
    //uint is by default 256 bits wide - we can specify other sizes if we know for example that we are storing smaller numbers


    /*
    every contract needs a 'constructor' function that tells the compiler how to initialize the contract when it's created
    a function is a unit of code that belongs and excutes together - it can be invoked (called) from other bits of code
    every variable in solidity is either 'memory' or 'storage 
    the latter is more expensive to work with (in terms of gas) because it persists outside of the current transaction
    when declaring contract state, everything is assumed to be storage (persists on chain)
    */
    constructor (string memory initialData, uint initialPrice) {
        data = initialData; 
        //in programming the = operator means assignment that is, whatever is on the right hand side of the =
        //will be copied over and stored in whatever variable is on the left hand side.
        //initialize the price...
        price = initialPrice;
    }

    /*
    we can create functions to view or even modify the internal state of the contract
    the function we are going to define below allows anyone to view the "data"
    below, the first set of () braces contain any external information the function will need to do its job
    in this case, no external information is needed by the business logic
    the "public" keyword indicates that this function can be used by other contracts as part of MessageStore interface
    the "returns" keyword describes the type of information that this function will provide as a response
    the "view" keyword indicates that this function will not alter the internal state of MessageStore
    */
    function viewData() public view returns(string memory){
        return data; 
        //the return statement specifies which piece of information to provide as the response
    }

    /*
    this function allows the caller (anyone) to change the stored data
    */
    function updateData(string memory newData) public onlyOwner{
        //change the stored data to be the newData - this is very simple but probably bad logic
        data = newData;
    }

    /*
    this function allows the contract ownership to be sold to anyone who pays the price
    we need to use the 'payable' keyword which indicates to the compiler that this function can accept ETH as payment
    in this initial version, this contract can just keep the ETH (as if burning it)
    */
    function buy() payable public{
        //verify that the amount of ETH sent is at least the price that was set
        //the code below is written to be clear to anyone learning solidity
        //there are much more concise ways to do this including "require" or "assert" keywords
        if(msg.value >= price){//if the message value is greater than or equal to the price
            _transferOwnership(msg.sender);//transfer ownership to the transaction sender
        }
    }

}