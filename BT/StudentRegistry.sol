// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentRegistry {
    struct Student {
        uint256 rollNo;
        string name;
        string course;
    }

    Student[] private students;
    uint256 public fallbackCallCount;

    event StudentAdded(uint256 indexed index, uint256 rollNo, string name);
    event StudentUpdated(uint256 indexed index, uint256 rollNo, string name);
    event FallbackCalled(address indexed sender, uint256 value, bytes data);

    function addStudent(
        uint256 rollNo,
        string calldata name,
        string calldata course
    ) external {
        require(bytes(name).length > 0, "Name is required");
        students.push(Student(rollNo, name, course));
        emit StudentAdded(students.length - 1, rollNo, name);
    }

    function getStudent(uint256 index)
        external
        view
        returns (uint256 rollNo, string memory name, string memory course)
    {
        require(index < students.length, "Student does not exist");
        Student storage student = students[index];
        return (student.rollNo, student.name, student.course);
    }

    function getStudentCount() external view returns (uint256) {
        return students.length;
    }

    function updateStudent(
        uint256 index,
        uint256 rollNo,
        string calldata name,
        string calldata course
    ) external {
        require(index < students.length, "Student does not exist");
        require(bytes(name).length > 0, "Name is required");
        students[index] = Student(rollNo, name, course);
        emit StudentUpdated(index, rollNo, name);
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

    fallback() external payable {
        fallbackCallCount++;
        emit FallbackCalled(msg.sender, msg.value, msg.data);
    }
}
