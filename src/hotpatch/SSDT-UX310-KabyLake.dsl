// SSDT for Zenbook UX310 (Kabylake)

DefinitionBlock ("", "SSDT", 2, "hack", "ux310kl", 0)
{
    #define NO_DEFINITIONBLOCK

    // audio: CX8050
    #include "include/layout13_HDEF.dsl" // need testing

    // battery
    #include "include/SSDT-BATT.dsl"

    // keyboard backlight/fn keys/als
    #include "include/SSDT-ATK-KABY.dsl"
    #include "include/SSDT-RALS.dsl"

    // backlight
    #include "include/SSDT-PNLF.dsl"

    // disable DGPU
    #include "include/SSDT-DDGPU.dsl"

    // usb
    #include "include/SSDT-XHC.dsl"
    #include "include/SSDT-USBX.dsl"

    // power management
    #include "include/SSDT-PLUG.dsl"

    // others
    #include "include/SSDT-HACK.dsl"
    #include "include/SSDT-LPC.dsl"
}
