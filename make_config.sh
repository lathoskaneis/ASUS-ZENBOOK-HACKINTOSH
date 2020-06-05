#!/bin/bash

. ./src/config.txt

function countArray()
# $1 is path to config.plist
# $2 is path to array in plist
# result is in $cnt
{
    plistFile=$1
    cnt=0
    while true ; do
        /usr/libexec/PlistBuddy -c "Print :$2:$cnt" $plistFile >/dev/null 2>/dev/null
        if [ $? -ne 0 ]; then
            break
        fi
        cnt=$(($cnt + 1))
    done
}

function enableI2CPatch()
# $1 is path to config.plist
{
    plistFile=$1
    countArray $plistFile "ACPI:DSDT:Patches"
    cnt=$(($cnt - 1))

    for idx in `seq 0 $cnt`
    do
        val=`/usr/libexec/PlistBuddy -c "Print :ACPI:DSDT:Patches:$idx:Comment" $plistFile`
        if [ "$val" = "change Method(_STA,0,NS) in GPI0 to XSTA" ]; then
            /usr/libexec/PlistBuddy -c "Delete :ACPI:DSDT:Patches:$idx:Disabled" $plistFile
        fi
        if [ "$val" = "change Method(_CRS,0,S) in ETPD to XCRS" ]; then
            /usr/libexec/PlistBuddy -c "Delete :ACPI:DSDT:Patches:$idx:Disabled" $plistFile
        fi
    done
}

if [ ! -d $BUILDDIR ]; then mkdir $BUILDDIR; fi
rm -rf $BUILDCONFIG
mkdir $BUILDCONFIG

for i in "${!MODELCONFIG[@]}"; do
    . ./src/models/"${MODELCONFIG[$i]}"
    echo creating $CONFIGPLIST
    cp $SRCCONFIG/config_master.plist $BUILDCONFIG/$CONFIGPLIST
    /usr/libexec/PlistBuddy -c "Add :Comment string This config is created by @hieplpvip for $NAME" $BUILDCONFIG/$CONFIGPLIST
    /usr/libexec/PlistBuddy -c "Set :SMBIOS:ProductName $PRODUCTNAME" $BUILDCONFIG/$CONFIGPLIST
    for j in "${!CONFIGPARTS[@]}"; do
        ./tools/merge_plist.sh "${CONFIGMERGE[$j]}" $SRCCONFIG/"${CONFIGPARTS[$j]}" $BUILDCONFIG/$CONFIGPLIST
    done
    if [[ "$ETPDPATCH" == "true" ]]; then enableI2CPatch $BUILDCONFIG/$CONFIGPLIST; fi
    echo
done

#echo creating config_ux303_broadwell.plist
#cp $SRCCONFIG/config_master.plist $BUILDCONFIG/config_ux303_broadwell.plist
#/usr/libexec/PlistBuddy -c "Add :Comment string This config is created by @hieplpvip for UX303 (Broadwell)" $BUILDCONFIG/config_ux303_broadwell.plist
#/usr/libexec/PlistBuddy -c "Set :SMBIOS:ProductName MacBookPro12,1" $BUILDCONFIG/config_ux303_broadwell.plist
#echo
