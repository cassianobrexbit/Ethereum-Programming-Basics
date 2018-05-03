pragma solidity ^0.4.18;

contract SampleContract {

    uint numero;
    
    function set(uint x) {
        numero = x;
    }
    
    function get() constant returns (uint) {
        return numero;
    }
}
