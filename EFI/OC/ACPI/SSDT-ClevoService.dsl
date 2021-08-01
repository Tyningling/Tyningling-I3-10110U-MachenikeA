/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20210331 (64-bit version)
 * Copyright (c) 2000 - 2021 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of /Volumes/EFI/EFI/OC/ACPI/SSDT-ClevoService.aml, Sat Jul 24 23:21:28 2021
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000005AE (1454)
 *     Revision         0x01
 *     Checksum         0x85
 *     OEM ID           "hack "
 *     OEM Table ID     "CLEVO"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200925 (538970405)
 */
DefinitionBlock ("", "SSDT", 1, "hack ", "CLEVO", 0x00000000)
{
    External (_SB_.AC__, DeviceObj)
    External (_SB_.AC__.ACFG, IntObj)
    External (_SB_.DCHU.ZEVT, MethodObj)    // 3 Arguments
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (_SB_.PCI0.LPCB.EC__, DeviceObj)
    External (_SB_.PCI0.LPCB.EC__.AFLT, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC__.AIRP, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC__.BAT0, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC__.ECOK, IntObj)
    External (_SB_.PCI0.LPCB.EC__.OEM4, FieldUnitObj)
    External (_SB_.PCI0.LPCB.EC__.XQ50, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)
    External (_SB_.PCI0.PEG0.PEGP._OFF, MethodObj)    // 0 Arguments
    External (_SB_.WMI_.WMBB, MethodObj)    // 3 Arguments
    External (OEM4, IntObj)
    External (XWAK, MethodObj)    // 1 Arguments

    Scope (_SB.PCI0.LPCB.EC)
    {
        OperationRegion (EC82, EmbeddedControl, Zero, 0xFF)
        Field (EC82, ByteAcc, Lock, Preserve)
        {
            Offset (0xD0), 
            FCP0,   8, 
            FCP1,   8, 
            FGP0,   8, 
            FGP1,   8, 
            Offset (0xE0), 
            FGP2,   8, 
            FGP3,   8
        }
    }

    Method (_WAK, 1, Serialized)  // _WAK: Wake
    {
        If (((Arg0 == Zero) || (Arg0 > 0x04)))
        {
            Arg0 = 0x03
        }

        \_SB.PCI0.PEG0.PEGP._OFF ()
        \_SB.PCI0.LPCB.EC.AFLT = Zero
        \_SB.PCI0.LPCB.EC.BAT0 = One
        Notify (\_SB.CLV0, 0x83) // Device-Specific Change
        Return (XWAK (Arg0))
    }

    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (_Q14, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            Notify (CLV0, 0x84) // Reserved
            Return (Zero)
        }

        Method (_Q50, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            Local0 = OEM4 /* External reference */
            If ((Local0 == 0x80))
            {
                Notify (CLV0, 0x80) // Status Change
                Return (Zero)
            }

            If ((Local0 == 0x81))
            {
                Notify (CLV0, 0x81) // Information Change
                Return (Zero)
            }

            If ((Local0 == 0x82))
            {
                Notify (CLV0, 0x82) // Device-Specific Change
                Return (Zero)
            }

            If ((Local0 == 0x9F))
            {
                Notify (CLV0, 0x9F) // Device-Specific
                Return (Zero)
            }

            If ((Local0 == 0xC9))
            {
                AIRP &= 0xBF
                Return (Zero)
            }

            If ((Local0 == 0xCA))
            {
                AIRP |= 0x40
                Return (Zero)
            }

            XQ50 ()
            Return (Zero)
        }
    }

    Device (_SB.CLV0)
    {
        Name (_HID, EisaId ("PNP0C02") /* PNP Motherboard Resources */)  // _HID: Hardware ID
        Name (_CID, "MON0000")  // _CID: Compatible ID
        Name (KLVN, Zero)
        Name (CONF, Package (0x06)
        {
            "KbdAutoDimTimerActive", 
            ">y", 
            "KbdAutoDimActive", 
            ">y", 
            "KbdAutoDimTime", 
            0xB4
        })
        Name (TACH, Package (0x06)
        {
            "CPU Fan", 
            "VEN1", 
            "GPU Fan #1", 
            "VEN2", 
            "GPU Fan #2", 
            "VEN3"
        })
        Method (VEN1, 0, Serialized)
        {
            If (\_SB.PCI0.LPCB.EC.ECOK)
            {
                Local0 = B1B2 (\_SB.PCI0.LPCB.EC.FCP1, \_SB.PCI0.LPCB.EC.FCP0)
                If ((Local0 <= Zero))
                {
                    Return (Zero)
                }

                Local0 = (0x0020E6BC / Local0)
                Return (Local0)
            }

            Return (Zero)
        }

        Method (VEN2, 0, Serialized)
        {
            If (\_SB.PCI0.LPCB.EC.ECOK)
            {
                Local0 = B1B2 (\_SB.PCI0.LPCB.EC.FGP1, \_SB.PCI0.LPCB.EC.FGP0)
                If ((Local0 <= Zero))
                {
                    Return (Zero)
                }

                Local0 = (0x0020E6BC / Local0)
                Return (Local0)
            }

            Return (Zero)
        }

        Method (VEN3, 0, Serialized)
        {
            If (\_SB.PCI0.LPCB.EC.ECOK)
            {
                Local0 = B1B2 (\_SB.PCI0.LPCB.EC.FGP3, \_SB.PCI0.LPCB.EC.FGP2)
                If ((Local0 <= Zero))
                {
                    Return (Zero)
                }

                Local0 = (0x0020E6BC / Local0)
                Return (Local0)
            }

            Return (Zero)
        }

        Method (CLVE, 3, Serialized)
        {
            If (CondRefOf (\_SB.DCHU.ZEVT))
            {
                \_SB.DCHU.ZEVT (Arg0, Arg1, Arg2)
            }
            ElseIf (CondRefOf (\_SB.WMI.WMBB))
            {
                \_SB.WMI.WMBB (Arg0, Arg1, Arg2)
            }
        }

        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (CondRefOf (\_SB.PCI0.PEG0.PG00._OFF))
            {
                \_SB.PCI0.PEG0.PEGP._OFF ()
            }

            If (CondRefOf (\_SB.PCI0.LPCB.EC.AIRP))
            {
                \_SB.PCI0.LPCB.EC.AIRP &= 0xBF
            }
        }
    }

    Method (B1B2, 2, NotSerialized)
    {
        Return ((Arg0 | (Arg1 << 0x08)))
    }
}

