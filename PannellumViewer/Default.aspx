<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Pannellum</title>
    <link href="Script/css/pannellum.css" rel="stylesheet" />
    <script src="Script/jquery/jquery-1.11.1.js"></script>
    <script src="Script/js/pannellum.js"></script>
    <script src="Script/js/libpannellum.js"></script>
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }

        #panorama {
            width: 100%;
            height: 80vh;
        }

        #showCoordinate {
            width: 100%;
            margin-top: 3px;
            height: 15vh;
            border: 3px solid black;
        }
    </style>
    <script>       
        var PrintCoordinate = function (hotSpotDiv,args) {
            var pitch = args.pitch;
            jQuery("label[for='pitch']").html("<strong>Pitch: </strong>" + pitch);
            var yaw = args.yaw;
            jQuery("label[for='yaw']").html("<strong>Yaw: </strong>" + yaw);
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="panorama"></div>
        <div id="showCoordinate">
            <br />
            <label for="pitch"><strong>Pitch:</strong></label>
            <br />
            <br />
            <label for="yaw"><strong>Yaw:</strong></label>
        </div>
        <script>
            pannellum.viewer('panorama', {
                "type": "equirectangular",
                "panorama": "360images/QG13/00/IMG_20201030_154626_00_002.jpg",
                autoLoad: true,
                /*
                 * "panorama": "https://pannellum.org/images/bma-1.jpg",
                 * https://cdn.pannellum.org/2.5/pannellum.htm#panorama=https://pannellum.org/images/alma.jpg
                 * https://pannellum.org/images/bma-1.jpg
                 * Uncomment the next line to print the coordinates of mouse clicks
                 * to the browser's developer console, which makes it much easier
                 * to figure out where to place hot spots. Always remove it when
                 * finished, though.
                 */
                //"hotSpotDebug": true,

                "hotSpots": [
                    {
                        "pitch": -14.813,
                        "yaw": -147.880,
                        "type": "info",
                        "text": "Brandblusser",
                        "URL": "https://rd04.chalois.com/geoviewer/Components/ObjectProperties/Objectproperty.aspx?src=elements&id=BB001"
                    },

                    {
                        "pitch": -0.247,
                        "yaw": 159.61,
                        "type": "info",
                        "text": "Image Locatie",
                        "URL": "https://rd04.chalois.com/imageviewer/Showimage.aspx?img=360images/OG13/00/IMG_20201030_154718_00_003.jpg"
                    },

                    {
                        "pitch": -11.709,
                        "yaw": 127.924,
                        "type": "info",
                        "text": "Show coordinate",
                        "clickHandlerFunc": PrintCoordinate,
                        "clickHandlerArgs": { "pitch": -11.709, "yaw": 127.924 },
                        "URL": ""
                    }
                ]

            });

        </script>

    </form>
</body>
</html>

