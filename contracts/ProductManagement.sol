// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./RoleManagement.sol";
contract ProductManagement is RoleManagement {
    enum STAGE { Init, Manufacture, Distribution, Retail, Sold }

    uint256 public productCtr;

    struct Product {
        uint256 id;
        string name;
        string description;
        uint256 price;
        string imageHash;
        uint256 MANid;
        uint256 DISid;
        uint256 RETid;
        STAGE stage;
    }

    mapping(uint256 => Product) public ProductStock;

    function addProduct(string memory _name, string memory _description, uint256 _price, string memory _imageHash)
        public
        onlyByOwner
    {
        productCtr++;
        ProductStock[productCtr] = Product(productCtr, _name, _description, _price, _imageHash, 0, 0, 0, STAGE.Init);
    }
}
