#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 1, "hack", "lout13", 0)
{
#endif
    External(_SB.PCI0.HDEF, DeviceObj)
    Method(_SB.PCI0.HDEF._DSM, 4)
    {
        If (!Arg2) { Return (Buffer() { 0x03 } ) }
        Return(Package()
        {
            "layout-id", Buffer(4) { 13, 0, 0, 0 },
            "hda-gfx", Buffer() { "onboard-1" },
            "PinConfigurations", Buffer() { },
        })
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
