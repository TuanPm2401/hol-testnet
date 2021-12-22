pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./ERC20/IBEP20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CrowdSale is Ownable {

    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    // The token being sold
    IERC20 private _token;

    // Address where funds are collected
    address payable private _wallet;

    // How many token units a buyer gets per wei.
    // The rate is the conversion between wei and the smallest and indivisible token unit.
    // So, if you are using a rate of 1 with a ERC20Detailed token with 3 decimals called TOK
    // 1 wei will give you 1 unit, or 0.001 TOK.
    uint256 private _rate;

    // Amount of wei raised
    uint256 private _weiRaised;


    constructor (uint256 rate, IERC20 token) public {
        require(rate > 0, "Crowdsale: rate is 0");
        require(address(token) != address(0), "Crowdsale: token is the zero address");

        _rate = rate;
        _token = token;
    }

    function buyTokens() public payable {
        uint256 amountTobuy = msg.value;

        _token.transfer(msg.sender, amountTobuy * 1000000 * _rate);
    }

    function changeRate(uint256 rate) public onlyOwner {
        _rate = rate;
    }
}