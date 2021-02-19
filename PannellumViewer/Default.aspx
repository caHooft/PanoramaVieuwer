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

        #image
        {
            width: 880px;
            height: 440px;
        }
        .row 
        {
          display: flex;
        }

        .column 
        {
          flex: 50%;
        }

        #panorama 
        { 
            width: 860px;
            height: 492px;
        }
        .row 
        {
          display: flex;
        }

        .column 
        {
          flex: 50%;
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
            height: 50px;
            border: 1px solid black;
            
        }

        #showXY
        {
            width: 100%;            
            height: 50px;
            border: 1px solid black;
        }

        </style>
    <script>    
        //Print yaw/pitch useing jQuery
        var PrintCoordinate = function (hotSpotDiv, args)
        {
            var pitch = args.pitch;
            jQuery("label[for='pitch']").html("<strong>Pitch: </strong>" + pitch);
            var yaw = args.yaw;
            jQuery("label[for='yaw']").html("<strong>Yaw: </strong>" + yaw);
        };
        //Print x/y useing jQuery
        var PrintCoordinateXY = function (hotSpotDiv, args)
        {
            var X = args.X;
            jQuery("label[for='X']").html("<strong>X: </strong>" + X);
            var Y = args.Y;
            jQuery("label[for='Y']").html("<strong>Y: </strong>" + Y);
        };

    </script>
</head>
<body>
    <form id="form1" runat="server">

        <div class="row">

          <div class="column">
              <div id="image">
                  <div id="showXY">
                        <label for="X"><strong>X:</strong></label>
                        <br />
                        <label for="Y"><strong>Y:</strong></label>
                    </div> 
                  <img src="360images/trafficSign/stream_00002-000000_00007_0000030.jpg" style="width:100%"/>
              </div> 
          </div>

            <div class="column">
                 <div id="panorama">
                     <div id="showCoordinate">
                        <label for="pitch"><strong>Pitch:</strong></label>
                        <br />
                        <label for="yaw"><strong>Yaw:</strong></label>
                    </div> 

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
                 </div>            
            </div>
               

        </div>    
            <script>
                //var scalingFactor = 8.42;
                var scalingFactor = 9.1;
                //new script that debugs 2D image on click
                
                $(document).ready(function ()
                {
                    $('img').click(function (e)
                    {
                        var offset = $(this).offset();
                        var x = (e.pageX - offset.left) * scalingFactor;
                        var y = (e.pageY - offset.top) * scalingFactor;
                        var X = Math.round((x + Number.EPSILON) * 100) / 100;
                        var Y = Math.round((y + Number.EPSILON) * 100) / 100;
                        jQuery("label[for='X']").html("<strong>X: </strong>" + X);
                        jQuery("label[for='Y']").html("<strong>Y: </strong>" + Y);
                    });
                });
                
                
                //new script that debugs 2D image on hover
                /*
                $(document).ready(function () {
                    $('img').on("mousemove", function (e)
                    {
                        var offset = $(this).offset();
                        var X = (e.pageX - offset.left);
                        var Y = (e.pageY - offset.top);
                        jQuery("label[for='X']").html("<strong>X: </strong>" + X*scalingFactor);
                        jQuery("label[for='Y']").html("<strong>Y: </strong>" + Y*scalingFactor);
                    });
                });
                */
                
            </script> 
      
        
        <script>
            
            //create viewer as variable vieuwer (this is essential for the buttons!)
            viewer = pannellum.viewer('panorama',
                {
                    "type": "equirectangular",

                    //code that enables support for non complete panorama pictures
                    //"haov": 149.87,
                    //"vaov": 54.15,
                    //"vOffset": 1.17,     

                    //Determines what picture is vieuwed
                    "panorama": "360images/trafficSign/stream_00002-000000_00007_0000030.jpg",
                    //"panorama": "360images/QG13/00/IMG_20201030_154626_00_002.jpg",
                    autoLoad: true,
                    "showControls": false,

                    //debugs yaw and pitch to the debugger in the console (f12)
                    "hotSpotDebug": false,
                                
                    "hotSpots":
                        [
                        /*
                        "panorama": "360images/trafficSign/stream_00002-000000_00007_0000030.jpg"
                         hotspots
                        */
                        {
                            "pitch": 6,
                            "yaw": -122,
                            "type": "info",
                            "text": "Cycle path",
                            "clickHandlerFunc": PrintCoordinateXY,
                            "clickHandlerArgs": { "X": 1257, "Y": 1881 },
                            "URL": ""
                        
                        },

                        {
                            "pitch": 0,
                            "yaw": -90,
                            "type": "info",
                            "text": "Stop sign",
                            "clickHandlerFunc": PrintCoordinateXY,
                            "clickHandlerArgs": { "X": 1993, "Y": 2002 },
                            "URL": ""

                        },

                        {
                            "pitch": -1,
                            "yaw": 19,
                            "type": "info",
                            "text": "end of speed limit sign",
                            "clickHandlerFunc": PrintCoordinateXY,
                            "clickHandlerArgs": { "X": 4395, "Y": 2022 },
                            "URL": ""

                        }

                        /*
                            "panorama": "360images/QG13/00/IMG_20201030_154626_00_002.jpg"
                            hotspots
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
                            //use example function
                            "pitch": -11.709,
                            "yaw": 127.924,
                            "type": "info",
                            "text": "Show coordinate",
                            "clickHandlerFunc": PrintCoordinate,
                            "clickHandlerArgs": { "pitch": -11.709, "yaw": 127.924 },
                            "URL": ""
                        }
                        */
                    ]

            });

            viewer.on('mousedown', function (event)
            {
                // coords[0] is pitch, coords[1] is yaw
                var coords = viewer.mouseEventToCoords(event);
                
                jQuery("label[for='pitch']").html("<strong>Pitch: </strong>" + coords[0]);

                jQuery("label[for='yaw']").html("<strong>Yaw: </strong>" + coords[1]);

                //new debug rhing to calculate x.y from pannellum through math

                var k = 8000 / 360;
                vert_angle_of_view = 4000 / k;
                //coords[0] = 4000 / k;

                X = k * (coords[1] + 0.5 * 360);
                Y = k * (coords[0] + 0.5 * vert_angle_of_view);


                jQuery("label[for='X']").html("<strong>X: </strong>" + X);
                jQuery("label[for='Y']").html("<strong>Y: </strong>" + Y);
            });

            // Make buttons work
            document.getElementById('click').addEventListener('click', function (e)
            {
                //dead center button
                pitch = viewer.getPitch();
                //yaw = viewer.getYaw();
                viewer.getHfov() = fov;

             
                jQuery("label[for='pitch']").html("<strong>Pitch: </strong>" + pitch);
                
                jQuery("label[for='yaw']").html("<strong>Yaw: </strong>" + yaw);

            });
            
            document.getElementById('pan-up').addEventListener('click', function (e)
            {
                viewer.setPitch(viewer.getPitch() + 10);
            });
            document.getElementById('pan-down').addEventListener('click', function (e)
            {
                viewer.setPitch(viewer.getPitch() - 10);
            });
            document.getElementById('pan-left').addEventListener('click', function (e)
            {
                viewer.setYaw(viewer.getYaw() - 10);
            });
            document.getElementById('pan-right').addEventListener('click', function (e)
            {
                viewer.setYaw(viewer.getYaw() + 10);
            });
            document.getElementById('zoom-in').addEventListener('click', function (e)
            {
                viewer.setHfov(viewer.getHfov() - 10);
            });
            document.getElementById('zoom-out').addEventListener('click', function (e)
            {
                viewer.setHfov(viewer.getHfov() + 10);
            });
            document.getElementById('fullscreen').addEventListener('click', function (e)
            {
                viewer.toggleFullscreen();
            });

            
        </script>
    </form>      
</body>
</html>
