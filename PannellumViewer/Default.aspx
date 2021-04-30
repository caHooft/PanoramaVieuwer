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

        .Pannellum-Wrapper
        {
          margin: 15px;

        }
        .image
        {             
            
        }
        .panorama 
        { 
            
        }
        .row 
        {
          display: flex;
            flex-direction: row;
            flex-wrap: wrap;
            width: 100%;
        }
        .row2 
        {
          display: flex;
            flex-direction: row;
            flex-wrap: wrap;
            width: 100%;
        }

        .column 
        {
           display: flex;
              flex-direction: column;
              flex-basis: 100%;
              flex: 1;
        }
        
        @media screen and (min-width: 800px) 
        {
          .column 
          {
            flex: 1
          }

          .double-column 
          {
            flex: 2
          }
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
        <div class='Pannellum-Wrapper'>
            <div class="row">

                <div class="column">
                    <div id="showXY">
                        <label for="X"><strong>X:</strong></label>
                        <br />
                        <label for="Y"><strong>Y:</strong></label>
                    </div>
                </div>

                <div class="column">
                    <div id="showCoordinate">
                        <label for="pitch"><strong>Pitch:</strong></label>
                        <br />
                        <label for="yaw"><strong>Yaw:</strong></label>
                    </div>
                </div>
            </div>

            <div class="row2">

                <div class="column">

                    <div class="image">
                        <img src="360images/trafficSign/stream_00002-000000_00020_0000043.jpg" style="width:100%;height:100%;" />
                    </div>
                </div>

                <div class="column">
                    <div id="panorama">
                        <div id="controls">
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
        </div>
        <script>
            // script that debugs 2D image on click based on 8000 by 4000 image
            var origonalImageX = 8000;
            var origonalImageY = 4000;
            $(document).ready(function ()
            {
                $('img').click(function (e)
                {
                    var offset = $(this).offset();
                    var x = (e.pageX - offset.left) * (origonalImageX / form1.children[1].children[1].children[0].clientWidth);
                    var y = (e.pageY - offset.top) * (origonalImageY / form1.children[1].children[1].children[0].clientHeight);
                   
                    var X = Math.round((x + Number.EPSILON) * 100) / 100;
                    var Y = Math.round((y + Number.EPSILON) * 100) / 100;
                    jQuery("label[for='X']").html("<strong>X: </strong>" + X);
                    jQuery("label[for='Y']").html("<strong>Y: </strong>" + Y);

                    var k = origonalImageX / 360;
                    vert_angle_of_view = origonalImageY / k;

                    yaw = (k * -180 + x) / k;
                    pitch = (0.5 * k * vert_angle_of_view - y) / k

                    var Pitch = Math.round((pitch + Number.EPSILON) * 100) / 100;
                    var Yaw = Math.round((yaw + Number.EPSILON) * 100) / 100;

                    jQuery("label[for='pitch']").html("<strong>Pitch: </strong>" + Pitch);
                    jQuery("label[for='yaw']").html("<strong>Yaw: </strong>" + Yaw);
                    
                    
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
            viewer = pannellum.viewer('panorama', 
            {
                "default": 
                {
                        "firstScene": "First",
                        "author": "HawarIT",
                        "sceneFadeDuration": 1000,
                        autoLoad: true,
                        "showControls": false
                            
                },
                "scenes": 
                {
                        "First":
                        {
                        "title": "Tilburg 1",
                        "type": "equirectangular",
                        "panorama": "360images/trafficSign/stream_00002-000000_00020_0000043.jpg",
                        "hotSpots": 
                        [{
                                "pitch": 0,
                                "yaw": 0,
                                "type": "scene",
                                "text": "Tilburg 2",
                                "sceneId": "Second"
                        },
                        {
                            "pitch": -37,
                            "yaw": -178,
                            "type": "info",
                            "text": "extreme pitch and yaw example (car)"
                        },
                        {
                            "pitch": 0,
                            "yaw": -178,
                            "type": "info",
                            "text": "extreme yaw example (roundabout)"
                        },
                        {
                            "pitch": -54,
                            "yaw": 0,
                            "type": "info",
                            "text": "extreme pitch example (car)"
                        }
                        ]},

                        "Second": 
                        {
                        "title": "Tilburg 2",
                        "type": "equirectangular",
                        "panorama": "360images/trafficSign/stream_00002-000000_00007_0000030.jpg",
                        "hotSpots":
                        [{
                                "pitch": 0,
                                "yaw": 0,
                                "type": "scene",
                                "text": "Tilburg 1",
                                "sceneId": "First",
                        }]}
                }
            });
            viewer.on('mousedown', function (event)
            {
                // coords[0] is pitch, coords[1] is yaw
                var coords = viewer.mouseEventToCoords(event);

                jQuery("label[for='pitch']").html("<strong>Pitch: </strong>" + coords[0]);

                jQuery("label[for='yaw']").html("<strong>Yaw: </strong>" + coords[1]);

                //debug to calculate x.y from pannellum through math
                var k = 8000 / 360;

                vert_angle_of_view = 4000 / k;

                var x = k * (coords[1] + 0.5 * 360);
                var y = k * ((coords[0] * -1) + 0.5 * vert_angle_of_view);

                //problem is not in anything under this comment
                var X = Math.round((x + Number.EPSILON) * 100) / 100;
                var Y = Math.round((y + Number.EPSILON) * 100) / 100;

                jQuery("label[for='X']").html("<strong>X: </strong>" + X);
                jQuery("label[for='Y']").html("<strong>Y: </strong>" + Y);
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
