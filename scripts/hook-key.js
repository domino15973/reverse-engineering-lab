Java.perform(() => {
    const SecretKeySpec = Java.use("javax.crypto.spec.SecretKeySpec");

    SecretKeySpec.$init.overload('[B', 'java.lang.String').implementation = function(keyBytes, algo) {
        console.log("[+] SecretKeySpec() called");
        console.log("    ALGO =", algo);
        console.log("    KEY (HEX) =", bytesToHex(keyBytes));

        return this.$init(keyBytes, algo);
    };

    function bytesToHex(byteArray) {
        return Array.prototype.map.call(byteArray, function(byte) {
            return ('0' + (byte & 0xFF).toString(16)).slice(-2);
        }).join('');
    }
});
