const TransactionManagement = artifacts.require("TransactionManagement");

contract("TransactionManagement", (accounts) => {
    let transactionManagement;
    const owner = accounts[0];
    const manufacturer = accounts[1];
    const nonManufacturer = accounts[2];  // An account that is not registered as a manufacturer

    beforeEach(async () => {
        transactionManagement = await TransactionManagement.new();
        await transactionManagement.addManufacturer(manufacturer, "Manufacturer 1", "Place 1", { from: owner });
    });

    describe("Manufacturing process", () => {
        it("allows a registered manufacturer to start manufacturing a product", async () => {
            // Assume the function addProduct works correctly and is allowed by the owner
            await transactionManagement.addProduct("Product 1", "Description 1", web3.utils.toWei("1", "ether"), "hash1", { from: owner });
            await transactionManagement.Manufacturing(1, { from: manufacturer });
            const product = await transactionManagement.ProductStock(1);
            assert.equal(product.stage.toString(), "1", "The product should be in the Manufacture stage");
        });

        it("does not allow non-manufacturers to start manufacturing", async () => {
            await transactionManagement.addProduct("Product 2", "Description 2", web3.utils.toWei("1", "ether"), "hash2", { from: owner });
            try {
                await transactionManagement.Manufacturing(2, { from: nonManufacturer });
                assert.fail("The transaction should have failed");
            } catch (error) {
                assert.include(error.message, "revert", "The transaction should revert due to lack of permissions");
            }
        });
    });
});
