pragma solidity ^0.4.18;

contract ContacListCrud{

    struct ContacListStruct{

        bytes16 contacListUuid; 
        bytes32 contacListDescription;
        uint index;
        uint contacListContactsAge;
        mapping (uint => bytes16) contacListContacts;

    }

    mapping(bytes16 => ContacListStruct) contacListStructs;
    bytes16[] public contacListIndex;

    ContactCrud contactCrudContract;

    function setContactCrudContract(address contactContract) public {

        contactCrudContract = ContactCrud(contactContract);

    }

    function insertContacList(bytes16 contacListUuid, bytes32 contacListDescription) public returns (uint rIndex){

        contacListStructs[contacListUuid].contacListDescription = contacListDescription;
        contacListStructs[contacListUuid].index = contacListIndex.push(contacListUuid)-1;

        return contacListIndex.length-1;
    }

    function insertContact(uint contactIndex, bytes16 rUuid) public {

        ContacListStruct storage rs = contacListStructs[rUuid];

        bytes16 pointUuid = contactCrudContract.getContactAtIndex(contactIndex);

        rs.contacListContacts[rs.contacListContactsAge++] = pointUuid;
    }

    function getContacListCount() 
        public
        constant
        returns(uint count)
    {
        return contacListIndex.length;
    }

    function getContacListContacts(bytes16 contacListUuid, uint pointIndex) public constant returns(bytes16 pointUuid)
    {
        return contacListStructs[contacListUuid].contacListContacts[pointIndex];
    }

    function getContacListContactsCount(bytes16 contacListUuid) 
        public 
        constant 
        returns(uint pointCount)
    {
        return contacListStructs[contacListUuid].contacListContactsAge;
    }

    function getContacListAtIndex(uint index)
        public
        constant
        returns(bytes16  contactUuid)
    {
        return contacListIndex[index];
    }

    function getContacList(bytes16 contacListUuid)
        public 
        constant
        returns(bytes32 contacListDescription, uint contactAge)
    {
       
        return(
            contacListStructs[contacListUuid].contacListDescription,
            contacListStructs[contacListUuid].contacListContactsAge
        );
    }

}

contract ContactCrud {

    struct ContactStruct {

        bytes32 contactName;
        bytes16 contactEmail;
        bytes16 contactPhone;
        uint contactAge;
        uint index;
        
    }
  
    mapping(bytes16 => ContactStruct)  contactStructs;
    bytes16[] public contactIndex;

    event LogNewContact   (bytes16  indexed contactUuid, uint index, bytes32 contactName, bytes16 contactEmail, bytes16 contactPhone, uint contactAge);
    event LogUpdateContact(bytes16  indexed contactUuid, uint index, bytes32 contactName, bytes16 contactEmail, bytes16 contactPhone, uint contactAge);
    event LogDeleteContact(bytes16  indexed contactUuid, uint index);
    
    function isContact(bytes16  contactUuid)
        public 
        constant
        returns(bool isIndeed) 
    {
        if(contactIndex.length == 0) return false;
        return (contactIndex[contactStructs[contactUuid].index] == contactUuid);
    }

    function insertContact(bytes16 contactUuid, bytes32 contactName, bytes16 contactEmail, bytes16 contactPhone, uint contactAge) public returns(uint index)
    {
        contactStructs[contactUuid].contactName = contactName;
        contactStructs[contactUuid].contactEmail = contactEmail;
        contactStructs[contactUuid].contactPhone = contactPhone;
        contactStructs[contactUuid].contactAge = contactAge;
        contactStructs[contactUuid].index = contactIndex.push(contactUuid)-1;
        
        return contactIndex.length-1;
    }
    
    function getContact(bytes16 contactUuid)
        public 
        constant
        returns(bytes32 contactName, bytes16 contactEmail, bytes16 contactPhone, uint contactAge, uint index)
    {
        if(!isContact(contactUuid))
            throw; 
        
        return(
            contactStructs[contactUuid].contactName,
            contactStructs[contactUuid].contactEmail, 
            contactStructs[contactUuid].contactPhone, 
            contactStructs[contactUuid].contactAge, 
            contactStructs[contactUuid].index
        );
    } 

    function getContactCount() 
        public
        constant
        returns(uint count)
    {
        return contactIndex.length;
    }

    function getContactAtIndex(uint index)
        public
        constant
        returns(bytes16  contactUuid)
    {
        return contactIndex[index];
    }

    function deleteContact(bytes16  contactUuid) 
    public
    returns(uint index)
    {
        if(!isContact(contactUuid)) 
            throw;

        uint rowToDelete = contactStructs[contactUuid].index;
        bytes16 keyToMove = contactIndex[contactIndex.length-1];

        contactIndex[rowToDelete] = keyToMove;
        contactStructs[keyToMove].index = rowToDelete; 
        contactIndex.length--;

        emit LogDeleteContact(
            contactUuid, 
            rowToDelete
        );
        emit LogUpdateContact(
            keyToMove, 
            rowToDelete, 
            contactStructs[keyToMove].contactName,
            contactStructs[keyToMove].contactEmail, 
            contactStructs[keyToMove].contactPhone,  
            contactStructs[keyToMove].contactAge
        );
        return rowToDelete;
    }
    
    function updateContactName(bytes16  contactUuid, bytes32 contactName) 
        public
        returns(bool success) 
    {
        if(!isContact(contactUuid))
            throw; 

        contactStructs[contactUuid].contactName = contactName;
        
        emit LogUpdateContact(
            contactUuid, 
            contactStructs[contactUuid].index,
            contactName,
            contactStructs[contactUuid].contactEmail, 
            contactStructs[contactUuid].contactPhone,   
            contactStructs[contactUuid].contactAge
        );
        
        return true;
    }
    
    function updateContactAge(bytes16  contactUuid, uint contactAge) 
        public
        returns(bool success) 
    {
        if(!isContact(contactUuid))
            throw; 
        contactStructs[contactUuid].contactAge = contactAge;
        
        emit LogUpdateContact(
            contactUuid, 
            contactStructs[contactUuid].index,
            contactStructs[contactUuid].contactName,
            contactStructs[contactUuid].contactEmail, 
            contactStructs[contactUuid].contactPhone, 
            contactAge
        );
        
        return true;
    }

}
