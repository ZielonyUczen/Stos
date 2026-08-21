import QtQuick 2.15

Item {
    property string pkgName: "BBS02B VESC Package"
    property string pkgDescriptionMd: "README.md"
    property string pkgLisp: "../lispm/main.lisp"
    property string pkgQml: "../qml/main.qml"
    property bool pkgQmlIsFullscreen: false
    property string pkgOutput: "bbs02b.vescpkg"

    function isCompatible(fwRxParams) {
        // Final hardware compatibility rules will be added after
        // verification against the target VESC firmware/API.
        return fwRxParams.hwTypeStr().toLowerCase() == "vesc";
    }
}
