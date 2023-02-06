const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("MessageStore", function () {
  const initialMessage = "Hello world";
  const changedMessage = "Goodbye world";

  let account;
  let messageStore;

  // before function runs once before the whole test function runs
  before(async function () {
    const [owner, otherAccount] = await ethers.getSigners();
    // set the other account as the account to test the revertion of update data
    account = otherAccount;

    const MessageStore = await ethers.getContractFactory("MessageStore");
    // update the messageStore to be the contract
    messageStore = await MessageStore.deploy(initialMessage, 1);
  });

  describe("Data tests", function () {
    it("Should return the correct data", async function () {
      const data = await messageStore.viewData();
      expect(data).to.equal(initialMessage);
    });

    it("Should update the data", async function () {
      await messageStore.updateData(changedMessage);
      const data = await messageStore.viewData();
      expect(data).to.equal(changedMessage);
    });

    it("Should not be able to update the data if not owner", async function () {
      await expect(
        messageStore.connect(account).updateData(changedMessage)
      ).to.be.revertedWith("Ownable: caller is not the owner");
    });
  });
});
