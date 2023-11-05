// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/utils/Strings.sol";
import "hardhat/console.sol";
contract Gas5_128{
    uint128 public  a1;

	constructor() public{
	}
	function fn_cal() costGas('Gas5_128.setPackedValue') public {
		a1 = a1 * 5 + 2;
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
contract Gas5_256{
    uint256 public  a1;

	constructor() public{
	}
	function fn_cal() costGas('Gas5_256.setPackedValue') public {
		a1 = a1 * 5 + 2;
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