// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/utils/Strings.sol";
import "hardhat/console.sol";

contract Gas2 {
    function lowGas(uint value) costGas('lowGas') public view returns(bool) {
        uint x=10;
        x = x + x;
        
        return x == value;
    }

    function highGas(uint value)  costGas('highGas') public view returns(bool)  {
        uint x=10;
        x = x * 2;
        return x == value;
    }

    function fn_or(uint value) costGas('fn_or') public view returns(bool){
        return lowGas(value) || highGas(value);
    }

    function fn_add(uint value) costGas('fn_and') public view returns(bool){
        return lowGas(value) && highGas(value);
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