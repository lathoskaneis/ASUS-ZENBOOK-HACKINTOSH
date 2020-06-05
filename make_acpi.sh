#!/bin/bash
. ./src/config.txt

IASL='./tools/iasl -vw 6117 -vw 3073 -vi -vr -p'

if [ ! -d $BUILDDIR ]; then mkdir $BUILDDIR; fi
rm -rf $BUILDACPI
mkdir $BUILDACPI

$IASL $BUILDACPI/SSDT-DEBUG.aml $SRCHOTPATCH/SSDT-DEBUG.dsl
$IASL $BUILDACPI/SSDT-ELAN.aml $SRCHOTPATCH/SSDT-ELAN.dsl

for i in "${!MODELCONFIG[@]}"; do
    . ./src/models/"${MODELCONFIG[$i]}"
    if [ ! -d ./$BUILDACPI/$AMLDIR ]; then mkdir ./$BUILDACPI/$AMLDIR; fi && rm -Rf $BUILDACPI/$AMLDIR/*
    for j in "${!AMLFILES[@]}"; do
        $IASL $BUILDACPI/$AMLDIR/"${AMLFILES[$j]}".aml $SRCHOTPATCH/"${AMLFILES[$j]}".dsl
    done
done
