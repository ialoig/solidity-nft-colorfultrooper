

const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory("ColorfulTrooperNFT")
    const nftContract = await nftContractFactory.deploy()
    await nftContract.deployed()
    console.log("Contract deployed !! - ", nftContract.address)

    //call the function to make an NFT
    let tx = await nftContract.make();
    //wait for it to be mined.
    await tx.wait();
    console.log("Minted #1 NFT")

}


const runMain = async () => {
    try {
        await main()
        process.exit(0)
    } catch (error) {
        console.log("Error while deploying contract: ", error)
        process.exit(1)
    }
}

runMain()