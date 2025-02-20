// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./DSREToken.sol";
import "./StudyResourceNFT.sol";

contract DSREMarketplace {
    DSREToken public dsreToken;
    StudyResourceNFT public studyResourceNFT;
    address public owner;

    struct Listing {
        uint256 price;
        address seller;
        bool isSold;
    }

    mapping(uint256 => Listing) public listings;

    constructor(address _dsreTokenAddress, address _studyResourceNFTAddress) {
        dsreToken = DSREToken(_dsreTokenAddress);
        studyResourceNFT = StudyResourceNFT(_studyResourceNFTAddress);
        owner = msg.sender;
    }

    event Listed(uint256 indexed tokenId, uint256 price, address indexed seller);
    event Purchased(uint256 indexed tokenId, address indexed buyer);

    function listResource(uint256 tokenId, uint256 price) public {
        require(studyResourceNFT.ownerOf(tokenId) == msg.sender, "Not the owner");
        require(price > 0, "Price must be greater than 0");
        
        studyResourceNFT.transferFrom(msg.sender, address(this), tokenId);

        listings[tokenId] = Listing(price, msg.sender, false);

        emit Listed(tokenId, price, msg.sender);
    }

    function buyResource(uint256 tokenId) public {
        Listing memory listing = listings[tokenId];
        require(listing.price > 0, "Resource not listed");
        require(!listing.isSold, "Resource already sold");

        dsreToken.transferFrom(msg.sender, listing.seller, listing.price);

        studyResourceNFT.transferFrom(address(this), msg.sender, tokenId);
        listings[tokenId].isSold = true;

        emit Purchased(tokenId, msg.sender);
    }
}
