import React, { useEffect, useState } from 'react';
import Web3 from 'web3';
import './App.css';

// ABI of the contract
const abi = [
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "_task",
                "type": "string"
            }
        ],
        "name": "addTask",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "name": "tasks",
        "outputs": [
            {
                "internalType": "string",
                "name": "",
                "type": "string"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getTasks",
        "outputs": [
            {
                "internalType": "string[]",
                "name": "",
                "type": "string[]"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    }
];

// Address of the deployed contract
const contractAddress = '0x66ada7900472c0152d2e15dd1c241f8e5d85c7d5';

function App() {
    const [tasks, setTasks] = useState([]);
    const [task, setTask] = useState('');
    const [web3, setWeb3] = useState(null);
    const [contract, setContract] = useState(null);
    const [account, setAccount] = useState(null);

    useEffect(() => {
        async function loadWeb3() {
            if (window.ethereum) {
                const web3 = new Web3(window.ethereum);
                await window.ethereum.enable();
                setWeb3(web3);

                const accounts = await web3.eth.getAccounts();
                setAccount(accounts[0]);

                const contract = new web3.eth.Contract(abi, contractAddress);
                setContract(contract);

                const tasks = await contract.methods.getTasks().call();
                setTasks(tasks);
            } else {
                alert('Non-Ethereum browser detected. You should consider trying MetaMask!');
            }
        }
        loadWeb3();
    }, []);

    const addTask = async (event) => {
        event.preventDefault();
        if (!contract) {
            alert('Contract not loaded yet');
            return;
        }
        await contract.methods.addTask(task).send({ from: account });
        const tasks = await contract.methods.getTasks().call();
        setTasks(tasks);
        setTask('');
    };

    return (
        <div className="App">
            <h1>To-Do List</h1>
            <form onSubmit={addTask}>
                <input 
                    type="text" 
                    value={task} 
                    onChange={(e) => setTask(e.target.value)} 
                    placeholder="Enter a task"
                />
                <button type="submit">Add Task</button>
            </form>
            <ul>
                {tasks.map((task, index) => (
                    <li key={index}>{task}</li>
                ))}
            </ul>
        </div>
    );
}

export default App;
