pragma solidity ^0.4.20;

contract MoveIt {
    enum StateType {Active, OfferAccepted, AcceptedandPaid, Clearing, Release}
    address public PackingList;
    string public Description;
    uint public price;
    StateType public State;

    address public InstanceRetailer;
    address public InstanceShipper;
    address public InstanceAuthority;
    
    
    function Reject() public
    {
        if( State != StateType.Active && State != StateType.OfferAccepted && State != StateType.OfferAccepted && State != StateType.AcceptedandPaid && State != StateType.Clearing && State != StateType.Release) {
            revert();
        }
        
        if (InstanceShipper != msg.sender) {
            revert();
        }
        
        if (InstanceRetailer != msg.sender) {
            revert();
        }
        State = StateType.OfferAccepted;
    }
    
    function OfferSubmitted() public
    {
        if (State == StateType.Active) {
            State = StateType.OfferAccepted;
        }
        revert();
    }
    
    function Modify(string description, uint256 Price) public
    {
        if (State != StateType.Active)
        {
            revert();
        }
        
        Description = description;
        price = Price;
    }
    
    function BOLPaid() public
    {
    if (InstanceShipper == msg.sender) {
        State = StateType.AcceptedandPaid;
    }
    revert();
    }
    
    function NotSeen() public
    {
    if (InstanceAuthority != msg.sender) {
        State = StateType.AcceptedandPaid;
    }
      revert();
    }
    
    function ShipSeen() public
    {
    if (InstanceAuthority == msg.sender) {
        State = StateType.Clearing;
    }
    revert();
    }
    
    function MarkAccepted() public
    {
    if (State == StateType.Clearing) {
        State = StateType.Release;
    }
    revert();
    }
      
}
