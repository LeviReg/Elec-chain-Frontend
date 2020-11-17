// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.4 .16 < 0.8 .0;

contract Vote {

    // list all the candidates
    bytes32[] private candidates;

    // list all the voters
    address[] private voters;

    // hashmap to get the votes
    mapping(bytes32 => uint) private votesReceived;

    //name of candidates running
    function Candidates(bytes32[] memory candidateNames) public {
        candidates = candidateNames;
    }
    //number of votes a candidate has received
    function CandidateResult(bytes32 cadidate) view public returns(uint) {
        return votesReceived[cadidate];
    }
    //cast vote for valid candidate
    function CastVote(bytes32 candidate) public {
        //check if candidate is valid
        require(isValidCandidate(candidate));
        require(isValidVoter(msg.sender));

        votesReceived[candidate] += 1;
        voters.push(msg.sender);
    }

    // for verifying if candidate is legit as well as the vote
    function isValidCandidate(bytes32 candidate) view public returns(bool) {
        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i] == candidate) {
                return true;
            }
        }
        return false;
    }

    function isValidVoter(address voter) view public returns(bool) {
        for (uint i = 0; i < voters.length; i++) {
            if (voters[i] == voter) {
                return false;
            }
        }
        return true;
    }
}