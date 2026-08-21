import QtQuick 2.15

Item {
    property string pkgName: "BBS02B VESC Package"
    property string pkgDescriptionMd: "README.md"
    property string pkgLisp: "main.lisp"
    property string pkgQml: "ui.qml"
    property bool pkgQmlIsFullscreen: false
    property string pkgOutput: "bbs02b.vescpkg"

    function isCompatible(fwRxParams) {
        return fwRxParams.hwTypeStr().toLowerCase() == "vesc";
    }
}
