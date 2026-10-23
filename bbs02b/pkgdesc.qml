import QtQuick 2.15

Item {
    property string pkgName: "BBS02B VESC Package"
    property string pkgDescriptionMd: "README.md"
    property string pkgLisp: "main.lisp"
    property string pkgQml: "ui.qml"
    property bool pkgQmlIsFullscreen: false
    property string pkgOutput: "bbs02b.vescpkg"

    function isCompatible(fwRxParams) {
        if (!fwRxParams || !fwRxParams.hw || !fwRxParams.hwTypeStr) {
            return false;
        }

        var hwType = fwRxParams.hwTypeStr().toLowerCase();
        var hwName = fwRxParams.hw.toLowerCase();
        var major = Number(fwRxParams.major);
        var minor = Number(fwRxParams.minor);

        if (hwType !== "vesc" || hwName !== "mksesc_75_200_v2") {
            return false;
        }

        if (!isFinite(major) || !isFinite(minor)) {
            return false;
        }

        return major > 7 || (major === 7 && minor >= 0);
    }
}
