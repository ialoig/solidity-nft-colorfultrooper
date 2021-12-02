// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import {Base64} from "./Base64.sol";

library NFTDescriptor {
    struct TokenURIParams {
        string name;
        string description;
        string bgColor;
        string imageColor;
    }

    function constructTokenURI(TokenURIParams memory params)
        public
        pure
        returns (string memory)
    {
        //generate SVG image with background and image colors
        string memory svgImage = generateSVG(params.bgColor, params.imageColor);

        string memory jsonParams = string(
            abi.encodePacked(
                '{"name": "',
                //set the name of the NFT.
                params.name,
                //set a description of the NFT
                '", "description": "',
                params.description,
                //set the svg generated image with base64 enoce
                '", "image": "data:image/svg+xml;base64,',
                Base64.encode(bytes(svgImage)),
                '"}'
            )
        );

        //create json metadata and encode with Base64
        string memory json = Base64.encode(bytes(jsonParams));

        string memory tokenURI = string(
            abi.encodePacked("data:application/json;base64,", json)
        );
        return tokenURI;
    }

    function generateSVG(string memory bgColor, string memory imageColor)
        internal
        pure
        returns (string memory)
    {
        string memory svg = string(
            abi.encodePacked(
                "<svg xmlns='http://www.w3.org/2000/svg' width='336' height='336'><g clip-path='url(#clip0_301_2)'>",
                string(
                    abi.encodePacked(
                        "<path d='M336.005 0H0V335.999H336.005V0Z' fill='",
                        bgColor,
                        "'/>"
                    )
                ), //background
                string(
                    abi.encodePacked(
                        "<path d='M206.888 233.721H219.153V221.07H206.888V233.721Z' fill='",
                        imageColor,
                        "'/>"
                    )
                ),
                //face-detail dx
                string(
                    abi.encodePacked(
                        "<path d='M121 233.651H133.265V221H121V233.651Z' fill='",
                        imageColor,
                        "'/>"
                    )
                ), //face-detail sx
                string(
                    abi.encodePacked(
                        "<path d='M243.73 195.796V233.724H255.997V195.796H243.73ZM231.441 246.349H243.73V233.721H231.441V246.349ZM194.599 246.349V233.721H182.309V221.07H157.754V233.721H145.464V246.349H108.623V259H157.757V246.349H182.311V259H231.443V246.349H194.599ZM96.3327 233.721V246.349H108.623V233.721H96.3327ZM96.3327 195.796H84.0658V233.724H96.3327V195.796Z' fill='",
                        imageColor,
                        "'/>"
                    )
                ), //face-bottom
                string(
                    abi.encodePacked(
                        "<path d='M108.62 145.216V183.144H120.91V195.796H96.3327L96.3304 145.216L108.62 145.216ZM219.151 183.144V195.796H243.73L243.728 145.216H231.438V183.144H219.151Z' fill='",
                        imageColor,
                        "'/>"
                    )
                ), //face-top
                string(
                    abi.encodePacked(
                        "<path d='M206.888 195.796H194.598V183.144H182.309V170.493H157.754V183.144H145.464V195.796H133.175V208.421H206.886V195.796H206.888Z' fill='",
                        imageColor,
                        "'/>"
                    )
                ), //nose
                string(
                    abi.encodePacked(
                        "<path d='M218.862 81.5901H120.622V132.169H218.862V81.5901Z' fill='",
                        bgColor,
                        "'/>"
                    )
                ), //head
                string(
                    abi.encodePacked(
                        "<path d='M132.889 81.5902V68.9625H206.6V81.5878H132.889V81.5902ZM132.889 81.5902H120.622V94.2415H132.889V81.5902ZM218.865 94.2391V81.5878H206.6V94.2391H218.865ZM218.865 94.2391H120.622Z' fill='",
                        imageColor,
                        "'/>"
                    )
                ), //head-border top
                string(
                    abi.encodePacked(
                        "<path d='M120.657 144.82V132.169H218.9V144.82H231.19V94.2412H218.9L218.9 119.518H120.657V94.2436L108.367 94.2412V144.82' fill='",
                        imageColor,
                        "'/>"
                    )
                ), //head-border
                string(
                    abi.encodePacked(
                        "<path d='M120.657 170.493L145.464 170.496V157.844H157.771V145.077L120.603 145.113L120.657 170.493Z' fill='",
                        imageColor,
                        "'/>"
                    )
                ), //eye sx
                string(
                    abi.encodePacked(
                        "<path d='M218.851 170.493H194.731V157.844H182.562L182.526 145.077H218.852L218.851 170.493Z' fill='",
                        imageColor,
                        "'/>"
                    )
                ), //eye dx
                string(
                    abi.encodePacked(
                        "<path d='M218.851 170.493H194.731V157.844H182.562L182.526 145.077H218.852L218.851 170.493Z' fill='",
                        imageColor,
                        "'/></g></svg>"
                    )
                )
            )
        );
        return svg;
    }
}
