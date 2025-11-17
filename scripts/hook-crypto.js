Java.perform(() => {
    const CryptoManager = Java.use("com.example.securenotes.crypto.CryptoManager");

    CryptoManager.$init.overload('android.content.Context').implementation = function(ctx) {
        console.log("[+] CryptoManager instantiated");
        return this.$init(ctx);
    };

    CryptoManager.encrypt.overload('java.lang.String').implementation = function(plaintext) {
        console.log("[+] encrypt() called");
        console.log("    PLAINTEXT =", plaintext);

        const result = this.encrypt(plaintext);
        console.log("    CIPHERTEXT =", result);
        return result;
    };

    CryptoManager.decrypt.overload('java.lang.String').implementation = function(ciphertext) {
        console.log("[+] decrypt() called");
        console.log("    CIPHERTEXT =", ciphertext);

        const result = this.decrypt(ciphertext);
        console.log("    PLAINTEXT =", result);
        return result;
    };
});
