// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract BoxV2 is Initializable {
    uint256 public width;
    uint256 public length;

    function initialize(uint256 _length, uint256 _width) public initializer {
        length = _length;
        width = _width;
    }

    function area() public view returns (uint256) {
        return length * width;
    }

    function perimeter() public view returns (uint256) {
        return length * 2 + width * 2;
    }
}
