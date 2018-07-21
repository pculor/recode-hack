pragma solidity ^0.4.20;

contract WorkbenchBase {
    event WorkbenchContractCreated(string applicationName,
    string workflowName, address originatingAddress);
    
    event WorkbenchContractUpdated(string applicationName,
    string workflowName, string action, address originatingAddress);

    string internal ApplicationName;
    string internal WorkflowName;

    function WorkbenchBase(string applicationName, string workflowName) internal {
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

contract MoveIt is WorkbenchBase('Moveit', 'MoveIt') {
    enum StateType {Active, Terminated, OfferPlaced, PendingInspection, Inspected}
    address public PackingList;
    string public Description;
    StateType public State;

    address public InstanceBuyer;
    address public InstanceRetailer;
    address public InstanceShipper;
    address public InstanceAuthority;
    
    function MoveIt() {
        
    }
    
    function Reject(){
        
    }
    
    function OfferSubmitted(){
        
    }
    
    function Modify() {
        
    }
    
    function BOLPaid(){
        
    }
    
    function NotSeen() {
        
    }
    
    function ShipSeen() {
        
    }
    
    function MarkAccepted() {
        
    }
    
    
    
}
