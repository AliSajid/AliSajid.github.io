---
title: All the slots in YubiKey Series 5
date: 2025-01-20T21:23:11-04:00
draft: true
tags: []
categories: []
author:
  name: "Ali Sajid Imami"
  link: "/about_me/"
  avatar: "/images/aliimami.png"
  email: "<hello@aliimami.com>"
---

## Introduction

Hardware keys have seen a resurgence in the past couple years. This is particularly
in the wake of the recent standardization of [Passkeys](https://fidoalliance.org/passkeys/) by the [FIDO Alliance](https://fidoalliance.org). I have
been keeping an eye on them for improving the security for myself and my family. I ended up buying a set of [YubiKey 5c NFC](https://www.yubico.com/product/yubikey-5-series/yubikey-5c-nfc/) for my family. I have had a good experience integrating them into my online identities.

However, this is not a post reviewing the YubiKey. This is about a technical detail in it. YubiKeys have a concept of [slots](https://docs.yubico.com/yesdk/users-manual/application-piv/slots.html), which is where it can store the necessary authentication-related information. Some of them are pretty widely mentioned in the YubiKey related literature, but I was curious about how many slots there are, and which ones can be used.

## The Impetus

The primary reason I wanted to look into this was because I have been actively trying to integrate encryption and cryptographic signatures
into my workflow. This includes using GPG signatures to sign my git commits and signing all of my emails, and encrypting them wherever possible.

I recently became ware of the [age](https://github.com/FiloSottile/age) project. I am not a cryptography researcher or professional, but I am an avid user
of these technologies. When I looked into _age_, I found it to be an interesting approach to the problem of encryption and attestation. Since I already use my GPG keys resident on the YubiKey, I wanted to keep my primary keys on it as well. However, I didn't want to overwrite anything that I already was using, and I couldn't find information about the slots and related stuff. Thus, I decided to look for all the slots on the YubiKey's PIV Interface.

## Enumerating The Slots

### Assumptions

I started this process with a couple of things that I already knew, or had guessed.

1. All the slots are available from the YubiKey PIV (SmartCard) Interface
2. The slots are identified by two-digit hexadecimal numbers.

The second assumption is based on my reading where the literature often referred to slot F9 or slot 9C.

### Preparation

YubiKey helpfully provides us with a CLI that can be used to interact with the key and read and manipulate the information
on it. This tool is called [`ykman`](https://github.com/Yubico/yubikey-manager) and is quite fantastic. I decided to use this tool.

I also decided that I will iterate through all the two-digit hexadecimal numbers from `01` to `ff`.

### Application

I ran the following bash loop to get all the information.

```bash
for n in $(seq 1 255); do
    h=$(printf "%02x\n" "$n")
    ykman piv keys info "$h" 2>&1 | tee -a ykslots
done
```

The output from this is available in the [`ykslots`](/ykslots.txt) file.

### Result

After poring through the result, I have created the following table:

| Hexadecimal ID | Decimal ID | Script Output | Tag |
| :-------------: | :-------------: | :-------------: | :-------------: |
| 01 - 81 | 1 - 129  | `Error: Invalid value for "slot"` | _N/A_ |
| 82 | 130  | `ERROR: No key stored in slot 82` | `RETIRED1` |
| 83 | 131  | `ERROR: No key stored in slot 83` | `RETIRED2` |
| 84 | 132  | `ERROR: No key stored in slot 84` | `RETIRED3` |
| 85 | 133  | `ERROR: No key stored in slot 85` | `RETIRED4` |
| 86 | 134  | `ERROR: No key stored in slot 86` | `RETIRED5` |
| 87 | 135  | `ERROR: No key stored in slot 87` | `RETIRED6` |
| 88 | 136  | `ERROR: No key stored in slot 88` | `RETIRED7` |
| 89 | 137  | `ERROR: No key stored in slot 89` | `RETIRED8` |
| 8A | 138  | `ERROR: No key stored in slot 8A` | `RETIRED9` |
| 8B | 139  | `ERROR: No key stored in slot 8B` | `RETIRED10` |
| 8C | 140  | `ERROR: No key stored in slot 8C` | `RETIRED11` |
| 8D | 141  | `ERROR: No key stored in slot 8D` | `RETIRED12` |
| 8E | 142  | `ERROR: No key stored in slot 8E` | `RETIRED13` |
| 8F | 143  | `ERROR: No key stored in slot 8F` | `RETIRED14` |
| 90 | 144  | `ERROR: No key stored in slot 90` | `RETIRED15` |
| 91 | 145  | `ERROR: No key stored in slot 91` | `RETIRED16` |
| 92 | 146  | `ERROR: No key stored in slot 92` | `RETIRED17` |
| 93 | 147  | `ERROR: No key stored in slot 93` | `RETIRED18` |
| 94 | 148  | `ERROR: No key stored in slot 94` | `RETIRED19` |
| 95 | 149  | `ERROR: No key stored in slot 95` | `RETIRED20` |
| 96 - 99 | 150 - 153  | `Error: Invalid value for "slot"` | _N/A_ |
| 9A | 154  | `ERROR: No key stored in slot 9A` | `AUTHENTICATION` |
| 9B | 155  | `Error: Invalid value for "slot"` | _N/A_ |
| 9C | 156  | `ERROR: No key stored in slot 9C` | `SIGNATURE` |
| 9D | 157  | `ERROR: No key stored in slot 9D` | `KEY_MANAGEMENT` |
| 9E | 158  | `ERROR: No key stored in slot 9E` | `CARD_AUTH` |
| 9F - F8 | 158 - 248  | `Error: Invalid value for "slot"` | _N/A_ |
| F9 | 249  | `ERROR: No key stored in slot F9` | `ATTESTATION` |
| FA - FF | 250 - 255  | `Error: Invalid value for "slot"` | _N/A_ |

## Conclusion

So there you have it. It appears that the YubiKey 5 Series has 20 slots
available for arbitrary data (82 - 95) and five slots (9A, 9C, 9D, 9E, and F9)
that are tagged for specific use cases. Thank you for listening to me.


{{< center-quote >}}
So long, and thanks for all the fish.
{{< /center-quote >}}
