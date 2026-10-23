import QtQuick 2.15

Item {
    property string pkgName: "BBS02B VESC Package"
    property string pkgDescriptionMd: "../bbs02b/README.md"
    property string pkgLisp: "../bbs02b/main.lisp"
    property string pkgQml: "../bbs02b/ui.qml"
    property bool pkgQmlIsFullscreen: false
    property string pkgOutput: "bbs02b.vescpkg"

    function isCompatible(fwRxParams) {
        if (!fwRxParams || !fwRxParams.hw || !fwRxParams.hwTypeStr) {
            return false;
        }

        var major = Number(fwRxParams.major);
        var minor = Number(fwRxParams.minor);

        return fwRxParams.hwTypeStr().toLowerCase() === "vesc"
                && fwRxParams.hw.toLowerCase() === "mksesc_75_200_v2"
                && isFinite(major)
                && isFinite(minor)
                && (major > 7 || (major === 7 && minor >= 0));
    }
}
