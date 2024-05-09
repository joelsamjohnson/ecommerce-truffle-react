// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ProductManagement.sol";

contract TransactionManagement is ProductManagement {
    
    //To manufacture product
    function Manufacturing(uint256 _productID) public {
        require(_productID > 0 && _productID <= productCtr);
        uint256 _id = findMAN(msg.sender);
        require(_id > 0);
        require(ProductStock[_productID].stage == STAGE.Init);
        ProductStock[_productID].MANid = _id;
        ProductStock[_productID].stage = STAGE.Manufacture;
    }

    //To check if Manufacturer is available in the blockchain
    function findMAN(address _address) private view returns (uint256) {
        require(manCtr > 0);
        for (uint256 i = 1; i <= manCtr; i++) {
            if (MAN[i].addr == _address) return MAN[i].id;
        }
        return 0;
    }

    //To supply products from Manufacturer to distributor
    function Distribute(uint256 _productID) public {
        require(_productID > 0 && _productID <= productCtr);
        uint256 _id = findDIS(msg.sender);
        require(_id > 0);
        require(ProductStock[_productID].stage == STAGE.Manufacture);
        ProductStock[_productID].DISid = _id;
        ProductStock[_productID].stage = STAGE.Distribution;
    }

    //To check if distributor is available in the blockchain
    function findDIS(address _address) private view returns (uint256) {
        require(disCtr > 0);
        for (uint256 i = 1; i <= disCtr; i++) {
            if (DIS[i].addr == _address) return DIS[i].id;
        }
        return 0;
    }

    //To supply products from distributor to retailer
    function Retail(uint256 _productID) public {
        require(_productID > 0 && _productID <= productCtr);
        uint256 _id = findRET(msg.sender);
        require(_id > 0);
        require(ProductStock[_productID].stage == STAGE.Distribution);
        ProductStock[_productID].RETid = _id;
        ProductStock[_productID].stage = STAGE.Retail;
    }

    //To check if retailer is available in the blockchain
    function findRET(address _address) private view returns (uint256) {
        require(retCtr > 0);
        for (uint256 i = 1; i <= retCtr; i++) {
            if (RET[i].addr == _address) return RET[i].id;
        }
        return 0;
    }

    mapping(address => uint[]) public purchases;

    function purchaseProduct(uint256 _productID) public payable {
        require(_productID > 0 && _productID <= productCtr);
        require(ProductStock[_productID].stage == STAGE.Retail);
        require(msg.value == ProductStock[_productID].price);

        // Transfer the payment to the retailer
        address payable retailerAddress = payable(RET[ProductStock[_productID].RETid].addr);
        retailerAddress.transfer(msg.value);

        // Update product stage to sold
        ProductStock[_productID].stage = STAGE.Sold;
        purchases[msg.sender].push(_productID);
    }

}
