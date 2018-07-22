pragma solidity ^0.4.20;

contract WorkbenchBase {
    event WorkbenchContractCreated(string applicationName, string workflowName, address originatingAddress);
    event WorkbenchContractUpdated(string applicationName, string workflowName, string action, address originatingAddress);

    string internal ApplicationName;
    string internal WorkflowName;

    
    function WorkbenchBase(string applicationName, string workflowName) internal 
    {
        ApplicationName = applicationName;
        WorkflowName = workflowName;
    }

    function ContractCreated() internal {
        WorkbenchContractCreated(ApplicationName, WorkflowName, msg.sender);
    }

    function ContractUpdated(string action) internal {
        WorkbenchContractUpdated(ApplicationName, WorkflowName, action, msg.sender);
    }
}

contract MoveIt is WorkbenchBase('MoveIt', 'MoveIt') {
    enum StateType {Active, OfferAccepted, AcceptedandPaid, Clearing, Release}
    address public PackingList;
    string public Description;
    uint public price;
    StateType public State;

    address public InstanceRetailer;
    address public InstanceShipper;
    address public InstanceAuthority;
    
    function MoveIt(uint256 bill_of_lading) public
    {
        InstanceRetailer = msg.sender;
        bill_of_lading = bill_of_lading;
        State = StateType.Active;
        ContractCreated();
    }
    
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
    
    function Modify(uint256 bill_of_lading) public
    {
        if (State != StateType.Active)
        {
            revert();
        }
        
        bill_of_lading = bill_of_lading;
        ContractUpdated('Modify');
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
