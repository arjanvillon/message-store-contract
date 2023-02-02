const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("MessageStore", async function () {
  const initialMessage = "Hello world";
  const changedMessage = "Goodbye world";

  const [owner, otherAccount] = await ethers.getSigners();

  const MessageStore = await ethers.getContractFactory("MessageStore");
  const messageStore = await MessageStore.deploy(initialMessage, 1);

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
        messageStore.connect(otherAccount).updateData(changedMessage)
      ).to.be.revertedWith("Ownable: caller is not the owner");
    });
  });
});
