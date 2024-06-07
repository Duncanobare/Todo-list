// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {TodoList} from "../src/TodoList.sol";

contract DeployTodoList is Script {
    function run() external returns (TodoList) {
        vm.startBroadcast();
        TodoList todoList = new TodoList();
        vm.stopBroadcast();
        return todoList;
    }
}
