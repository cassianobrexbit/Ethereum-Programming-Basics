pragma solidity ^0.4.18;

contract RegisterCrud {

    struct RegisterStruct {

        bytes32 registerOwnerName;
        bytes16 registerOrigin;
        bytes16 registerDestination;
        uint registerNumber;
        uint equipmentsIndex;
        uint index;
        mapping(uint => EquipmentStruct) equipmentStructs;
    }

    struct EquipmentStruct{
        bytes32 equipmentDescription;
        bytes16 equipmentUnit;
        uint equipmentQuantity;
    }

    mapping(bytes16 => RegisterStruct)  registerStructs;
    bytes16[] public registerIndex;

    event LogNewRegister   (bytes16  indexed registerUuid, uint index, bytes32 registerOwnerName, bytes16 registerOrigin, bytes16 registerDestination, uint registerNumber);
    event LogUpdateRegister(bytes16  indexed registerUuid, uint index, bytes32 registerOwnerName, bytes16 registerOrigin, bytes16 registerDestination, uint registerNumber);
    event LogDeleteRegister(bytes16  indexed registerUuid, uint index);
    
    function isRegister(bytes16  registerUuid)
        public 
        constant
        returns(bool isIndeed) 
    {
        if(registerIndex.length == 0) return false;
        return (registerIndex[registerStructs[registerUuid].index] == registerUuid);
    }

    function insertRegister(
        bytes16 registerUuid, 
        bytes32 registerOwnerName,
        bytes16 registerOrigin,
        bytes16 registerDestination, 
        uint    registerNumber) 
        public
        returns(uint index)
    {
        if(isRegister(registerUuid))
            throw; 
        registerStructs[registerUuid].registerOwnerName = registerOwnerName;
        registerStructs[registerUuid].registerOrigin = registerOrigin;
        registerStructs[registerUuid].registerDestination = registerDestination;
        registerStructs[registerUuid].registerNumber = registerNumber;
        registerStructs[registerUuid].index = registerIndex.push(registerUuid)-1;
        
        emit LogNewRegister(
            registerUuid, 
            registerStructs[registerUuid].index, 
            registerOwnerName,
            registerOrigin,
            registerDestination, 
            registerNumber
        );
        return registerIndex.length-1;
    }
    
    function getRegister(bytes16 registerUuid)
        public 
        constant
        returns(uint registerNumber, bytes32 registerOwnerName, bytes16 registerOrigin, bytes16 registerDestination, uint equipmentsIndex, uint index)
    {
        if(!isRegister(registerUuid))
            throw; 
        
        return(

            registerStructs[registerUuid].registerNumber,
            registerStructs[registerUuid].registerOwnerName,
            registerStructs[registerUuid].registerOrigin, 
            registerStructs[registerUuid].registerDestination,
            registerStructs[registerUuid].equipmentsIndex,  
            registerStructs[registerUuid].index
        );
    } 


    function insertEquipment(bytes16 rUuid, bytes32 eDesc, uint eQuant, bytes16 eUnit) public{

        RegisterStruct storage rs = registerStructs[rUuid];

        rs.equipmentStructs[rs.equipmentsIndex].equipmentDescription = eDesc;
        rs.equipmentStructs[rs.equipmentsIndex].equipmentQuantity = eQuant;
        rs.equipmentStructs[rs.equipmentsIndex].equipmentUnit = eUnit;
        rs.equipmentsIndex++;

    }

    function getEquipments(bytes16 rUuid, uint eIndex) public constant returns(bytes32 eDesc, uint eQuant, bytes16 eUnit)
    {
        
        return(
            registerStructs[rUuid].equipmentStructs[eIndex].equipmentDescription,
            registerStructs[rUuid].equipmentStructs[eIndex].equipmentQuantity,
            registerStructs[rUuid].equipmentStructs[eIndex].equipmentUnit
        );
    }

    function getRegisterCount() 
        public
        constant
        returns(uint count)
    {
        return registerIndex.length;
    }

    function getRegisterAtIndex(uint index)
        public
        constant
        returns(bytes16  registerUuid)
    {
        return registerIndex[index];
    }

    function deleteRegister(bytes16  registerUuid) 
    public
    returns(uint index)
    {
        if(!isRegister(registerUuid)) 
            throw;

        uint rowToDelete = registerStructs[registerUuid].index;
        bytes16 keyToMove = registerIndex[registerIndex.length-1];

        registerIndex[rowToDelete] = keyToMove;
        registerStructs[keyToMove].index = rowToDelete; 
        registerIndex.length--;

        emit LogDeleteRegister(
            registerUuid, 
            rowToDelete
        );
        emit LogUpdateRegister(
            keyToMove, 
            rowToDelete, 
            registerStructs[keyToMove].registerOwnerName,
            registerStructs[keyToMove].registerOrigin, 
            registerStructs[keyToMove].registerDestination,  
            registerStructs[keyToMove].registerNumber
        );
        return rowToDelete;
    }
    
    function updateRegisterOrigin(bytes16  registerUuid, bytes32 registerOwnerName) 
        public
        returns(bool success) 
    {
        if(!isRegister(registerUuid))
            throw; 

        registerStructs[registerUuid].registerOwnerName = registerOwnerName;
        
        emit LogUpdateRegister(
            registerUuid, 
            registerStructs[registerUuid].index,
            registerOwnerName,
            registerStructs[registerUuid].registerOrigin, 
            registerStructs[registerUuid].registerDestination,   
            registerStructs[registerUuid].registerNumber
        );
        
        return true;
    }
    
    function updateRegisterNumber(bytes16  registerUuid, uint registerNumber) 
        public
        returns(bool success) 
    {
        if(!isRegister(registerUuid))
            throw; 
        registerStructs[registerUuid].registerNumber = registerNumber;
        
        emit LogUpdateRegister(
            registerUuid, 
            registerStructs[registerUuid].index,
            registerStructs[registerUuid].registerOwnerName,
            registerStructs[registerUuid].registerOrigin, 
            registerStructs[registerUuid].registerDestination, 
            registerNumber
        );
        
        return true;
    }

}
