// SSDT for VivoBook S510 (Kabylake-R) (WIP)

DefinitionBlock ("", "SSDT", 2, "hack", "s510klr", 0)
{
    #define NO_DEFINITIONBLOCK

    // audio: CX8050
    #include "include/layout13_HDEF.dsl" // need testing

    // battery
    #include "include/SSDT-BATT.dsl"

    // keyboard backlight/fn keys/fake als
    #include "include/SSDT-ATK-KABY.dsl"
    #include "include/SSDT-ALS0.dsl"

    // backlight
    #include "include/SSDT-PNLF.dsl"

    // usb
    #include "include/SSDT-XHC.dsl"
    #include "include/SSDT-USBX.dsl"

    // power management
    #include "include/SSDT-PLUG.dsl"

    // others
    #include "include/SSDT-HACK.dsl"
    #include "include/SSDT-PTSWAK.dsl"
    #include "include/SSDT-LPC.dsl"
    #include "include/SSDT-IGPU.dsl"
}
