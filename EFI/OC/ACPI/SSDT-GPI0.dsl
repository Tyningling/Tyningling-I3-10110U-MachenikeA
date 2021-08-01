/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20210331 (64-bit version)
 * Copyright (c) 2000 - 2021 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of /Volumes/EFI/EFI/OC/ACPI/SSDT-GPI0.aml, Sat Jul 31 16:39:31 2021
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000086 (134)
 *     Revision         0x02
 *     Checksum         0x00
 *     OEM ID           "hack"
 *     OEM Table ID     "GPI0"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20180427 (538444839)
 */
DefinitionBlock ("", "SSDT", 2, "hack", "GPI0", 0x00000000)
{
    External (_SB_.PCI0.GPI0, DeviceObj)

    Scope (_SB.PCI0.GPI0)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (0x0F)
        }
    }

}

