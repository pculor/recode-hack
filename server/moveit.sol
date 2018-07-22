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
    enum StateType {Active, AcceptedandPaid, Clearing, Release, Terminated}
    string public PackingList;
    string public Description;
    uint public price;
    StateType public State;

    address public InstanceRetailer;
    address public InstanceShipper;
    address public InstanceAuthority;
    
    function MoveIt(string packlist, string description, uint256 bill_of_lading) public
    {
        InstanceShipper = msg.sender;
        bill_of_lading = bill_of_lading;
        Description = description;
        PackingList = packlist;
        State = StateType.Active;
        ContractCreated();
    }
    
    function Terminate() public
    {
        if( State != StateType.Active && State != StateType.AcceptedandPaid && State != StateType.Clearing && State != StateType.Release) {
            revert();
        }
        
        if (InstanceShipper != msg.sender) {
            revert();
        }
        if (State == StateType.Terminated) {
            revert();
        }
        
        if (InstanceRetailer != msg.sender) {
            revert();
        }
        State = StateType.AcceptedandPaid;
    }
    
    function OfferAccepted() public
    {
        if (State != StateType.Terminated) {
            State = StateType.AcceptedandPaid;
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
    
    function AcceptandPaid() public
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
