#!/usr/bin/env bash

# pyhf pallet for the SUSY EWK 1Lbb analysis
pyhf contrib download https://doi.org/10.17182/hepdata.90607.v3/r3 1Lbb-pallet
cd 1Lbb-pallet

# verify patchset is valid
pyhf patchset verify BkgOnly.json patchset.json

# signal model: m1 = 900, m2 = 300
cat BkgOnly.json | \
pyhf cls --patch <(pyhf patchset extract --name C1N2_Wh_hbb_900_300 patchset.json) | \
jq .CLs_obs

# signal model: m1 = 900, m2 = 400
pyhf patchset extract --name C1N2_Wh_hbb_900_400 --output-file C1N2_Wh_hbb_900_400_patch.json patchset.json
pyhf cls --patch C1N2_Wh_hbb_900_400_patch.json BkgOnly.json | \
jq .CLs_obs
