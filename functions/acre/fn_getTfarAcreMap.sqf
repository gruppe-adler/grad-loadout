#define PREFIX grad
#define COMPONENT loadout
#include "\x\cba\addons\main\script_macros_mission.hpp"

if (!(isNil "grad_loadout_tfar2acre")) exitWith { grad_loadout_tfar2acre };


_pairs = [
// [tfar_radio, [acre_radio, backpack?]]

["TFAR_anprc152", ["ACRE_PRC152"]],
["TFAR_anprc148jem", ["ACRE_PRC148"]],
["TFAR_fadak", ["ACRE_PRC148"]],
["TFAR_rf7800str", ["ACRE_PRC343"]],
["TFAR_anprc154", ["ACRE_PRC343"]],
["TFAR_pnr1000a", ["ACRE_PRC343"]],
["TFAR_rt1523g", ["ACRE_PRC117F", "B_AssaultPack_sgg"]],
["TFAR_rt1523g_big", ["ACRE_PRC117F", "B_AssaultPack_sgg"]],
["TFAR_rt1523g_black", ["ACRE_PRC117F", "B_AssaultPack_sgg"]],
["TFAR_rt1523g_fabric", ["ACRE_PRC117F", "B_AssaultPack_sgg"]],
["TFAR_rt1523g_green", ["ACRE_PRC117F", "B_AssaultPack_sgg"]],
["TFAR_rt1523g_rhs", ["ACRE_PRC117F", "B_AssaultPack_sgg"]],
["TFAR_rt1523g_sage", ["ACRE_PRC117F", "B_AssaultPack_sgg"]],
["TFAR_mr3000", ["ACRE_PRC77"]],
["TFAR_mr3000_multicam", ["ACRE_PRC77"]],
["TFAR_mr3000_rhs", ["ACRE_PRC77"]]

];

grad_loadout_tfar2acre = [
    _pairs,
    []
] call CBA_fnc_hashCreate;

grad_loadout_tfar2acre
