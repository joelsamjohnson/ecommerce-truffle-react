// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract RoleManagement {
    address public Owner;

    constructor() {
        Owner = msg.sender;
    }

    modifier onlyByOwner() {
        require(msg.sender == Owner);
        _;
    }

    struct Manufacturer {
        address addr;
        uint256 id;
        string name;
        string place;
    }

    struct Distributor {
        address addr;
        uint256 id;
        string name;
        string place;
    }

    struct Retailer {
        address addr;
        uint256 id;
        string name;
        string place;
    }

    uint256 public manCtr;
    uint256 public disCtr;
    uint256 public retCtr;

    mapping(uint256 => Manufacturer) public MAN;
    mapping(uint256 => Distributor) public DIS;
    mapping(uint256 => Retailer) public RET;

    function addManufacturer(address _address, string memory _name, string memory _place) public onlyByOwner {
        manCtr++;
        MAN[manCtr] = Manufacturer(_address, manCtr, _name, _place);
    }

    function addDistributor(address _address, string memory _name, string memory _place) public onlyByOwner {
        disCtr++;
        DIS[disCtr] = Distributor(_address, disCtr, _name, _place);
    }

    function addRetailer(address _address, string memory _name, string memory _place) public onlyByOwner {
        retCtr++;
        RET[retCtr] = Retailer(_address, retCtr, _name, _place);
    }
}
