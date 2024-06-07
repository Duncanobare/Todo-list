// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TodoList {
    address owner;

    struct Task {
        string taskName;
        bool completed;
        uint256 startAt;
        uint256 endAt;
    }

    Task[] private tasks;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "not the owner");
        _;
    }

    function addTask(
        string memory taskName,
        uint256 startAt,
        uint256 endAt,
        bool completed
    ) public onlyOwner {
        tasks.push(Task(taskName, completed, startAt, endAt));
    }

    function viewTasksCount() public view onlyOwner returns (uint256) {
        return tasks.length;
    }

    function viewTask(
        uint256 index
    ) public view onlyOwner returns (string memory, bool, uint256, uint256) {
        require(index < tasks.length, "task absent");
        Task memory task = tasks[index];
        return (task.taskName, task.completed, task.startAt, task.endAt);
    }

    function timeTaken(uint256 index) public view onlyOwner returns (uint256) {
        require(index < tasks.length, "task absent");
        Task memory task = tasks[index];
        require(
            task.endAt >= task.startAt,
            "end time must be after start time"
        );
        return task.endAt - task.startAt;
    }

    function taskCompleted(uint256 index) public view onlyOwner returns (bool) {
        require(index < tasks.length, "task absent");
        Task memory task = tasks[index];
        return task.completed;
    }

    function markTaskComplete(uint256 index) public onlyOwner {
        require(index < tasks.length, "task absent");
        tasks[index].completed = true;
    }
}
//127.0.0.1:8545