/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20210331 (64-bit version)
 * Copyright (c) 2000 - 2021 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of /Volumes/EFI/EFI/OC/ACPI/SSDT-XPAA.aml, Mon Jul 26 17:14:46 2021
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x0000038C (908)
 *     Revision         0x02
 *     Checksum         0x6B
 *     OEM ID           "hack"
 *     OEM Table ID     "XPAA"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20210331 (539034417)
 */
DefinitionBlock ("", "SSDT", 2, "hack", "XPAA", 0x00000000)
{
    External (_SB_.GNUM, MethodObj)    // 1 Arguments
    External (_SB_.INUM, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.HIDD, MethodObj)    // 5 Arguments
    External (_SB_.PCI0.HIDG, IntObj)
    External (_SB_.PCI0.I2C0, DeviceObj)
    External (_SB_.PCI0.I2C0.I2CX, IntObj)
    External (_SB_.PCI0.I2CM, MethodObj)    // 3 Arguments
    External (_SB_.PCI0.TP7D, MethodObj)    // 6 Arguments
    External (_SB_.PCI0.TP7G, IntObj)
    External (_SB_.SHPO, MethodObj)    // 2 Arguments
    External (GPDI, FieldUnitObj)
    External (PSF6, FieldUnitObj)
    External (TPDB, FieldUnitObj)
    External (TPDH, FieldUnitObj)
    External (TPDM, FieldUnitObj)
    External (TPDS, FieldUnitObj)
    External (TPDT, FieldUnitObj)

    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            TPDT = Zero
        }
    }

    Scope (_SB.PCI0.I2C0)
    {
        Device (TP55)
        {
            Name (HID2, Zero)
            Name (SBFB, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x0038, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.PCI0.I2C0",
                    0x00, ResourceConsumer, _Y00, Exclusive,
                    )
            })
            Name (SBFG, ResourceTemplate ()
            {
                GpioInt (Edge, ActiveLow, Exclusive, PullUp, 0x0000,
                    "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, _Y02,
                    )
                    {   // Pin list
                        0x0000
                    }
            })
            Name (SBFI, ResourceTemplate ()
            {
                Interrupt (ResourceConsumer, Edge, ActiveLow, Exclusive, ,, _Y01)
                {
                    0x00000000,
                }
            })
            CreateWordField (SBFB, \_SB.PCI0.I2C0.TP55._Y00._ADR, BADR)  // _ADR: Address
            CreateDWordField (SBFB, \_SB.PCI0.I2C0.TP55._Y00._SPE, SPED)  // _SPE: Speed
            CreateWordField (SBFG, 0x17, INT1)
            CreateDWordField (SBFI, \_SB.PCI0.I2C0.TP55._Y01._INT, INT2)  // _INT: Interrupts
            CreateBitField (SBFI, \_SB.PCI0.I2C0.TP55._Y01._HE, FIEL)  // _HE_: High-Edge
            CreateBitField (SBFI, \_SB.PCI0.I2C0.TP55._Y01._LL, FIAL)  // _LL_: Low Level
            CreateBitField (SBFG, \_SB.PCI0.I2C0.TP55._Y02._MOD, FGEL)  // _MOD: Mode
            CreateField (SBFG, \_SB.PCI0.I2C0.TP55._Y02._POL, 0x02, FGAL)  // _POL: Polarity
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                Local0 = ((PSF6 >> 0x10) & 0x03)
                Local1 = ((PSF6 >> 0x12) & One)
                If ((Local0 != 0x02))
                {
                    If ((Local0 == 0x03))
                    {
                        FIEL = One
                        FGEL = One
                        FIAL = Local1
                        FGAL = 0x02
                    }
                    Else
                    {
                        FIEL = Local0
                        FGEL = Local0
                        FIAL = Local1
                        FGAL = Local1
                    }
                }

                INT1 = GNUM (GPDI)
                INT2 = INUM (GPDI)
                If ((TPDM == Zero))
                {
                    SHPO (GPDI, One)
                }

                If ((TPDT == 0x05))
                {
                    HID2 = TPDH /* External reference */
                    BADR = TPDB /* External reference */
                    If ((TPDS == Zero))
                    {
                        SPED = 0x000186A0
                    }

                    If ((TPDS == One))
                    {
                        SPED = 0x00061A80
                    }

                    If ((TPDS == 0x02))
                    {
                        SPED = 0x000F4240
                    }

                    Return (Zero)
                }
            }

            Method (_HID, 0, Serialized)  // _HID: Hardware ID
            {
                Switch ((PSF6 & 0xFFFF))
                {
                    Case (0x06CB)
                    {
                        Return ("SYNA1202")
                    }
                    Case (0x04F3)
                    {
                        Return ("ELAN0415")
                    }
                    Case (0x2808)
                    {
                        Return ("FTCS1000")
                    }

                }

                Return ("MSFT0004")
            }

            Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
            Name (_UID, One)  // _UID: Unique ID
            Name (_S0W, 0x04)  // _S0W: S0 Device Wake State
            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                If ((Arg0 == HIDG))
                {
                    Return (HIDD (Arg0, Arg1, Arg2, Arg3, HID2))
                }

                If ((Arg0 == TP7G))
                {
                    Return (TP7D (Arg0, Arg1, Arg2, Arg3, SBFB, SBFG))
                }

                Return (Buffer (One)
                {
                     0x00                                             // .
                })
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (ConcatenateResTemplate (I2CM (I2CX, BADR, SPED), SBFG))
            }
        }
    }
}

