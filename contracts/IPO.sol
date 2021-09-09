pragma solidity ^0.5.0;

import "@openzeppelin/contracts/crowdsale/distribution/PostDeliveryCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/AllowanceCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";



contract IPO is PostDeliveryCrowdsale, AllowanceCrowdsale, CappedCrowdsale{
    
    
    mapping(address => uint256) private _contributions;
    uint public individualCap;
    uint public individualFloor;
    
    constructor (uint startTime, uint stopTime) public 
        Crowdsale(50, 0x43833a52813ae6BdCfeaf7deb46351cE00c740F7, IERC20(0xB2d7b35539A543bbE4c74965488fFE33c6721f0d)) 
        CappedCrowdsale(360 ether) 
        AllowanceCrowdsale(0xDC7eDEE4d0A8dc5F38CA1590c6e9Dd9c049D79a6) 
        TimedCrowdsale(startTime, stopTime) 
        PostDeliveryCrowdsale() {
        individualCap = 2 ether;
        individualFloor = 0.2 ether;
    }
    
    function getIndividualContribution() public view returns(uint256){
        return individualCap;
    }
    
    /**
     * @dev Returns the amount contributed so far by a specific beneficiary.
     * @param beneficiary Address of contributor
     * @return Beneficiary contribution so far
     */
    function getContribution(address beneficiary) public view returns (uint256) {
        return _contributions[beneficiary];
    }
    
    /**
    * @dev Extend parent behavior requiring purchase to respect the beneficiary's funding cap.
    * @param beneficiary Token purchaser
    * @param weiAmount Amount of wei contributed
    */
    function _preValidatePurchase(address beneficiary, uint256 weiAmount) internal view {
        super._preValidatePurchase(beneficiary, weiAmount);
        // solhint-disable-next-line max-line-length
        require(weiAmount >= individualFloor, "IPO: weiAmount less than minimum contribution");
        uint contribution = _contributions[beneficiary].add(weiAmount);
        require(contribution <= individualCap, "IPO: beneficiary's cap exceeded");
    }
    
    function _updatePurchasingState(address beneficiary, uint256 weiAmount) internal {
        super._updatePurchasingState(beneficiary, weiAmount);
        _contributions[beneficiary] = _contributions[beneficiary].add(weiAmount);
    }
}
