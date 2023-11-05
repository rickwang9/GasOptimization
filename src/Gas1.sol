// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/utils/Strings.sol";
import "hardhat/console.sol";

contract Ga1{


    function lowGas() costGas('lowGas') public view returns(uint) {
        uint x=10;
        x = x + x;
        return x;
    }

    function highGas()  costGas('highGas') public view returns(uint)  {
        uint x=10;
        x = x * 2;
        return x;
    }

    modifier costGas(string memory name) {
        uint beforeGas = gasleft();
        _;
        uint afterGas = gasleft();
        console.log(name, concat("costGas: ", Strings.toString(beforeGas - afterGas)));
    }

    function concat(string memory value1, string memory value2) public pure returns(string memory result){
        result = string(abi.encodePacked(value1, value2));
    }


}