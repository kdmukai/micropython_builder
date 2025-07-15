import sys
if sys.platform == 'esp32':
    import machine
    if machine.freq() != 240_000_000:
        machine.freq(240_000_000)  # 240MHz
        print("Set CPU frequency to 240MHz")

import time
import secp256k1
from embit import bip39, bip32
from embit.networks import NETWORKS

def test_run():
    mnemonic = "smoke chimney announce candy glory tongue refuse fatigue cricket once consider beef treat urge wing deny gym robot tobacco adult problem priority wheat diagram"
    seed_bytes = bip39.mnemonic_to_seed(mnemonic)
    root = bip32.HDKey.from_seed(seed_bytes, version=NETWORKS["main"]["xprv"])
    xprv = root.derive("m/84'/0'/0'")
    xpub = xprv.to_public()
    return xpub

for i in range(0, 4):
    start = time.ticks_ms()
    xpub = test_run()
    end = time.ticks_ms()
    print(f"{time.ticks_diff(end, start)}ms")

print(xpub)

