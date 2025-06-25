import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtWebSockets 1.1


ApplicationWindow {
    id:root
    width: 1600
    height: 1200
    visible: true
    title: qsTr("Dashboard")
    color: "#000000"

    property real currentSpeed: 0
    property real currentRpm: 0
    property real distanceRemaining: 0
    property real totalDistance: 0
    property bool inLane: true
    property bool right_lane_departure: false
    property bool left_lane_departure: false
    property bool offroad: false
    property string drive_mode: "D"
    property string fuel_km: "0"
    property string speedLimt: ""
    property real speedLimitDistance: 0
    property string trafficState: ""
    property real trafficDistance: 0
    property string left_blinker: "OFF"
    property string right_blinker: "OFF"
    property string reverseLight: "OFF"
    property bool leftDirection: false
    property bool rightDirection: false
    property bool straightDirection: false
    property real temperature: 0
    property string turnSignal: ""
    property string distanceToEmpty: ""
    property bool fogLight: false
    property bool highBeam: false
    property bool ecoMode: false
    property bool tpms: false
    property bool fuelWarning: false
    property bool engineWarning: false
    property bool washerFluidWarning: false
    property bool hazardIndicator: false
    property real turnSignalDistance: 0
    property bool route_completed: false
    property string currentTime: "12:00"
    property string weatherCondition: "rain"
    property string crossingDistance: ""
    // property string pedestrianDistance: ""
    property string constructionDistance: ""
    property string stopDistance: ""
    property bool connected: false

    WebSocket {
        id: socket
        url: "ws://137.207.14.63:8765"
        active: true

        onStatusChanged: {
            switch (socket.status) {
            case WebSocket.Error:
                // console.log("Error: " + socket.errorString)
                connected = false
                break
            case WebSocket.Open:
                console.log("WebSocket connected")
                connected = true
                break
            case WebSocket.Closed:
                console.log("WebSocket closed")
                connected = false
                break
            }
        }

        onTextMessageReceived: {
            var data = JSON.parse(message)
            console.log(message)

            currentSpeed = data.speed_kmph
            currentRpm = data.rpm
            distanceRemaining = parseInt(data.current_destination_distance)
            right_lane_departure = data.right_lane_departure
            left_lane_departure = data.left_lane_departure
            totalDistance = data.total_destination_distance
            turnSignal = data.turn_signal
            turnSignalDistance = data.turn_signal_distance
            distanceToEmpty = data.distance_to_empty
            fogLight = data.fog_light
            highBeam = data.high_beam
            ecoMode = data.eco_mode
            tpms = data.tpms
            fuelWarning = data.fuel_warning
            engineWarning = data.engine_warning
            washerFluidWarning = data.washer_fluid_warning
            hazardIndicator = data.hazard_indicator
            inLane = data.in_lane
            offroad = data.off_road
            drive_mode = data.drive_mode
            fuel_km = data.fuel_status
            speedLimt = data.speed_limit
            speedLimitDistance = data.speed_limit_distance
            trafficState = data.traffic_state
            trafficDistance = parseInt(data.traffic_light_distance)
            left_blinker = data.left_blinker
            right_blinker = data.right_blinker
            reverseLight = data.reverse_light
            leftDirection = data.left_direction
            rightDirection = data.right_direction
            straightDirection = data.straight_direction
            temperature = parseInt(data.temperature)
            currentTime = data.current_time
            weatherCondition = data.weather_condition
            crossingDistance = data.warning_crossing_distance
            constructionDistance = data.construction_distance
            pedestrianDistance = data.warning_pedestrian_distance
            stopDistance = data.warning_stop

        }
    }

    function getLaneImg() {
        return "qrc:/Dashboard-Design/Design Img/Dash Board/Dash-board-Vehicle-Center-Line.png"

        // if (!inLane){
        //     if (right_lane_departure) {
        //         return "qrc:/Dashboard-Design/Design Img/Dash Board/Dash-board-Vehicle-Center-Line-right.png"
        //     }
        //     else {
        //         return "qrc:/Dashboard-Design/Design Img/Dash Board/Dash-board-Vehicle-Center-Line-left.png"
        //     }

        // }
        // else {
        //     return "qrc:/Dashboard-Design/Design Img/Dash Board/Dash-board-Vehicle-Center-Line.png"
        // }
    }

    function distanceCovered(){
        var value = totalDistance - distanceRemaining
        return (value > 0) ? parseInt(value) : 0
    }


    function getWeatherIcon(weatherName) {
        switch (weatherName.toLowerCase()) {
            case "sunny":
            case "clear":
                return "qrc:/Dashboard-Design/Design Img/Informations/weather-clear.png";
            case "cloudy":
                return "qrc:/Dashboard-Design/Design Img/Informations/weather-cloudy.png";
            case "rain":
            case "rainy":
                return "qrc:/Dashboard-Design/Design Img/Informations/weather-rainy.png";
            case "snow":
            case "snowy":
                return "qrc:/Dashboard-Design/Design Img/Informations/weather-clear.png";
            case "thunderstorm":
                return "qrc:/Dashboard-Design/Design Img/Informations/weather-clear.png";
            case "fog":
            case "foggy":
                return "qrc:/Dashboard-Design/Design Img/Informations/weather-rainy.png";
            case "partly cloudy":
                return "qrc:/Dashboard-Design/Design Img/Informations/weather-rainy.png";
            case "wind":
            case "windy":
                return"qrc:/Dashboard-Design/Design Img/Informations/weather-rainy.png";
            default:
                return "qrc:/Dashboard-Design/Design Img/Informations/weather-clear.png";
        }
    }

    function getTrafficIcon(trafficState) {
        switch (trafficState.toLowerCase()) {
            case "green":
                return "qrc:/Dashboard-Design/Design Img/Informations/green-icon.png";
            case "red":
                return "qrc:/Dashboard-Design/Design Img/Informations/red-icon.png";
            default:
                return "qrc:/Dashboard-Design/Design Img/Informations/green-icon.png";
        }
    }

    function getDistanceIcon(distance) {
        switch (distance.toLowerCase()) {
            case "middle":
                return "qrc:/Dashboard-Design/Design Img/Informations/4. Distance Information/A. Distance to Empty/Distance-to-Empty-Middle.png"

            case "full":
                return "qrc:/Dashboard-Design/Design Img/Informations/4. Distance Information/A. Distance to Empty/Distance-to-Empty-Full.png"
            default:
                return "qrc:/Dashboard-Design/Design Img/Informations/4. Distance Information/A. Distance to Empty/Distance-to-Empty-Low.png";
        }
    }

    function getNavigationIcon(turn) {
        switch (turn.toLowerCase()) {
            case "right":
                return "qrc:/Dashboard-Design/Design Img/Informations/2. Navigation Information/A. Directions/Right-Direction.png";
            case "left":
                return "qrc:/Dashboard-Design/Design Img/Informations/2. Navigation Information/A. Directions/Left-Direction.png";
            default:
                return "qrc:/Dashboard-Design/Design Img/Informations/2. Navigation Information/A. Directions/Straight-Direction.png";
        }
    }

    function getSpeedLimitIcon(speedLimt) {
        switch (speedLimt) {
            case "30":
                return "qrc:/Dashboard-Design/Design Img/Informations/1. Safety Information/B. Speed Limit/Speed-Limit-30.png";
            case "40":
                return "qrc:/Dashboard-Design/Design Img/Informations/1. Safety Information/B. Speed Limit/Speed-Limit-40.png";
            case "50":
                return "qrc:/Dashboard-Design/Design Img/Informations/1. Safety Information/B. Speed Limit/Speed-Limit-50.png";
            case "60":
                return "qrc:/Dashboard-Design/Design Img/Informations/1. Safety Information/B. Speed Limit/Speed-Limit-60.png";
            case "70":
                return "qrc:/Dashboard-Design/Design Img/Informations/1. Safety Information/B. Speed Limit/Speed-Limit-70.png";
            case "80":
                return "qrc:/Dashboard-Design/Design Img/Informations/1. Safety Information/B. Speed Limit/Speed-Limit-80.png";
            case "90":
                return "qrc:/Dashboard-Design/Design Img/Informations/1. Safety Information/B. Speed Limit/Speed-Limit-90.png";
            case "100":
                return "qrc:/Dashboard-Design/Design Img/Informations/1. Safety Information/B. Speed Limit/Speed-Limit-100.png";
            case "110":
                return "qrc:/Dashboard-Design/Design Img/Informations/1. Safety Information/B. Speed Limit/Speed-Limit-110.png";
            case "120":
                return "qrc:/Dashboard-Design/Design Img/Informations/1. Safety Information/B. Speed Limit/Speed-Limit-120.png";
            default:
                return "qrc:/Dashboard-Design/Design Img/Informations/1. Safety Information/B. Speed Limit/Speed-Limit-30.png"
        }
    }

    //time display
    RowLayout{
        id:timeDisplay
        spacing: 20
        anchors{
            left: parent.left
            leftMargin: 10
            top: parent.top
            topMargin: 10
        }

        Label{
            text: currentTime//"11:30 AM"
            font.pixelSize: 32
            //font.family: "Sans"
            font.bold: Font.Normal
            font.capitalization: Font.AllUppercase
            color: "#FFFFFF"
        }

        Image {
            source: getWeatherIcon(weatherCondition)
            sourceSize: Qt.size(30,30)
        }

        Label{
            text: temperature + "°C"
            font.pixelSize: 32
            //font.family: "Sans"
            font.bold: Font.Normal
            font.capitalization: Font.AllUppercase
            color: "#FFFFFF"
        }
    }

    //car mode
    RowLayout{
        id:carStatus
        spacing: 20
        anchors{
            left: parent.left
            leftMargin: 20
            top: parent.top
            topMargin: 140
        }
        Label{
            text: "P"
            font.pixelSize: 32
            //font.family: "Sans"
            font.bold: Font.Normal
            font.capitalization: Font.AllUppercase
            opacity: 0.2
            color: "#FFFFFF"
        }

        Label{
            text: "R"
            font.pixelSize: 32
            //font.family: "Sans"
            font.bold: Font.Normal
            font.capitalization: Font.AllUppercase
            opacity: (drive_mode === "R") ? 1 : 0.2
            color: "#FFFFFF"
        }
        Label{
            text: "N"
            font.pixelSize: 32
            //font.family: "Sans"
            font.bold: Font.Normal
            font.capitalization: Font.AllUppercase
            opacity: 0.2
            color: "#FFFFFF"
        }
        Label{
            text: "D"
            font.pixelSize: 32
            //font.family: "Sans"
            font.bold: Font.Normal
            font.capitalization: Font.AllUppercase
            opacity: (drive_mode === "D") ? 1 : 0.2
            color: "#FFFFFF"
        }
    }


    //distance travelled display
    RowLayout{
        id:distanceDisplay
        spacing: 20
        anchors{
            right: parent.right
            rightMargin: 20
            top: parent.top
            topMargin: 140
        }
        Label{
            text: distanceCovered() + " mi"
            font.pixelSize: 32
            // //font.family: "Sans"
            font.bold: Font.Normal
            color: "#FFFFFF"
        }

        Image {
            source: getDistanceIcon(distanceToEmpty)
            sourceSize: Qt.size(60,60)
        }
    }

    //top navigation bar
    Image{
        id:topNavigation
        anchors{
            top: parent.top
            topMargin: 160
            horizontalCenter: parent.horizontalCenter
        }

        source: "qrc:/Dashboard-Design/Design Img/HUD/HUD-Top-Line.png"
        sourceSize: Qt.size(1500,1000)

        //speed display
        ColumnLayout {
            id: speedDisplayBar
            spacing: 1
            anchors{
                bottom: topNavigation.bottom
                bottomMargin: 55
                horizontalCenter: topNavigation.horizontalCenter
            }

            Label {
                text: "MPH"
                font.pixelSize: 30
                //font.family: "Sans"
                color: "#FFFFFF"
                opacity: 0.4
                font.bold: Font.Normal
                Layout.alignment: Qt.AlignHCenter
            }

            Label {
                text: currentSpeed//leftGauge.value.toFixed(0)
                font.pixelSize: 108
                //font.family: "Sans"
                color: "#FFFFFF"
                font.bold: Font.DemiBold
                Layout.alignment: Qt.AlignHCenter
            }

        }

        //vehicle condition display
        RowLayout {
            id: conditionDisplayBar
            spacing: 1
            anchors{
                top: topNavigation.top
                topMargin: 55
                horizontalCenter: topNavigation.horizontalCenter
            }

            Loader {
                active: fogLight  // Only loads when condition is true
                sourceComponent: Image {
                    source: "qrc:/Dashboard-Design/Design Img/Informations/5. Indicator Information/B. Vehicle Status indicator/Fog_Light_Indicator.png"
                    sourceSize: Qt.size(90,90)
                }
            }
            Loader {
                active: highBeam
                sourceComponent: Image {
                    source: "qrc:/Dashboard-Design/Design Img/Informations/5. Indicator Information/B. Vehicle Status indicator/High_Beam_indicator-.png"
                    sourceSize: Qt.size(90,90)
                }
            }
            Loader {
                active: hazardIndicator
                sourceComponent: Image {
                    source: "qrc:/Dashboard-Design/Design Img/Informations/5. Indicator Information/B. Vehicle Status indicator/Turn_Signal_Indicator_Hazard_Warning_Light.png"
                    sourceSize: Qt.size(90,90)
                }
            }
        }

        //road signs
        RowLayout{
            id:roadSigns
            spacing: 40
            // anchors{
            //     left: parent.left
            //     leftMargin: parent.width / 6
            //     bottom: parent.bottom
            //     bottomMargin: 26.50 + 30
            // }
            anchors{
                right: speedDisplayBar.left
                rightMargin: 70
                bottom: parent.bottom
                bottomMargin: 55
            }

            Loader {
                active: speedLimt !== ""  // Only loads when condition is true
                sourceComponent: ColumnLayout {
                    Image {
                        source: getSpeedLimitIcon(speedLimt)
                        sourceSize: Qt.size(90,90)
                    }

                    Label {
                        text: parseInt(speedLimitDistance) + " m"
                        font.pixelSize: 28
                        //font.family: "Sans"
                        color: "#FFFFFF"
                        font.bold: Font.Normal
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

            // Loader {
            //     active: trafficState !== ""  // Only loads when condition is true
            //     sourceComponent: ColumnLayout {
            //         Image {
            //             source: getTrafficIcon(trafficState)
            //             sourceSize: Qt.size(90,90)
            //         }

            //         Label {
            //             text: parseInt(trafficDistance) + " mi"
            //             font.pixelSize: 28
            //             //font.family: "Sans"
            //             color: "#FFFFFF"
            //             font.bold: Font.Normal
            //             Layout.alignment: Qt.AlignHCenter
            //         }
            //     }
            // }

            Loader {
                active: crossingDistance !== ""  // Only loads when condition is true
                sourceComponent: ColumnLayout {
                    Image {
                        source: "qrc:/Dashboard-Design/Design Img/Informations/1. Safety Information/A. Caution Zone/Caution-zone-example.png"
                        sourceSize: Qt.size(90,90)
                    }

                    Label {
                        text: parseInt(crossingDistance) + " m"
                        font.pixelSize: 28
                        //font.family: "Sans"
                        color: "#FFFFFF"
                        font.bold: Font.Normal
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

            Loader {
                active: constructionDistance !== ""  // Only loads when condition is true
                sourceComponent: ColumnLayout {
                    Image {
                        source: "qrc:/Dashboard-Design/Design Img/Informations/1. Safety Information/A. Caution Zone/construction-zone.webp"
                        sourceSize: Qt.size(90,90)
                    }

                    Label {
                        text: parseInt(crossingDistance) + " m"
                        font.pixelSize: 28
                        //font.family: "Sans"
                        color: "#FFFFFF"
                        font.bold: Font.Normal
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

            Loader {
                active: stopDistance !== ""  // Only loads when condition is true
                sourceComponent: ColumnLayout {
                    Image {
                        source: "qrc:/Dashboard-Design/Design Img/Informations/stop.png";
                        sourceSize: Qt.size(90,90)
                    }

                    Label {
                        text: parseInt(stopDistance, 10) + " m"
                        font.pixelSize: 28
                        //font.family: "Sans"
                        color: "#FFFFFF"
                        font.bold: Font.Normal
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }

        }

        //right side symbols
        RowLayout{
            id:rightSymbols
            spacing: 18
            anchors{
                left: speedDisplayBar.right
                leftMargin: 70
                bottom: parent.bottom
                bottomMargin: 55
            }
            ColumnLayout {
                Image {
                    source: getNavigationIcon(turnSignal)
                    sourceSize: Qt.size(80,80)
                }
                Label {
                    text: turnSignalDistance + " m"
                    font.pixelSize: 32
                    //font.family: "Sans"
                    color: "#FFFFFF"
                    font.bold: Font.Normal
                    Layout.alignment: Qt.AlignHCenter
                }

            }

            Loader {
                active: ecoMode
                sourceComponent: Image {
                    source: "qrc:/Dashboard-Design/Design Img/Informations/5. Indicator Information/B. Vehicle Status indicator/Eco_mode_indicator.png"
                    sourceSize: Qt.size(100,100)
                }
            }
            Loader {
                active: tpms
                sourceComponent: Image {
                    source: "qrc:/Dashboard-Design/Design Img/Informations/5. Indicator Information/A. Warning indicator/TPMS_warning_indicato.png"
                    sourceSize: Qt.size(100,100)
                }
            }
            Loader {
                active: fuelWarning
                sourceComponent: Image {
                    source: "qrc:/Dashboard-Design/Design Img/Informations/5. Indicator Information/A. Warning indicator/Fuel_warning_indicator.png"
                    sourceSize: Qt.size(100,100)
                }
            }
            Loader {
                active: engineWarning
                sourceComponent: Image {
                    source: "qrc:/Dashboard-Design/Design Img/Informations/5. Indicator Information/A. Warning indicator/Engine_warning_indicator.png"
                    sourceSize: Qt.size(100,100)
                }
            }
            Loader {
                active: washerFluidWarning
                sourceComponent: Image {
                    source: "qrc:/Dashboard-Design/Design Img/Informations/5. Indicator Information/A. Warning indicator/Washer_fluid_warning_indicator.png"
                    sourceSize: Qt.size(100,100)
                }
            }

        }

    }

    Image {
        anchors{
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 100 + 65
        }
        sourceSize: Qt.size(550,550)
        source: getLaneImg()

    }

    Image {
        anchors{
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 120 + 85
        }
        sourceSize: Qt.size(200,200)
        source: "qrc:/Dashboard-Design/Design Img/Informations/Vehicle Img.png"

    }

    SideGauge {
        id:leftGauge
        anchors{
            left: parent.left
            leftMargin: 2
            bottom: parent.bottom
            bottomMargin: 25
        }
        property bool accelerating
        decimalPlace: 0
        img_path: "qrc:/Dashboard-Design/Design Img/Dash Board/Dash-board-Gauge-Cluster-Speed.png"
        width: 580
        height: 580
        // value: currentSpeed //
        speedValue: currentSpeed //accelerating ? maximumValue : 0 //
        maximumValue: 350
        Component.onCompleted: forceActiveFocus()
        Behavior on value { NumberAnimation { duration: 1000 }}

        Keys.onSpacePressed: accelerating = true
        Keys.onDigit1Pressed: rightGauge.accelerating = true
        Keys.onReleased: {
            if (event.key === Qt.Key_Space) {
                accelerating = false;
                event.accepted = true;
            }else if(event.key === Qt.Key_1){
                rightGauge.accelerating = false;
                event.accepted = true;
            }
        }
    }

    //Fuel Km
    RowLayout{
        id:fuelKm
        spacing: 20
        anchors{
            left: parent.left
            leftMargin: 200
            bottom: parent.bottom
            bottomMargin: 5
        }

        Image {
            source: "qrc:/Dashboard-Design/Design Img/Informations/fuel-indicator.png"
            sourceSize: Qt.size(30,30)
        }

        Label{
            text: fuel_km + " km"
            font.pixelSize: 25
            //font.family: "Sans"
            font.bold: Font.Normal
            color: "#FFFFFF"
        }
    }

    function roundForDisplay(number) {
        return number.toLocaleString(Qt.locale(), 'f', 1);
    }


    SideGauge {
        id:rightGauge
        anchors{
            right: parent.right
            rightMargin: 2
            bottom: parent.bottom
            bottomMargin: 25
        }

        property bool accelerating
        decimalPlace: 1
        img_path: "qrc:/Dashboard-Design/Design Img/Dash Board/Dash-board-Gauge-Cluster-RPM.png"
        width: 580
        height: 580
        speedValue: currentRpm / 10
        // value: currentRpm / 10 //currentSpeed * 10//accelerating ? maximumValue : 0
        maximumValue: 3
        Behavior on value { NumberAnimation { duration: 500 }}
    }

}
