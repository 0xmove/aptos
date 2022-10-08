
import 'package:aptos/aptos_account.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final aptosAccountObject = AptosAccountObject(
    address: "0x978c213990c4833df71548df7ce49d54c759d6b6d932de22b24d56060b7af2aa",
    privateKeyHex: "0xc5338cd251c22daa8c9c9cc94f498cc8a5c7e1d2e75287a5dda91096fe64efa5de19e5d1880cac87d57484ce9ed2e84cf0f9599f12e7cc3a52e4e7657a763f2c",
    publicKeyHex: "0xde19e5d1880cac87d57484ce9ed2e84cf0f9599f12e7cc3a52e4e7657a763f2c"
  );

  const mnemonic = "shoot island position soft burden budget tooth cruel issue economy destroy above";

  test("generates random accounts", () {
    final a1 = AptosAccount();
    final a2 = AptosAccount();
    expect(a1.authKey() == a2.authKey(), false);
    expect(a1.address().hex() == a2.address().hex(), false);
  });


  test("generates derive path accounts", () {
    const address = "0x07968dab936c1bad187c60ce4082f307d030d780e91e694ae03aef16aba73f30";
    final a1 = AptosAccount.fromDerivePath("m/44'/637'/0'/0'/0'", mnemonic);
    expect(a1.address().hex(), address);
  });

  test("generates derive path accounts", () {
    expect(() {
      AptosAccount.fromDerivePath("", mnemonic);
    }, throwsArgumentError);
  });

  test("accepts custom address", () {
    const address = "0x777";
    final a1 = AptosAccount(null, address);
    expect(a1.address().hex(), address);
  });

  test("Deserializes from AptosAccountObject", () {
    final a1 = AptosAccount.fromAptosAccountObject(aptosAccountObject);
    expect(a1.address().hex(), aptosAccountObject.address);
    expect(a1.pubKey().hex(), aptosAccountObject.publicKeyHex);
  });

  test("Deserializes from AptosAccountObject without address", () {
    final privateKeyObject = AptosAccountObject(privateKeyHex: aptosAccountObject.privateKeyHex);
    final a1 = AptosAccount.fromAptosAccountObject(privateKeyObject);
    expect(a1.address().hex(), aptosAccountObject.address);
    expect(a1.pubKey().hex(), aptosAccountObject.publicKeyHex);
  });

  test("Serializes/Deserializes", () {
    final a1 = AptosAccount();
    final a2 = AptosAccount.fromAptosAccountObject(a1.toPrivateKeyObject());
    expect(a1.authKey().hex(), a2.authKey().hex());
    expect(a1.address().hex(), a2.address().hex());
  });

  test("Signs Strings", () {
    final a1 = AptosAccount.fromAptosAccountObject(aptosAccountObject);
    expect(a1.signHexString("0x7777").hex(), 
      "0xc5de9e40ac00b371cd83b1c197fa5b665b7449b33cd3cdd305bb78222e06a671a49625ab9aea8a039d4bb70e275768084d62b094bc1b31964f2357b7c1af7e0d",
    );
  });


}