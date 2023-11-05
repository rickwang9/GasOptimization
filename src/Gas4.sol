// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/utils/Strings.sol";
import "hardhat/console.sol";
contract PackedContract{
	uint128 public  a1;
	uint128 public  a2;
	uint256 public  a3;

    uint128 public a4;
	uint256 public a5;
	uint128 public a6;

	constructor() public{
	
	}
	function setPackedValue(uint128 _a1, uint128 _a2, uint256 _a3) costGas('setPackedValue') public {
		a1 = _a1;
		a2 = _a2;
		a3 = _a3;
	}
	function setUnpackedValue(uint128 _a4, uint256 _a5, uint128 _a6) costGas('setUnpackedValue') public {
		a4 = _a4;
		a5 = _a5;
		a6 = _a6;
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
