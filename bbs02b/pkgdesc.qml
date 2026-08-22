import QtQuick 2.15

Item {
    property string pkgName: "BBS02B VESC Package"
    property string pkgDescriptionMd: "README.md"
    property string pkgLisp: "main.lisp"
    property string pkgQml: "ui.qml"
    property bool pkgQmlIsFullscreen: false
    property string pkgOutput: "bbs02b.vescpkg"

    // Project firmware baseline: VESC 7.00+
    function isCompatible(fwRxParams) {
        var hw = fwRxParams.hwTypeStr().toLowerCase();
        var fw = Number(fwRxParams.fwVersion());

        return hw == "vesc" && fw >= 7.00;
    }
}
