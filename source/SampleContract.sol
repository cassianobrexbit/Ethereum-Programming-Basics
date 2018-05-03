pragma solidity ^0.4.18;

contract SampleContract {
    uint storageData;
    function set(uint x) {
        storageData = x;
    }
    function get() constant returns (uint) {
        return storageData;
    }
}
