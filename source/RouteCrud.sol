pragma solidity ^0.4.18;

contract RouteCrud{

    struct RouteStruct{

        bytes16 routeUuid; 
        bytes32 routeName;
        uint index;
        uint routePointsNumber;
        mapping (uint => bytes16) routePoints;

    }

    mapping(bytes16 => RouteStruct) routeStructs;
    bytes16[] public routeIndex;

    PlaceCrud placeCrudContract;

    function setPlaceCrudContract(address placeContract) public {

        placeCrudContract = PlaceCrud(placeContract);

    }

    function insertRoute(bytes16 routeUuid, bytes32 routeName) public returns (uint rIndex){

        routeStructs[routeUuid].routeName = routeName;
        routeStructs[routeUuid].index = routeIndex.push(routeUuid)-1;

        return routeIndex.length-1;
    }

    function insertPoint(uint placeIndex, bytes16 rUuid) public {

        RouteStruct storage rs = routeStructs[rUuid];

        bytes16 pointUuid = placeCrudContract.getPlaceAtIndex(placeIndex);

        rs.routePoints[rs.routePointsNumber++] = pointUuid;
    }

    function getRouteCount() 
        public
        constant
        returns(uint count)
    {
        return routeIndex.length;
    }

    function getRoutePoints(bytes16 routeUuid, uint pointIndex) public constant returns(bytes16 pointUuid)
    {
        return routeStructs[routeUuid].routePoints[pointIndex];
    }

    function getRoutePointsCount(bytes16 routeUuid) 
        public 
        constant 
        returns(uint pointCount)
    {
        return routeStructs[routeUuid].routePointsNumber;
    }

    function getRouteAtIndex(uint index)
        public
        constant
        returns(bytes16  placeUuid)
    {
        return routeIndex[index];
    }

    function getRoute(bytes16 routeUuid)
        public 
        constant
        returns(bytes32 routeName, uint placeNumber)
    {
       
        return(
            routeStructs[routeUuid].routeName,
            routeStructs[routeUuid].routePointsNumber
        );
    }

}

contract PlaceCrud {

    struct PlaceStruct {

        bytes32 placeLocation;
        bytes16 placeLatd;
        bytes16 placeLongtd;
        uint placeNumber;
        uint index;
        
    }
  
    mapping(bytes16 => PlaceStruct)  placeStructs;
    bytes16[] public placeIndex;

    event LogNewPlace   (bytes16  indexed placeUuid, uint index, bytes32 placeLocation, bytes16 placeLatd, bytes16 placeLongtd, uint placeNumber);
    event LogUpdatePlace(bytes16  indexed placeUuid, uint index, bytes32 placeLocation, bytes16 placeLatd, bytes16 placeLongtd, uint placeNumber);
    event LogDeletePlace(bytes16  indexed placeUuid, uint index);
    
    function isPlace(bytes16  placeUuid)
        public 
        constant
        returns(bool isIndeed) 
    {
        if(placeIndex.length == 0) return false;
        return (placeIndex[placeStructs[placeUuid].index] == placeUuid);
    }

    function insertPlace(bytes16 placeUuid, bytes32 placeLocation, bytes16 placeLatd, bytes16 placeLongtd, uint placeNumber) public returns(uint index)
    {
        placeStructs[placeUuid].placeLocation = placeLocation;
        placeStructs[placeUuid].placeLatd = placeLatd;
        placeStructs[placeUuid].placeLongtd = placeLongtd;
        placeStructs[placeUuid].placeNumber = placeNumber;
        placeStructs[placeUuid].index = placeIndex.push(placeUuid)-1;
        
        return placeIndex.length-1;
    }
    
    function getPlace(bytes16 placeUuid)
        public 
        constant
        returns(bytes32 placeLocation, bytes16 placeLatd, bytes16 placeLongtd, uint placeNumber, uint index)
    {
        if(!isPlace(placeUuid))
            throw; 
        
        return(
            placeStructs[placeUuid].placeLocation,
            placeStructs[placeUuid].placeLatd, 
            placeStructs[placeUuid].placeLongtd, 
            placeStructs[placeUuid].placeNumber, 
            placeStructs[placeUuid].index
        );
    } 

    function getPlaceCount() 
        public
        constant
        returns(uint count)
    {
        return placeIndex.length;
    }

    function getPlaceAtIndex(uint index)
        public
        constant
        returns(bytes16  placeUuid)
    {
        return placeIndex[index];
    }

    function deletePlace(bytes16  placeUuid) 
    public
    returns(uint index)
    {
        if(!isPlace(placeUuid)) 
            throw;

        uint rowToDelete = placeStructs[placeUuid].index;
        bytes16 keyToMove = placeIndex[placeIndex.length-1];

        placeIndex[rowToDelete] = keyToMove;
        placeStructs[keyToMove].index = rowToDelete; 
        placeIndex.length--;

        emit LogDeletePlace(
            placeUuid, 
            rowToDelete
        );
        emit LogUpdatePlace(
            keyToMove, 
            rowToDelete, 
            placeStructs[keyToMove].placeLocation,
            placeStructs[keyToMove].placeLatd, 
            placeStructs[keyToMove].placeLongtd,  
            placeStructs[keyToMove].placeNumber
        );
        return rowToDelete;
    }
    
    function updatePlaceLocation(bytes16  placeUuid, bytes32 placeLocation) 
        public
        returns(bool success) 
    {
        if(!isPlace(placeUuid))
            throw; 

        placeStructs[placeUuid].placeLocation = placeLocation;
        
        emit LogUpdatePlace(
            placeUuid, 
            placeStructs[placeUuid].index,
            placeLocation,
            placeStructs[placeUuid].placeLatd, 
            placeStructs[placeUuid].placeLongtd,   
            placeStructs[placeUuid].placeNumber
        );
        
        return true;
    }
    
    function updatePlaceNumber(bytes16  placeUuid, uint placeNumber) 
        public
        returns(bool success) 
    {
        if(!isPlace(placeUuid))
            throw; 
        placeStructs[placeUuid].placeNumber = placeNumber;
        
        emit LogUpdatePlace(
            placeUuid, 
            placeStructs[placeUuid].index,
            placeStructs[placeUuid].placeLocation,
            placeStructs[placeUuid].placeLatd, 
            placeStructs[placeUuid].placeLongtd, 
            placeNumber
        );
        
        return true;
    }

}
