// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.0/contracts/utils/Strings.sol";
import "hardhat/console.sol";
// mapping const

contract MemberManagerV1 {
    mapping(address => bool) memberMap;
    function addMember(address member) public {
        require(!isMember(member));
        memberMap[member] = true;
    }
    function removeMember(address member) public {
        require(isMember(member));
        memberMap[member] = false;
    }
    function isMember(address member) public view returns(bool){
        return memberMap[member];

    }
    function getMembers() public view returns (address[] memory members){
    }
}
contract MemberManagerV2 {
    mapping(address=>address) memberNextMap;
    uint256 listSize;
    address constant HEADER = address(1);

    constructor() public {
        memberNextMap[HEADER] = HEADER;
    }

    function addMember(address member) public {
        require(!isMember(member));
        memberNextMap[member] = memberNextMap[HEADER];
        memberNextMap[HEADER] = member;
        listSize++;
    }

    function removeMember(address member, address preMember) public {
        require(isMember(member));
        require(memberNextMap[preMember] == member);//保证不会出错
        memberNextMap[preMember] = memberNextMap[member];
        memberNextMap[member] = address(0);
        listSize--;
    }
    function getPreMember(address member) public returns(address){
        address currentAddress = HEADER;
        while(memberNextMap[currentAddress] != HEADER){
            if(memberNextMap[member] == member){
                return currentAddress;
            }
            currentAddress = memberNextMap[currentAddress];
        }
        return address(0);
    }
    function isMember(address member) public view returns(bool){
        return memberNextMap[member] != address(0);
    }

    function getMemberList() public view returns (address[] memory){
        address[] memory memberList = new address[](listSize);
        address currentAddress = memberNextMap[HEADER];
        for(uint256 i =0; currentAddress != HEADER; i++){
            memberList[i] = currentAddress;
            currentAddress = memberNextMap[currentAddress];
        }
    }
}
contract Gas3 {
    MemberManagerV1 v1 ;
    MemberManagerV2 v2 ;
    address[10] list;
    constructor(){
        v1 = new MemberManagerV1();
        v2 = new MemberManagerV2();

        list[0]=0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266; 
        list[1]=0x70997970C51812dc3A010C7d01b50e0d17dc79C8; 
        list[2]=0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC; 
        list[3]=0x90F79bf6EB2c4f870365E785982E1f101E93b906; 
        list[4]=0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65; 
        list[5]=0x9965507D1a55bcC2695C58ba16FB37d819B0A4dc; 
        list[6]=0x976EA74026E726554dB657fA54763abd0C3a0aa9; 
        list[7]=0x14dC79964da2C08b23698B3D3cc7Ca32193d9955; 
        list[8]=0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f; 
        list[9]=0xa0Ee7A142d267C1f36714E4a8F75612F20a79720; 
    }
    function testV1_add() costGas('testV1_add') public {
        // address[] memory list = new address[](10);

        for(uint i=0; i < 10;i++){
            v1.addMember(address(list[i]));
        }
    }
        function testV2_add() costGas('testV2_add') public {
        // address[] memory list = new address[](10);

        for(uint i=0; i < 10;i++){
            v2.addMember(address(list[i]));
        }
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