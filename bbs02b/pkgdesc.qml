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
        var hwType = fwRxParams.hwTypeStr().toLowerCase();
        var major = fwRxParams.major;
        var minor = fwRxParams.minor;

        if (hwType != "vesc") {
            return false;
        }

        return major > 7 || (major == 7 && minor >= 0);
    }
}
