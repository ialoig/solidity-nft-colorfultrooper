// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./libraries/NFTDescriptor.sol";

contract ColorfulTrooperNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string[] bgPalette = [
        "#000D6B",
        "#B983FF",
        "#FF0075",
        "#49FF00",
        "#7027A0",
        "#FF0000",
        "#2D46B9",
        "#04009A",
        "#AE00FB",
        "#480032",
        "#1EAE98",
        "#542E71",
        "#CF0000",
        "#40394A",
        "#810034",
        "#7868E6",
        "#64DFDF",
        "#007965",
        "#0E49B5",
        "#12947F",
        "#4D089A",
        "#272121",
        "#AF0404",
        "#204969",
        "#930077"
    ];

    string[] imagePalette = [
        "#FFF338",
        "#D2E603",
        "#94B3FD",
        "#FF5DA2",
        "#B4FE98",
        "#FFEDED",
        "#FDB9FC",
        "#49FF00",
        "#77D970",
        "#B1FFFD",
        "#F5FDB0",
        "#78DEC7",
        "#C0FEFC",
        "#CCFFBD",
        "#C67ACE",
        "#B8B5FF",
        "#FB7813",
        "#C4FB6D",
        "#DC2ADE",
        "#F5F0E3",
        "#E4F9FF",
        "#B2FCFF",
        "#F1FA3C",
        "#A8FF3E",
        "#F77FEE"
    ];

    event NewColorfulTrooperMinted(address sender, uint256 tokenId);

    constructor() ERC721("Colorful Trooper", "TROOP") {
        console.log("This is the Colorful Trooper NFT Contract!");
    }

    function getBgPalette() public view returns (string memory) {
        uint256 randomNum = random("BACKGROUND");
        // Squash the # between 0 and the length of the array to avoid going out of bounds.
        randomNum = randomNum % bgPalette.length;
        console.log("random BG number: ", randomNum);
        return bgPalette[randomNum];
    }

    function getImagePalette() public view returns (string memory) {
        uint256 randomNum = random("IMAGE");
        // Squash the # between 0 and the length of the array to avoid going out of bounds.
        randomNum = randomNum % imagePalette.length;
        console.log("random Image number: ", randomNum);
        return imagePalette[randomNum];
    }

    /**
        get a random number calculated from :
        'input' : could be whatever you want (here a string)
        '_tokenIds': represents ids minted, always different because it will be incremented every time a new NFT is minted
        'timestamp': timestamp of the block
    */
    function random(string memory input) internal view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(
                        input,
                        _tokenIds.current(),
                        block.timestamp
                    )
                )
            );
    }

    function mintNFT() public {
        //get the current ID
        uint256 newItemId = _tokenIds.current();

        //generate SVG
        string memory randomBgPalette = getBgPalette();
        string memory randomImagePalette = getImagePalette();

        //define params of NFT
        NFTDescriptor.TokenURIParams memory params = NFTDescriptor
            .TokenURIParams({
                name: "Colorful Trooper",
                description: string(
                    abi.encodePacked(
                        "A ",
                        randomBgPalette,
                        " ",
                        randomImagePalette,
                        " Trooper"
                    )
                ),
                bgColor: randomBgPalette,
                imageColor: randomImagePalette
            });

        //construct token URI for the generated image with params passed by
        string memory tokenURI = NFTDescriptor.constructTokenURI(params);
        console.log("tokenURI created: ", tokenURI);

        // mint the NFT to the sender using msg.sender
        _safeMint(msg.sender, newItemId);

        //set the NFT data
        _setTokenURI(newItemId, tokenURI);
        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );

        //increment the counter
        _tokenIds.increment();

        //emit event
        emit NewColorfulTrooperMinted(msg.sender, newItemId);
    }
}
