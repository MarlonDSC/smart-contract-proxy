// SPDX-License-Identifier: MIT LICENSE

pragma solidity ^0.8.2;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

// import "@openzeppelin/contracts-upgradable/";
// import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

// import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
// import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
// import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
// import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
// import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
// import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

// ERC721Upgradeable,

contract LandRegistry is
    Initializable,
    ERC721URIStorageUpgradeable,
    ERC721EnumerableUpgradeable,
    OwnableUpgradeable,
    UUPSUpgradeable
{
    struct TokenInfo {
        IERC20 paytoken;
        uint256 costvalue;
    }

    TokenInfo[] public AllowedCrypto;

    using StringsUpgradeable for uint256;
    string public baseURI;
    string public baseExtension;
    uint256 public maxSupply;
    bool public paused;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        __ERC721_init("Marstack LAND", "LAND");
        __ERC721Enumerable_init();
        __ERC721URIStorage_init();
        __Ownable_init();
        __UUPSUpgradeable_init();
        paused = false;
        maxSupply = 46226;
        baseExtension = ".json";
    }

    // function initialize() public initializer {
    //     __ERC721_init("Marstack LAND", "LAND");
    //     __ERC721Enumerable_init();
    //     __ERC721URIStorage_init();
    //     __Ownable_init();
    //     __UUPSUpgradeable_init();
    //     paused = false;
    //     maxSupply = 46226;
    //     baseExtension = ".json";
    // }

    function _authorizeUpgrade(address newImplementation)
        internal
        override
        onlyOwner
    {}

    event Mint(address user, uint256 cost);

    function addCurrency(IERC20 _paytoken, uint256 _costvalue)
        public
        onlyOwner
    {
        AllowedCrypto.push(
            TokenInfo({paytoken: _paytoken, costvalue: _costvalue})
        );
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return "ipfs://EE5MmqVp5MmqVp7ZRMBBizicVh9ficVh9fjUofWicVh9f/";
    }

    function mintLand(
        uint256 _mintAmount,
        uint256[] memory NFTId,
        uint256 cryptoTokenId,
        string memory uri
    ) public payable {
        TokenInfo storage tokens = AllowedCrypto[cryptoTokenId];
        IERC20 paytoken;
        paytoken = tokens.paytoken;
        uint256 cost;
        cost = tokens.costvalue;
        uint256 supply = totalSupply();
        require(!paused);
        require(_mintAmount > 0);
        require(supply + _mintAmount <= maxSupply);

        if (msg.sender != owner()) {
            require(
                msg.value >= cost * _mintAmount,
                "Not enough balance to complete transaction."
            );
        }

        for (uint256 i = 1; i <= _mintAmount; i++) {
            paytoken.transferFrom(msg.sender, address(this), msg.value);
            safeMint(msg.sender, NFTId[i - 1], uri);
            emit Mint(msg.sender, msg.value);
        }
    }

    function safeMint(
        address to,
        uint256 tokenId,
        string memory uri
    ) public onlyOwner {
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    function walletOfOwner(address _owner)
        public
        view
        returns (uint256[] memory)
    {
        uint256 ownerTokenCount = balanceOf(_owner);
        uint256[] memory tokenIds = new uint256[](ownerTokenCount);
        for (uint256 i; i < ownerTokenCount; i++) {
            tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
        }
        return tokenIds;
    }

    // function tokenURI(uint256 tokenId)
    //     public
    //     view
    //     virtual
    //     override
    //     returns (string memory)
    // {
    //     require(
    //         _exists(tokenId),
    //         "ERC721Metadata: URI query for nonexistent token"
    //     );

    //     string memory currentBaseURI = _baseURI();
    //     return
    //         bytes(currentBaseURI).length > 0
    //             ? string(
    //                 abi.encodePacked(
    //                     currentBaseURI,
    //                     tokenId.toString(),
    //                     baseExtension
    //                 )
    //             )
    //             : "";
    // }

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }

    function setBaseExtension(string memory _newBaseExtension)
        public
        onlyOwner
    {
        baseExtension = _newBaseExtension;
    }

    function pause(bool _state) public onlyOwner {
        paused = _state;
    }

    function withdraw(uint256 _pid) public payable onlyOwner {
        TokenInfo storage tokens = AllowedCrypto[_pid];
        IERC20 paytoken;
        paytoken = tokens.paytoken;
        paytoken.transfer(msg.sender, paytoken.balanceOf(address(this)));
    }

    // The following functions are overrides required by Solidity.

    // function _beforeTokenTransfer(
    //     address from,
    //     address to,
    //     uint256 tokenId
    // ) internal override(ERC721Upgradeable, ERC721EnumerableUpgradeable) {
    //     super._beforeTokenTransfer(from, to, tokenId);
    // }

    // function supportsInterface(bytes4 interfaceId)
    //     public
    //     view
    //     override(ERC721Upgradeable, ERC721EnumerableUpgradeable)
    //     returns (bool)
    // {
    //     return super.supportsInterface(interfaceId);
    // }
    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721Upgradeable, ERC721EnumerableUpgradeable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
    {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721Upgradeable, ERC721URIStorageUpgradeable)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721Upgradeable, ERC721EnumerableUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
