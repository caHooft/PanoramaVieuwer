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

        /*
        html, body
        {
            height: 100%;
            margin: 0;
        }
        */

        #panorama 
        {
            
           width: 50%; 
            
            

            margin-left: 800px;
            height: 100vh;
        }

        #controls 
        {
        position: absolute;
        bottom: 1px;
        z-index: 2;
        text-align: center;
        width: 100%;
        padding-bottom: 5px;
            left: 9px;
            margin-top: 0px;
        }
        .ctrl 
        {
        padding: 8px 5px;
        width: 30px;
        text-align: center;
        background: rgba(200, 200, 200, 0.8);
        display: inline-block;
        cursor: pointer;
        }
        .ctrl:hover 
        {
        background: rgba(200, 200, 200, 1);
        }

        #showCoordinate 
        {
            width: 100%;            
            height: 7.5vh;
            border: 2px solid black;
        }

        </style>
    <script>       
        var PrintCoordinate = function (hotSpotDiv, args)
        {
            var pitch = args.pitch;
            jQuery("label[for='pitch']").html("<strong>Pitch: </strong>" + pitch);
            var yaw = args.yaw;
            jQuery("label[for='yaw']").html("<strong>Yaw: </strong>" + yaw);
        };

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="panorama">
            <div id="controls">
                <div class="ctrl" id="click">&#9640;</div>
                <div class="ctrl" id="pan-up">&#9650;</div>
                <div class="ctrl" id="pan-down">&#9660;</div>
                <div class="ctrl" id="pan-left">&#9664;</div>
                <div class="ctrl" id="pan-right">&#9654;</div>
                <div class="ctrl" id="zoom-in">&plus;</div>
                <div class="ctrl" id="zoom-out">&minus;</div>
                <div class="ctrl" id="fullscreen">&#x2922;</div>
            </div>        

            <div id="showCoordinate">
                <label for="pitch"><strong>Pitch:</strong></label>
                <br />
                <br />
                <label for="yaw"><strong>Yaw:</strong></label>
            </div> 
        </div>        

        <script>
            //create viewer as variable vieuwer (this is essential for the buttons!)
            viewer = pannellum.viewer('panorama', {
                "type": "equirectangular",
                //Determines what picture is vieuwed
                //"panorama": "360images/trafficSign/Position_01_panorama.jpg",
                //"haov": 149.87,
                //"vaov": 54.15,
                //"vOffset": 1.17,                
                "panorama": "360images/trafficSign/stream_00002-000000_00007_0000030.jpg",
                //"panorama": "360images/QG13/00/IMG_20201030_154626_00_002.jpg",
                autoLoad: true,
                "showControls": false,

                //debugs yaw and pitch to the debugger in the console (f12)
                "hotSpotDebug": false,

                //trying to debug the yaw and pitch visually without debug console
                                
                "hotSpots":
                [
                    {
                        //asset data link example
                        "pitch": -14.813,
                        "yaw": -147.880,
                        "type": "info",
                        "text": "Brandblusser",
                        "URL": "https://rd04.chalois.com/geoviewer/Components/ObjectProperties/Objectproperty.aspx?src=elements&id=BB001"
                    },

                    {
                        //switch to diffrent panorama picture
                        "pitch": -0.247,
                        "yaw": 159.61,
                        "type": "info",
                        "text": "Image Locatie",
                        "URL": "https://rd04.chalois.com/imageviewer/Showimage.aspx?img=360images/OG13/00/IMG_20201030_154718_00_003.jpg"
                    },

                    {
                        //debug coordinate
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

            viewer.on('mousedown', function (event)
            {
                // coords[0] is pitch, coords[1] is yaw
                var coords = viewer.mouseEventToCoords(event);
                
                jQuery("label[for='pitch']").html("<strong>Pitch: </strong>" + coords[0]);

                jQuery("label[for='yaw']").html("<strong>Yaw: </strong>" + coords[1]);
            });

            // Make buttons work
            document.getElementById('click').addEventListener('click', function (e)
            {                
                pitch = viewer.getPitch();
                yaw = viewer.getYaw();
                //viewer.getHfov() = fov;

             
                jQuery("label[for='pitch']").html("<strong>Pitch: </strong>" + pitch);
                
                jQuery("label[for='yaw']").html("<strong>Yaw: </strong>" + yaw);

            });

            document.getElementById('pan-up').addEventListener('click', function (e) {
                viewer.setPitch(viewer.getPitch() + 10);
            });
            document.getElementById('pan-down').addEventListener('click', function (e) {
                viewer.setPitch(viewer.getPitch() - 10);
            });
            document.getElementById('pan-left').addEventListener('click', function (e) {
                viewer.setYaw(viewer.getYaw() - 10);
            });
            document.getElementById('pan-right').addEventListener('click', function (e) {
                viewer.setYaw(viewer.getYaw() + 10);
            });
            document.getElementById('zoom-in').addEventListener('click', function (e) {
                viewer.setHfov(viewer.getHfov() - 10);
            });
            document.getElementById('zoom-out').addEventListener('click', function (e) {
                viewer.setHfov(viewer.getHfov() + 10);
            });
            document.getElementById('fullscreen').addEventListener('click', function (e) {
                viewer.toggleFullscreen();
            });

            
        </script>

    </form>
</body>
</html>
