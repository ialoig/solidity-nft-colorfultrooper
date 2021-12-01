

const main = async () => {
    //deploy libraries
    const libraryFactory = await hre.ethers.getContractFactory("NFTDescriptor")
    const libraryContract = await libraryFactory.deploy()
    await libraryContract.deployed()
    console.log("Library deployed !! - ", libraryContract.address)

    //deploy contract
    const nftContractFactory = await hre.ethers.getContractFactory("ColorfulTrooperNFT", {
        libraries: {
            NFTDescriptor: libraryContract.address
        }
    })
    const nftContract = await nftContractFactory.deploy()
    await nftContract.deployed()
    console.log("Contract deployed !! - ", nftContract.address)

    //call the function to mint an NFT
    let tx = await nftContract.mintNFT();
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