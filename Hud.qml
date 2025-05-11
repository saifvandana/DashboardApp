import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtWebSockets 1.1


ApplicationWindow {
    id:root
    width: 1300
    height: 750
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
    property string speedLimt: " "
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
    property string currentTime: "12:00"
    property string weatherCondition: "rain"
    property string crossingDistance: ""
    property string pedestrianDistance: ""
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
            pedestrianDistance = data.warning_pedestrian_distance
            stopDistance = data.warning_stop

        }
    }

    function getLaneImg() {
        if (!inLane){
            if (right_lane_departure) {
                return "qrc:/Dashboard-Design/Design Img/HUD/HUD-Vehicle-Center-Line-right.png"
            }
            else {
                return "qrc:/Dashboard-Design/Design Img/HUD/HUD-Vehicle-Center-Line-left.png"
            }

        }
        else {
            return "qrc:/Dashboard-Design/Design Img/HUD/HUD-Vehicle-Center-Line.png"
        }
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
            font.pixelSize: 42
            //font.family: "Sans"
            font.bold: Font.Normal
            font.capitalization: Font.AllUppercase
            color: "#FFFFFF"
        }

        Image {
            source: getWeatherIcon(weatherCondition)
            sourceSize: Qt.size(40,40)
        }

        Label{
            text: temperature + "°C"
            font.pixelSize: 42
            //font.family: "Sans"
            font.bold: Font.Normal
            font.capitalization: Font.AllUppercase
            color: "#FFFFFF"
        }
    }

    //road signs
    ColumnLayout{
        id:roadSigns
        spacing: 30
        anchors{
            left: parent.left
            leftMargin: 50
            top: parent.top
            topMargin: 180
        }

        Loader {
            active: speedLimt !== ""  // Only loads when condition is true
            sourceComponent: ColumnLayout {
                Image {
                    source: getSpeedLimitIcon(speedLimt)
                    sourceSize: Qt.size(90,90)
                }

                Label {
                    text: parseInt(speedLimitDistance) + " mi"
                    font.pixelSize: 28
                    //font.family: "Sans"
                    color: "#FFFFFF"
                    font.bold: Font.Normal
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }

        Loader {
            active: trafficState !== ""  // Only loads when condition is true
            sourceComponent: ColumnLayout {
                Image {
                    source: getTrafficIcon(trafficState)
                    sourceSize: Qt.size(90,90)
                }

                Label {
                    text: parseInt(trafficDistance) + " mi"
                    font.pixelSize: 28
                    //font.family: "Sans"
                    color: "#FFFFFF"
                    font.bold: Font.Normal
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }

        Loader {
            active: crossingDistance !== ""  // Only loads when condition is true
            sourceComponent: ColumnLayout {
                Image {
                    source: "qrc:/Dashboard-Design/Design Img/Informations/1. Safety Information/A. Caution Zone/Caution-zone-example.png"
                    sourceSize: Qt.size(90,90)
                }

                Label {
                    text: parseInt(crossingDistance) + " mi"
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
                    text: parseInt(stopDistance, 10) + " mi"
                    font.pixelSize: 28
                    //font.family: "Sans"
                    color: "#FFFFFF"
                    font.bold: Font.Normal
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }

    }

    ColumnLayout{
        id:rightSymbols
        spacing: 18
        anchors{
            right: parent.right
            rightMargin: 50
            top: parent.top
            topMargin: 180
        }

        Image {
            source: "qrc:/Dashboard-Design/Design Img/Informations/5. Indicator Information/A. Warning indicator/Engine_oil_warning_indicator.png"
            sourceSize: Qt.size(100,100)
        }
        Image {
            source: "qrc:/Dashboard-Design/Design Img/Informations/5. Indicator Information/A. Warning indicator/ABS_warning_indicator.png"
            sourceSize: Qt.size(100,100)
        }
        Image {
            source: "qrc:/Dashboard-Design/Design Img/Informations/5. Indicator Information/B. Vehicle Status indicator/Eco_mode_indicator.png"
            sourceSize: Qt.size(100,100)
        }
    }

    RowLayout{
        id:nav
        spacing: 18
        anchors{
            top: parent.top
            topMargin: 50
            horizontalCenter: parent.horizontalCenter
        }
        Image {
            source: "qrc:/Dashboard-Design/Design Img/Informations/2. Navigation Information/A. Directions/Straight-Direction.png"
            sourceSize: Qt.size(100,100)
        }
        ColumnLayout {
            Label {
                text: distanceRemaining + " mi"
                font.pixelSize: 52
                //font.family: "Sans"
                color: "#FFFFFF"
                font.bold: Font.Normal
                Layout.alignment: Qt.AlignHCenter
            }

            Label {
                text: "Destination"
                font.pixelSize: 48
                //font.family: "Sans"
                color: "#FFFFFF"
                Layout.alignment: Qt.AlignHCenter
            }
        }

    }


    //car mode
    RowLayout{
        id:carStatus
        spacing: 20
        anchors{
            left: parent.left
            leftMargin: 20
            bottom: parent.bottom
            bottomMargin: 10
        }
        Label{
            text: "P"
            font.pixelSize: 52
            font.bold: Font.Normal
            font.capitalization: Font.AllUppercase
            opacity: 0.2
            color: "#FFFFFF"
        }

        Label{
            text: "R"
            font.pixelSize: 52
            font.bold: Font.Normal
            font.capitalization: Font.AllUppercase
            opacity: (drive_mode === "R") ? 1 : 0.2
            color: "#FFFFFF"
        }
        Label{
            text: "N"
            font.pixelSize: 52
            font.bold: Font.Normal
            font.capitalization: Font.AllUppercase
            opacity: 0.2
            color: "#FFFFFF"
        }
        Label{
            text: "D"
            font.pixelSize: 52
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
            bottom: parent.bottom
            bottomMargin: 10
        }
        Label{
            text: distanceCovered() + " mi"
            font.pixelSize: 52
            // //font.family: "Sans"
            font.bold: Font.Normal
            color: "#FFFFFF"
        }

        Image {
            source: "qrc:/Dashboard-Design/Design Img/Informations/4. Distance Information/A. Distance to Empty/Distance-to-Empty-Middle.png"
            sourceSize: Qt.size(120,120)
        }
    }

    Image {
        anchors{
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 100 + 65
        }
        sourceSize: Qt.size(700,700)
        source: getLaneImg()

    }

    Image {
        anchors{
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 220
        }
        sourceSize: Qt.size(300,300)
        source: "qrc:/Dashboard-Design/Design Img/Informations/Vehicle Img.png"

    }

    //speed display
    ColumnLayout {
        id: speedDisplayBar
        spacing: 1
        anchors{
            bottom: parent.bottom
            bottomMargin: 10
            horizontalCenter: parent.horizontalCenter
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
            font.pixelSize: 92
            //font.family: "Sans"
            color: "#FFFFFF"
            font.bold: Font.DemiBold
            Layout.alignment: Qt.AlignHCenter
        }

    }

}
