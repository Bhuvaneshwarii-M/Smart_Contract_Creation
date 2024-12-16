// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Crowdfunding {
    struct Campaign {
        address payable creator;
        string title;
        string description;
        uint goal;
        uint raisedAmount;
        uint deadline;
        bool completed;
        uint milestoneAmount;
    }

    mapping(uint => Campaign) public campaigns;
    uint public campaignCount = 0;

    event CampaignCreated(uint campaignId, address creator, string title, uint goal);
    event DonationReceived(uint campaignId, address donor, uint amount);
    event FundsReleased(uint campaignId, uint amount);

    function createCampaign(
        string memory _title,
        string memory _description,
        uint _goal,
        uint _deadline,
        uint _milestoneAmount
    ) public {
        require(_goal > 0, "Goal should be greater than 0");
        require(_deadline > block.timestamp, "Deadline should be in the future");

        campaignCount++;
        campaigns[campaignCount] = Campaign(
            payable(msg.sender),
            _title,
            _description,
            _goal,
            0,
            _deadline,
            false,
            _milestoneAmount
        );

        emit CampaignCreated(campaignCount, msg.sender, _title, _goal);
    }

    function donate(uint _campaignId) public payable {
        Campaign storage campaign = campaigns[_campaignId];
        require(block.timestamp < campaign.deadline, "Campaign is over");
        require(msg.value > 0, "Donation should be greater than 0");

        campaign.raisedAmount += msg.value;
        emit DonationReceived(_campaignId, msg.sender, msg.value);
    }

    function releaseFunds(uint _campaignId) public {
        Campaign storage campaign = campaigns[_campaignId];
        require(msg.sender == campaign.creator, "Only creator can release funds");
        require(campaign.raisedAmount >= campaign.milestoneAmount, "Milestone not reached");
        require(!campaign.completed, "Funds already released");

        campaign.completed = true;
        campaign.creator.transfer(campaign.raisedAmount);

        emit FundsReleased(_campaignId, campaign.raisedAmount);
    }
}
