model wrapped "Wrapped model"
	// Input overwrite
	Modelica.Blocks.Interfaces.RealInput AHU219_oveFanSupSpe_u(unit="1", min=0.0, max=1.0) "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput AHU219_oveFanSupSpe_activate "Activation for AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput waterTRVSplitterManifold2Zone_val219_oveValRad_u(unit="1", min=0.0, max=1.0) "Radiator valve control signal [0-1]";
	Modelica.Blocks.Interfaces.BooleanInput waterTRVSplitterManifold2Zone_val219_oveValRad_activate "Activation for Radiator valve control signal [0-1]";
	Modelica.Blocks.Interfaces.RealInput AHU219_oveFanSup_u(unit="1", min=0.0, max=1.0) "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput AHU219_oveFanSup_activate "Activation for AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput floor5Zone_Shading_oveShaSecFloorEas_u(unit="1", min=0.0, max=1.0) "Overwrite shading position for second floor";
	Modelica.Blocks.Interfaces.BooleanInput floor5Zone_Shading_oveShaSecFloorEas_activate "Activation for Overwrite shading position for second floor";
	Modelica.Blocks.Interfaces.RealInput waterTRVSplitterManifold2Zone_TSetRadNor_u(unit="K", min=285.15, max=313.15) "Radiator setpoint for zone north";
	Modelica.Blocks.Interfaces.BooleanInput waterTRVSplitterManifold2Zone_TSetRadNor_activate "Activation for Radiator setpoint for zone north";
	Modelica.Blocks.Interfaces.RealInput districtHeating_oveTSupSetHea_u(unit="K", min=283.15, max=333.15) "Supply temperature set point for heating";
	Modelica.Blocks.Interfaces.BooleanInput districtHeating_oveTSupSetHea_activate "Activation for Supply temperature set point for heating";
	Modelica.Blocks.Interfaces.RealInput AHU220_oveFanRet_u(unit="1", min=0.0, max=1.0) "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput AHU220_oveFanRet_activate "Activation for AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput AHU220_oveFanSupSpe_u(unit="1", min=0.0, max=1.0) "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput AHU220_oveFanSupSpe_activate "Activation for AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput waterTRVSplitterManifold2Zone_TSetRadWes_u(unit="K", min=285.15, max=313.15) "Radiator setpoint for zone west";
	Modelica.Blocks.Interfaces.BooleanInput waterTRVSplitterManifold2Zone_TSetRadWes_activate "Activation for Radiator setpoint for zone west";
	Modelica.Blocks.Interfaces.RealInput floor5Zone_Shading_oveSha220_u(unit="1", min=0.0, max=1.0) "Overwrite shading position for 2.20";
	Modelica.Blocks.Interfaces.BooleanInput floor5Zone_Shading_oveSha220_activate "Activation for Overwrite shading position for 2.20";
	Modelica.Blocks.Interfaces.RealInput floor5Zone_Shading_oveSha219_u(unit="1", min=0.0, max=1.0) "Overwrite shading position for 2.19";
	Modelica.Blocks.Interfaces.BooleanInput floor5Zone_Shading_oveSha219_activate "Activation for Overwrite shading position for 2.19";
	Modelica.Blocks.Interfaces.RealInput AHU220_oveFanSup_u(unit="1", min=0.0, max=1.0) "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput AHU220_oveFanSup_activate "Activation for AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput floor5Zone_Shading_oveShaSecFloorWes_u(unit="1", min=0.0, max=1.0) "Overwrite shading position for second floor";
	Modelica.Blocks.Interfaces.BooleanInput floor5Zone_Shading_oveShaSecFloorWes_activate "Activation for Overwrite shading position for second floor";
	Modelica.Blocks.Interfaces.RealInput floor5Zone_Shading_oveShaSecFloorNor_u(unit="1", min=0.0, max=1.0) "Overwrite shading position for second floor";
	Modelica.Blocks.Interfaces.BooleanInput floor5Zone_Shading_oveShaSecFloorNor_activate "Activation for Overwrite shading position for second floor";
	Modelica.Blocks.Interfaces.RealInput AHU219_oveFanRet_u(unit="1", min=0.0, max=1.0) "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.BooleanInput AHU219_oveFanRet_activate "Activation for AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealInput waterTRVSplitterManifold2Zone_val220_oveValRad_u(unit="1", min=0.0, max=1.0) "Radiator valve control signal [0-1]";
	Modelica.Blocks.Interfaces.BooleanInput waterTRVSplitterManifold2Zone_val220_oveValRad_activate "Activation for Radiator valve control signal [0-1]";
	// Out read
	Modelica.Blocks.Interfaces.RealOutput reaRadHeaPow219_y(unit="W") = mod.reaRadHeaPow219.y "Radiator heating power";
	Modelica.Blocks.Interfaces.RealOutput reaFanPow220_y(unit="W") = mod.reaFanPow220.y "AHU Fan power 2.20";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaTWetBul_y(unit="K") = mod.weatherStation.reaWeaTWetBul.y "Wet bulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput reaPumPow_y(unit="W") = mod.reaPumPow.y "Heating pump power";
	Modelica.Blocks.Interfaces.RealOutput districtHeating_reaHeaRet_y(unit="K") = mod.districtHeating.reaHeaRet.y "Return temperature for heating";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaWinDir_y(unit="rad") = mod.weatherStation.reaWeaWinDir.y "Wind direction measurement";
	Modelica.Blocks.Interfaces.RealOutput reaVenHeaPow220_y(unit="W") = mod.reaVenHeaPow220.y "Ventilation heating power 2.20";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaNOpa_y(unit="1") = mod.weatherStation.reaWeaNOpa.y "Opaque sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput AHU220_reaTRetAir_y(unit="K") = mod.AHU220.reaTRetAir.y "AHU return air temperature";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaLon_y(unit="rad") = mod.weatherStation.reaWeaLon.y "Longitude of the location";
	Modelica.Blocks.Interfaces.RealOutput AHU219_reaFloExtAir_y(unit="m3/s") = mod.AHU219.reaFloExtAir.y "AHU extract air volume flowrate";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaCloTim_y(unit="s") = mod.weatherStation.reaWeaCloTim.y "Day number with units of seconds";
	Modelica.Blocks.Interfaces.RealOutput AHU220_reaFloSupAir_y(unit="m3/s") = mod.AHU220.reaFloSupAir.y "AHU supply air volume flowrate";
	Modelica.Blocks.Interfaces.RealOutput reaRadTRet219_y(unit="W") = mod.reaRadTRet219.y "Radiator return temp 2.19";
	Modelica.Blocks.Interfaces.RealOutput AHU219_reaTSupAir_y(unit="K") = mod.AHU219.reaTSupAir.y "AHU supply air temperature";
	Modelica.Blocks.Interfaces.RealOutput reaTemRadRet_y(unit="K") = mod.reaTemRadRet.y "Water temperature from radiators";
	Modelica.Blocks.Interfaces.RealOutput AHU219_reaTHeaRec_y(unit="K") = mod.AHU219.reaTHeaRec.y "AHU air temperature exiting heat recovery in supply air stream";
	Modelica.Blocks.Interfaces.RealOutput reaRadHeaEne219_y(unit="J") = mod.reaRadHeaEne219.y "Radiator heating energy";
	Modelica.Blocks.Interfaces.RealOutput reaDHPow_y(unit="W") = mod.reaDHPow.y "District heating power";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaTBlaSky_y(unit="K") = mod.weatherStation.reaWeaTBlaSky.y "Black-body sky temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput floor5Zone_Shading_reaCO2220_y(unit="ppm") = mod.floor5Zone_Shading.reaCO2220.y "CO2 concentration of 2.20";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaLat_y(unit="rad") = mod.weatherStation.reaWeaLat.y "Latitude of the location";
	Modelica.Blocks.Interfaces.RealOutput floor5Zone_Shading_reaAuxPow_y(unit="W") = mod.floor5Zone_Shading.reaAuxPow.y "Aux power consumption";
	Modelica.Blocks.Interfaces.RealOutput reaRadTSup219_y(unit="W") = mod.reaRadTSup219.y "Radiator supply temp 2.19";
	Modelica.Blocks.Interfaces.RealOutput AHU219_reaTCoiSup_y(unit="K") = mod.AHU219.reaTCoiSup.y "AHU heating coil supply water temperature";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaHDirNor_y(unit="W/m2") = mod.weatherStation.reaWeaHDirNor.y "Direct normal radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput floor5Zone_Shading_reaT220_y(unit="K") = mod.floor5Zone_Shading.reaT220.y "Temperature of room 220";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolTim_y(unit="s") = mod.weatherStation.reaWeaSolTim.y "Solar time";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaTDewPoi_y(unit="K") = mod.weatherStation.reaWeaTDewPoi.y "Dew point temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput reaVenHeaEne219_y(unit="J") = mod.reaVenHeaEne219.y "Ventilation heating energy 2.19";
	Modelica.Blocks.Interfaces.RealOutput reaFanPow219_y(unit="W") = mod.reaFanPow219.y "AHU Fan power 2.19";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolHouAng_y(unit="rad") = mod.weatherStation.reaWeaSolHouAng.y "Solar hour angle measurement";
	Modelica.Blocks.Interfaces.RealOutput districtHeating_reaHeaSup_y(unit="K") = mod.districtHeating.reaHeaSup.y "Supply temperature for heating";
	Modelica.Blocks.Interfaces.RealOutput reaRadHeaPow220_y(unit="W") = mod.reaRadHeaPow220.y "Radiator heating power";
	Modelica.Blocks.Interfaces.RealOutput reaTemAHURet_y(unit="K") = mod.reaTemAHURet.y "Water temperature from heating coil";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolZen_y(unit="rad") = mod.weatherStation.reaWeaSolZen.y "Solar zenith angle measurement";
	Modelica.Blocks.Interfaces.RealOutput floor5Zone_Shading_reaCO2Sou_y(unit="ppm") = mod.floor5Zone_Shading.reaCO2Sou.y "Temperature of south zone";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolDec_y(unit="rad") = mod.weatherStation.reaWeaSolDec.y "Solar declination angle measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaHGloHor_y(unit="W/m2") = mod.weatherStation.reaWeaHGloHor.y "Global horizontal solar irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput floor5Zone_Shading_reaT2nd_y(unit="K") = mod.floor5Zone_Shading.reaT2nd.y "Temperature of 2nd floor";
	Modelica.Blocks.Interfaces.RealOutput reaVenHeaPow219_y(unit="W") = mod.reaVenHeaPow219.y "Ventilation heating power 2.19";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaNTot_y(unit="1") = mod.weatherStation.reaWeaNTot.y "Sky cover measurement";
	Modelica.Blocks.Interfaces.RealOutput AHU219_reaTRetAir_y(unit="K") = mod.AHU219.reaTRetAir.y "AHU return air temperature";
	Modelica.Blocks.Interfaces.RealOutput AHU220_reaTCoiSup_y(unit="K") = mod.AHU220.reaTCoiSup.y "AHU heating coil supply water temperature";
	Modelica.Blocks.Interfaces.RealOutput AHU220_reaFloExtAir_y(unit="m3/s") = mod.AHU220.reaFloExtAir.y "AHU extract air volume flowrate";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaHDifHor_y(unit="W/m2") = mod.weatherStation.reaWeaHDifHor.y "Horizontal diffuse solar radiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaCeiHei_y(unit="m") = mod.weatherStation.reaWeaCeiHei.y "Cloud cover ceiling height measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaTDryBul_y(unit="K") = mod.weatherStation.reaWeaTDryBul.y "Outside drybulb temperature measurement";
	Modelica.Blocks.Interfaces.RealOutput reaVenHeaEne220_y(unit="J") = mod.reaVenHeaEne220.y "Ventilation heating energy 2.20";
	Modelica.Blocks.Interfaces.RealOutput AHU220_reaTSupAir_y(unit="K") = mod.AHU220.reaTSupAir.y "AHU supply air temperature";
	Modelica.Blocks.Interfaces.RealOutput reaRadHeaEne220_y(unit="J") = mod.reaRadHeaEne220.y "Radiator heating energy";
	Modelica.Blocks.Interfaces.RealOutput AHU219_reaFloSupAir_y(unit="m3/s") = mod.AHU219.reaFloSupAir.y "AHU supply air volume flowrate";
	Modelica.Blocks.Interfaces.RealOutput AHU220_reaTHeaRec_y(unit="K") = mod.AHU220.reaTHeaRec.y "AHU air temperature exiting heat recovery in supply air stream";
	Modelica.Blocks.Interfaces.RealOutput floor5Zone_Shading_reaCO2Cor_y(unit="ppm") = mod.floor5Zone_Shading.reaCO2Cor.y "CO2 concentration of 2nd floor";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaHHorIR_y(unit="W/m2") = mod.weatherStation.reaWeaHHorIR.y "Horizontal infrared irradiation measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaPAtm_y(unit="Pa") = mod.weatherStation.reaWeaPAtm.y "Atmospheric pressure measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaSolAlt_y(unit="rad") = mod.weatherStation.reaWeaSolAlt.y "Solar altitude angle measurement";
	Modelica.Blocks.Interfaces.RealOutput floor5Zone_Shading_reaT219_y(unit="K") = mod.floor5Zone_Shading.reaT219.y "Temperature of room 219";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaWinSpe_y(unit="m/s") = mod.weatherStation.reaWeaWinSpe.y "Wind speed measurement";
	Modelica.Blocks.Interfaces.RealOutput weatherStation_reaWeaRelHum_y(unit="1") = mod.weatherStation.reaWeaRelHum.y "Outside relative humidity measurement";
	Modelica.Blocks.Interfaces.RealOutput reaRadFlow219_y(unit="W") = mod.reaRadFlow219.y "Radiator mass flow 2.19";
	Modelica.Blocks.Interfaces.RealOutput AHU219_oveFanSupSpe_y(unit="1") = mod.AHU219.oveFanSupSpe.y "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput waterTRVSplitterManifold2Zone_val219_oveValRad_y(unit="1") = mod.waterTRVSplitterManifold2Zone.val219.oveValRad.y "Radiator valve control signal [0-1]";
	Modelica.Blocks.Interfaces.RealOutput AHU219_oveFanSup_y(unit="1") = mod.AHU219.oveFanSup.y "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput floor5Zone_Shading_oveShaSecFloorEas_y(unit="1") = mod.floor5Zone_Shading.oveShaSecFloorEas.y "Overwrite shading position for second floor";
	Modelica.Blocks.Interfaces.RealOutput waterTRVSplitterManifold2Zone_TSetRadNor_y(unit="K") = mod.waterTRVSplitterManifold2Zone.TSetRadNor.y "Radiator setpoint for zone north";
	Modelica.Blocks.Interfaces.RealOutput districtHeating_oveTSupSetHea_y(unit="K") = mod.districtHeating.oveTSupSetHea.y "Supply temperature set point for heating";
	Modelica.Blocks.Interfaces.RealOutput AHU220_oveFanRet_y(unit="1") = mod.AHU220.oveFanRet.y "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput AHU220_oveFanSupSpe_y(unit="1") = mod.AHU220.oveFanSupSpe.y "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput waterTRVSplitterManifold2Zone_TSetRadWes_y(unit="K") = mod.waterTRVSplitterManifold2Zone.TSetRadWes.y "Radiator setpoint for zone west";
	Modelica.Blocks.Interfaces.RealOutput floor5Zone_Shading_oveSha220_y(unit="1") = mod.floor5Zone_Shading.oveSha220.y "Overwrite shading position for 2.20";
	Modelica.Blocks.Interfaces.RealOutput floor5Zone_Shading_oveSha219_y(unit="1") = mod.floor5Zone_Shading.oveSha219.y "Overwrite shading position for 2.19";
	Modelica.Blocks.Interfaces.RealOutput AHU220_oveFanSup_y(unit="1") = mod.AHU220.oveFanSup.y "AHU supply fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput floor5Zone_Shading_oveShaSecFloorWes_y(unit="1") = mod.floor5Zone_Shading.oveShaSecFloorWes.y "Overwrite shading position for second floor";
	Modelica.Blocks.Interfaces.RealOutput floor5Zone_Shading_oveShaSecFloorNor_y(unit="1") = mod.floor5Zone_Shading.oveShaSecFloorNor.y "Overwrite shading position for second floor";
	Modelica.Blocks.Interfaces.RealOutput AHU219_oveFanRet_y(unit="1") = mod.AHU219.oveFanRet.y "AHU return fan speed control signal";
	Modelica.Blocks.Interfaces.RealOutput waterTRVSplitterManifold2Zone_val220_oveValRad_y(unit="1") = mod.waterTRVSplitterManifold2Zone.val220.oveValRad.y "Radiator valve control signal [0-1]";
	// Original model
	TwinRooms.TwinRooms.TestCase mod(
		AHU219.oveFanSupSpe(uExt(y=AHU219_oveFanSupSpe_u),activate(y=AHU219_oveFanSupSpe_activate)),
		waterTRVSplitterManifold2Zone.val219.oveValRad(uExt(y=waterTRVSplitterManifold2Zone_val219_oveValRad_u),activate(y=waterTRVSplitterManifold2Zone_val219_oveValRad_activate)),
		AHU219.oveFanSup(uExt(y=AHU219_oveFanSup_u),activate(y=AHU219_oveFanSup_activate)),
		floor5Zone_Shading.oveShaSecFloorEas(uExt(y=floor5Zone_Shading_oveShaSecFloorEas_u),activate(y=floor5Zone_Shading_oveShaSecFloorEas_activate)),
		waterTRVSplitterManifold2Zone.TSetRadNor(uExt(y=waterTRVSplitterManifold2Zone_TSetRadNor_u),activate(y=waterTRVSplitterManifold2Zone_TSetRadNor_activate)),
		districtHeating.oveTSupSetHea(uExt(y=districtHeating_oveTSupSetHea_u),activate(y=districtHeating_oveTSupSetHea_activate)),
		AHU220.oveFanRet(uExt(y=AHU220_oveFanRet_u),activate(y=AHU220_oveFanRet_activate)),
		AHU220.oveFanSupSpe(uExt(y=AHU220_oveFanSupSpe_u),activate(y=AHU220_oveFanSupSpe_activate)),
		waterTRVSplitterManifold2Zone.TSetRadWes(uExt(y=waterTRVSplitterManifold2Zone_TSetRadWes_u),activate(y=waterTRVSplitterManifold2Zone_TSetRadWes_activate)),
		floor5Zone_Shading.oveSha220(uExt(y=floor5Zone_Shading_oveSha220_u),activate(y=floor5Zone_Shading_oveSha220_activate)),
		floor5Zone_Shading.oveSha219(uExt(y=floor5Zone_Shading_oveSha219_u),activate(y=floor5Zone_Shading_oveSha219_activate)),
		AHU220.oveFanSup(uExt(y=AHU220_oveFanSup_u),activate(y=AHU220_oveFanSup_activate)),
		floor5Zone_Shading.oveShaSecFloorWes(uExt(y=floor5Zone_Shading_oveShaSecFloorWes_u),activate(y=floor5Zone_Shading_oveShaSecFloorWes_activate)),
		floor5Zone_Shading.oveShaSecFloorNor(uExt(y=floor5Zone_Shading_oveShaSecFloorNor_u),activate(y=floor5Zone_Shading_oveShaSecFloorNor_activate)),
		AHU219.oveFanRet(uExt(y=AHU219_oveFanRet_u),activate(y=AHU219_oveFanRet_activate)),
		waterTRVSplitterManifold2Zone.val220.oveValRad(uExt(y=waterTRVSplitterManifold2Zone_val220_oveValRad_u),activate(y=waterTRVSplitterManifold2Zone_val220_oveValRad_activate))) "Original model with overwrites";
end wrapped;
