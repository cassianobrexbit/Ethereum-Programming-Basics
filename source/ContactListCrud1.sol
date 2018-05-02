pragma solidity ^0.4.18;

contract ContactListCrud {

    struct ContactListStruct {

        bytes32 contactListDescription;
        uint contactsIndex;
        uint index;
        mapping(uint => ContactStruct) contactStructs;
    }

    struct ContactStruct{

        bytes32 contactName;
        bytes16 contactEmail;
        bytes16 contactPhone;
        uint contactAge;

    }

    mapping(bytes16 => ContactListStruct)  contactListStructs;
    bytes16[] public contactListIndex;

    event LogNewContactList   (bytes16  indexed contactListUuid, uint index, bytes32 contactListDescription);

    function insertContactList(bytes16 contactListUuid, bytes32 contactListDescription) public returns(uint index) {
        
        contactListStructs[contactListUuid].contactListDescription = contactListDescription;
        contactListStructs[contactListUuid].index = contactListIndex.push(contactListUuid)-1;
        
        emit LogNewContactList(
            contactListUuid, 
            contactListStructs[contactListUuid].index, 
            contactListDescription
        );
        return contactListIndex.length-1;
    }
    
    function getContactList(bytes16 contactListUuid) public constant returns(bytes32 contactListDescription, uint contactsIndex, uint index)
    {
        return(

            contactListStructs[contactListUuid].contactListDescription,
            contactListStructs[contactListUuid].contactsIndex,  
            contactListStructs[contactListUuid].index
        );
    } 


    function insertContact(bytes16 rUuid, bytes32 cName, uint cAge, bytes16 cEmail, bytes16 cPhone) public{

        ContactListStruct storage rs = contactListStructs[rUuid];

        rs.contactStructs[rs.contactsIndex].contactName = cName;
        rs.contactStructs[rs.contactsIndex].contactAge = cAge;
        rs.contactStructs[rs.contactsIndex].contactEmail = cEmail;
        rs.contactStructs[rs.contactsIndex].contactPhone = cPhone;
        rs.contactsIndex++;

    }

    function getContacts(bytes16 rUuid, uint eIndex) public constant returns(bytes32 cName, uint cAge, bytes16 cEmail)
    {
        
        return(
            contactListStructs[rUuid].contactStructs[eIndex].contactName,
            contactListStructs[rUuid].contactStructs[eIndex].contactAge,
            contactListStructs[rUuid].contactStructs[eIndex].contactEmail
        );
    }

    function getContactListCount() public constant returns(uint count){

        return contactListIndex.length;

    }

    function getContactListAtIndex(uint index) public constant returns(bytes16  contactListUuid){

        return contactListIndex[index];

    }

}
