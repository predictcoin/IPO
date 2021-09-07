pragma solidity ^0.5.0;

import "@openzeppelin/contracts/crowdsale/distribution/PostDeliveryCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/AllowanceCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";



contract IPO is PostDeliveryCrowdsale, AllowanceCrowdsale, CappedCrowdsale{
    
    
    mapping(address => uint256) private _contributions;
    uint public _individualCap;
    
    constructor (uint startTime, uint stopTime) public 
        Crowdsale(100, 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB, IERC20(0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8)) 
        CappedCrowdsale(170 ether) 
        AllowanceCrowdsale(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4) 
        TimedCrowdsale(startTime, stopTime) 
        PostDeliveryCrowdsale() {
        _individualCap = 1000000000000000000;
    }
    
    function getIndividualContribution() public view returns(uint256){
        return _individualCap;
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
        require(weiAmount >= 0.1 ether, "IPO: weiAmount less than minimum contribution");
        uint contribution = _contributions[beneficiary].add(weiAmount);
        require(contribution <= _individualCap, "IPO: beneficiary's cap exceeded");
    }
    
    function _updatePurchasingState(address beneficiary, uint256 weiAmount) internal {
        super._updatePurchasingState(beneficiary, weiAmount);
        _contributions[beneficiary] = _contributions[beneficiary].add(weiAmount);
    }
}
