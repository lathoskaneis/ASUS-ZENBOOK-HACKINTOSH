// SSDT for Zenbook UX430 (Kabylake)

DefinitionBlock ("", "SSDT", 2, "hack", "ux430kl", 0)
{
    #define NO_DEFINITIONBLOCK

    // audio: ALC295
    #include "include/layout14_HDEF.dsl"

    // battery
    #include "include/SSDT-BATT.dsl"

    // keyboard backlight/fn keys/als
    #include "include/SSDT-ATK-KABY.dsl"
    #include "include/SSDT-RALS.dsl"
    #include "include/SSDT-ALSC.dsl"

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
