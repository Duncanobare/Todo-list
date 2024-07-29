// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TodoList {
    address owner;

    struct Task {
        string taskName;
        bool completed;
        uint256 startAt;
        uint256 duration;
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
        string memory _taskName,
        uint256 _startAt,
        uint256 _duration
    ) public onlyOwner {
        Task memory ts = Task({
            taskName: _taskName,
            startAt: _startAt,
            duration: _duration,
            endAt: _startAt + _duration, // Explicitly setting endAt
            completed: false
        });
        tasks.push(ts);
    }

    function viewTasksCount() public view onlyOwner returns (uint256) {
        return tasks.length;
    }

    function viewTask(uint256 index) public view onlyOwner returns (Task memory) { // Corrected return type
        require(index < tasks.length, "task absent");
        return tasks[index]; 
    }

    function timeTaken(uint256 index) public view onlyOwner returns (uint256) {
        require(index < tasks.length, "task absent");
        Task storage task = tasks[index]; 
        require(task.endAt >= task.startAt, "end time must be after start time");
        return task.endAt - task.startAt;
    }

    function taskCompleted(uint256 index) public view onlyOwner returns (bool) {
        require(index < tasks.length, "task absent");
        Task storage task = tasks[index];
        return task.completed;
    }

    function markTaskComplete(uint256 index) public onlyOwner {
        require(index < tasks.length, "task absent");
        tasks[index].completed = true; 
    }
}
