// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "./lzApp/NonblockingLzApp.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./interfaces/IStargateEthVault.sol";
import "./interfaces/IStargateRouter.sol";

interface ILido {
    function totalSupply() external view returns (uint256);
    function getTotalShares() external view returns (uint256);

    /**
      * @notice Adds eth to the pool
      * @return StETH Amount of StETH generated
      */
    function submit(address _referral) external payable returns (uint256 StETH);
}

contract Destination is NonblockingLzApp {
    IStargateRouter public stargateRouter;
    ILido public lido;
    IERC20 public steth;
    IStargateEthVault public stargateEthVault;

    constructor(
        address _lzEndpoint,
        address _stargateRouter,
        address _lido,
        address _steth,
        address _stargateEthVault
    ) NonblockingLzApp(_lzEndpoint) {
        stargateRouter = IStargateRouter(_stargateRouter);
        lido = ILido(_lido);
        steth = IERC20(_steth);
        stargateEthVault = IStargateEthVault(_stargateEthVault);
    }

    function _nonblockingLzReceive(
        uint16 _srcChainId, 
        bytes memory _srcAddress, 
        uint64 _nonce, 
        bytes memory _payload
    ) internal override {
      
    }

    function sgReceive(
        uint16 _chainId, 
        bytes memory _srcAddress, 
        uint _nonce, 
        address _token, 
        uint amountLD, 
        bytes memory _payload
    ) external {
        require(msg.sender == address(stargateRouter), "Unauthorized");
        require(_token == address(0), "Invalid token");
        require(_token == address(stargateEthVault), "not sgETH");

        // Decode data
        (address sender) = abi.decode(data, (address));

        // Transfer ETH from Stargate to this contract
        stargateEthVault.withdraw(amountLD);

        // Mint stETH
        uint256 stethAmount = lido.submit{value: amountLD}(address(this.owner));

        // Transfer stETH to destination address
        steth.transfer(sender, stethAmount);
    }
}