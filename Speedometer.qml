import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.3
import QtQuick.Extras.Private 1.0
import QtGraphicalEffects 1.0

CircularGauge {
    id: gauge
    width: 400
    height: 400
    minimumValue: 0
    maximumValue: 250
    value: 0  // Default speed

    property bool shadowVisible: true
    property string speedColor: "white"
    // Define the radius and angle for the arc
    property real arcAngle: 180  // Angle in degrees
    property real arcRadius: 90
    property real speedValue: 0

    style: CircularGaugeStyle {
        labelStepSize: 50
        labelInset: outerRadius / 2.2
        tickmarkInset: outerRadius / 3.5
        minorTickmarkInset: outerRadius / 4.2
        minimumValueAngle: -155
        maximumValueAngle: 155

        background: Rectangle {
            implicitHeight: gauge.height
            implicitWidth: gauge.width
            color: "transparent"
            radius: 360

            //outer cirlce
            Canvas {
                id:circularCanva
                property int value: gauge.value

                anchors.fill: parent

                Component.onCompleted: requestPaint()

                function degreesToRadians(degrees) {
                    return degrees * (Math.PI / 180);
                }

                function createLinearGradient(ctx, start, end, colors) {
                    var gradient = ctx.createLinearGradient(start.x, start.y, end.x, end.y);
                    for (var i = 0; i < colors.length; i++) {
                        gradient.addColorStop(i / (colors.length - 1), colors[i]);
                    }
                    return gradient;
                }

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();

                    // Define the gradient colors for the filled arc
                    var gradientColors = [
                                "#09A6F3",// Start color blue
                                "#09A6F3",    // End color
                            ];

                    // Calculate the start and end angles for the filled arc
                    var startAngle = valueToAngle(gauge.minimumValue) - 90;
                    var endAngle = valueToAngle(250) - 90;

                    // Create a linear gradient
                    var gradient = createLinearGradient(ctx, { x: 0, y: 0 }, { x: outerRadius * 2, y: 0 }, gradientColors);

                    //Loop through the gradient colors and fill the arc segment with each color
                    for (var i = 0; i < gradientColors.length; i++) {
                        var gradientColor = gradientColors[i];
                        var angle = startAngle + (endAngle - startAngle) * (i / (gradientColors.length - 1));

                        ctx.beginPath();
                        ctx.lineWidth = 8;
                        ctx.strokeStyle = gradient;
                        ctx.arc(outerRadius,
                                outerRadius,
                                outerRadius - 54,
                                degreesToRadians(angle),
                                degreesToRadians(endAngle));
                        ctx.stroke();
                    }
                }
            }

            //inner circle
            Canvas {
                id:outercircularCanva
                property int value: gauge.value

                anchors.fill: parent

                Component.onCompleted: requestPaint()

                function degreesToRadians(degrees) {
                    return degrees * (Math.PI / 180);
                }

                function createLinearGradient(ctx, start, end, colors) {
                    var gradient = ctx.createLinearGradient(start.x, start.y, end.x, end.y);
                    for (var i = 0; i < colors.length; i++) {
                        gradient.addColorStop(i / (colors.length - 1), colors[i]);
                    }
                    return gradient;
                }

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();

                    // Define the gradient colors for the filled arc
                    var gradientColors = [
                                "#9B9B94",// Start color ash
                                "#9B9B94",    // End color
                            ];

                    // Calculate the start and end angles for the filled arc
                    var startAngle = valueToAngle(gauge.minimumValue) - 90;
                    var endAngle = valueToAngle(360) - 90;

                    // Create a linear gradient
                    var gradient = createLinearGradient(ctx, { x: 0, y: 0 }, { x: outerRadius * 2, y: 0 }, gradientColors);

                    //Loop through the gradient colors and fill the arc segment with each color
                    for (var i = 0; i < gradientColors.length; i++) {
                        var gradientColor = gradientColors[i];
                        var angle = startAngle + (endAngle - startAngle) * (i / (gradientColors.length - 1));

                        ctx.beginPath();
                        ctx.lineWidth = 4;
                        ctx.strokeStyle = gradient;
                        ctx.arc(outerRadius,
                                outerRadius,
                                outerRadius - 50,
                                degreesToRadians(angle),
                                degreesToRadians(endAngle));
                        ctx.stroke();
                    }
                }
            }

            //inside circle
            Canvas {
                property int value: gauge.value

                anchors.fill: parent

                Component.onCompleted: requestPaint()

                function degreesToRadians(degrees) {
                    return degrees * (Math.PI / 180);
                }

                function createLinearGradient(ctx, start, end, colors) {
                    var gradient = ctx.createLinearGradient(start.x, start.y, end.x, end.y);
                    for (var i = 0; i < colors.length; i++) {
                        gradient.addColorStop(i / (colors.length - 1), colors[i]);
                    }
                    return gradient;
                }

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();

                    // Define the gradient colors for the filled arc
                    var gradientColors = [
                                "#545451",// Start color
                                "#545451",
                                // End color
                            ];

                    // Calculate the start and end angles for the filled arc
                    var startAngle = valueToAngle(gauge.minimumValue) - 90;
                    var endAngle = valueToAngle(360) - 90;

                    // Create a linear gradient
                    var gradient = createLinearGradient(ctx, { x: 0, y: 0 }, { x: outerRadius * 2, y: 0 }, gradientColors);

                    //Loop through the gradient colors and fill the arc segment with each color
                    for (var i = 0; i < gradientColors.length; i++) {
                        var gradientColor = gradientColors[i];
                        var angle = startAngle + (endAngle - startAngle) * (i / (gradientColors.length - 1));

                        ctx.beginPath();
                        ctx.lineWidth = 5;
                        ctx.strokeStyle = gradient;
                        ctx.arc(outerRadius,
                                outerRadius,
                                outerRadius - 130,
                                degreesToRadians(angle),
                                degreesToRadians(endAngle));
                        ctx.stroke();
                    }
                }
            }

            Canvas {
                property int value: gauge.value

                anchors.fill: parent
                onValueChanged: requestPaint()

                function degreesToRadians(degrees) {
                    return degrees * (Math.PI / 180);
                }

                function createLinearGradient(ctx, start, end, colors) {
                    var gradient = ctx.createLinearGradient(start.x, start.y, end.x, end.y);
                    for (var i = 0; i < colors.length; i++) {
                        gradient.addColorStop(i / (colors.length - 1), colors[i]);
                    }
                    return gradient;
                }

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();

                    // Define the gradient colors for the filled arc
                    var gradientColors = [
                                "#6369FF",// Start color
                                "#63FFFF",    // End color
                                "#FFFF00",
                                "#FF0000"
                            ];

                    // Calculate the start and end angles for the filled arc
                    var startAngle = valueToAngle(gauge.minimumValue) - 90;
                    var endAngle = valueToAngle(gauge.value) - 90;

                    // Create a linear gradient
                    var gradient = createLinearGradient(ctx, { x: 0, y: 0 }, { x: outerRadius * 2, y: 0 }, gradientColors);

                    // Loop through the gradient colors and fill the arc segment with each color
                    for (var i = 0; i < gradientColors.length; i++) {
                        var gradientColor = gradientColors[i];
                        var angle = startAngle + (endAngle - startAngle) * (i / (gradientColors.length - 1));

                        ctx.beginPath();
                        ctx.lineWidth = outerRadius * 0.3;
                        ctx.strokeStyle = gradient;
                        ctx.arc(outerRadius,
                                outerRadius,
                                outerRadius - 88,
                                degreesToRadians(angle),
                                degreesToRadians(endAngle));
                        ctx.stroke();
                    }
                }
            }



            // Speed color arc
            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();

                    var startAngle = Math.PI * (-135 / 180);
                    var endAngle = Math.PI * ((gauge.value / 250) * 270 - 135) / 180;

                    ctx.beginPath();
                    ctx.lineWidth = outerRadius * 0.15;
                    ctx.strokeStyle = speedColor(gauge.value);
                    ctx.arc(outerRadius, outerRadius, outerRadius - 75, startAngle, endAngle);
                    ctx.stroke();
                }
            }

        }


        //Needle
        needle: Item {
            y: -outerRadius * 0.70
            //height: outerRadius * 0.25
            Image {
                id: needle
                source: "qrc:/img/Rectangle 4.svg"
                width: height * 0.015
                asynchronous: true
                antialiasing: true
            }

            Glow {
              anchors.fill: needle
              radius: 5
              samples: 10
              color: "white"
              source: needle
          }
        }


        // Speed Text
        foreground: Item {
            anchors.centerIn: parent

            ColumnLayout {
                anchors.centerIn: parent
                Label {
                    text: gauge.value.toFixed(0)
                    font.pixelSize: 46
                    font.family: "Inter"
                    color: "#FFFFFF"
                    font.bold: Font.DemiBold
                    Layout.alignment: Qt.AlignHCenter
                }

                Label {
                    text: "mph"
                    font.pixelSize: 18
                    font.family: "Inter"
                    color: "#FFFFFF"
                    opacity: 0.4
                    font.bold: Font.Normal
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }

        tickmarkLabel:  Text {
            visible: false
            font.pixelSize: Math.max(6, outerRadius * 0.05)
            text: styleData.value
            color: styleData.value <= gauge.value ? "white" : "#777776"
            antialiasing: true
        }

        tickmark:Rectangle {
            // visible: false
            implicitWidth: outerRadius * 0.008
            implicitHeight: outerRadius * 0.05
            antialiasing: true
            smooth: true
            color: styleData.value <= gauge.value ? "white" : "darkGray"
        }
        minorTickmark: Rectangle {
            visible: false
            implicitWidth: outerRadius * 0.008
            implicitHeight: outerRadius * 0.05

            antialiasing: true
            smooth: true
            color: styleData.value <= gauge.value ? "white" : "darkGray"
        }
    }

    // Animate speed changes
    Behavior on value {
        NumberAnimation {
            duration: 400
            easing.type: Easing.OutCubic
        }
    }

    // Simulate speed updates
    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: gauge.value = Math.random() * 250;
    }
}
