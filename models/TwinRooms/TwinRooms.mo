within TwinRooms;
package TwinRooms
  model TestCase
    extends Modelica.Icons.Example;

    package MediumA = Buildings.Media.Air (extraPropertiesNames={"CO2"}) "Medium model for air";
    package MediumW = Buildings.Media.Water "Medium model for water";

    Components.Floor5Zone_Shading floor5Zone_Shading(lat=lat, gai(data(MatEmi=
              8.64E-6*0.01)))
      annotation (Placement(transformation(extent={{50,114},{156,174}})));
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3
                                              weaDat(filNam=
          ModelicaServices.ExternalReferences.loadResource(
          "Resources/NOR_TD_Trondheim-Voll.012570_TMYx.2009-2023.mos"),
        computeWetBulbTemperature=true)
      annotation (Placement(transformation(extent={{-200,182},{-180,202}})));
    Buildings.BoundaryConditions.WeatherData.Bus
                                       weaBus "Weather Data Bus"
      annotation (Placement(transformation(extent={{-164,170},{-144,190}}),
          iconTransformation(extent={{-360,170},{-340,190}})));
    parameter Modelica.SIunits.Angle lat=1.0454522219446 "Latitude";
    Components.AHUSpeedHHB AHU219(
      m_flow_nominal_air=m_flow_nominal_air,
      m_flow_nominal_water=m_flow_nominal_water_AHU,
      dp_nominal_ext=200,
      dp_nominal_coilWat=1000,
      Q_flow_nominal_coil=3000,
      T_in_air_nominal_coil=287.15,
      T_in_wat_nominal_coil=320.15,
      redeclare package Air = MediumA,
      redeclare package Water = MediumW)
      annotation (Placement(transformation(extent={{-164,108},{-132,128}})));
    Modelica.Blocks.Sources.Constant TAirSupSet(k=273.15 + 19)
      annotation (Placement(transformation(extent={{-256,162},{-236,182}})));
    Components.TwoWayHeatBattery twoWayHeatBattery219(
      redeclare package Medium = MediumW,
      m_flow_nominal=m_flow_nominal_water_AHU,
      dpValve_nominal(displayUnit="Pa"),
      dpFixed_nominal(displayUnit="Pa"),
      dpExternal_nominal(displayUnit="Pa") = AHU219.dp_nominal_coilWat,
      m_flow_nominal_bypass=m_flow_nominal_water_AHU/1000,
      conPIDcoil(k=0.01, Ti=30))
      annotation (Placement(transformation(extent={{-132,80},{-152,100}})));
    Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad219(
      redeclare package Medium = MediumW,
      T_start=295.15,
      Q_flow_nominal(displayUnit="W") = 45*floor5Zone_Shading.AFlo219,
      T_a_nominal=320.15,
      T_b_nominal=308.15,
      TAir_nominal=294.15,
      VWat=5.68E-6*abs(rad219.Q_flow_nominal),
      mDry=0.0263*abs(rad219.Q_flow_nominal),
      dp_nominal=0) "radiator for room 2.19"
      annotation (Placement(transformation(extent={{100,90},{120,110}})));
    Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad220(
      redeclare package Medium = MediumW,
      Q_flow_nominal(displayUnit="W") = 45*floor5Zone_Shading.AFlo220,
      T_a_nominal=320.15,
      T_b_nominal=308.15,
      TAir_nominal=294.15,
      dp_nominal=0) "radiator for room 2.20"
      annotation (Placement(transformation(extent={{22,114},{42,134}})));
    Components.DistrictHeating_dp districtHeating(
      redeclare package Medium = MediumW,
      m_flow_nominal=m_flow_nominal_water_AHU + m_flow_nominal_water_rad,
      m_flow_nominal_dh=(m_flow_nominal_water_AHU + m_flow_nominal_water_rad),
      dp_nominal(displayUnit="Pa") = 35000)
      annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-182,-128})));
    Buildings.Fluid.FixedResistances.Junction jun(redeclare package Medium =
          MediumW,
      m_flow_nominal={m_flow_nominal_water_AHU + m_flow_nominal_water_rad,
          m_flow_nominal_water_rad,m_flow_nominal_water_AHU},
                   dp_nominal={0,0,0})
      annotation (Placement(transformation(extent={{-106,-100},{-86,-120}})));
    Buildings.Fluid.FixedResistances.Junction jun2(redeclare package Medium =
          MediumW,
      m_flow_nominal={m_flow_nominal_water_rad,m_flow_nominal_water_AHU,
          m_flow_nominal_water_AHU + m_flow_nominal_water_rad},
                   dp_nominal={0,0,0})
      annotation (Placement(transformation(extent={{-96,-136},{-116,-156}})));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_air=0.1
      "Nominal mass flow rate - air"
      annotation (Dialog(group="Nominal condition"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_water_AHU=0.1
      "Nominal mass flow rate - water in AHU"
      annotation (Dialog(group="Nominal condition"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_water_rad=0.6
      "Nominal mass flow rate - water in rad"
      annotation (Dialog(group="Nominal condition"));
    Modelica.Blocks.Sources.Constant pumDP(k=15000 + 20000)
      annotation (Placement(transformation(extent={{-200,-180},{-180,-160}})));
    Buildings.Utilities.IO.SignalExchange.Read reaFanPow219(
      description="AHU Fan power 2.19",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
      y(unit="W"))
      annotation (Placement(transformation(extent={{-186,88},{-198,100}})));

    Buildings.Utilities.IO.SignalExchange.Read reaPumPow(
      description="Heating pump power",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
      y(unit="W"))
      annotation (Placement(transformation(extent={{-188,-88},{-200,-76}})));

    Buildings.Utilities.IO.SignalExchange.Read reaDHPow(
      description="District heating power",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.DistrictHeatingPower,
      y(unit="W"))
      annotation (Placement(transformation(extent={{-188,-100},{-200,-88}})));

    Buildings.Utilities.IO.SignalExchange.Read reaVenHeaPow219(
      description="Ventilation heating power 2.19",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
      y(unit="W"))
      annotation (Placement(transformation(extent={{-186,64},{-198,76}})));

    Components.Sensors.EnergyMeter energyMeter(
      redeclare package Medium1 = MediumW,
      redeclare package Medium2 = MediumW,
      m1_flow_nominal=m_flow_nominal_water_rad,
      m2_flow_nominal=m_flow_nominal_water_rad) annotation (Placement(
          transformation(
          extent={{-10,10},{10,-10}},
          rotation=90,
          origin={-4,-68})));
    Buildings.Utilities.IO.SignalExchange.Read reaVenHeaEne219(
      description="Ventilation heating energy 2.19",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
      y(unit="J"))
      annotation (Placement(transformation(extent={{-186,52},{-198,64}})));

    Buildings.Utilities.IO.SignalExchange.Read reaRadHeaEne(
      description="Radiator heating energy",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
      y(unit="J"))
      annotation (Placement(transformation(extent={{48,-72},{60,-60}})));

    Buildings.Utilities.IO.SignalExchange.Read reaRadHeaPow(
      description="Radiator heating power",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
      y(unit="W"))
      annotation (Placement(transformation(extent={{48,-84},{60,-72}})));

    Buildings.Fluid.FixedResistances.Pipe pipSupCoil219(
      redeclare package Medium = MediumW,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      m_flow_nominal=m_flow_nominal_water_AHU,
      dp_nominal=0,
      nSeg=3,
      thicknessIns=0.03,
      lambdaIns=0.04,
      length=50,
      v_nominal=0.3) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-132,-44})));
    Buildings.Fluid.FixedResistances.Pipe pipRetCoil219(
      redeclare package Medium = MediumW,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      m_flow_nominal=m_flow_nominal_water_AHU,
      dp_nominal=0,
      nSeg=3,
      thicknessIns=0.03,
      lambdaIns=0.04,
      length=50,
      v_nominal=0.3) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-152,-44})));
    Buildings.Fluid.FixedResistances.Pipe pipSupRad(
      redeclare package Medium = MediumW,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      m_flow_nominal=m_flow_nominal_water_rad,
      dp_nominal=0,
      nSeg=3,
      thicknessIns=0.03,
      lambdaIns=0.04,
      length=50,
      v_nominal=0.3) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={14,-34})));
    Buildings.Fluid.FixedResistances.Pipe pipRetRad(
      redeclare package Medium = MediumW,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      m_flow_nominal=m_flow_nominal_water_rad,
      dp_nominal=0,
      nSeg=3,
      thicknessIns=0.03,
      lambdaIns=0.04,
      length=50,
      v_nominal=0.3) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-20,-32})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature tPipHeaLoss(T(
          displayUnit="K") = 293.15) "Temperature exposed to pipes"
      annotation (Placement(transformation(extent={{-60,-14},{-80,6}})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTemRadRet(redeclare package
        Medium = Buildings.Media.Water, m_flow_nominal=m_flow_nominal_water_rad)
      annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-10,-94})));
    Buildings.Fluid.Sensors.TemperatureTwoPort senTemVenRet(redeclare package
        Medium = Buildings.Media.Water, m_flow_nominal=m_flow_nominal_water_AHU)
      annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={-152,-84})));
    Buildings.Utilities.IO.SignalExchange.Read reaTemAHURet(
      description="Water temperature from heating coil",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
      y(unit="K"))
      annotation (Placement(transformation(extent={{-188,-72},{-200,-60}})));

    Buildings.Utilities.IO.SignalExchange.Read reaTemRadRet(
      description="Water temperature from radiators",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
      y(unit="K"))
      annotation (Placement(transformation(extent={{-188,-60},{-200,-48}})));

    Buildings.Utilities.IO.SignalExchange.WeatherStation weatherStation
      annotation (Placement(transformation(extent={{-102,178},{-82,198}})));
    Modelica.Blocks.Sources.Constant CO2SetPoi(k=800)
      annotation (Placement(transformation(extent={{-354,160},{-334,180}})));
    Components.AHUSpeedHHB AHU220(
      m_flow_nominal_air=m_flow_nominal_air,
      m_flow_nominal_water=m_flow_nominal_water_AHU,
      dp_nominal_ext=200,
      dp_nominal_coilWat=1000,
      Q_flow_nominal_coil=3000,
      T_in_air_nominal_coil=287.15,
      T_in_wat_nominal_coil=320.15,
      redeclare package Air = MediumA,
      redeclare package Water = MediumW)
      annotation (Placement(transformation(extent={{-330,58},{-298,78}})));
    Components.TwoWayHeatBattery twoWayHeatBattery220(
      redeclare package Medium = MediumW,
      m_flow_nominal=m_flow_nominal_water_AHU,
      dpValve_nominal(displayUnit="Pa"),
      dpFixed_nominal(displayUnit="Pa"),
      dpExternal_nominal(displayUnit="Pa") = AHU219.dp_nominal_coilWat,
      m_flow_nominal_bypass=m_flow_nominal_water_AHU/1000,
      conPIDcoil(k=0.01, Ti=30))
      annotation (Placement(transformation(extent={{-290,22},{-310,42}})));
    Buildings.Fluid.FixedResistances.Junction jun1(
      redeclare package Medium = MediumW,
      m_flow_nominal={m_flow_nominal_water_AHU + m_flow_nominal_water_rad,
          m_flow_nominal_water_rad,m_flow_nominal_water_AHU},
      dp_nominal={0,0,0})
      annotation (Placement(transformation(extent={{-150,-100},{-130,-120}})));
    Buildings.Fluid.FixedResistances.Junction jun3(
      redeclare package Medium = MediumW,
      m_flow_nominal={m_flow_nominal_water_AHU + m_flow_nominal_water_rad,
          m_flow_nominal_water_rad,m_flow_nominal_water_AHU},
      dp_nominal={0,0,0})
      annotation (Placement(transformation(extent={{-154,-136},{-134,-156}})));
    Buildings.Fluid.FixedResistances.Pipe pipRetCoil220(
      redeclare package Medium = MediumW,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      m_flow_nominal=m_flow_nominal_water_AHU,
      dp_nominal=0,
      nSeg=3,
      thicknessIns=0.03,
      lambdaIns=0.04,
      length=50,
      v_nominal=0.3) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-266,-48})));
    Buildings.Fluid.FixedResistances.Pipe pipSupCoil220(
      redeclare package Medium = MediumW,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      m_flow_nominal=m_flow_nominal_water_AHU,
      dp_nominal=0,
      nSeg=3,
      thicknessIns=0.03,
      lambdaIns=0.04,
      length=50,
      v_nominal=0.3) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-230,-46})));
    Buildings.Utilities.IO.SignalExchange.Read reaFanPow220(
      description="AHU Fan power 2.20",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
      y(unit="W"))
      annotation (Placement(transformation(extent={{-346,36},{-358,48}})));

    Buildings.Utilities.IO.SignalExchange.Read reaVenHeaPow220(
      description="Ventilation heating power 2.20",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
      y(unit="W"))
      annotation (Placement(transformation(extent={{-346,12},{-358,24}})));

    Buildings.Utilities.IO.SignalExchange.Read reaVenHeaEne220(
      description="Ventilation heating energy 2.20",
      KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
      y(unit="J"))
      annotation (Placement(transformation(extent={{-346,0},{-358,12}})));

    Buildings.Controls.SetPoints.OccupancySchedule
                                         occSch(occupancy=3600*{8,18})
                                                "Occupancy schedule"
      annotation (Placement(transformation(extent={{82,-44},{102,-24}})));
    Modelica.Blocks.Sources.Constant TRooNig(k=273.15 + 15)
      "Room temperature set point at night"
      annotation (Placement(transformation(extent={{82,-70},{102,-50}})));
    Modelica.Blocks.Sources.Constant TRooSet(k=273.15 + 22)
      annotation (Placement(transformation(extent={{82,-14},{102,6}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{156,-22},{176,-2}})));
    Components.WaterPIDSplitterManifold2Zone waterTRVSplitterManifold2Zone(
      m_flow_nominal={rad219.Q_flow_nominal/(4200*12),rad220.Q_flow_nominal/(4200
          *12)},                                                           nPorts=2,
        redeclare package Medium = MediumW) annotation (Placement(transformation(
          extent={{-17,-15},{17,15}},
          rotation=90,
          origin={33,33})));
    Components.WaterJoinerManifold2Zone waterJoinerManifold2Zone(
      m_flow_nominal={rad219.Q_flow_nominal/(4200*12),rad220.Q_flow_nominal/(4200
          *12)},                                                 nPorts=2,
        redeclare package Medium = MediumW)
      annotation (Placement(transformation(
          extent={{-16,-16},{16,16}},
          rotation=270,
          origin={-8,34})));
    Buildings.Fluid.FixedResistances.Junction jun4(
      redeclare package Medium = MediumW,
      m_flow_nominal={m_flow_nominal_water_AHU + m_flow_nominal_water_rad,
          m_flow_nominal_water_rad,m_flow_nominal_water_AHU},
      dp_nominal={0,0,0})
      annotation (Placement(transformation(extent={{-60,-102},{-40,-122}})));
    Buildings.Fluid.FixedResistances.Junction jun5(
      redeclare package Medium = MediumW,
      m_flow_nominal={m_flow_nominal_water_AHU + m_flow_nominal_water_rad,
          m_flow_nominal_water_rad,m_flow_nominal_water_AHU},
      dp_nominal={0,0,0})
      annotation (Placement(transformation(extent={{-68,-136},{-48,-156}})));
    Buildings.Fluid.FixedResistances.Pipe pipSupRad2nd(
      redeclare package Medium = MediumW,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      m_flow_nominal=m_flow_nominal_water_rad,
      dp_nominal=0,
      nSeg=3,
      thicknessIns=0.03,
      lambdaIns=0.04,
      length=50,
      v_nominal=0.3) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={96,-140})));
    Buildings.Fluid.FixedResistances.Pipe pipRetRad2nd(
      redeclare package Medium = MediumW,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      m_flow_nominal=m_flow_nominal_water_rad,
      dp_nominal=0,
      nSeg=3,
      thicknessIns=0.03,
      lambdaIns=0.04,
      length=50,
      v_nominal=0.3) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={66,-140})));
    Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad2nd(
      redeclare package Medium = MediumW,
      T_start=295.15,
      Q_flow_nominal(displayUnit="W") = 30*floor5Zone_Shading.AFlo2nd,
      T_a_nominal=320.15,
      T_b_nominal=308.15,
      TAir_nominal=294.15,
      VWat=5.68E-6*abs(rad219.Q_flow_nominal),
      mDry=0.0263*abs(rad219.Q_flow_nominal),
      dp_nominal=0) "radiator for 2nd floor agg"
      annotation (Placement(transformation(extent={{136,-108},{156,-88}})));
    Components.TwoWayTRV val(redeclare package Medium = MediumW,
      allowFlowReversal=true,
      m_flow_nominal=m_flow_nominal_water_rad,
      dpValve_nominal=5000,
      use_TSet_in=true,
      dpFixed_nominal=10000)
      annotation (Placement(transformation(extent={{98,-116},{118,-96}})));
  equation
    connect(weaDat.weaBus,weaBus)  annotation (Line(
        points={{-180,192},{-170,192},{-170,180},{-154,180}},
        color={255,204,51},
        thickness=0.5,
        smooth=Smooth.None));
    connect(weaBus, floor5Zone_Shading.weaBus) annotation (Line(
        points={{-154,180},{-154,200},{116.826,200},{116.826,178.615}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(AHU219.weaBus, weaBus) annotation (Line(
        points={{-163,127.4},{-163,150},{-168,150},{-168,170},{-154,170},{-154,180}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));

    connect(TAirSupSet.y, AHU219.TsupSet) annotation (Line(
        points={{-235,172},{-170,172},{-170,146},{-148.4,146},{-148.4,129}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(AHU219.Tsu, twoWayHeatBattery219.TemMea) annotation (Line(
        points={{-131.4,110},{-124,110},{-124,91.4},{-132,91.4}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(TAirSupSet.y, twoWayHeatBattery219.TemSet) annotation (Line(
        points={{-235,172},{-170,172},{-170,146},{-148,146},{-148,138},{-126,138},
            {-126,112},{-122,112},{-122,88},{-132,88}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(twoWayHeatBattery219.secSup, AHU219.port_a2) annotation (Line(points={
            {-132,100},{-138,100},{-138,108}}, color={102,44,145}));
    connect(AHU219.port_b2, twoWayHeatBattery219.secRet) annotation (Line(points={
            {-144,108},{-144,100},{-151.8,100}}, color={0,127,255}));
    connect(rad219.heatPortRad,floor5Zone_Shading.heaPorRad219)  annotation (Line(
          points={{112,107.2},{112,122},{99.0826,122},{99.0826,124.846}}, color={191,
            0,0}));
    connect(rad219.heatPortCon,floor5Zone_Shading.heaPorAir219)  annotation (Line(
          points={{108,107.2},{108,126},{99.0826,126},{99.0826,128.538}}, color={191,
            0,0}));
    connect(rad220.heatPortRad,floor5Zone_Shading.heaPorRad220)  annotation (Line(
          points={{34,131.2},{34,136.385},{61.7522,136.385}}, color={191,0,0}));
    connect(rad220.heatPortCon,floor5Zone_Shading.heaPorAir220)  annotation (Line(
          points={{30,131.2},{30,138},{61.7522,138},{61.7522,139.615}}, color={191,
            0,0}));
    connect(districtHeating.weaBus, weaBus) annotation (Line(
        points={{-173,-119.4},{-173,-4},{-174,-4},{-174,110},{-204,110},{-204,180},
            {-154,180}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%second",
        index=1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(pumDP.y, districtHeating.y) annotation (Line(points={{-179,-170},{-176,
            -170},{-176,-139}}, color={0,0,127}));
    connect(AHU219.qel, reaFanPow219.u) annotation (Line(
        points={{-158,107.4},{-158,94},{-184.8,94}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(districtHeating.qel, reaPumPow.u) annotation (Line(
        points={{-176,-117.4},{-176,-82},{-186.8,-82}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(districtHeating.pdh, reaDHPow.u) annotation (Line(
        points={{-186.8,-117},{-186.8,-94},{-186.8,-94}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(twoWayHeatBattery219.Pow, reaVenHeaPow219.u) annotation (Line(
        points={{-152.8,93},{-152.8,90},{-162,90},{-162,70},{-184.8,70}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(twoWayHeatBattery219.Ene, reaVenHeaEne219.u) annotation (Line(
        points={{-152.8,91},{-152.8,88},{-158,88},{-158,58},{-184.8,58}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(energyMeter.Energy, reaRadHeaEne.u) annotation (Line(
        points={{6.6,-64},{38,-64},{38,-66},{46.8,-66}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(energyMeter.Power, reaRadHeaPow.u) annotation (Line(
        points={{6.6,-66},{26,-66},{26,-78},{46.8,-78}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(jun.port_3, pipSupCoil219.port_a) annotation (Line(points={{-96,-100},
            {-96,-60},{-132,-60},{-132,-54}}, color={0,127,255}));
    connect(pipSupCoil219.port_b, twoWayHeatBattery219.priSup)
      annotation (Line(points={{-132,-34},{-132,80}}, color={0,127,255}));
    connect(twoWayHeatBattery219.priRet, pipRetCoil219.port_a)
      annotation (Line(points={{-152,80},{-152,-34}}, color={0,127,255}));
    connect(energyMeter.port_b1, pipSupRad.port_a) annotation (Line(points={{2,-58},
            {2,-54},{14,-54},{14,-44}},      color={0,127,255}));
    connect(energyMeter.port_a2, pipRetRad.port_b) annotation (Line(points={{-10,-58},
            {-10,-54},{-20,-54},{-20,-42}},      color={0,127,255}));
    connect(tPipHeaLoss.port, pipRetCoil219.heatPort)
      annotation (Line(points={{-80,-4},{-147,-4},{-147,-44}}, color={191,0,0}));
    connect(tPipHeaLoss.port, pipSupCoil219.heatPort) annotation (Line(points={{-80,
            -4},{-116,-4},{-116,-44},{-127,-44}}, color={191,0,0}));
    connect(tPipHeaLoss.port, pipRetRad.heatPort) annotation (Line(points={{-80,
            -4},{-116,-4},{-116,-50},{-4,-50},{-4,-32},{-15,-32}}, color={191,0,0}));
    connect(tPipHeaLoss.port, pipSupRad.heatPort) annotation (Line(points={{-80,-4},
            {-196,-4},{-196,-52},{-50,-52},{-50,-34},{19,-34}},
                                color={191,0,0}));
    connect(senTemRadRet.port_a, energyMeter.port_b2)
      annotation (Line(points={{-10,-84},{-10,-78}}, color={0,127,255}));
    connect(pipRetCoil219.port_b, senTemVenRet.port_a)
      annotation (Line(points={{-152,-54},{-152,-74}}, color={0,127,255}));
    connect(senTemVenRet.port_b, jun2.port_3)
      annotation (Line(points={{-152,-94},{-152,-130},{-106,-130},{-106,-136}},
                                                        color={0,127,255}));
    connect(senTemVenRet.T, reaTemAHURet.u) annotation (Line(
        points={{-163,-84},{-174,-84},{-174,-66},{-186.8,-66}},
        color={0,0,127},
        pattern=LinePattern.Dash));
    connect(reaTemRadRet.u, senTemRadRet.T) annotation (Line(
        points={{-186.8,-54},{-168,-54},{-168,-70},{-28,-70},{-28,-94},{-21,-94}},
        color={0,0,127},
        pattern=LinePattern.Dash));

    connect(weaBus, weatherStation.weaBus) annotation (Line(
        points={{-154,180},{-108,180},{-108,187.9},{-101.9,187.9}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(AHU219.port_b1, floor5Zone_Shading.ports219[1]) annotation (Line(
          points={{-132,114.4},{-96,114.4},{-96,90},{89.8652,90},{89.8652,
            126.923}},
          color={0,127,255}));
    connect(floor5Zone_Shading.ports219[2], AHU219.port_a1) annotation (Line(
          points={{92.1696,126.923},{92.1696,104},{-42,104},{-42,122},{-132,122}},
          color={0,127,255}));
    connect(CO2SetPoi.y, AHU219.CO2SetPoi) annotation (Line(points={{-333,170},{-328,
            170},{-328,129},{-162,129}}, color={0,0,127}));
    connect(jun2.port_2, jun3.port_2)
      annotation (Line(points={{-116,-146},{-134,-146}}, color={0,127,255}));
    connect(jun3.port_1, districtHeating.port_a) annotation (Line(points={{-154,-146},
            {-160,-146},{-160,-134},{-172,-134},{-172,-134}}, color={0,127,255}));
    connect(jun.port_1, jun1.port_2)
      annotation (Line(points={{-106,-110},{-130,-110}}, color={0,127,255}));
    connect(jun1.port_1, districtHeating.port_b) annotation (Line(points={{-150,-110},
            {-156,-110},{-156,-112},{-160,-112},{-160,-122},{-172,-122}}, color={0,
            127,255}));
    connect(jun1.port_3, pipSupCoil220.port_a) annotation (Line(points={{-140,-100},
            {-184,-100},{-184,-112},{-230,-112},{-230,-56}}, color={0,127,255}));
    connect(pipSupCoil220.port_b, twoWayHeatBattery220.priSup) annotation (Line(
          points={{-230,-36},{-230,16},{-290,16},{-290,22}}, color={0,127,255}));
    connect(jun3.port_3, pipRetCoil220.port_b) annotation (Line(points={{-144,-136},
            {-266,-136},{-266,-58}}, color={0,127,255}));
    connect(pipRetCoil220.port_a, twoWayHeatBattery220.priRet) annotation (Line(
          points={{-266,-38},{-266,10},{-318,10},{-318,22},{-310,22}}, color={0,127,
            255}));
    connect(twoWayHeatBattery220.secSup, AHU220.port_a2) annotation (Line(points={
            {-290,42},{-290,52},{-304,52},{-304,58}}, color={0,127,255}));
    connect(twoWayHeatBattery220.secRet, AHU220.port_b2) annotation (Line(points={
            {-309.8,42},{-309.8,52},{-310,52},{-310,58}}, color={0,127,255}));
    connect(CO2SetPoi.y, AHU220.CO2SetPoi) annotation (Line(points={{-333,170},{-328,
            170},{-328,79}}, color={0,0,127}));
    connect(TAirSupSet.y, AHU220.TsupSet) annotation (Line(points={{-235,172},{-230,
            172},{-230,90},{-314.4,90},{-314.4,79}}, color={0,0,127}));
    connect(AHU220.qel, reaFanPow220.u) annotation (Line(points={{-324,57.4},{-324,
            42},{-344.8,42}}, color={0,0,127}));
    connect(twoWayHeatBattery220.Ene, reaVenHeaEne220.u) annotation (Line(points={
            {-310.8,33},{-310.8,6},{-344.8,6}}, color={0,0,127}));
    connect(twoWayHeatBattery220.Pow, reaVenHeaPow220.u) annotation (Line(points={
            {-310.8,35},{-328,35},{-328,18},{-344.8,18}}, color={0,0,127}));
    connect(AHU220.Tsu, twoWayHeatBattery220.TemMea) annotation (Line(points={{-297.4,
            60},{-276,60},{-276,33.4},{-290,33.4}}, color={0,0,127}));
    connect(TAirSupSet.y, twoWayHeatBattery220.TemSet) annotation (Line(points={{-235,
            172},{-230,172},{-230,90},{-272,90},{-272,30},{-290,30}}, color={0,0,127}));
    connect(AHU220.port_a1, floor5Zone_Shading.ports220[1]) annotation (Line(
          points={{-298,72},{-192,72},{-192,22},{-36,22},{-36,143.538},{61.2913,
            143.538}},
          color={0,127,255}));
    connect(AHU220.port_b1, floor5Zone_Shading.ports220[2]) annotation (Line(
          points={{-298,64.4},{-174,64.4},{-174,28},{-52,28},{-52,76},{63.5957,
            76},{63.5957,143.538}},
                       color={0,127,255}));
    connect(weaDat.weaBus, AHU220.weaBus) annotation (Line(
        points={{-180,192},{-180,144},{-250,144},{-250,104},{-329,104},{-329,77.4}},
        color={255,204,51},
        thickness=0.5));

    connect(tPipHeaLoss.port, pipSupCoil220.heatPort) annotation (Line(points={{-80,
            -4},{-212,-4},{-212,-46},{-225,-46}}, color={191,0,0}));
    connect(tPipHeaLoss.port, pipRetCoil220.heatPort) annotation (Line(points={{-80,
            -4},{-254,-4},{-254,-48},{-261,-48}}, color={191,0,0}));
    connect(occSch.occupied,switch1. u2) annotation (Line(points={{103,-40},{110,-40},
            {110,-18},{154,-18},{154,-12}},        color={255,0,255}));
    connect(TRooNig.y,switch1. u3) annotation (Line(points={{103,-60},{118,-60},{118,
            -20},{154,-20}},        color={0,0,127}));
    connect(TRooSet.y,switch1. u1) annotation (Line(points={{103,-4},{154,-4}},
                                                          color={0,0,127}));
    connect(switch1.y, waterTRVSplitterManifold2Zone.TSet) annotation (Line(
          points={{177,-12},{177,30},{54,30},{54,-2},{18,-2},{18,16}}, color={0,0,
            127}));
    connect(pipSupRad.port_b, waterTRVSplitterManifold2Zone.port_a) annotation (
        Line(points={{14,-24},{12,-24},{12,0},{33,0},{33,16}}, color={0,127,255}));
    connect(waterTRVSplitterManifold2Zone.ports_b[1], rad219.port_a) annotation (
        Line(points={{34.5,50},{76,50},{76,100},{100,100}}, color={0,127,255}));
    connect(rad219.port_b, waterJoinerManifold2Zone.ports_a[1]) annotation (Line(
          points={{120,100},{138,100},{138,62},{-12,62},{-12,50},{-9.6,50}},
          color={0,127,255}));
    connect(waterJoinerManifold2Zone.port_b, pipRetRad.port_a) annotation (Line(
          points={{-8,18},{-8,-10},{-20,-10},{-20,-22}}, color={0,127,255}));
    connect(waterTRVSplitterManifold2Zone.ports_b[2], rad220.port_a) annotation (
        Line(points={{31.5,50},{12,50},{12,118},{-20,118},{-20,128},{22,128},{22,124}},
          color={0,127,255}));
    connect(rad220.port_b, waterJoinerManifold2Zone.ports_a[2]) annotation (Line(
          points={{42,124},{42,80},{38,80},{38,82},{-16,82},{-16,56},{-6.4,56},{-6.4,
            50}}, color={0,127,255}));
    connect(floor5Zone_Shading.TRooAir[1], waterTRVSplitterManifold2Zone.TMea[1])
      annotation (Line(points={{158.304,143.231},{174,143.231},{174,40},{70,40},
            {70,-16},{18.75,-16},{18.75,16}},color={0,0,127}));
    connect(floor5Zone_Shading.TRooAir[2], waterTRVSplitterManifold2Zone.TMea[2])
      annotation (Line(points={{158.304,144},{182,144},{182,-12},{60,-12},{60,
            -24},{17.25,-24},{17.25,16}},
                                     color={0,0,127}));
    connect(floor5Zone_Shading.CO2Roo[1], AHU219.CO2meas) annotation (Line(points={{158.304,
            150.154},{158.304,162},{-52,162},{-52,152},{-144.2,152},{-144.2,129}},
                   color={0,0,127}));
    connect(floor5Zone_Shading.CO2Roo[2], AHU220.CO2meas) annotation (Line(points={{158.304,
            150.923},{158.304,174},{-82,174},{-82,148},{-310.2,148},{-310.2,79}},
                         color={0,0,127}));
    connect(jun.port_2, jun4.port_1) annotation (Line(points={{-86,-110},{-68,-110},
            {-68,-112},{-60,-112}}, color={0,127,255}));
    connect(jun4.port_2, energyMeter.port_a1) annotation (Line(points={{-40,-112},
            {14,-112},{14,-78},{2,-78}}, color={0,127,255}));
    connect(jun2.port_1, jun5.port_1)
      annotation (Line(points={{-96,-146},{-68,-146}}, color={0,127,255}));
    connect(jun5.port_2, senTemRadRet.port_b) annotation (Line(points={{-48,-146},
            {-10,-146},{-10,-104}}, color={0,127,255}));
    connect(rad2nd.port_b, pipRetRad2nd.port_a) annotation (Line(points={{156,-98},
            {156,-78},{66,-78},{66,-130}}, color={0,127,255}));
    connect(jun4.port_3, pipSupRad2nd.port_a) annotation (Line(points={{-50,-102},
            {-48,-102},{-48,-86},{-28,-86},{-28,-136},{24,-136},{24,-166},{96,-166},
            {96,-150}}, color={0,127,255}));
    connect(pipRetRad2nd.port_b, jun5.port_3) annotation (Line(points={{66,-150},{
            68,-150},{68,-178},{-36,-178},{-36,-128},{-58,-128},{-58,-136}},
          color={0,127,255}));
    connect(rad2nd.heatPortRad, floor5Zone_Shading.heaPorRad2nd) annotation (Line(
          points={{148,-90.8},{124,-90.8},{124,76},{188,76},{188,141.462},{
            99.0826,141.462}},
                       color={191,0,0}));
    connect(rad2nd.heatPortCon, floor5Zone_Shading.heaPorAir2nd) annotation (Line(
          points={{144,-90.8},{150,-90.8},{150,88},{166,88},{166,145.154},{
            99.0826,145.154}},
                       color={191,0,0}));
    connect(pipSupRad2nd.port_b, val.port_a) annotation (Line(points={{96,-130},{90,
            -130},{90,-106},{98,-106}}, color={0,127,255}));
    connect(val.port_b, rad2nd.port_a) annotation (Line(points={{118,-106},{124,-106},
            {124,-100},{136,-100},{136,-98}}, color={0,127,255}));
    connect(floor5Zone_Shading.TRooAir[3], val.T) annotation (Line(points={{158.304,
            144.769},{196,144.769},{196,84},{186,84},{186,-86},{108,-86},{108,
            -95.4}},
          color={0,0,127}));
    connect(switch1.y, val.TSet_in) annotation (Line(points={{177,-12},{178,-12},{
            178,-88},{80,-88},{80,-98},{96,-98}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-380,-200},
              {200,200}})),                                        Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-380,-200},{200,200}}),
          graphics={
          Text(
            extent={{-124,92},{-70,54}},
            lineColor={28,108,200},
            textString="VAV system 2.19"),
          Rectangle(extent={{-178,134},{-64,50}}, lineColor={28,108,200}),
          Text(
            extent={{-280,44},{-226,6}},
            lineColor={28,108,200},
            textString="VAV system 2.20"),
          Rectangle(extent={{-338,86},{-224,2}}, lineColor={28,108,200})}),
      experiment(
        StopTime=1209600,
        Interval=30,
        Tolerance=1e-06,
        __Dymola_Algorithm="Cvode"));
  end TestCase;

  package Components

    model Floor5Zone_Shading
      "Model of a floor of the building with automatic solar shading"
      extends .TwinRooms.Components.BaseClasses.PartialFloor(
        redeclare final package Medium = MediumA,
        final VRoo2nd=SecFloor.AFlo*hRoo,
        final VRoo219=room219.AFlo*hRoo,
        final VRoo220=room220.AFlo*hRoo,
        final wWesFac=16.546,
        final wSouFac=24.073,
        AFlo219=66.7,
        AFlo220=66.7,
        AFlo2nd=308.16,
        lea219(amb(C=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
                /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC))),
        lea220(amb(C=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
                /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC))),
        lea2nd(amb(C=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
                /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC))),
        door220To2nd(wOpe=1.710),
        door219To2nd(wOpe=1.710),
        reaT219(zone="1"));

      package MediumA = Buildings.Media.Air(extraPropertiesNames={"CO2"}) "Medium model for air";

      parameter Buildings.HeatTransfer.Types.InteriorConvection intConMod=Buildings.HeatTransfer.Types.InteriorConvection.Temperature
        "Convective heat transfer model for room-facing surfaces of opaque constructions";
      parameter Modelica.SIunits.Angle lat "Latitude";
      parameter Real winWalRat(
        min=0.01,
        max=0.99) = 0.33 "Window to wall ratio for exterior walls";

      parameter Modelica.SIunits.Height hWin = 1.775 "Height of windows";
      parameter Modelica.SIunits.Length wWin = 0.9 "Width of windows";
      parameter Modelica.SIunits.DimensionlessRatio nWinTwin = 8 "# of windows in each twin room";
      parameter Modelica.SIunits.Height hWinNor = 2.210 "Height of windows, north facace";
      parameter Modelica.SIunits.Length wWinNor = 1.890 "Width of windows, north facade";
      parameter Modelica.SIunits.DimensionlessRatio nWinNor = 7 "# of windows on north facade";
      parameter Modelica.SIunits.Height hWinWes = 2.290 "Height of windows, west facace";
      parameter Modelica.SIunits.Length wWinWes = 3.34 "Width of windows, west facade";
      parameter Modelica.SIunits.Height hWinEas = 2.290 "Height of windows, east facace";
      parameter Modelica.SIunits.Length wWinEas = 2.34 "Width of windows, east facade";

      parameter Modelica.SIunits.DimensionlessRatio ach = 0.3 "ACH nominal at 50 Pa";

      parameter Buildings.HeatTransfer.Data.Solids.Plywood matFur(x=0.15, nStaRef=5)
        "Material for furniture"
        annotation (Placement(transformation(extent={{140,460},{160,480}})));
    parameter Buildings.HeatTransfer.Data.Resistances.Carpet matCar "Carpet"
      annotation (Placement(transformation(extent={{180,460},{200,480}})));
    parameter Buildings.HeatTransfer.Data.Solids.Concrete matCon(
      x=0.1,
      k=1.311,
      c=836,
      nStaRef=5) "Concrete"
      annotation (Placement(transformation(extent={{140,430},{160,450}})));
    parameter Buildings.HeatTransfer.Data.Solids.Plywood matWoo(
      x=0.01,
      k=0.11,
      d=544,
      nStaRef=1) "Wood for exterior construction"
      annotation (Placement(transformation(extent={{140,400},{160,420}})));
    parameter Buildings.HeatTransfer.Data.Solids.Generic matIns(
      x=0.250,
      k=0.049,
      c=852,
      d=214,
      nStaRef=5) "Steelframe construction with insulation"
      annotation (Placement(transformation(extent={{180,398},{200,418}})));
     parameter Buildings.HeatTransfer.Data.Solids.Generic matDoubleBevel(
       x=0.019,
       k=0.13,
       c=1600,
       d=500) "Vertical panel double bevel square edge"
       annotation (Placement(transformation(extent={{-360,518},{-340,538}})));
     parameter Buildings.HeatTransfer.Data.Solids.Generic matHorBatt(
       x=0.068,
       k=0.12,
       c=1600,
       d=450) "Horizontal batten"
       annotation (Placement(transformation(extent={{-360,498},{-340,518}})));
     parameter Buildings.HeatTransfer.Data.Solids.Generic matVerBatt(
       x=0.036,
       k=0.12,
       c=1600,
       d=450) "Vertical batten"
       annotation (Placement(transformation(extent={{-360,478},{-340,498}})));
     parameter Buildings.HeatTransfer.Data.Solids.Generic matWinBar(
       x=0.002,
       k=0.04,
       c=1400,
       d=60) "Wind barrier fabric, black"
       annotation (Placement(transformation(extent={{-358,458},{-338,478}})));
     parameter Buildings.HeatTransfer.Data.Solids.Generic matGUx(
       x=0.09,
       k=0.22,
       c=1000,
       d=1000) "GUx"
       annotation (Placement(transformation(extent={{-360,438},{-340,458}})));
     parameter Buildings.HeatTransfer.Data.Solids.Generic matMinWooFra(
       x=0.223,
       k=0.046,
       c=1900,
       d=74) "Frame with mineral wool"
       annotation (Placement(transformation(extent={{-360,418},{-340,438}})));
     parameter Buildings.HeatTransfer.Data.Solids.Generic matVapBar(
       x=0.005,
       k=0.22,
       c=1700,
       d=130) "Vapor barrier"
       annotation (Placement(transformation(extent={{-360,398},{-340,418}})));
     parameter Buildings.HeatTransfer.Data.Solids.Generic matMinWooFur(
       x=0.073,
       k=0.046,
       c=1900,
       d=74) "Inner furring with mineral wool"
       annotation (Placement(transformation(extent={{-332,510},{-312,530}})));
     parameter Buildings.HeatTransfer.Data.Solids.GypsumBoard matGyp(
        x=0.013,
        k=0.25,
        c=960,
        d=680,
       nStaRef=2) "Gypsum board"
       annotation (Placement(transformation(extent={{-332,484},{-312,504}})));
    parameter Buildings.HeatTransfer.Data.Solids.GypsumBoard matGyp3(
      x=0.0127,
      k=0.16,
      c=830,
      d=784,
      nStaRef=2) "Gypsum board"
      annotation (Placement(transformation(extent={{138,372},{158,392}})));
    parameter Buildings.HeatTransfer.Data.Solids.GypsumBoard matGyp2(
      x=0.025,
      k=0.16,
      c=830,
      d=784,
      nStaRef=2) "Gypsum board"
      annotation (Placement(transformation(extent={{178,372},{198,392}})));
      parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conExtWal(final
          nLay=4, material={matGUx,matMinWooFra,matMinWooFur,matGyp})
                                                   "Exterior construction"
        annotation (Placement(transformation(extent={{278,460},{298,480}})));
      parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conIntWal(final
          nLay=3, material={matGyp1,matMinWooFraWoo,matGyp1})
                                      "Interior wall construction"
        annotation (Placement(transformation(extent={{320,460},{340,480}})));
      parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conFlo(final
          nLay=3, material={matChiBoa,matMinWoo,matCLT})
                                     "Floor construction (opa_a is carpet)"
        annotation (Placement(transformation(extent={{276,420},{296,440}})));
      parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conFur(final
          nLay=1, material={matFur}) "Construction for internal mass of furniture"
        annotation (Placement(transformation(extent={{320,420},{340,440}})));
      parameter Buildings.HeatTransfer.Data.Solids.Plywood matCarTra(
        k=0.11,
        d=544,
        nStaRef=1,
        x=0.215/0.11) "Wood for floor"
        annotation (Placement(transformation(extent={{102,460},{122,480}})));
      parameter Buildings.HeatTransfer.Data.GlazingSystems.DoubleClearAir13Clear glaSys(
        UFra=2,
        shade=Buildings.HeatTransfer.Data.Shades.Gray(),
        haveInteriorShade=false,
        haveExteriorShade=true)  "Data record for the glazing system"
        annotation (Placement(transformation(extent={{240,460},{260,480}})));

      constant Modelica.SIunits.Height hRoo=3.850 "Room height";

      parameter Boolean sampleModel = false
        "Set to true to time-sample the model, which can give shorter simulation time if there is already time sampling in the system model"
        annotation (
          Evaluate=true,
          Dialog(tab="Experimental (may be changed in future releases)"));

      Buildings.ThermalZones.Detailed.MixedAir room219(
        datConExt(
          layers={conExtWal},
          A={(4.073 + 1.8)*hRoo},
          til={Buildings.Types.Tilt.Wall},
          azi={Buildings.Types.Azimuth.E}),
        datConPar(
          layers={conFlo,conFlo},
          A={AFlo2nd,AFlo2nd},
          til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Ceiling}),
        surBou(
          A={(wSouFac/2)*hRoo,5.89*hRoo},
          absIR={0.9,0.9},
          absSol={0.9,0.9},
          til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),
        redeclare package Medium = Medium,
        lat=lat,
        AFlo=AFlo219,
        hRoo=hRoo,
        nConExt=1,
        nConExtWin=1,
        datConExtWin(
          layers={conExtWal},
          A={12*hRoo},
          glaSys={datGlaSys},
          wWin={nWinTwin*wWin*hWin},
          each hWin=hWin,
          fFra={0.1},
          til={Buildings.Types.Tilt.Wall},
          azi={Buildings.Types.Azimuth.S}),
        nConPar=2,
        nConBou=0,
        nSurBou=2,
        use_C_flow=true,
        T_start=295.15,
        C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
            Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
        nPorts=6,
        intConMod=intConMod,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        m_flow_nominal=(AFlo219*hRoo)*1.2*ach/3600,
        final sampleModel=sampleModel) "Room 2.19"
        annotation (Placement(transformation(extent={{142,-44},{182,-4}})));

      Buildings.ThermalZones.Detailed.MixedAir room220(
        datConExt(
          layers={conExtWal},
          A={(4.073 + 1.8)*hRoo},
          til={Buildings.Types.Tilt.Wall},
          azi={Buildings.Types.Azimuth.W}),
        datConPar(
          layers={conFlo,conFlo},
          A={AFlo2nd,AFlo2nd},
          til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Ceiling}),
        surBou(
          A={(wSouFac/2)*hRoo,5.89*hRoo},
          absIR={0.9,0.9},
          absSol={0.9,0.9},
          til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),
        redeclare package Medium = Medium,
        lat=lat,
        AFlo=AFlo220,
        hRoo=hRoo,
        nConExt=1,
        nConExtWin=1,
        datConExtWin(
          layers={conExtWal},
          A={12*hRoo},
          glaSys={datGlaSys},
          wWin={nWinTwin*wWin*hWin},
          each hWin=hWin,
          fFra={0.1},
          til={Buildings.Types.Tilt.Wall},
          azi={Buildings.Types.Azimuth.S}),
        nConPar=2,
        nConBou=0,
        nSurBou=2,
        use_C_flow=true,
        T_start=295.15,
        C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
            Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
        nPorts=6,
        intConMod=intConMod,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        m_flow_nominal=(AFlo220*hRoo)*1.2*ach/3600,
        final sampleModel=sampleModel) "Room 2.20"
        annotation (Placement(transformation(extent={{20,-46},{60,-6}})));
      Buildings.ThermalZones.Detailed.MixedAir SecFloor(
        datConExtWin(
          layers={conExtWal,conExtWal,conExtWal},
          A={(4.073 + 1.8 + 4.8)*hRoo,28.873*hRoo,(4.073 + 1.8 + 4.8)*hRoo},
          glaSys={datGlaSys,datGlaSys,datGlaSys},
          wWin={wWinWes,nWinTwin*wWinNor,wWinEas},
          hWin={hWinWes,hWinNor,hWinEas},
          fFra={0.1,0.1,0.1},
          til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
          azi={Buildings.Types.Azimuth.W,Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.E}),
        surBou(
          each A=(wSouFac/2)*hRoo,
          each absIR=0.9,
          each absSol=0.9,
          each til=Buildings.Types.Tilt.Wall),
        redeclare package Medium = Medium,
        lat=lat,
        AFlo=AFlo2nd,
        hRoo=hRoo,
        nConExt=0,
        nConExtWin=3,
        nConPar=2,
        datConPar(
          layers={conFlo,conFlo},
          A={AFlo2nd,AFlo2nd},
          til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Ceiling}),
        nConBou=0,
        nSurBou=2,
        use_C_flow=true,
        C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
            Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
        nPorts=8,
        intConMod=intConMod,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        m_flow_nominal=(AFlo219*hRoo)*1.2*ach/3600,
        final sampleModel=sampleModel) "Rest of 2nd floor lumped as one zone"
        annotation (Placement(transformation(extent={{146,36},{186,76}})));

      InternalGains.InternalGains                           gai(
        Area=1,                                                               redeclare
          .TwinRooms.Components.InternalGains.Data.SNTS3031_Office          data(
            equSenPowNom=0.5, ligSenPowNom=0.5),
        combiTimeTable(
          tableOnFile=true,
          tableName="tab1",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "Resources/intGains.txt")))
        "Matrix gain to split up heat gain in radiant, convective and latent gain"
        annotation (Placement(transformation(extent={{-116,104},{-96,124}})));

        Modelica.Blocks.Sources.RealExpression CO2Gen220(y=gai.CO2*AFlo220)
                   "CO2 generated by people in the west zone"
      annotation (Placement(transformation(extent={{-138,48},{-118,68}})));
      Modelica.Blocks.Sources.RealExpression CO2Gen2nd(y=0)
                   "CO2 generated by people in the corridor zone"
      annotation (Placement(transformation(extent={{82,52},{102,72}})));
      Modelica.Blocks.Sources.RealExpression CO2Gen219(y=gai.CO2*AFlo219)
                   "CO2 generated by people in the south zone"
      annotation (Placement(transformation(extent={{74,-30},{94,-10}})));

      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAir220
        "Heat port to air volume" annotation (Placement(transformation(extent={{-34,
                26},{-24,36}}), iconTransformation(extent={{-34,26},{-24,36}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRad220
        "Heat port for radiative heat gain and radiative temperature" annotation (
          Placement(transformation(extent={{-34,12},{-24,22}}), iconTransformation(
              extent={{-34,12},{-24,22}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAir219
        "Heat port to air volume" annotation (Placement(transformation(extent={{128,
                -22},{138,-12}}), iconTransformation(extent={{128,-22},{138,-12}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRad219
        "Heat port for radiative heat gain and radiative temperature" annotation (
          Placement(transformation(extent={{128,-38},{138,-28}}),
            iconTransformation(extent={{128,-38},{138,-28}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAir2nd
        "Heat port to air volume" annotation (Placement(transformation(extent={{128,
                50},{138,60}}), iconTransformation(extent={{128,50},{138,60}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRad2nd
        "Heat port for radiative heat gain and radiative temperature" annotation (
          Placement(transformation(extent={{128,34},{138,44}}), iconTransformation(
              extent={{128,34},{138,44}})));
      Buildings.Fluid.Sensors.PPM senCO2219(redeclare package Medium = Medium,
          warnAboutOnePortConnection=false)
        annotation (Placement(transformation(extent={{294,146},{314,166}})));
      Buildings.Fluid.Sensors.PPM senCO2220(redeclare package Medium = Medium,
          warnAboutOnePortConnection=false)
        annotation (Placement(transformation(extent={{294,120},{314,140}})));
      Buildings.Fluid.Sensors.PPM senCO22nd(redeclare package Medium = Medium,
          warnAboutOnePortConnection=false)
        annotation (Placement(transformation(extent={{294,100},{314,120}})));
      Modelica.Blocks.Interfaces.RealOutput CO2Roo[3]
        "Connector of Real output signals" annotation (Placement(transformation(
              extent={{380,70},{400,90}}), iconTransformation(extent={{380,70},{400,
                90}})));
      BaseClasses.shading              shading_control[5](
        each threshold=150,
        each til=Buildings.Types.Tilt.Wall,
        each lat=lat,
        azi={Buildings.Types.Azimuth.S,Buildings.Types.Azimuth.S,Buildings.Types.Azimuth.W,Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.E})
        annotation (Placement(transformation(extent={{-58,174},{-38,194}})));
      Buildings.Utilities.IO.SignalExchange.Read reaCO2Cor(
        description="CO2 concentration of 2nd floor",
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
        zone="3",
        y(unit="ppm"))
        annotation (Placement(transformation(extent={{322,106},{330,114}})));

      Buildings.Utilities.IO.SignalExchange.Read reaCO2220(
        description="CO2 concentration of 2.20",
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
        zone="2",
        y(unit="ppm"))
        annotation (Placement(transformation(extent={{322,126},{330,134}})));

      Buildings.Utilities.IO.SignalExchange.Read reaCO2Sou(
        description="Temperature of south zone",
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
        zone="1",
        y(unit="ppm"))
        annotation (Placement(transformation(extent={{324,152},{332,160}})));

      Buildings.Utilities.IO.SignalExchange.Overwrite oveSha219(description="Overwrite shading position for 2.19",
                                                           u(
          unit="1",
          min=0,
          max=1)) annotation (Placement(transformation(extent={{126,-10},{136,0}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite oveSha220(description="Overwrite shading position for 2.20",
                                                          u(
          unit="1",
          min=0,
          max=1)) annotation (Placement(transformation(extent={{-10,70},{0,80}})));
      Buildings.Utilities.IO.SignalExchange.Read reaAuxPow(
        description="Aux power consumption",
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
        y(unit="W", displayUnit="W"))
        annotation (Placement(transformation(extent={{-144,80},{-160,96}})));

      Modelica.Blocks.Math.Gain gaiArea(k=1)
        annotation (Placement(transformation(extent={{-110,78},{-130,98}})));
      parameter Buildings.HeatTransfer.Data.Solids.Concrete matConExt(
        x=0.15,
        k=1.311,
        c=836,
        nStaRef=5) "Concrete for external facade"
        annotation (Placement(transformation(extent={{178,432},{198,452}})));
     parameter Buildings.HeatTransfer.Data.Solids.GypsumBoard matGyp1(
        x=0.026,
        k=0.25,
        c=960,
        d=680,
        nStaRef=2) "Gypsum board"
       annotation (Placement(transformation(extent={{-356,246},{-336,266}})));
     parameter Buildings.HeatTransfer.Data.Solids.Generic matMinWooFraWoo(
        x=0.098,
        k=0.046,
        c=1900,
        d=74) "Wooden frame and mineral wool"
        annotation (Placement(transformation(extent={{-356,216},{-336,236}})));
      parameter Buildings.HeatTransfer.Data.Solids.Generic matChiBoa(
        x=0.044,
        k=0.14,
        c=1800,
        d=650) "Chipboard"
        annotation (Placement(transformation(extent={{566,450},{586,470}})));
      parameter Buildings.HeatTransfer.Data.Solids.Generic matMinWoo(
        x=0.068,
        k=0.035,
        c=830,
        d=20) "Mineral Wool"
        annotation (Placement(transformation(extent={{566,424},{586,444}})));
      parameter Buildings.HeatTransfer.Data.Solids.Generic matCLT(
        x=0.21,
        k=0.13,
        c=1600,
        d=471) "CLT"
        annotation (Placement(transformation(extent={{566,398},{586,418}})));
      Buildings.HeatTransfer.Conduction.MultiLayer parWal220To2nd(
        A=(wSouFac/2)*hRoo,
        layers=conIntWal,
        stateAtSurface_a=true,
        stateAtSurface_b=true)
        "Partition wall between room 2.20 to rest of 2nd floor" annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={78,16})));
      Buildings.HeatTransfer.Conduction.MultiLayer parWal219To2nd(
        A=(wSouFac/2)*hRoo,
        layers=conIntWal,
        stateAtSurface_a=true,
        stateAtSurface_b=true)
        "Partition wall between room 2.19 to rest of 2nd floor" annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={238,14})));
      parameter BaseClasses.TripleArgon18Argon18Clear datGlaSys(haveExteriorShade=
            true, shade=Buildings.HeatTransfer.Data.Shades.Gray())
        annotation (Placement(transformation(extent={{240,422},{260,442}})));
      Modelica.Blocks.Sources.Constant const(k=0)
        annotation (Placement(transformation(extent={{-158,-110},{-138,-90}})));
      Buildings.HeatTransfer.Conduction.MultiLayer parWal220To219(
        A=5.89*hRoo,
        layers=conIntWal,
        stateAtSurface_a=true,
        stateAtSurface_b=true) "Partition wall between room 2.20 and room 2.19"
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={212,-114})));
      Buildings.Utilities.IO.SignalExchange.Overwrite oveShaSecFloorWes(description
          ="Overwrite shading position for second floor", u(
          unit="1",
          min=0,
          max=1)) annotation (Placement(transformation(extent={{72,148},{82,158}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite oveShaSecFloorNor(description
          ="Overwrite shading position for second floor", u(
          unit="1",
          min=0,
          max=1)) annotation (Placement(transformation(extent={{72,166},{82,176}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite oveShaSecFloorEas(description
          ="Overwrite shading position for second floor", u(
          unit="1",
          min=0,
          max=1)) annotation (Placement(transformation(extent={{72,182},{82,192}})));
      Modelica.Blocks.Sources.Constant intGains2nd[3](k=0)
        annotation (Placement(transformation(extent={{-124,12},{-104,32}})));
      Modelica.Blocks.Routing.Multiplex3 multiplex3_2
        annotation (Placement(transformation(extent={{350,112},{370,132}})));
    equation
      connect(room219.weaBus, weaBus) annotation (Line(
          points={{179.9,-6.1},{179.9,8},{210,8},{210,200}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None), Text(
          textString="%second",
          index=1,
          extent={{6,3},{6,3}}));
      connect(room220.weaBus, weaBus) annotation (Line(
          points={{57.9,-8.1},{57.9,200},{210,200}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(SecFloor.weaBus, weaBus) annotation (Line(
          points={{183.9,73.9},{183.9,90},{210,90},{210,200}},
          color={255,204,51},
          thickness=0.5,
          smooth=Smooth.None));
      connect(room219.heaPorAir,temAir219.port)  annotation (Line(
          points={{161,-24},{224,-24},{224,100},{264,100},{264,350},{290,350}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(room220.heaPorAir,temAir220.port)  annotation (Line(
          points={{39,-26},{-28,-26},{-28,248},{-8,248},{-8,284},{280,284},{280,258},
              {292,258}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(SecFloor.heaPorAir,temAir2nd.port)  annotation (Line(
          points={{165,56},{162,56},{162,228},{294,228}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(room219.ports[1],ports219 [1]) annotation (Line(
          points={{147,-35.6667},{114,-35.6667},{114,-36},{85,-36}},
          color={0,127,255},
          thickness=0.5));
      connect(room219.ports[2],ports219 [2]) annotation (Line(
          points={{147,-35},{122,-35},{122,-50},{108,-50},{108,-36},{95,-36}},
          color={0,127,255},
          thickness=0.5));
      connect(room220.ports[1],ports220 [1]) annotation (Line(
          points={{25,-37.6667},{25,-32},{-32,-32},{-32,4},{-35,4},{-35,44}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(room220.ports[2],ports220 [2]) annotation (Line(
          points={{25,-37},{-32,-37},{-32,4},{-36,4},{-36,44},{-25,44}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(SecFloor.ports[1],ports2nd [1]) annotation (Line(
          points={{151,44.25},{114,44.25},{114,46},{85,46}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(SecFloor.ports[2],ports2nd [2]) annotation (Line(
          points={{151,44.75},{124,44.75},{124,46},{95,46}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(senRelPre2nd.p_rel, p_rel) annotation (Line(
          points={{50,241},{50,220},{-170,220}},
          color={0,0,127},
          smooth=Smooth.None,
          pattern=LinePattern.Dash));
      connect(CO2Gen220.y, room220.C_flow[1]) annotation (Line(points={{-117,58},{
              -64,58},{-64,64},{-20,64},{-20,88},{16,88},{16,36},{4,36},{4,-23.2},{
              18.4,-23.2}},                                color={0,0,127}));
      connect(CO2Gen2nd.y, SecFloor.C_flow[1]) annotation (Line(points={{103,62},{
              124,62},{124,58.8},{144.4,58.8}},
                                            color={0,0,127}));
      connect(room220.heaPorAir,heaPorAir220)
        annotation (Line(points={{39,-26},{-29,-26},{-29,31}}, color={191,0,0}));
      connect(room220.heaPorRad,heaPorRad220)  annotation (Line(points={{39,-29.8},{
              16,-29.8},{16,-16},{8,-16},{8,32},{-24,32},{-24,17},{-29,17}}, color={
              191,0,0}));
      connect(room219.heaPorAir,heaPorAir219)  annotation (Line(points={{161,-24},{
              192,-24},{192,-17},{133,-17}},
                                         color={191,0,0}));
      connect(room219.heaPorRad,heaPorRad219)  annotation (Line(points={{161,-27.8},
              {162,-27.8},{162,-48},{126,-48},{126,-33},{133,-33}}, color={191,0,0}));
      connect(SecFloor.heaPorAir,heaPorAir2nd)  annotation (Line(points={{165,56},{134,
              56},{134,55},{133,55}}, color={191,0,0}));
      connect(SecFloor.heaPorRad,heaPorRad2nd)  annotation (Line(points={{165,52.2},
              {133,52.2},{133,39}}, color={191,0,0}));
      connect(CO2Gen219.y, room219.C_flow[1]) annotation (Line(points={{95,-20},{95,
              4},{120,4},{120,8},{140.4,8},{140.4,-21.2}},
                                   color={0,0,127}));
      connect(senCO2219.port, room219.ports[3]) annotation (Line(points={{304,146},
              {276,146},{276,-136},{147,-136},{147,-34.3333}},       color={0,127,255}));
      connect(senCO2220.port, room220.ports[3]) annotation (Line(points={{304,120},
              {282,120},{282,196},{226,196},{226,200},{190,200},{190,196},{46,
              196},{46,68},{6,68},{6,44},{-38,44},{-38,4},{-34,4},{-34,-36.3333},
              {25,-36.3333}},
            color={0,127,255}));
      connect(senCO22nd.port, SecFloor.ports[3]) annotation (Line(points={{304,100},
              {288,100},{288,28},{228,28},{228,40},{188,40},{188,32},{140,32},{140,
              45.25},{151,45.25}},
                              color={0,127,255}));
      connect(weaBus, shading_control[1].weaBus) annotation (Line(
          points={{210,200},{52,200},{52,220},{-106,220},{-106,193.4},{-57,193.4}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(weaBus, shading_control[2].weaBus) annotation (Line(
          points={{210,200},{-57,200},{-57,193.4}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(weaBus, shading_control[3].weaBus) annotation (Line(
          points={{210,200},{-57,200},{-57,193.4}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(senCO2219.ppm, reaCO2Sou.u) annotation (Line(
          points={{315,156},{323.2,156}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(senCO2220.ppm,reaCO2220. u) annotation (Line(
          points={{315,130},{321.2,130}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(senCO22nd.ppm, reaCO2Cor.u) annotation (Line(
          points={{315,110},{321.2,110}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(oveSha219.y, room219.uSha[1]) annotation (Line(
          points={{136.5,-5},{139.45,-5},{139.45,-6},{140.4,-6}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(oveSha220.y, room220.uSha[1]) annotation (Line(
          points={{0.5,75},{12,75},{12,-8},{18.4,-8}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(gai.elCon, gaiArea.u) annotation (Line(points={{-95,106},{-92,106},{
              -92,88},{-108,88}}, color={0,0,127}));
      connect(gaiArea.y, reaAuxPow.u) annotation (Line(points={{-131,88},{-142.4,88}},
                                        color={0,0,127}));
      connect(SecFloor.surf_surBou[1], parWal219To2nd.port_b) annotation (Line(
            points={{162.2,41.75},{184,41.75},{184,40},{238,40},{238,24}}, color={
              191,0,0}));
      connect(room219.surf_surBou[1], parWal219To2nd.port_a) annotation (Line(
            points={{158.2,-38.25},{158.2,-74},{238,-74},{238,4}},
                                                                color={191,0,0}));
      connect(room220.surf_surBou[1], parWal220To2nd.port_a) annotation (Line(
            points={{36.2,-40.25},{36,-40.25},{36,-74},{62,-74},{62,-4},{78,-4},{78,
              6}},
            color={191,0,0}));
      connect(parWal220To2nd.port_b, SecFloor.surf_surBou[2]) annotation (Line(
            points={{78,26},{78,28},{162,28},{162,36},{162.2,36},{162.2,42.25}},
            color={191,0,0}));
      connect(room220.ports[4], door220To2nd.port_a1) annotation (Line(points={{25,
              -35.6667},{-86,-35.6667},{-86,-92},{-54,-92},{-54,-94}},
                                                                 color={0,127,255}));
      connect(door220To2nd.port_b2, room220.ports[5]) annotation (Line(points={{-54,
              -106},{-122,-106},{-122,-28},{-30,-28},{-30,-35},{25,-35}},
            color={0,127,255}));
      connect(door220To2nd.port_b1, SecFloor.ports[3]) annotation (Line(points={{-34,-94},
              {22,-94},{22,45.25},{151,45.25}},color={0,127,255}));
      connect(door220To2nd.port_a2, SecFloor.ports[4]) annotation (Line(points={{-34,
              -106},{-8,-106},{-8,45.75},{151,45.75}},
            color={0,127,255}));
      connect(room219.ports[4], door219To2nd.port_b2) annotation (Line(points={{147,
              -33.6667},{147,-136},{58,-136},{58,-106},{88,-106}},
                                                                color={0,127,255}));
      connect(room219.ports[5], door219To2nd.port_a1) annotation (Line(points={{147,-33},
              {132,-33},{132,-76},{60,-76},{60,-94},{88,-94}},          color={0,127,
              255}));
      connect(door219To2nd.port_b1, SecFloor.ports[5]) annotation (Line(points={{108,-94},
              {118,-94},{118,46.25},{151,46.25}},          color={0,127,255}));
      connect(door219To2nd.port_a2, SecFloor.ports[6]) annotation (Line(points={{108,
              -106},{110,-106},{110,46.75},{151,46.75}},     color={0,127,255}));
      connect(const.y, door220To2nd.y) annotation (Line(points={{-137,-100},{-55,-100}},
                                                                  color={0,0,127}));
      connect(const.y, door219To2nd.y) annotation (Line(points={{-137,-100},{-64,-100},
              {-64,-120},{80,-120},{80,-100},{87,-100}},
                                          color={0,0,127}));
      connect(room220.surf_surBou[2], parWal220To219.port_b) annotation (Line(
            points={{36.2,-39.75},{68,-39.75},{68,-116},{186,-116},{186,-114},{202,-114}},
                      color={191,0,0}));
      connect(parWal220To219.port_a, room219.surf_surBou[2]) annotation (Line(
            points={{222,-114},{250,-114},{250,-64},{158.2,-64},{158.2,-37.75}},
                                    color={191,0,0}));
      connect(shading_control[1].y, oveSha220.u) annotation (Line(points={{-37,184},
              {-20,184},{-20,138},{-16,138},{-16,-10},{-11,-10},{-11,75}}, color={0,
              0,127}));
      connect(shading_control[2].y, oveSha219.u) annotation (Line(points={{-37,184},
              {-4,184},{-4,122},{42,122},{42,-5},{125,-5}}, color={0,0,127}));
      connect(shading_control[3].y, oveShaSecFloorWes.u) annotation (Line(points={{
              -37,184},{-4,184},{-4,124},{60,124},{60,153},{71,153}}, color={0,0,
              127}));
      connect(oveShaSecFloorWes.y, SecFloor.uSha[1]) annotation (Line(points={{82.5,
              153},{82.5,73.4667},{144.4,73.4667}}, color={0,0,127}));
      connect(shading_control[4].y, oveShaSecFloorNor.u) annotation (Line(points={{
              -37,184},{-6,184},{-6,152},{26,152},{26,171},{71,171}}, color={0,0,
              127}));
      connect(oveShaSecFloorNor.y, SecFloor.uSha[2]) annotation (Line(points={{82.5,
              171},{82.5,74},{144.4,74}}, color={0,0,127}));
      connect(shading_control[5].y, oveShaSecFloorEas.u) annotation (Line(points={{
              -37,184},{8,184},{8,187},{71,187}}, color={0,0,127}));
      connect(oveShaSecFloorEas.y, SecFloor.uSha[3]) annotation (Line(points={{82.5,
              187},{82.5,74.5333},{144.4,74.5333}}, color={0,0,127}));
      connect(shading_control[4].weaBus, out.weaBus) annotation (Line(
          points={{-57,193.4},{-90,193.4},{-90,200},{-114,200},{-114,250.2},{-54,250.2}},
          color={255,204,51},
          thickness=0.5));
      connect(shading_control[5].weaBus, out.weaBus) annotation (Line(
          points={{-57,193.4},{-100,193.4},{-100,206},{-142,206},{-142,250.2},{-54,
              250.2}},
          color={255,204,51},
          thickness=0.5));
      connect(SecFloor.ports[7], senRelPre2nd.port_a) annotation (Line(points={{151,
              47.25},{151,36},{132,36},{132,250},{60,250}}, color={0,127,255}));
      connect(lea219.port_b, room219.ports[6]) annotation (Line(points={{-20,376},
              {22,376},{22,-46},{147,-46},{147,-32.3333}},
                                                       color={0,127,255}));
      connect(lea220.port_b, room220.ports[6]) annotation (Line(points={{-20,334},
              {-8,334},{-8,-34.3333},{25,-34.3333}},color={0,127,255}));
      connect(intGains2nd.y, SecFloor.qGai_flow) annotation (Line(points={{-103,22},
              {-98,22},{-98,24},{-90,24},{-90,62},{116,62},{116,64},{144.4,64}},
            color={0,0,127}));
      connect(gai.intGai, room220.qGai_flow) annotation (Line(points={{-95,114},{20,
              114},{20,40},{0,40},{0,-18},{18.4,-18}}, color={0,0,127}));
      connect(gai.intGai, room219.qGai_flow) annotation (Line(points={{-95,114},{20,
              114},{20,40},{0,40},{0,4},{72,4},{72,0},{116,0},{116,-16},{140.4,-16}},
            color={0,0,127}));
      connect(reaCO2Sou.y, multiplex3_2.u1[1]) annotation (Line(points={{332.4,156},
              {340,156},{340,129},{348,129}}, color={0,0,127}));
      connect(reaCO2220.y, multiplex3_2.u2[1]) annotation (Line(points={{330.4,130},
              {332,130},{332,122},{348,122}}, color={0,0,127}));
      connect(reaCO2Cor.y, multiplex3_2.u3[1]) annotation (Line(points={{330.4,110},
              {336,110},{336,115},{348,115}}, color={0,0,127}));
      connect(CO2Roo, multiplex3_2.y)
        annotation (Line(points={{390,80},{390,122},{371,122}}, color={0,0,127}));
      connect(lea2nd.port_b, SecFloor.ports[8]) annotation (Line(points={{-20,290},
              {22,290},{22,292},{62,292},{62,47.75},{151,47.75}}, color={0,127,255}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=true,
            extent={{-160,-100},{380,500}},
            initialScale=0.1), graphics={
            Text(
              extent={{-420,576},{-228,538}},
              lineColor={28,108,200},
              textString="External wall (ZEB YV-223+73)"),
            Rectangle(extent={{-442,580},{-206,378}}, lineColor={28,108,200}),
            Text(
              extent={{-424,314},{-232,276}},
              lineColor={28,108,200},
              textString="Internal Wall (ZEB IV-98 GG)"),
            Rectangle(extent={{-442,320},{-206,118}}, lineColor={28,108,200}),
            Text(
              extent={{490,536},{682,498}},
              lineColor={28,108,200},
              textString="Internal Slab"),
            Rectangle(extent={{476,552},{688,360}}, lineColor={28,108,200})}),
                                    Icon(coordinateSystem(
              preserveAspectRatio=true, extent={{-80,-80},{380,180}}), graphics={
            Rectangle(
              extent={{-80,-80},{380,180}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-60,160},{360,-60}},
              pattern=LinePattern.None,
              lineColor={117,148,176},
              fillColor={170,213,255},
              fillPattern=FillPattern.Sphere),
            Rectangle(
              extent={{0,-80},{294,-60}},
              lineColor={95,95,95},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{0,-74},{294,-66}},
              lineColor={95,95,95},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{8,8},{294,100}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{20,88},{280,22}},
              pattern=LinePattern.None,
              lineColor={117,148,176},
              fillColor={170,213,255},
              fillPattern=FillPattern.Sphere),
            Polygon(
              points={{-56,170},{20,94},{12,88},{-62,162},{-56,170}},
              smooth=Smooth.None,
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Polygon(
              points={{290,16},{366,-60},{358,-66},{284,8},{290,16}},
              smooth=Smooth.None,
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Polygon(
              points={{284,96},{360,168},{368,162},{292,90},{284,96}},
              smooth=Smooth.None,
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{-80,120},{-60,-20}},
              lineColor={95,95,95},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-74,120},{-66,-20}},
              lineColor={95,95,95},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-64,-56},{18,22},{26,16},{-58,-64},{-64,-56}},
              smooth=Smooth.None,
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{360,122},{380,-18}},
              lineColor={95,95,95},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{366,122},{374,-18}},
              lineColor={95,95,95},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{2,170},{296,178}},
              lineColor={95,95,95},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{2,160},{296,180}},
              lineColor={95,95,95},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{2,166},{296,174}},
              lineColor={95,95,95},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid)}),
        Documentation(revisions="<html>
    <ul>
<li>
April 30, 2021, by Michael Wetter:<br/>
Reformulated replaceable class and introduced floor areas in base class
to avoid access of components that are not in the constraining type.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2471\">issue #2471</a>.
</li>
<li>
January 23, 2020, by Milica Grahovac:<br/>
Updated core zone geometry parameters related to
room heat and mass balance.
</li>
<li>
November 15, 2019, by Milica Grahovac:<br/>
Added extend from a partial floor model.
</li>
<li>
May 1, 2013, by Michael Wetter:<br/>
Declared the parameter record to be a parameter, as declaring its elements
to be parameters does not imply that the whole record has the variability of a parameter.
</li>
</ul>
</html>",     info="<html>
<p>
Model of a floor that consists
of five thermal zones that are representative of one floor of the
new construction medium office building for Chicago, IL,
as described in the set of DOE Commercial Building Benchmarks.
There are four perimeter zones and one core zone.
The envelope thermal properties meet ASHRAE Standard 90.1-2004.
</p>
</html>"),
        experiment(StopTime=604800, __Dymola_Algorithm="Dassl"));
    end Floor5Zone_Shading;

    model DistrictHeating_dp "District heating substation with fixed pressure pump"
      replaceable package Medium = Buildings.Media.Water constrainedby
        Modelica.Media.Interfaces.PartialMedium "Medium in the condenser"
        annotation (choices(
          choice(redeclare package Medium = Buildings.Media.Air "Moist air"),
          choice(redeclare package Medium = Buildings.Media.Water "Water"),
          choice(redeclare package Medium =
                Buildings.Media.Antifreeze.PropyleneGlycolWater (property_T=293.15,
                  X_a=0.40) "Propylene glycol water, 40% mass fraction")));
        Buildings.Fluid.HeatExchangers.PlateHeatExchangerEffectivenessNTU
                                                             dhHX(
          redeclare package Medium1 = Medium,
          redeclare package Medium2 = Medium,
          m1_flow_nominal=m_flow_nominal,
        dp1_nominal=1000,
        dp2_nominal=20000,
        allowFlowReversal1=false,
        allowFlowReversal2=false,
        linearizeFlowResistance1=true,
        linearizeFlowResistance2=true,
        m2_flow_nominal=m_flow_nominal_dh,
        configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
        Q_flow_nominal=-m_flow_nominal*4.2*20*1000*1.2,
        T_a1_nominal=308.15,
        T_a2_nominal=338.15)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

        Modelica.Blocks.Interfaces.RealOutput pdh "District heating power [W]"
          annotation (Placement(transformation(extent={{100,-58},{120,-38}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort tDHRe(redeclare package Medium =
              Medium,
        allowFlowReversal=false,
        m_flow_nominal=m_flow_nominal_dh)
          annotation (Placement(transformation(extent={{-26,-16},{-46,4}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort tSu(redeclare package Medium =
              Medium, m_flow_nominal=m_flow_nominal,
        allowFlowReversal=false)
          annotation (Placement(transformation(extent={{34,-4},{54,16}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium = Medium)
          annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium = Medium)
          annotation (Placement(transformation(extent={{50,90},{70,110}})));
        Buildings.Fluid.Movers.FlowControlled_dp pmp2(
          redeclare package Medium = Medium,
        m_flow_nominal=m_flow_nominal,
          addPowerToMedium=false,
        energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
        massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
        allowFlowReversal=false,
        redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to8 per,
        dp_start=dp_nominal,
        dp_nominal=dp_nominal,
        prescribeSystemPressure=false)
                                    annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-42,40})));
        Modelica.Blocks.Interfaces.RealInput y "Normalized pump speed (indoor loop)"
          annotation (Placement(transformation(extent={{-130,40},{-90,80}})));
        Buildings.Fluid.Sensors.VolumeFlowRate senVolFloSu(redeclare package
          Medium =
              Medium, m_flow_nominal=m_flow_nominal,
        allowFlowReversal=false)                    annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={60,38})));
        parameter Modelica.SIunits.MassFlowRate m_flow_nominal=2
          "Nominal mass flow rate";
        parameter Modelica.SIunits.MassFlowRate m_flow_nominal_dh=5
          "Nominal mass flow rate";
        Buildings.Fluid.Sensors.TemperatureTwoPort tRe(redeclare package Medium =
              Medium, m_flow_nominal=m_flow_nominal,
        allowFlowReversal=false)                    annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={-60,64})));
        Buildings.Fluid.Sensors.MassFlowRate senMasFloSu(redeclare package Medium =
              Medium, allowFlowReversal=false)
                     annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={60,62})));
        Modelica.Blocks.Interfaces.RealOutput qel
          "Circulation pump electricity consumption [W]"
          annotation (Placement(transformation(extent={{96,50},{116,70}})));
      Buildings.Fluid.Storage.ExpansionVessel expSec(redeclare package Medium =
            Medium, V_start=0.025)
        annotation (Placement(transformation(extent={{-94,18},{-74,38}})));
      Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{10,72},{-10,92}})));
      Buildings.Fluid.Sources.MassFlowSource_T boundary(
        redeclare package Medium = Medium,
        use_m_flow_in=true,
        use_T_in=false,
        T=338.15,
        nPorts=1) annotation (Placement(transformation(extent={{32,-98},{12,-78}})));
      Buildings.Fluid.Sources.Boundary_pT bou1(
        redeclare package Medium = Medium,
        p=480000,
        use_T_in=false,
        T=313.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-96,-98},{-76,-78}})));
      Sensors.EnergyMeter energyMeter(
        redeclare package Medium1 = Medium,
        redeclare package Medium2 = Medium,
        m1_flow_nominal=m_flow_nominal_dh,
        m2_flow_nominal=m_flow_nominal_dh) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={0,-50})));
      Buildings.Controls.SetPoints.Table dhTsupCur(table=[273.15 - 20,273.15 + 55;
            273.15 + 10,273.15 + 35]) "District heating temperature supply curve"
        annotation (Placement(transformation(extent={{118,-82},{98,-62}})));
      Buildings.Controls.Continuous.LimPID conPIDdh(
        Ti=600,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.05,
        yMax=1) annotation (Placement(transformation(extent={{76,-64},{60,-80}})));
      Modelica.Blocks.Math.Gain gain(k=m_flow_nominal_dh)
        annotation (Placement(transformation(extent={{52,-86},{40,-74}})));
      Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
            transformation(extent={{70,68},{110,108}}), iconTransformation(extent={
                {76,80},{96,100}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite oveTSupSetHea(description="Supply temperature set point for heating",
          u(
          unit="K",
          min=273.15 + 10,
          max=273.15 + 60))
        "Overwrite for supply temperature set point for heating" annotation (
          Placement(transformation(
            extent={{-5,5},{5,-5}},
            rotation=180,
            origin={87,-73})));
      Buildings.Utilities.IO.SignalExchange.Read reaHeaSup(
        description="Supply temperature for heating",
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
        y(unit="K"))
        annotation (Placement(transformation(extent={{82,-32},{100,-14}})));

      Buildings.Utilities.IO.SignalExchange.Read reaHeaRet(
        description="Return temperature for heating",
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
        y(unit="K"))
        annotation (Placement(transformation(extent={{82,-8},{100,10}})));

      Modelica.Blocks.Interfaces.RealOutput qdh "Accumulated energy"
        annotation (Placement(transformation(extent={{100,-48},{120,-28}})));
      parameter Modelica.SIunits.PressureDifference dp_nominal=50000 "Nominal pressure raise, used to normalized the filter if use_inputFilter=true,
        to set default values of constantHead and heads, and
        and for default pressure curve if not specified in record per"
        annotation (Dialog(group="Nominal condition"));
    equation
        connect(dhHX.port_b2, tDHRe.port_a)
          annotation (Line(points={{-10,-6},{-26,-6}}, color={0,127,255}));
        connect(tSu.port_a, dhHX.port_b1)
          annotation (Line(points={{34,6},{10,6}}, color={0,127,255}));
        connect(pmp2.port_b, dhHX.port_a1) annotation (Line(points={{-32,40},{-24,
              40},{-24,6},{-10,6}},
                                  color={0,127,255}));
        connect(tSu.port_b, senVolFloSu.port_a)
          annotation (Line(points={{54,6},{60,6},{60,28}}, color={0,127,255}));
        connect(port_a, tRe.port_a)
          annotation (Line(points={{-60,100},{-60,74}}, color={0,127,255}));
        connect(tRe.port_b, pmp2.port_a)
          annotation (Line(points={{-60,54},{-60,40},{-52,40}}, color={0,127,255}));
        connect(senVolFloSu.port_b, senMasFloSu.port_a)
          annotation (Line(points={{60,48},{60,52}}, color={0,127,255}));
        connect(senMasFloSu.port_b, port_b)
          annotation (Line(points={{60,72},{60,100}}, color={0,127,255}));
        connect(pmp2.P, qel) annotation (Line(points={{-31,49},{-11.5,49},{-11.5,60},
              {106,60}},   color={0,0,127}));
      connect(expSec.port_a, pmp2.port_a) annotation (Line(points={{-84,18},{-84,12},
              {-62,12},{-62,40},{-52,40}}, color={0,127,255}));
      connect(pmp2.dp_in, y) annotation (Line(points={{-42,52},{-42,58},{-84,58},{
              -84,60},{-110,60}},  color={0,0,127}));
      connect(senRelPre.port_a, senMasFloSu.port_b)
        annotation (Line(points={{10,82},{60,82},{60,72}}, color={0,127,255}));
      connect(senRelPre.port_b, tRe.port_a) annotation (Line(points={{-10,82},{
              -60,82},{-60,74}}, color={0,127,255}));
      connect(tSu.T, conPIDdh.u_m) annotation (Line(points={{44,17},{44,22},{68,22},
              {68,-62.4}},            color={0,0,127}));
      connect(conPIDdh.y, gain.u)
        annotation (Line(points={{59.2,-72},{56,-72},{56,-80},{53.2,-80}},
                                                       color={0,0,127}));
      connect(gain.y, boundary.m_flow_in)
        annotation (Line(points={{39.4,-80},{34,-80}},        color={0,0,127}));
      connect(weaBus.TDryBul, dhTsupCur.u) annotation (Line(
          points={{90,88},{120,88},{120,-72}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(dhTsupCur.y, oveTSupSetHea.u) annotation (Line(points={{97,-72},{95,-72},
              {95,-73},{93,-73}}, color={0,0,127}));
      connect(oveTSupSetHea.y, conPIDdh.u_s) annotation (Line(points={{81.5,-73},{79.55,
              -73},{79.55,-72},{77.6,-72}}, color={0,0,127}));
      connect(boundary.ports[1], energyMeter.port_a1)
        annotation (Line(points={{12,-88},{6,-88},{6,-60}}, color={0,127,255}));
      connect(dhHX.port_a2, energyMeter.port_b1) annotation (Line(points={{10,-6},{
              50,-6},{50,-34},{6,-34},{6,-40}}, color={0,127,255}));
      connect(tDHRe.port_b, energyMeter.port_a2) annotation (Line(points={{-46,-6},
              {-50,-6},{-50,-34},{-6,-34},{-6,-40}}, color={0,127,255}));
      connect(energyMeter.port_b2, bou1.ports[1])
        annotation (Line(points={{-6,-60},{-6,-88},{-76,-88}}, color={0,127,255}));
      connect(tSu.T, reaHeaSup.u) annotation (Line(points={{44,17},{44,22},{68,22},{
              68,-23},{80.2,-23}}, color={0,0,127}));
      connect(reaHeaRet.u, tRe.T) annotation (Line(points={{80.2,1},{80.2,0},{70,0},
              {70,24},{38,24},{38,64},{-49,64}}, color={0,0,127}));
      connect(qdh, energyMeter.Energy) annotation (Line(points={{110,-38},{16,-38},{
              16,-46},{10.6,-46}}, color={0,0,127}));
      connect(energyMeter.Power, pdh)
        annotation (Line(points={{10.6,-48},{110,-48}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-20,20},{20,-20}},
                lineColor={238,46,47},
                fillColor={255,255,255},
                fillPattern=FillPattern.Backward),
              Line(points={{18,-4}}, color={28,108,200}),
              Line(points={{20,0},{60,0},{60,90}}, color={238,46,47}),
              Ellipse(extent={{-74,74},{-46,46}}, lineColor={28,108,200}),
              Line(points={{-60,46},{-72,68},{-48,68},{-60,46}}, color={28,108,200}),
              Line(points={{-60,90},{-60,74}}, color={28,108,200}),
              Line(points={{-60,46},{-60,0},{-20,0}}, color={28,108,200}),
              Line(
                points={{0,-20},{0,-60},{96,-60}},
                color={238,46,47},
                pattern=LinePattern.Dash),
              Line(points={{-90,60},{-74,60}}, color={0,0,0})}),       Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(StopTime=259200),
          __Dymola_experimentSetupOutput);
    end DistrictHeating_dp;

    model TwoWayHeatBattery
      "Circuit for controlling heating battery supply flow with two way valve and bypass"

        replaceable package Medium = Buildings.Media.Water constrainedby
        Modelica.Media.Interfaces.PartialMedium;

      Buildings.Fluid.Sensors.EnthalpyFlowRate senEntFloSup(redeclare package
          Medium = Medium, m_flow_nominal=m_flow_nominal) annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={-40,18})));
      Buildings.Fluid.Sensors.EnthalpyFlowRate senEntFloRet(redeclare package
          Medium = Medium, m_flow_nominal=m_flow_nominal) annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={40,20})));
      Sensors.EnergyDiffCalc energyDiffCalc
        annotation (Placement(transformation(extent={{-12,4},{8,24}})));
      Buildings.Fluid.Sensors.TemperatureTwoPort senTemSup(redeclare package
          Medium =
            Medium, m_flow_nominal=m_flow_nominal) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-40,58})));
      Buildings.Fluid.Sensors.TemperatureTwoPort senTemRet(redeclare package
          Medium =
            Medium, m_flow_nominal=m_flow_nominal) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={40,56})));
      Modelica.Fluid.Interfaces.FluidPort_b secSup(redeclare package Medium =
            Medium) "Supply (outlet) of secondary circuit"
        annotation (Placement(transformation(extent={{-110,90},{-90,110}}),
            iconTransformation(extent={{-110,90},{-90,110}})));
      Modelica.Fluid.Interfaces.FluidPort_a secRet(redeclare package Medium =
            Medium) "Return (inlet) of secondary circuit"
        annotation (Placement(transformation(extent={{88,90},{108,110}}),
            iconTransformation(extent={{88,90},{108,110}})));
      Modelica.Blocks.Interfaces.RealOutput TemSup "Temperature of supply water"
        annotation (Placement(transformation(extent={{98,60},{118,80}}),
            iconTransformation(extent={{98,60},{118,80}})));
      Modelica.Blocks.Interfaces.RealOutput TemRet
        "Temperature of the returning water"
        annotation (Placement(transformation(extent={{98,40},{118,60}}),
            iconTransformation(extent={{98,40},{118,60}})));
      Modelica.Blocks.Interfaces.RealOutput Ene(final unit="J") "Accumulated Energy"
        annotation (Placement(transformation(extent={{98,0},{118,20}}),
            iconTransformation(extent={{98,0},{118,20}})));
      Modelica.Blocks.Interfaces.RealOutput Pow(final unit="W") "Instant Power"
        annotation (Placement(transformation(extent={{98,20},{118,40}}),
            iconTransformation(extent={{98,20},{118,40}})));
    Buildings.Fluid.Actuators.Valves.TwoWayLinear   valCoil(
        redeclare package Medium = Medium,
        allowFlowReversal=false,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
        m_flow_nominal=m_flow_nominal,
        dpValve_nominal=dpValve_nominal,
        y_start=0,
        dpFixed_nominal=dpFixed_nominal)
                         annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={40,-20})));
      Buildings.Fluid.Sensors.TemperatureTwoPort senTemCoiRet(
        redeclare package Medium = Medium,
        allowFlowReversal=false,
        m_flow_nominal=m_flow_nominal)
        "Sensor for AHU heating coil return water temperature" annotation (
          Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=-90,
            origin={40,-72})));
      Buildings.Fluid.FixedResistances.PressureDrop res(
        redeclare package Medium = Medium,
        allowFlowReversal=false,
        m_flow_nominal=m_flow_nominal_bypass,
        dp_nominal=dpValve_nominal + dpFixed_nominal + dpExternal_nominal)
        annotation (Placement(transformation(extent={{-4,-58},{6,-38}})));
    Buildings.Fluid.FixedResistances.Junction junSup(
        redeclare package Medium = Medium,
        portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
        portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
        portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
        m_flow_nominal={m_flow_nominal,-m_flow_nominal,-m_flow_nominal_bypass},
        dp_nominal={0,0,0},
        energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
        annotation (Placement(transformation(
            extent={{8,8},{-8,-8}},
            rotation=-90,
            origin={-40,-48})));
    Buildings.Fluid.FixedResistances.Junction junRet(
        redeclare package Medium = Medium,
        dp_nominal={0,0,0},
        portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
        portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
        portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
        m_flow_nominal={m_flow_nominal,-m_flow_nominal,m_flow_nominal_bypass},
        energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
        annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=-90,
            origin={40,-48})));
      Buildings.Controls.Continuous.LimPID conPIDcoil(
        Ti=300,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.01)
        annotation (Placement(transformation(extent={{-68,-12},{-52,-28}})));
      Modelica.Fluid.Interfaces.FluidPort_a priSup(redeclare package Medium =
            Medium)                                "Primary inlet"
        annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_b priRet(redeclare package Medium =
            Medium)                                "Primary outlet"
        annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
      parameter Modelica.SIunits.MassFlowRate m_flow_nominal
        "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dpValve_nominal=5000
        "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dpFixed_nominal=0
        "Pressure drop of pipe and other resistances that are in series"
        annotation (Dialog(group="Nominal condition"));
        parameter Modelica.SIunits.PressureDifference dpExternal_nominal=0
        "Pressure drop of external components in secondary circuit"
        annotation (Dialog(group="Nominal condition"));
      Modelica.Blocks.Interfaces.RealInput TemSet
        "Connector of setpoint temperature"
        annotation (Placement(transformation(extent={{-120,-40},{-80,0}})));
      Modelica.Blocks.Interfaces.RealInput TemMea
        "Connector of measurement temperature"
        annotation (Placement(transformation(extent={{-120,-6},{-80,34}})));
      parameter Modelica.SIunits.MassFlowRate m_flow_nominal_bypass=m_flow_nominal/
          1000 "Nominal mass flow rate";
    equation
      connect(senEntFloSup.H_flow,energyDiffCalc. H_flowSup) annotation (Line(
            points={{-29,18},{-26,18},{-26,3.6},{-4,3.6}},       color={0,0,127}));
      connect(energyDiffCalc.H_flowRet,senEntFloRet. H_flow) annotation (Line(
            points={{0,3.6},{8,3.6},{8,4},{16,4},{16,20},{29,20}},
                                                              color={0,0,127}));
      connect(senEntFloSup.port_b,senTemSup. port_a)
        annotation (Line(points={{-40,28},{-40,48}},   color={0,127,255}));
      connect(senTemRet.port_b,senEntFloRet. port_a)
        annotation (Line(points={{40,46},{40,30}},   color={0,127,255}));
      connect(senTemSup.port_b,secSup)
        annotation (Line(points={{-40,68},{-82,68},{-82,100},{-100,100}},
                                                       color={0,127,255}));
      connect(senTemRet.port_a,secRet)
        annotation (Line(points={{40,66},{88,66},{88,100},{98,100}},
                                                     color={0,127,255}));
      connect(senTemSup.T,TemSup)  annotation (Line(points={{-51,58},{-54,58},{-54,70},
              {108,70}},           color={0,0,127}));
      connect(senTemRet.T,TemRet)  annotation (Line(points={{51,56},{80,56},{80,50},
              {108,50}},       color={0,0,127}));
      connect(energyDiffCalc.Energy,Ene)  annotation (Line(points={{0,24.6},{0,32},{
              92,32},{92,10},{108,10}},      color={0,0,127}));
      connect(energyDiffCalc.Power,Pow)  annotation (Line(points={{-4,24.6},{-4,34},
              {92,34},{92,30},{108,30}},                                      color=
             {0,0,127}));
      connect(conPIDcoil.y, valCoil.y) annotation (Line(points={{-51.2,-20},{28,-20}},
                                     color={0,0,127}));
      connect(senEntFloRet.port_b, valCoil.port_a)
        annotation (Line(points={{40,10},{40,-10}}, color={0,127,255}));
      connect(junRet.port_2, senTemCoiRet.port_a)
        annotation (Line(points={{40,-56},{40,-62}}, color={0,127,255}));
      connect(res.port_b, junRet.port_3)
        annotation (Line(points={{6,-48},{32,-48}}, color={0,127,255}));
      connect(valCoil.port_b, junRet.port_1)
        annotation (Line(points={{40,-30},{40,-40}}, color={0,127,255}));
      connect(junSup.port_2, senEntFloSup.port_a)
        annotation (Line(points={{-40,-40},{-40,8}}, color={0,127,255}));
      connect(junSup.port_3, res.port_a)
        annotation (Line(points={{-32,-48},{-4,-48}}, color={0,127,255}));
      connect(junSup.port_1, priSup) annotation (Line(points={{-40,-56},{-40,-100},{
              -100,-100}}, color={0,127,255}));
      connect(senTemCoiRet.port_b, priRet) annotation (Line(points={{40,-82},{40,-100},
              {100,-100}}, color={0,127,255}));
      connect(conPIDcoil.u_s, TemSet)
        annotation (Line(points={{-69.6,-20},{-100,-20}}, color={0,0,127}));
      connect(conPIDcoil.u_m, TemMea) annotation (Line(points={{-60,-10.4},{-60,14},
              {-100,14}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={205,205,205},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-96,-100},{-38,-100},{-38,99.8262},{-98,100}},
              color={28,108,200},
              thickness=0.5),
            Line(
              points={{102,100},{42,100},{42,-100},{102,-100}},
              color={28,108,200},
              thickness=0.5),
            Line(
              points={{-38,-36},{42,-36}},
              color={28,108,200},
              thickness=0.5),
            Polygon(
              points={{24,-10},{62,-10},{42,14},{24,-10}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{42,14},{60,40},{24,40},{42,14}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-7,-2},{3,14},{-17,14},{-7,-2}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              origin={0,-29},
              rotation=90),
            Polygon(
              points={{7,2},{-3,-14},{17,-14},{7,2}},
              lineColor={28,108,200},
              lineThickness=0.5,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              origin={4,-43},
              rotation=90)}),                                        Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end TwoWayHeatBattery;

    model AHUPresHHB
      "AHU with supply pressure control and hydronic heating battery"

      parameter Modelica.SIunits.MassFlowRate m_flow_nominal_air=20
        "Nominal mass flow rate - air"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.MassFlowRate m_flow_nominal_water=2
        "Nominal mass flow rate - water"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dp_nominal_ext(displayUnit="Pa")=
           0 "External pressure drop at nominal flow"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dp_nominal_rotHex(displayUnit="Pa")=
           150 "Rotary heat exchanger nominal pressure drop"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dp_nominal_coilAir(displayUnit="Pa")=
           200 "nominal pressure drop air in coil"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dp_nominal_coilWat(displayUnit="Pa")=
           15000 "Nominal pressure drop water in coil"
        annotation (Dialog(group="Nominal condition"));
      parameter Real eps_nominal_rotHex=0.80
        "Nominal heat transfer effectiveness for rotary wheel"
        annotation (Dialog(group="Nominal thermal performance"));
      parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal_coil=250000
        "Nominal heat flow rate for coil"
        annotation (Dialog(group="Nominal thermal performance"));
      parameter Modelica.SIunits.Temperature T_in_air_nominal_coil=287.15
        "Nominal air temperature at coil inlet "
        annotation (Dialog(group="Nominal thermal performance"));
      parameter Modelica.SIunits.Temperature T_in_wat_nominal_coil=328.15
        "Nominal water temperature at port coil inlet"
        annotation (Dialog(group="Nominal thermal performance"));

        Buildings.Fluid.Movers.SpeedControlled_y fanSu(
        per(
          pressure(V_flow={2.08,3.25,3.9,4.55}, dp={800,680,408,100}),
          use_powerCharacteristic=true,
          power(V_flow(displayUnit="m3/h") = {2.08,3.25,3.9,4.55}, P(displayUnit=
                  "kW") = {2340,3250,3600,3900})),
          addPowerToMedium=false,
          redeclare package Medium = Air,
        allowFlowReversal=false,
        energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        y_start=0.7)
          annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
        Buildings.Fluid.Sensors.VolumeFlowRate senVolFloIn(
                                                     redeclare package Medium = Air,
          m_flow_nominal=m_flow_nominal_air,
        allowFlowReversal=false)
          annotation (Placement(transformation(extent={{78,-50},{98,-30}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn2(
                                                            redeclare package
          Medium =
              Air,
          m_flow_nominal=m_flow_nominal_air,
        allowFlowReversal=false)
          annotation (Placement(transformation(extent={{-36,-50},{-16,-30}})));
      ControlledEffectivenessNTU hex(
        redeclare package Medium1 = Air,
        redeclare package Medium2 = Air,
        allowFlowReversal1=false,
        allowFlowReversal2=false,
        m1_flow_nominal=m_flow_nominal_air,
        m2_flow_nominal=m_flow_nominal_air,
        dp1_nominal=dp_nominal_rotHex,
        dp2_nominal=dp_nominal_rotHex,
        linearizeFlowResistance1=true,
        linearizeFlowResistance2=true,
        eps_nominal=eps_nominal_rotHex)
        annotation (Placement(transformation(extent={{-46,-10},{-66,10}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTemEx1(
                                                            redeclare package
          Medium =
              Air,
          m_flow_nominal=m_flow_nominal_air,
        allowFlowReversal=false)
          annotation (Placement(transformation(extent={{-18,30},{-38,50}})));
        Buildings.Fluid.Sensors.VolumeFlowRate senVolFloEx(
                                                     redeclare package Medium = Air,
          allowFlowReversal=false,
          m_flow_nominal=m_flow_nominal_air)
          annotation (Placement(transformation(extent={{48,30},{28,50}})));
        Buildings.Fluid.Sensors.Pressure senPreIn(redeclare package Medium = Air)
          annotation (Placement(transformation(extent={{132,-40},{152,-20}})));
        Buildings.Fluid.Sensors.Pressure senPreEx(redeclare package Medium = Air)
          annotation (Placement(transformation(extent={{102,40},{122,60}})));
        Buildings.Fluid.Movers.SpeedControlled_y fanEx(
        per(
          pressure(V_flow={2.08,3.25,3.9,4.55}, dp={800,680,408,100}),
          use_powerCharacteristic=true,
          power(V_flow(displayUnit="m3/h") = {2.08,3.25,3.9,4.55}, P(displayUnit=
                  "kW") = {2340,3250,3600,3900})),
          addPowerToMedium=false,
          redeclare package Medium = Air,
        allowFlowReversal=false,
        energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        y_start=0.7)
          annotation (Placement(transformation(extent={{-68,30},{-88,50}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTemEx2(
                                                            redeclare package
          Medium =
              Air,
          allowFlowReversal=false,
          m_flow_nominal=m_flow_nominal_air)
          annotation (Placement(transformation(extent={{-96,30},{-116,50}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn1(
                                                            redeclare package
          Medium =
              Air,
          m_flow_nominal=m_flow_nominal_air,
        allowFlowReversal=false)
          annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn3(
                                                            redeclare package
          Medium =
              Air,
          m_flow_nominal=m_flow_nominal_air,
        allowFlowReversal=false)
          annotation (Placement(transformation(extent={{108,-50},{128,-30}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium = Air)
          annotation (Placement(transformation(extent={{150,-50},{170,-30}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium = Air)
          annotation (Placement(transformation(extent={{150,30},{170,50}})));
        Modelica.Blocks.Interfaces.RealInput y annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=-90,
              origin={-60,110})));
        replaceable package Air = Buildings.Media.Air(extraPropertiesNames={"CO2"}) constrainedby
        Modelica.Media.Interfaces.PartialMedium;
        replaceable package Water = Buildings.Media.Water constrainedby
        Modelica.Media.Interfaces.PartialMedium;
        Modelica.Blocks.Interfaces.RealOutput qel annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={-100,-106})));
        Modelica.Blocks.Math.Add add
          annotation (Placement(transformation(extent={{-72,-84},{-92,-64}})));
        Buildings.Fluid.Sources.Outside outEx(nPorts=1, redeclare package Medium =
              Air,
        use_C_in=true)
          annotation (Placement(transformation(extent={{-140,30},{-120,50}})));
        Buildings.Fluid.Sources.Outside outSu(nPorts=1, redeclare package Medium =
              Air,
        use_C_in=true)
          annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));
        Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
              transformation(extent={{-180,-22},{-140,18}}), iconTransformation(
                extent={{-160,84},{-140,104}})));
        Buildings.Fluid.HeatExchangers.DryCoilEffectivenessNTU
                                                             coil(redeclare
          package Medium1 =
                      Air,
          redeclare package Medium2 = Water,
          m1_flow_nominal=m_flow_nominal_air,
          m2_flow_nominal=m_flow_nominal_water,
        allowFlowReversal1=false,
        allowFlowReversal2=false,
        dp1_nominal=dp_nominal_coilAir,
        linearizeFlowResistance1=true,
        linearizeFlowResistance2=true,
        dp2_nominal=dp_nominal_coilWat,
        configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
        use_Q_flow_nominal=true,
        Q_flow_nominal=-Q_flow_nominal_coil,
        T_a1_nominal=T_in_air_nominal_coil,
        T_a2_nominal=T_in_wat_nominal_coil)
          annotation (Placement(transformation(extent={{50,-56},{70,-36}})));

        Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
              Water)
          annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
              Water)
          annotation (Placement(transformation(extent={{30,-110},{50,-90}})));

        Modelica.Blocks.Interfaces.RealOutput Tsu annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={166,-80})));
      Modelica.Blocks.Sources.Constant cCO2(k=0.00064)
        annotation (Placement(transformation(extent={{-98,-10},{-118,10}})));
      Buildings.Fluid.FixedResistances.PressureDrop resEx(
        redeclare package Medium = Air,
        m_flow_nominal=m_flow_nominal_air,
        dp_nominal=150,
        allowFlowReversal=false)
        annotation (Placement(transformation(extent={{90,30},{70,50}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTemCoilIn(
        allowFlowReversal=false,
        redeclare package Medium = Water,
        m_flow_nominal=m_flow_nominal_water)
        annotation (Placement(transformation(extent={{94,-82},{74,-62}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite oveFanRet(description=
            "AHU return fan speed control signal", u(
          min=0,
          max=1,
          unit="1")) "Overwirte for return fan speed control signal"
        annotation (Placement(transformation(extent={{-28,70},{-48,90}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite oveFanSupPre(description=
            "AHU supply fan pressure control signal", u(
          min=0,
          max=1,
          unit="1")) "Overwrite for supply fan speed control signal" annotation (
          Placement(transformation(
            extent={{8,-8},{-8,8}},
            rotation=90,
            origin={-60,52})));
      Buildings.Utilities.IO.SignalExchange.Read reaTSupAir(
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
        y(unit="K"),
        description="AHU supply air temperature") "Read supply air temperature"
        annotation (Placement(transformation(
            extent={{7,-7},{-7,7}},
            rotation=90,
            origin={131,-65})));

      Buildings.Utilities.IO.SignalExchange.Read reaTRetAir(
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
        y(unit="K"),
        description="AHU return air temperature") "Read returrn air temperature"
        annotation (Placement(transformation(
            extent={{6,6},{-6,-6}},
            rotation=180,
            origin={-18,58})));

      Buildings.Utilities.IO.SignalExchange.Read reaFloSupAir(
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
        y(unit="m3/s"),
        description="AHU supply air volume flowrate")
        "Read supply air mass flow rate" annotation (Placement(transformation(
            extent={{6,6},{-6,-6}},
            rotation=180,
            origin={130,8})));

      Buildings.Utilities.IO.SignalExchange.Read reaTCoiSup(
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
        y(unit="K"),
        description="AHU heating coil supply water temperature")
        "Read heating coil supply water temperature" annotation (Placement(
            transformation(
            extent={{6,6},{-6,-6}},
            rotation=180,
            origin={120,-90})));

      Buildings.Utilities.IO.SignalExchange.Read reaTHeaRec(
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
        y(unit="K"),
        description=
            "AHU air temperature exiting heat recovery in supply air stream")
        "Read air temperature exiting heat recovery in supply air stream"
        annotation (Placement(transformation(
            extent={{6,6},{-6,-6}},
            rotation=180,
            origin={8,-12})));

      Buildings.Controls.Continuous.LimPID conPID(controllerType=Modelica.Blocks.Types.SimpleController.PID,
        k=10,
          initType=Modelica.Blocks.Types.InitPID.InitialState)
        annotation (Placement(transformation(extent={{-12,-8},{-32,12}})));
      Modelica.Blocks.Interfaces.RealInput TsupSet
        "Supply temperature setpoint for rotary wheel control" annotation (
          Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={-4,110})));
      Buildings.Utilities.IO.SignalExchange.Read reaFloExtAir(
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
        y(unit="m3/s"),
        description="AHU extract air volume flowrate")
        "Read extract air volume flow rate" annotation (Placement(transformation(
            extent={{6,6},{-6,-6}},
            rotation=180,
            origin={64,60})));

      Buildings.Controls.Continuous.LimPID conPIDfanExt(
        Td=300,
        Ti=10,
        k=0.05,
        yMin=0.2,
        initType=Modelica.Blocks.Types.InitPID.InitialOutput,
        xi_start=0,
        xd_start=0,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        y_start=1,
        reverseActing=true)
        annotation (Placement(transformation(extent={{22,70},{2,90}})));

      Buildings.Controls.Continuous.LimPID conPIDfanExt1(
        Td=300,
        Ti=10,
        k=0.005,
        yMin=0.2,
        initType=Modelica.Blocks.Types.InitPID.InitialState,
        xi_start=0,
        xd_start=0,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        reverseActing=true)
        annotation (Placement(transformation(extent={{56,-8},{40,8}})));
      Modelica.Blocks.Math.Add dpSup(k1=-1, k2=+1) "Pressure rise across AHU"
        annotation (Placement(transformation(
            extent={{-6,-6},{6,6}},
            rotation=90,
            origin={48,-20})));

      Buildings.Utilities.IO.SignalExchange.Overwrite oveFanSup(description=
            "AHU supply fan speed control signal", u(
          min=0,
          max=1,
          unit="1")) "Overwrite for supply fan speed control signal" annotation (
          Placement(transformation(
            extent={{6,-6},{-6,6}},
            rotation=0,
            origin={26,0})));
    equation
        connect(fanSu.port_a, senTemIn2.port_b)
          annotation (Line(points={{-10,-40},{-16,-40}}, color={0,127,255}));
        connect(senTemIn2.port_a, hex.port_b2) annotation (Line(points={{-36,-40},{
                -40,-40},{-40,-6},{-46,-6}}, color={0,127,255}));
        connect(senTemEx1.port_b, hex.port_a1) annotation (Line(points={{-38,40},
              {-44,40},{-44,6},{-46,6}},  color={0,127,255}));
        connect(hex.port_a2, senTemIn1.port_b) annotation (Line(points={{-66,-6},{-72,
                -6},{-72,-40},{-80,-40}},     color={0,127,255}));
        connect(senPreIn.port, senTemIn3.port_b)
          annotation (Line(points={{142,-40},{128,-40}}, color={0,127,255}));
        connect(senPreEx.port, port_a1)
          annotation (Line(points={{112,40},{160,40}}, color={0,127,255}));
        connect(senPreIn.port, port_b1) annotation (Line(points={{142,-40},{160,-40}},
                                      color={0,127,255}));
        connect(add.y, qel) annotation (Line(points={{-93,-74},{-100,-74},{-100,
              -106}},
              color={0,0,127}));
        connect(senTemEx2.port_b, outEx.ports[1])
          annotation (Line(points={{-116,40},{-120,40}}, color={0,127,255}));
        connect(senTemIn1.port_a, outSu.ports[1])
          annotation (Line(points={{-100,-40},{-120,-40}}, color={0,127,255}));
        connect(weaBus, outEx.weaBus) annotation (Line(
            points={{-160,-2},{-150,-2},{-150,4},{-140,4},{-140,40.2}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-6,3},{-6,3}}));
        connect(weaBus, outSu.weaBus) annotation (Line(
            points={{-160,-2},{-150,-2},{-150,-6},{-140,-6},{-140,-39.8}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-6,3},{-6,3}}));
      connect(cCO2.y, outEx.C_in[1]) annotation (Line(points={{-119,0},{-146,0},{-146,
              32},{-142,32}}, color={0,0,127}));
      connect(cCO2.y, outSu.C_in[1]) annotation (Line(points={{-119,0},{-146,0},{-146,
              -48},{-142,-48}}, color={0,0,127}));
      connect(senVolFloEx.port_a, resEx.port_b)
        annotation (Line(points={{48,40},{70,40}}, color={0,127,255}));
      connect(resEx.port_a, senPreEx.port)
        annotation (Line(points={{90,40},{112,40}}, color={0,127,255}));
      connect(port_a2, senTemCoilIn.port_a) annotation (Line(points={{100,-100},{100,
              -72},{94,-72}}, color={0,127,255}));
      connect(senTemCoilIn.port_b,coil. port_a2)
        annotation (Line(points={{74,-72},{70,-72},{70,-52}}, color={0,127,255}));
      connect(y, oveFanSupPre.u)
        annotation (Line(points={{-60,110},{-60,61.6}}, color={0,0,127}));
      connect(senTemIn3.T, reaTSupAir.u) annotation (Line(points={{118,-29},{118,
              -20},{131,-20},{131,-56.6}}, color={0,0,127}));
      connect(reaTSupAir.y, Tsu) annotation (Line(points={{131,-72.7},{131,-80},{
              166,-80}}, color={0,0,127}));
      connect(senTemEx1.T, reaTRetAir.u) annotation (Line(points={{-28,51},{-28,58},
              {-25.2,58}},                    color={0,0,127}));
      connect(senTemCoilIn.T, reaTCoiSup.u) annotation (Line(points={{84,-61},{92,
              -61},{92,-60},{106,-60},{106,-90},{112.8,-90}}, color={0,0,127}));
      connect(coil.port_b2, port_b2) annotation (Line(points={{50,-52},{40,-52},{40,
              -100}},    color={0,127,255}));
      connect(senTemIn2.T, reaTHeaRec.u) annotation (Line(points={{-26,-29},{-26,-26},
              {-6,-26},{-6,-12},{0.8,-12}},       color={0,0,127}));
      connect(oveFanRet.y, fanEx.y)
        annotation (Line(points={{-49,80},{-78,80},{-78,52}},
                                                            color={0,0,127}));
      connect(fanEx.port_b, senTemEx2.port_a)
        annotation (Line(points={{-88,40},{-96,40}}, color={0,127,255}));
      connect(fanEx.port_a, hex.port_b1) annotation (Line(points={{-68,40},{-62,40},
              {-62,14},{-70,14},{-70,6},{-66,6}}, color={0,127,255}));
      connect(senTemEx1.port_a, senVolFloEx.port_b)
        annotation (Line(points={{-18,40},{28,40}}, color={0,127,255}));
      connect(senTemIn2.T, conPID.u_m) annotation (Line(points={{-26,-29},{-26,-26},
              {-6,-26},{-6,-18},{-22,-18},{-22,-10}}, color={0,0,127}));
      connect(conPID.y, hex.rel_eps_contr) annotation (Line(points={{-33,2},{-38,2},
              {-38,14},{-56,14},{-56,8.8}}, color={0,0,127}));
      connect(conPID.u_s, TsupSet)
        annotation (Line(points={{-10,2},{-4,2},{-4,110}}, color={0,0,127}));
      connect(reaFloSupAir.u, senVolFloIn.V_flow)
        annotation (Line(points={{122.8,8},{88,8},{88,-29}},color={0,0,127}));
      connect(senTemIn3.port_a, senVolFloIn.port_b)
        annotation (Line(points={{108,-40},{98,-40}}, color={0,127,255}));
      connect(senVolFloIn.port_a,coil. port_b1)
        annotation (Line(points={{78,-40},{70,-40}}, color={0,127,255}));
      connect(coil.port_a1, fanSu.port_b)
        annotation (Line(points={{50,-40},{10,-40}}, color={0,127,255}));
      connect(senVolFloEx.V_flow, reaFloExtAir.u)
        annotation (Line(points={{38,51},{38,60},{56.8,60}}, color={0,0,127}));
      connect(conPIDfanExt.y, oveFanRet.u)
        annotation (Line(points={{1,80},{-26,80}}, color={0,0,127}));
      connect(senVolFloEx.V_flow, conPIDfanExt.u_m) annotation (Line(points={{38,51},
              {38,62},{12,62},{12,68}}, color={0,0,127}));
      connect(conPIDfanExt.u_s, senVolFloIn.V_flow) annotation (Line(points={{24,80},
              {100,80},{100,8},{88,8},{88,-29}}, color={0,0,127}));
      connect(add.u1, fanEx.P) annotation (Line(points={{-70,-68},{-64,-68},{-64,
              -26},{-84,-26},{-84,26},{-92,26},{-92,49},{-89,49}}, color={0,0,127}));
      connect(fanSu.P, add.u2) annotation (Line(points={{11,-31},{22,-31},{22,-80},
              {-70,-80}}, color={0,0,127}));
      connect(oveFanSupPre.y, conPIDfanExt1.u_s) annotation (Line(points={{-60,43.2},
              {-58,43.2},{-58,22},{68,22},{68,0},{57.6,0}}, color={0,0,127}));
      connect(senPreIn.p, dpSup.u2) annotation (Line(points={{153,-30},{158,-30},{158,
              -14},{104,-14},{104,-27.2},{51.6,-27.2}}, color={0,0,127}));
      connect(weaBus.pAtm, dpSup.u1) annotation (Line(
          points={{-160,-2},{-124,-2},{-124,-22},{14,-22},{14,-32},{44.4,-32},{44.4,
              -27.2}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(dpSup.y, conPIDfanExt1.u_m)
        annotation (Line(points={{48,-13.4},{48,-9.6}}, color={0,0,127}));
      connect(conPIDfanExt1.y, oveFanSup.u)
        annotation (Line(points={{39.2,0},{33.2,0}}, color={0,0,127}));
      connect(oveFanSup.y, fanSu.y) annotation (Line(points={{19.4,0},{16,0},{16,
              -26},{6,-26},{6,-28},{0,-28}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
                  -100},{160,100}}), graphics={
              Rectangle(
                extent={{-160,100},{160,-100}},
                lineColor={28,108,200},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(extent={{-20,60},{20,20}}, lineColor={28,108,200}),
              Line(points={{12,56},{12,24},{-20,40},{12,56}}, color={28,108,200}),
              Ellipse(extent={{-20,-20},{20,-60}}, lineColor={28,108,200}),
              Line(points={{-12,-24},{-12,-56},{20,-40},{-12,-24}}, color={28,108,200}),
              Line(points={{20,-40},{150,-40}}, color={28,108,200}),
              Line(points={{-20,-40},{-150,-40}}, color={28,108,200}),
              Line(points={{-150,40},{-20,40}}, color={28,108,200}),
              Line(points={{20,40},{150,40}}, color={28,108,200}),
              Line(points={{-82,40},{-122,-40}}, color={28,108,200}),
              Line(points={{-122,40},{-82,-40}}, color={28,108,200}),
              Rectangle(
                extent={{62,-20},{82,-60}},
                lineColor={28,108,200},
                fillColor={238,46,47},
                fillPattern=FillPattern.Solid),
              Line(points={{0,72},{0,60}}, color={0,0,0}),
              Line(points={{-60,90},{-60,-10},{0,-10},{0,-20}},
                                                            color={0,0,0}),
              Line(points={{0,72},{-60,72}}, color={0,0,0}),
              Line(
                points={{2,-60},{2,-74},{-100,-74},{-100,-96}},
                color={0,0,0},
                pattern=LinePattern.Dash),
              Line(
                points={{0,20},{0,12},{-40,12},{-40,-74}},
                color={0,0,0},
                pattern=LinePattern.Dash),
              Line(points={{-150,44},{-150,36}}, color={28,108,200}),
              Line(points={{-150,-36},{-150,-44}}, color={28,108,200}),
              Line(points={{100,-90},{100,-54},{82,-54}}, color={238,46,47}),
              Line(points={{62,-54},{40,-54},{40,-90}}, color={28,108,200}),
              Line(
                points={{156,-80},{130,-80},{130,-40}},
                color={0,140,72},
                pattern=LinePattern.Dash)}),
                                      Diagram(coordinateSystem(preserveAspectRatio=
                  false, extent={{-160,-100},{160,100}})),
        experiment(
          StartTime=3240000,
          StopTime=3960000,
          Interval=600.0012,
          Tolerance=1e-05,
          __Dymola_Algorithm="Cvode"));
    end AHUPresHHB;

    model AHUSpeedHHB
      "AHU with supply speed control and hydronic heating battery"

      parameter Modelica.SIunits.MassFlowRate m_flow_nominal_air=20
        "Nominal mass flow rate - air"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.MassFlowRate m_flow_nominal_water=2
        "Nominal mass flow rate - water"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dp_nominal_ext(displayUnit="Pa")=
           0 "External pressure drop at nominal flow"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dp_nominal_rotHex(displayUnit="Pa")=
           150 "Rotary heat exchanger nominal pressure drop"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dp_nominal_coilAir(displayUnit="Pa")=
           200 "nominal pressure drop air in coil"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dp_nominal_coilWat(displayUnit="Pa")=
           15000 "Nominal pressure drop water in coil"
        annotation (Dialog(group="Nominal condition"));
      parameter Real eps_nominal_rotHex=0.80
        "Nominal heat transfer effectiveness for rotary wheel"
        annotation (Dialog(group="Nominal thermal performance"));
      parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal_coil=250000
        "Nominal heat flow rate for coil"
        annotation (Dialog(group="Nominal thermal performance"));
      parameter Modelica.SIunits.Temperature T_in_air_nominal_coil=287.15
        "Nominal air temperature at coil inlet "
        annotation (Dialog(group="Nominal thermal performance"));
      parameter Modelica.SIunits.Temperature T_in_wat_nominal_coil=328.15
        "Nominal water temperature at port coil inlet"
        annotation (Dialog(group="Nominal thermal performance"));

        Buildings.Fluid.Movers.SpeedControlled_y fanSu(
        per(
          pressure(V_flow={2.08,3.25,3.9,4.55}, dp={800,680,408,100}),
          use_powerCharacteristic=true,
          power(V_flow(displayUnit="m3/h") = {2.08,3.25,3.9,4.55}, P(displayUnit=
                  "kW") = {2340,3250,3600,3900})),
          addPowerToMedium=false,
          redeclare package Medium = Air,
        allowFlowReversal=true,
        energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        riseTime=30,
        y_start=0.1)
          annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn2(
                                                            redeclare package
          Medium =
              Air,
          m_flow_nominal=m_flow_nominal_air,
        allowFlowReversal=false)
          annotation (Placement(transformation(extent={{-36,-50},{-16,-30}})));
      ControlledEffectivenessNTU hex(
        redeclare package Medium1 = Air,
        redeclare package Medium2 = Air,
        allowFlowReversal1=false,
        allowFlowReversal2=false,
        m1_flow_nominal=m_flow_nominal_air,
        m2_flow_nominal=m_flow_nominal_air,
        dp1_nominal=dp_nominal_rotHex,
        dp2_nominal=dp_nominal_rotHex,
        linearizeFlowResistance1=true,
        linearizeFlowResistance2=true,
        eps_nominal=eps_nominal_rotHex)
        annotation (Placement(transformation(extent={{-46,-10},{-66,10}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTemEx1(
                                                            redeclare package
          Medium =
              Air,
          m_flow_nominal=m_flow_nominal_air,
        allowFlowReversal=false)
          annotation (Placement(transformation(extent={{-18,30},{-38,50}})));
        Buildings.Fluid.Sensors.Pressure senPreIn(redeclare package Medium = Air)
          annotation (Placement(transformation(extent={{136,-36},{156,-16}})));
        Buildings.Fluid.Sensors.Pressure senPreEx(redeclare package Medium = Air)
          annotation (Placement(transformation(extent={{102,40},{122,60}})));
        Buildings.Fluid.Movers.SpeedControlled_y fanEx(
        per(
          pressure(V_flow={2.08,3.25,3.9,4.55}, dp={800,680,408,100}),
          use_powerCharacteristic=true,
          power(V_flow(displayUnit="m3/h") = {2.08,3.25,3.9,4.55}, P(displayUnit=
                  "kW") = {2340,3250,3600,3900})),
          addPowerToMedium=false,
          redeclare package Medium = Air,
        allowFlowReversal=true,
        energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
        riseTime=30,
        y_start=0.1)
          annotation (Placement(transformation(extent={{-68,30},{-88,50}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTemEx2(
                                                            redeclare package
          Medium =
              Air,
          allowFlowReversal=false,
          m_flow_nominal=m_flow_nominal_air)
          annotation (Placement(transformation(extent={{-96,30},{-116,50}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn1(
                                                            redeclare package
          Medium =
              Air,
          m_flow_nominal=m_flow_nominal_air,
        allowFlowReversal=false)
          annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTemIn3(
                                                            redeclare package
          Medium =
              Air,
          m_flow_nominal=m_flow_nominal_air,
        allowFlowReversal=false)
          annotation (Placement(transformation(extent={{86,-46},{106,-26}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium
          =                                                                      Air)
          annotation (Placement(transformation(extent={{150,-46},{170,-26}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium
          =                                                                      Air)
          annotation (Placement(transformation(extent={{150,30},{170,50}})));
        Modelica.Blocks.Interfaces.RealInput CO2SetPoi annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={-140,110})));
        replaceable package Air = Buildings.Media.Air(extraPropertiesNames={"CO2"}) constrainedby
        Modelica.Media.Interfaces.PartialMedium;
        replaceable package Water = Buildings.Media.Water constrainedby
        Modelica.Media.Interfaces.PartialMedium;
        Modelica.Blocks.Interfaces.RealOutput qel annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=-90,
              origin={-100,-106})));
        Modelica.Blocks.Math.Add add
          annotation (Placement(transformation(extent={{-72,-84},{-92,-64}})));
        Buildings.Fluid.Sources.Outside outEx(nPorts=1, redeclare package
          Medium =
              Air,
        use_C_in=true)
          annotation (Placement(transformation(extent={{-140,30},{-120,50}})));
        Buildings.Fluid.Sources.Outside outSu(nPorts=1, redeclare package
          Medium =
              Air,
        use_C_in=true)
          annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));
        Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
              transformation(extent={{-180,-22},{-140,18}}), iconTransformation(
                extent={{-160,84},{-140,104}})));
        Buildings.Fluid.HeatExchangers.DryCoilEffectivenessNTU
                                                             coil(redeclare
          package Medium1 =
                      Air,
          redeclare package Medium2 = Water,
          m1_flow_nominal=m_flow_nominal_air,
          m2_flow_nominal=m_flow_nominal_water,
        allowFlowReversal1=false,
        allowFlowReversal2=false,
        dp1_nominal=dp_nominal_coilAir,
        linearizeFlowResistance1=true,
        linearizeFlowResistance2=true,
        dp2_nominal=dp_nominal_coilWat,
        configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
        use_Q_flow_nominal=true,
        Q_flow_nominal=-Q_flow_nominal_coil,
        T_a1_nominal=T_in_air_nominal_coil,
        T_a2_nominal=T_in_wat_nominal_coil)
          annotation (Placement(transformation(extent={{36,-52},{56,-32}})));

        Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium
          =   Water)
          annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium
          =   Water)
          annotation (Placement(transformation(extent={{30,-110},{50,-90}})));

        Modelica.Blocks.Interfaces.RealOutput Tsu annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={166,-80})));
      Modelica.Blocks.Sources.Constant cCO2(k=0.00064)
        annotation (Placement(transformation(extent={{-98,-10},{-118,10}})));
      Buildings.Fluid.FixedResistances.PressureDrop resEx(
        redeclare package Medium = Air,
        m_flow_nominal=m_flow_nominal_air,
        dp_nominal=150,
        allowFlowReversal=false)
        annotation (Placement(transformation(extent={{90,30},{70,50}})));
        Buildings.Fluid.Sensors.TemperatureTwoPort senTemCoilIn(
        allowFlowReversal=false,
        redeclare package Medium = Water,
        m_flow_nominal=m_flow_nominal_water)
        annotation (Placement(transformation(extent={{94,-82},{74,-62}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite oveFanRet(description=
            "AHU return fan speed control signal", u(
          min=0,
          max=1,
          unit="1")) "Overwirte for return fan speed control signal"
        annotation (Placement(transformation(extent={{-28,70},{-48,90}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite oveFanSupSpe(description=
            "AHU supply fan speed control signal", u(
          min=0,
          max=1,
          unit="1")) "Overwrite for supply fan speed control signal" annotation (
          Placement(transformation(
            extent={{8,-8},{-8,8}},
            rotation=90,
            origin={-54,40})));
      Buildings.Utilities.IO.SignalExchange.Read reaTSupAir(
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
        y(unit="K"),
        description="AHU supply air temperature") "Read supply air temperature"
        annotation (Placement(transformation(
            extent={{7,-7},{-7,7}},
            rotation=90,
            origin={131,-65})));

      Buildings.Utilities.IO.SignalExchange.Read reaTRetAir(
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
        y(unit="K"),
        description="AHU return air temperature") "Read returrn air temperature"
        annotation (Placement(transformation(
            extent={{6,6},{-6,-6}},
            rotation=180,
            origin={-18,58})));

      Buildings.Utilities.IO.SignalExchange.Read reaFloSupAir(
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
        y(unit="m3/s"),
        description="AHU supply air volume flowrate")
        "Read supply air mass flow rate" annotation (Placement(transformation(
            extent={{6,6},{-6,-6}},
            rotation=180,
            origin={130,8})));

      Buildings.Utilities.IO.SignalExchange.Read reaTCoiSup(
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
        y(unit="K"),
        description="AHU heating coil supply water temperature")
        "Read heating coil supply water temperature" annotation (Placement(
            transformation(
            extent={{6,6},{-6,-6}},
            rotation=180,
            origin={120,-90})));

      Buildings.Utilities.IO.SignalExchange.Read reaTHeaRec(
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
        y(unit="K"),
        description=
            "AHU air temperature exiting heat recovery in supply air stream")
        "Read air temperature exiting heat recovery in supply air stream"
        annotation (Placement(transformation(
            extent={{6,6},{-6,-6}},
            rotation=180,
            origin={8,-12})));

      Buildings.Controls.Continuous.LimPID conPIDhex(
        controllerType=Modelica.Blocks.Types.SimpleController.PID,
        k=0.5,
        Ti=300,
        initType=Modelica.Blocks.Types.InitPID.InitialState)
        annotation (Placement(transformation(extent={{-12,-8},{-32,12}})));
      Modelica.Blocks.Interfaces.RealInput TsupSet
        "Supply temperature setpoint for rotary wheel control" annotation (
          Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={-4,110})));
      Buildings.Utilities.IO.SignalExchange.Read reaFloExtAir(
        KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
        y(unit="m3/s"),
        description="AHU extract air volume flowrate")
        "Read extract air volume flow rate" annotation (Placement(transformation(
            extent={{6,6},{-6,-6}},
            rotation=180,
            origin={64,60})));

      Buildings.Controls.Continuous.LimPID conPIDfans(
        Td=300,
        Ti=300,
        k=0.5,
        yMin=0.001,
        initType=Modelica.Blocks.Types.InitPID.InitialState,
        xi_start=0,
        xd_start=0,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        reverseActing=true)
        annotation (Placement(transformation(extent={{56,-8},{40,8}})));

      Buildings.Utilities.IO.SignalExchange.Overwrite oveFanSup(description=
            "AHU supply fan speed control signal", u(
          min=0,
          max=1,
          unit="1")) "Overwrite for supply fan speed control signal" annotation (
          Placement(transformation(
            extent={{6,-6},{-6,6}},
            rotation=0,
            origin={26,0})));
      Buildings.Fluid.Sensors.MassFlowRate senMasFloSup(redeclare package
          Medium =                                                                 Air)
        annotation (Placement(transformation(extent={{62,-46},{82,-26}})));
      Buildings.Fluid.Sensors.MassFlowRate senMasFloExt(redeclare package
          Medium =                                                                 Air) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={38,40})));
      Modelica.Blocks.Interfaces.RealInput CO2meas
        "Measured CO2 from zone for independent VAV system " annotation (
          Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={38,110})));
      Buildings.Controls.Continuous.LimPID conPIDCO2(
        controllerType=Modelica.Blocks.Types.SimpleController.PID,
        k=0.5,
        Ti=300,
        yMax=(1800*1.2)/3600,
        yMin=(300*1.2)/3600,
        initType=Modelica.Blocks.Types.InitPID.InitialState,
        reverseActing=false) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-108,74})));
      Buildings.Fluid.FixedResistances.PressureDrop resSup(
        redeclare package Medium = Air,
        m_flow_nominal=m_flow_nominal_air,
        dp_nominal=150,
        allowFlowReversal=false)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=180,
            origin={122,-36})));
    equation
        connect(fanSu.port_a, senTemIn2.port_b)
          annotation (Line(points={{-10,-40},{-16,-40}}, color={0,127,255}));
        connect(senTemIn2.port_a, hex.port_b2) annotation (Line(points={{-36,-40},{
                -40,-40},{-40,-6},{-46,-6}}, color={0,127,255}));
        connect(senTemEx1.port_b, hex.port_a1) annotation (Line(points={{-38,40},
              {-44,40},{-44,6},{-46,6}},  color={0,127,255}));
        connect(hex.port_a2, senTemIn1.port_b) annotation (Line(points={{-66,-6},{-72,
                -6},{-72,-40},{-80,-40}},     color={0,127,255}));
        connect(senPreEx.port, port_a1)
          annotation (Line(points={{112,40},{160,40}}, color={0,127,255}));
        connect(senPreIn.port, port_b1) annotation (Line(points={{146,-36},{160,
              -36}},                  color={0,127,255}));
        connect(add.y, qel) annotation (Line(points={{-93,-74},{-100,-74},{-100,
              -106}},
              color={0,0,127}));
        connect(senTemEx2.port_b, outEx.ports[1])
          annotation (Line(points={{-116,40},{-120,40}}, color={0,127,255}));
        connect(senTemIn1.port_a, outSu.ports[1])
          annotation (Line(points={{-100,-40},{-120,-40}}, color={0,127,255}));
        connect(weaBus, outEx.weaBus) annotation (Line(
            points={{-160,-2},{-150,-2},{-150,4},{-140,4},{-140,40.2}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-6,3},{-6,3}}));
        connect(weaBus, outSu.weaBus) annotation (Line(
            points={{-160,-2},{-150,-2},{-150,-6},{-140,-6},{-140,-39.8}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-6,3},{-6,3}}));
      connect(cCO2.y, outEx.C_in[1]) annotation (Line(points={{-119,0},{-146,0},{-146,
              32},{-142,32}}, color={0,0,127}));
      connect(cCO2.y, outSu.C_in[1]) annotation (Line(points={{-119,0},{-146,0},{-146,
              -48},{-142,-48}}, color={0,0,127}));
      connect(resEx.port_a, senPreEx.port)
        annotation (Line(points={{90,40},{112,40}}, color={0,127,255}));
      connect(port_a2, senTemCoilIn.port_a) annotation (Line(points={{100,-100},{100,
              -72},{94,-72}}, color={0,127,255}));
      connect(senTemCoilIn.port_b,coil. port_a2)
        annotation (Line(points={{74,-72},{62,-72},{62,-48},{56,-48}},
                                                              color={0,127,255}));
      connect(senTemIn3.T, reaTSupAir.u) annotation (Line(points={{96,-25},{96,
              -22},{126,-22},{126,-52},{131,-52},{131,-56.6}},
                                           color={0,0,127}));
      connect(reaTSupAir.y, Tsu) annotation (Line(points={{131,-72.7},{131,-80},{
              166,-80}}, color={0,0,127}));
      connect(senTemEx1.T, reaTRetAir.u) annotation (Line(points={{-28,51},{-28,58},
              {-25.2,58}},                    color={0,0,127}));
      connect(senTemCoilIn.T, reaTCoiSup.u) annotation (Line(points={{84,-61},{92,
              -61},{92,-60},{106,-60},{106,-90},{112.8,-90}}, color={0,0,127}));
      connect(coil.port_b2, port_b2) annotation (Line(points={{36,-48},{24,-48},
              {24,-100},{40,-100}},
                         color={0,127,255}));
      connect(senTemIn2.T, reaTHeaRec.u) annotation (Line(points={{-26,-29},{-26,-26},
              {-6,-26},{-6,-12},{0.8,-12}},       color={0,0,127}));
      connect(oveFanRet.y, fanEx.y)
        annotation (Line(points={{-49,80},{-78,80},{-78,52}},
                                                            color={0,0,127}));
      connect(fanEx.port_b, senTemEx2.port_a)
        annotation (Line(points={{-88,40},{-96,40}}, color={0,127,255}));
      connect(fanEx.port_a, hex.port_b1) annotation (Line(points={{-68,40},{-62,40},
              {-62,14},{-70,14},{-70,6},{-66,6}}, color={0,127,255}));
      connect(senTemIn2.T, conPIDhex.u_m) annotation (Line(points={{-26,-29},{-26,
              -26},{-6,-26},{-6,-18},{-22,-18},{-22,-10}}, color={0,0,127}));
      connect(conPIDhex.y, hex.rel_eps_contr) annotation (Line(points={{-33,2},{-38,
              2},{-38,14},{-56,14},{-56,8.8}}, color={0,0,127}));
      connect(conPIDhex.u_s, TsupSet)
        annotation (Line(points={{-10,2},{-4,2},{-4,110}}, color={0,0,127}));
      connect(coil.port_a1, fanSu.port_b)
        annotation (Line(points={{36,-36},{16,-36},{16,-40},{10,-40}},
                                                     color={0,127,255}));
      connect(add.u1, fanEx.P) annotation (Line(points={{-70,-68},{-64,-68},{-64,
              -26},{-84,-26},{-84,26},{-92,26},{-92,49},{-89,49}}, color={0,0,127}));
      connect(fanSu.P, add.u2) annotation (Line(points={{11,-31},{22,-31},{22,-80},
              {-70,-80}}, color={0,0,127}));
      connect(oveFanSupSpe.y, conPIDfans.u_s) annotation (Line(points={{-54,31.2},
              {-54,24},{64,24},{64,0},{57.6,0}},color={0,0,127}));
      connect(conPIDfans.y, oveFanSup.u)
        annotation (Line(points={{39.2,0},{33.2,0}}, color={0,0,127}));
      connect(oveFanSup.y, fanSu.y) annotation (Line(points={{19.4,0},{16,0},{16,
              -26},{6,-26},{6,-28},{0,-28}}, color={0,0,127}));
      connect(coil.port_b1, senMasFloSup.port_a)
        annotation (Line(points={{56,-36},{62,-36}}, color={0,127,255}));
      connect(senMasFloSup.port_b, senTemIn3.port_a)
        annotation (Line(points={{82,-36},{86,-36}},   color={0,127,255}));
      connect(senMasFloSup.m_flow, reaFloSupAir.u) annotation (Line(points={{72,-25},
              {72,8},{122.8,8}},                            color={0,0,127}));
      connect(senMasFloSup.m_flow, conPIDfans.u_m) annotation (Line(points={{72,-25},
              {72,-16},{48,-16},{48,-9.6}},          color={0,0,127}));
      connect(resEx.port_b, senMasFloExt.port_a) annotation (Line(points={{70,40},{62,
              40},{62,42},{48,42},{48,40}}, color={0,127,255}));
      connect(senMasFloExt.port_b, senTemEx1.port_a) annotation (Line(points={{28,40},
              {0,40},{0,44},{-18,44},{-18,40}}, color={0,127,255}));
      connect(senMasFloExt.m_flow, reaFloExtAir.u) annotation (Line(points={{38,29},
              {40,29},{40,26},{50,26},{50,60},{56.8,60}}, color={0,0,127}));
      connect(oveFanRet.u, conPIDfans.y) annotation (Line(points={{-26,80},{18,80},
              {18,16},{36,16},{36,8},{39.2,8},{39.2,0}}, color={0,0,127}));
      connect(CO2meas, conPIDCO2.u_m) annotation (Line(points={{38,110},{38,78},{-18,
              78},{-18,68},{-28,68},{-28,66},{-86,66},{-86,96},{-108,96},{-108,86}},
            color={0,0,127}));
      connect(CO2SetPoi, conPIDCO2.u_s) annotation (Line(points={{-140,110},{-140,
              74},{-120,74}}, color={0,0,127}));
      connect(conPIDCO2.y, oveFanSupSpe.u) annotation (Line(points={{-97,74},{-76,
              74},{-76,60},{-54,60},{-54,49.6}}, color={0,0,127}));
      connect(senTemIn3.port_b, resSup.port_a)
        annotation (Line(points={{106,-36},{112,-36}}, color={0,127,255}));
      connect(senPreIn.port, resSup.port_b)
        annotation (Line(points={{146,-36},{132,-36}}, color={0,127,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
                  -100},{160,100}}), graphics={
              Rectangle(
                extent={{-160,100},{160,-100}},
                lineColor={28,108,200},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(extent={{-20,60},{20,20}}, lineColor={28,108,200}),
              Line(points={{12,56},{12,24},{-20,40},{12,56}}, color={28,108,200}),
              Ellipse(extent={{-20,-20},{20,-60}}, lineColor={28,108,200}),
              Line(points={{-12,-24},{-12,-56},{20,-40},{-12,-24}}, color={28,108,200}),
              Line(points={{20,-40},{150,-40}}, color={28,108,200}),
              Line(points={{-20,-40},{-150,-40}}, color={28,108,200}),
              Line(points={{-150,40},{-20,40}}, color={28,108,200}),
              Line(points={{20,40},{150,40}}, color={28,108,200}),
              Line(points={{-82,40},{-122,-40}}, color={28,108,200}),
              Line(points={{-122,40},{-82,-40}}, color={28,108,200}),
              Rectangle(
                extent={{62,-20},{82,-60}},
                lineColor={28,108,200},
                fillColor={238,46,47},
                fillPattern=FillPattern.Solid),
              Line(points={{0,72},{0,60}}, color={0,0,0}),
              Line(points={{-60,90},{-60,-10},{0,-10},{0,-20}},
                                                            color={0,0,0}),
              Line(points={{0,72},{-60,72}}, color={0,0,0}),
              Line(
                points={{2,-60},{2,-74},{-100,-74},{-100,-96}},
                color={0,0,0},
                pattern=LinePattern.Dash),
              Line(
                points={{0,20},{0,12},{-40,12},{-40,-74}},
                color={0,0,0},
                pattern=LinePattern.Dash),
              Line(points={{-150,44},{-150,36}}, color={28,108,200}),
              Line(points={{-150,-36},{-150,-44}}, color={28,108,200}),
              Line(points={{100,-90},{100,-54},{82,-54}}, color={238,46,47}),
              Line(points={{62,-54},{40,-54},{40,-90}}, color={28,108,200}),
              Line(
                points={{156,-80},{130,-80},{130,-40}},
                color={0,140,72},
                pattern=LinePattern.Dash)}),
                                      Diagram(coordinateSystem(preserveAspectRatio=
                  false, extent={{-160,-100},{160,100}})),
        experiment(
          StartTime=3240000,
          StopTime=3960000,
          Interval=600.0012,
          Tolerance=1e-05,
          __Dymola_Algorithm="Cvode"));
    end AHUSpeedHHB;

    package BaseClasses
      partial model PartialFloor "Interface for a model of a floor of a building"

        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
          "Medium model for air" annotation (choicesAllMatching=true);

        parameter Boolean use_windPressure=true
          "Set to true to enable wind pressure";

        parameter Real kIntNor(min=0, max=1) = 1
          "Gain factor to scale internal heat gain in north zone";

        parameter Modelica.SIunits.Volume VRoo219 "Room volume corridor";
        parameter Modelica.SIunits.Volume VRoo220 "Room volume south";
        parameter Modelica.SIunits.Volume VRoo2nd "Room volume north";

        parameter Modelica.SIunits.Area AFlo219 "Floor area 219";
        parameter Modelica.SIunits.Area AFlo220 "Floor area 220";
        parameter Modelica.SIunits.Area AFlo2nd "Floor area 2nd";

        parameter Modelica.SIunits.Length wWesFac "Length of west facade";
        parameter Modelica.SIunits.Length wSouFac "South facade length";

        final parameter Modelica.SIunits.Area AFloTot = AFlo219+AFlo220+AFlo2nd "Floor area total";

        Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports219[2](
            redeclare package Medium = Medium) "Fluid inlets and outlets"
          annotation (Placement(transformation(extent={{70,-44},{110,-28}}),
              iconTransformation(extent={{78,-32},{118,-16}})));

        Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports220[2](
            redeclare package Medium = Medium) "Fluid inlets and outlets"
          annotation (Placement(transformation(extent={{-50,36},{-10,52}}),
              iconTransformation(extent={{-46,40},{-6,56}})));

        Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports2nd[2](
            redeclare package Medium = Medium) "Fluid inlets and outlets"
          annotation (Placement(transformation(extent={{70,38},{110,54}}),
              iconTransformation(extent={{78,40},{118,56}})));

        Modelica.Blocks.Interfaces.RealOutput TRooAir[3](
          each unit="K",
          each displayUnit="degC") "Room air temperatures"
          annotation (Placement(transformation(extent={{380,150},{400,170}}),
              iconTransformation(extent={{380,40},{400,60}})));

        Modelica.Blocks.Interfaces.RealOutput p_rel
          "Relative pressure signal of building static pressure" annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-170,220}), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-90,50})));

        Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather bus"
          annotation (Placement(transformation(extent={{200,190},{220,210}})));

        Buildings.Examples.VAVReheat.BaseClasses.RoomLeakage lea219(
          redeclare package Medium = Medium,
          VRoo=VRoo219,
          s=(wSouFac/2)/wWesFac,
          azi=Buildings.Types.Azimuth.S,
          final use_windPressure=use_windPressure)
          "Model for air infiltration through the envelope"
          annotation (Placement(transformation(extent={{-56,356},{-20,396}})));

        Buildings.Examples.VAVReheat.BaseClasses.RoomLeakage lea2nd(
          redeclare package Medium = Medium,
          VRoo=VRoo2nd,
          s=wWesFac/(wSouFac/2),
          azi=Buildings.Types.Azimuth.N,
          final use_windPressure=use_windPressure)
          "Model for air infiltration through the envelope"
          annotation (Placement(transformation(extent={{-56,270},{-20,310}})));

        Buildings.Examples.VAVReheat.BaseClasses.RoomLeakage lea220(
          redeclare package Medium = Medium,
          VRoo=VRoo220,
          s=(wSouFac/2)/wWesFac,
          azi=Buildings.Types.Azimuth.S,
          final use_windPressure=use_windPressure)
          "Model for air infiltration through the envelope"
          annotation (Placement(transformation(extent={{-56,314},{-20,354}})));

        Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAir219
          "Air temperature sensor"
          annotation (Placement(transformation(extent={{290,340},{310,360}})));
        Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAir220
          "Air temperature sensor"
          annotation (Placement(transformation(extent={{292,248},{312,268}})));
        Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAir2nd
          "Air temperature sensor"
          annotation (Placement(transformation(extent={{294,218},{314,238}})));

        Buildings.Fluid.Sensors.RelativePressure senRelPre2nd(redeclare package
            Medium = Medium) "Building pressure measurement"
          annotation (Placement(transformation(extent={{60,240},{40,260}})));
        Buildings.Fluid.Sources.Outside out(nPorts=1, redeclare package Medium = Medium)
          annotation (Placement(transformation(extent={{-54,240},{-34,260}})));

        Buildings.Utilities.IO.SignalExchange.Read reaT219(
          description="Temperature of room 219",
          KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
          zone="1",
          y(unit="K"))
          annotation (Placement(transformation(extent={{320,346},{328,354}})));

        Buildings.Utilities.IO.SignalExchange.Read reaT220(
          description="Temperature of room 220",
          KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
          zone="2",
          y(unit="K"))
          annotation (Placement(transformation(extent={{318,254},{326,262}})));

        Buildings.Utilities.IO.SignalExchange.Read reaT2nd(
          description="Temperature of 2nd floor",
          KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
          zone="3",
          y(unit="K"))
          annotation (Placement(transformation(extent={{322,224},{330,232}})));

        Buildings.Airflow.Multizone.DoorOperable door220To2nd(redeclare package
            Medium =                                                                     Medium,
            LClo=0.01)
          annotation (Placement(transformation(extent={{-54,-110},{-34,-90}})));
        Buildings.Airflow.Multizone.DoorOperable door219To2nd(redeclare package
            Medium =                                                                     Medium,
            LClo=0.01)
          annotation (Placement(transformation(extent={{88,-110},{108,-90}})));
        Modelica.Blocks.Routing.Multiplex3 multiplex3_1
          annotation (Placement(transformation(extent={{370,276},{390,296}})));
      equation
        connect(weaBus, lea219.weaBus) annotation (Line(
            points={{210,200},{-80,200},{-80,376},{-56,376}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None));
        connect(weaBus, lea2nd.weaBus) annotation (Line(
            points={{210,200},{-80,200},{-80,290},{-56,290}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None));
        connect(weaBus, lea220.weaBus) annotation (Line(
            points={{210,200},{-80,200},{-80,334},{-56,334}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None));
        connect(out.weaBus, weaBus) annotation (Line(
            points={{-54,250.2},{-70,250.2},{-70,250},{-80,250},{-80,200},{210,200}},
            color={255,204,51},
            thickness=0.5,
            smooth=Smooth.None), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}}));
        connect(senRelPre2nd.p_rel, p_rel) annotation (Line(
            points={{50,241},{50,220},{-170,220}},
            color={0,0,127},
            smooth=Smooth.None,
            pattern=LinePattern.Dash));
        connect(out.ports[1], senRelPre2nd.port_b) annotation (Line(
            points={{-34,250},{40,250}},
            color={0,127,255},
            smooth=Smooth.None,
            thickness=0.5));
        connect(temAir219.T,reaT219. u) annotation (Line(
            points={{310,350},{319.2,350}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(temAir220.T,reaT220. u) annotation (Line(
            points={{312,258},{317.2,258}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(temAir2nd.T,reaT2nd. u) annotation (Line(
            points={{314,228},{321.2,228}},
            color={0,0,127},
            pattern=LinePattern.Dash));
        connect(reaT219.y, multiplex3_1.u1[1]) annotation (Line(points={{328.4,350},{336,
                350},{336,320},{348,320},{348,293},{368,293}}, color={0,0,127}));
        connect(reaT220.y, multiplex3_1.u2[1]) annotation (Line(points={{326.4,258},{342,
                258},{342,268},{350,268},{350,286},{368,286}}, color={0,0,127}));
        connect(reaT2nd.y, multiplex3_1.u3[1]) annotation (Line(points={{330.4,228},{344,
                228},{344,234},{358,234},{358,279},{368,279}}, color={0,0,127}));
        connect(multiplex3_1.y, TRooAir) annotation (Line(points={{391,286},{406,286},
                {406,258},{416,258},{416,210},{360,210},{360,160},{390,160}}, color={0,
                0,127}));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=true,
              extent={{-160,-100},{380,500}},
              initialScale=0.1)),   Icon(coordinateSystem(extent={{-80,-80},{380,160}},
              preserveAspectRatio=true),
               graphics={Rectangle(
                extent={{-80,160},{380,-80}},
                lineColor={95,95,95},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-118,94},{-96,60}},
                textColor={0,0,255},
                textString="dP")}),
          Documentation(info="<html>
<p>
This is a partial model for one floor of the DOE reference office building.
</p>
</html>",
      revisions="<html>
<ul>
<li>
January 25, 2021, by Michael Wetter:<br/>
Replaced door model with the new model <a href=\"modelica://Buildings.Airflow.Multizone.DoorOpen\">
Buildings.Airflow.Multizone.DoorOpen</a>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1353\">IBPSA, #1353</a>.
</li>
<li>
November 15, 2019, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
      end PartialFloor;

      model shading "Control signal for shading"
        parameter Modelica.SIunits.Irradiance threshold=150
          "Shading closed when total external sola irradation is above this threshold";
        parameter Modelica.SIunits.Angle til "Surface tilt";
        parameter Modelica.SIunits.Angle lat "Latitude";
        parameter Modelica.SIunits.Angle azi "Surface azimuth";

        Buildings.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTilPerez(
          til=til,
          lat=lat,
          azi=azi) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
        Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil(
          til=til,
          lat=lat,
          azi=azi)
          annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
        Buildings.BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data"
          annotation (Placement(transformation(extent={{-100,84},{-80,104}})));

        Modelica.Blocks.Logical.Greater          greater
          "Greater comparison"
          annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
        Modelica.Blocks.Math.BooleanToReal booToRea(realTrue=1, realFalse=0)
          "Boolean to real conversion"
          annotation (Placement(transformation(extent={{28,-10},{48,10}})));
        Modelica.Blocks.Math.Add add
          annotation (Placement(transformation(extent={{-38,-10},{-18,10}})));

        parameter Integer nout=1 "Number of outputs";
        Modelica.Blocks.Interfaces.RealOutput y "Connector for shade position"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Sources.Constant const(k=threshold)
          annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
      equation
        connect(HDifTilPerez.weaBus, weaBus) annotation (Line(
            points={{-80,30},{-82,30},{-82,94},{-90,94}},
            color={255,204,51},
            thickness=0.5));
        connect(HDirTil.weaBus, weaBus) annotation (Line(
            points={{-80,-30},{-82,-30},{-82,94},{-90,94}},
            color={255,204,51},
            thickness=0.5), Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(booToRea.u,greater. y)
          annotation (Line(points={{26,0},{13,0}}, color={255,0,255}));
        connect(HDifTilPerez.H, add.u1)
          annotation (Line(points={{-59,30},{-40,30},{-40,6}}, color={0,0,127}));
        connect(HDirTil.H, add.u2)
          annotation (Line(points={{-59,-30},{-40,-30},{-40,-6}}, color={0,0,127}));
        connect(booToRea.y, y)
          annotation (Line(points={{49,0},{110,0}}, color={0,0,127}));
        connect(add.y, greater.u1)
          annotation (Line(points={{-17,0},{-10,0}}, color={0,0,127}));
        connect(greater.u2, const.y)
          annotation (Line(points={{-10,-8},{-10,-60},{-59,-60}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Line(
                points={{-40,60},{-40,66},{-40,100},{10,100}},
                color={95,95,95},
                smooth=Smooth.None),
              Line(
                points={{-40,60},{-20,60},{-20,80},{10,80}},
                color={95,95,95},
                smooth=Smooth.None),
              Line(
                points={{-36,60},{-36,-20}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.None),
              Polygon(
                points={{-90,80},{-40,60},{-36,60},{-36,-20},{-90,0},{-90,80}},
                smooth=Smooth.None,
                pattern=LinePattern.None,
                fillColor={255,255,170},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,0}),
              Polygon(
                points={{-36,40},{10,20},{10,-32},{-20,-20},{-36,-20},{-36,40}},
                smooth=Smooth.None,
                pattern=LinePattern.None,
                fillColor={179,179,179},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,0}),
              Line(
                points={{-40,-20},{-20,-20},{-20,-70},{-20,-70},{10,-70}},
                color={95,95,95},
                smooth=Smooth.None),
              Line(
                points={{-40,-20},{-40,-90},{10,-90}},
                color={95,95,95},
                smooth=Smooth.None)}),                                 Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end shading;

      package Interfaces
        partial model PartialTwoPortVectorRev
          "Partial component with two ports, inlet being vectorized"

          replaceable package Medium =
            Modelica.Media.Interfaces.PartialMedium "Medium in the component"
              annotation (choices(
                choice(redeclare package Medium = Buildings.Media.Air "Moist air"),
                choice(redeclare package Medium = Buildings.Media.Water "Water"),
                choice(redeclare package Medium =
                    Buildings.Media.Antifreeze.PropyleneGlycolWater (
                  property_T=293.15,
                  X_a=0.40)
                  "Propylene glycol water, 40% mass fraction")));
          parameter Integer nPorts "Number of ports"
            annotation(Evaluate=true, Dialog(connectorSizing=true, tab="General",group="Ports"));
          parameter Boolean allowFlowReversal=true
            "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
            annotation (Dialog(tab="Assumptions"), Evaluate=true);

          Modelica.Fluid.Interfaces.FluidPorts_a ports_a[nPorts](
            redeclare each package Medium = Medium,
            each m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
            each h_outflow(start=Medium.h_default, nominal=Medium.h_default))
            "Fluid connectors a (positive design flow direction is from ports_a to port_b)"
            annotation (Placement(transformation(extent={{-110,-40},{-90,40}})));

          Modelica.Fluid.Interfaces.FluidPort_b port_b(
            redeclare final package Medium = Medium,
            m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
            h_outflow(start=Medium.h_default, nominal=Medium.h_default))
            "Fluid connector b (positive design flow direction is from ports_a to port_b)"
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));

          // Diagnostics
           parameter Boolean show_T = false
            "= true, if actual temperature at port is computed"
            annotation (
              Dialog(tab="Advanced", group="Diagnostics"),
              HideResult=true);

          Medium.ThermodynamicState sta_a[nPorts]=
              Medium.setState_phX(ports_a.p,
                                  noEvent(actualStream(ports_a.h_outflow)),
                                  noEvent(actualStream(ports_a.Xi_outflow)))
              if show_T "Medium properties in ports_a";

          Medium.ThermodynamicState sta_b=
              Medium.setState_phX(port_b.p,
                                  noEvent(actualStream(port_b.h_outflow)),
                                  noEvent(actualStream(port_b.Xi_outflow)))
              if show_T "Medium properties in port_b";
          annotation (
            Documentation(info="<html>
<p>
This partial model defines an interface for components with two ports,
of which one is vectorized.
</p>
<p>
The treatment of the design flow direction and of flow reversal are
determined based on the parameter <code>allowFlowReversal</code>.
The component may transport fluid and may have internal storage.
</p>
<h4>Implementation</h4>
<p>
This model is similar to
<a href=\"modelica://Modelica.Fluid.Interfaces.PartialTwoPort\">
Modelica.Fluid.Interfaces.PartialTwoPort</a>
but it does not use the <code>outer system</code> declaration.
This declaration is omitted as in building energy simulation,
many models use multiple media, and in practice,
users have not used this global definition to assign parameters.
</p>
</html>",         revisions="<html>
<ul>
<li>
March 30, 2021, by Michael Wetter:<br/>
Added annotation <code>HideResult=true</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1459\">IBPSA, #1459</a>.
</li>
<li>
January 31, 2019, by Michael Mans:<br/>
Added optional temperature state calculation as diagnostics option.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1092\">#1092</a>.
</li>
<li>
January 18, 2019, by Jianjun Hu:<br/>
Limited the media choice.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1050\">#1050</a>.
</li>
<li>
July 8, 2018, by Filip Jorissen:<br/>
Added nominal value of <code>h_outflow</code> in <code>FluidPorts</code>.
See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/977\">#977</a>.
</li>
<li>
November 19, 2015, by Michael Wetter:<br/>
Removed parameters
<code>port_a_exposesState</code> and
<code>port_b_exposesState</code>
for <a href=\"https://github.com/ibpsa/modelica/issues/351\">#351</a>
and
<code>showDesignFlowDirection</code>
for <a href=\"https://github.com/ibpsa/modelica/issues/349\">#349</a>.
</li>
<li>
November 13, 2015, by Michael Wetter:<br/>
Assinged <code>start</code> attribute for leaving
enthalpy at <code>port_a</code> and <code>port_b</code>.
This was done to make the model similar to
<a href=\"modelica://Buildings.Fluid.Interfaces.PartialFourPort\">
Buildings.Fluid.Interfaces.PartialFourPort</a>.
</li>
<li>
November 12, 2015, by Michael Wetter:<br/>
Removed import statement.
</li>
<li>
October 21, 2014, by Michael Wetter:<br/>
Revised implementation.
Declared medium in ports to be <code>final</code>.
</li>
<li>
October 20, 2014, by Filip Jorisson:<br/>
First implementation.
</li>
</ul>
</html>"),  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
                graphics={
                Polygon(
                  points={{20,-70},{60,-85},{20,-100},{20,-70}},
                  lineColor={0,128,255},
                  fillColor={0,128,255},
                  fillPattern=FillPattern.Solid,
                  visible=not allowFlowReversal),
                Line(
                  points={{55,-85},{-60,-85}},
                  color={0,128,255},
                  visible=not allowFlowReversal),
                Text(
                  extent={{-149,-114},{151,-154}},
                  textColor={0,0,255},
                  textString="%name")}),
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                    100}})));
        end PartialTwoPortVectorRev;
      end Interfaces;

      block DamperControlVarSetpnt
        "Local loop controller for damper with variable setpoint input"
        extends Modelica.Blocks.Interfaces.SISO;
        parameter Real Kp = 10 "Gain";

        Buildings.Controls.Continuous.LimPID con(
          yMin=yMin,
          y_start=0.5,
          Ti=1,
          controllerType=Modelica.Blocks.Types.SimpleController.P,
          k=Kp,
          yMax=1,
          reverseActing=false,
          Td=60)
          annotation (Placement(transformation(extent={{20,-10},{40,10}})));

        Modelica.Blocks.Interfaces.RealInput u_s "Connector of Real input signal"
          annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120})));
        parameter Real yMin=0 "Lower limit of output";
      protected
        Modelica.Blocks.Sources.Constant xSetNor(k=1) "CO2 set point (normalized)"
        annotation (Placement(transformation(extent={{-40,20},{-20,40}})));

        Modelica.Blocks.Math.Division
                                  division
          "Gain. Division by CO2Set is to normalize the control error"
          annotation(Placement(transformation(extent={{-40,-50},{-20,-30}})));
      equation

        connect(con.y, y) annotation (Line(
            points={{41,6.10623e-16},{72,6.10623e-16},{72,5.55112e-16},{110,
                5.55112e-16}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(xSetNor.y, con.u_s) annotation (Line(
            points={{-19,30},{12,30},{12,0},{18,0}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(division.y, con.u_m) annotation (Line(
            points={{-19,-40},{30,-40},{30,-12}},
            color={0,0,127},
            smooth=Smooth.None));
        connect(division.u1, u) annotation (Line(points={{-42,-34},{-94,-34},{-94,0},{
                -120,0}}, color={0,0,127}));
        connect(division.u2, u_s) annotation (Line(points={{-42,-46},{-52,-46},{-52,-78},
                {0,-78},{0,-120}}, color={0,0,127}));
        annotation (Icon(graphics={
              Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
              Polygon(
                points={{-80,90},{-88,68},{-72,68},{-80,90}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{90,-80},{68,-72},{68,-88},{90,-80}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
              Line(points={{-80,-80},{-56,-80},{-2,18},{66,18}}, color={0,0,127})}));
      end DamperControlVarSetpnt;

      record TripleArgon18Argon18Clear =
          Buildings.HeatTransfer.Data.GlazingSystems.Generic (
          final glass={Glass4mm(), Glass4mm(),Glass4mm()},
          final gas={Buildings.HeatTransfer.Data.Gases.Argon(
                               x=0.018),Buildings.HeatTransfer.Data.Gases.Argon(
                                                   x=0.018)},
          UFra=0.8)
        "Triple pane, clear glass 4mm, argon 18, clear glass 4mm, argon 18, clear glass 4mm"
        annotation (
          defaultComponentPrefixes="parameter",
          defaultComponentName="datGlaSys");
      record Glass4mm =
                     Buildings.HeatTransfer.Data.Glasses.Generic (
          x=0.004,
          k=1.0,
          tauSol={0.74},
          rhoSol_a={0.18},
          rhoSol_b={0.18},
          tauIR=0,
          absIR_a=0.16,
          absIR_b=0.16) "Low emissivity 4mm. Manufacturer: Generic."
        annotation (
          defaultComponentPrefixes="parameter",
          defaultComponentName="datGla");
    end BaseClasses;

    package InternalGains
      model InternalGains "InternalGains to heat to zone"
        parameter Modelica.SIunits.Area Area=100;
        BaseClasses.InternalLoad equ(
          radFraction=0.7,
          latPower_nominal=0,
          senPower_nominal=data.equSenPowNom)
          annotation (Placement(transformation(extent={{-84,-10},{-64,10}})));
        BaseClasses.OccupancyLoad occ(
          radFraction=0.6,
          latPower=0,
          occ_density=data.occDen,
          senPower=data.occSenPow)
          annotation (Placement(transformation(extent={{-84,30},{-64,50}})));
        BaseClasses.InternalLoad Lig(
          radFraction=0.5,
          latPower_nominal=0,
          senPower_nominal=data.ligSenPowNom)
          annotation (Placement(transformation(extent={{-84,-50},{-64,-30}})));
        replaceable parameter Data.Generic data             constrainedby
          Data.Generic
          "Record with internal gains data data" annotation (choicesAllMatching=true,
            Placement(transformation(extent={{78,78},{98,98}})));
        Modelica.Blocks.Math.MultiSum sumRad(k=fill(Area, sumRad.nu), nu=3)
          annotation (Placement(transformation(extent={{4,38},{18,52}})));
        Modelica.Blocks.Math.MultiSum sumCon(k=fill(Area, sumCon.nu), nu=3)
          annotation (Placement(transformation(extent={{4,-6},{18,8}})));
        Modelica.Blocks.Math.MultiSum sumLat(k=fill(Area, sumLat.nu), nu=3)
          annotation (Placement(transformation(extent={{4,-42},{18,-28}})));
        Modelica.Blocks.Routing.Multiplex3 multiplex3_1
          annotation (Placement(transformation(extent={{56,-10},{76,10}})));
        Modelica.Blocks.Interfaces.RealOutput intGai[3]
          "Connector of radiant, convective and latent heat gain"
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Interfaces.RealOutput CO2 "CO2 production from people"
          annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
        Modelica.Blocks.Math.Gain gain(k=Area)
          annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
        Modelica.Blocks.Interfaces.RealOutput elCon "Connector electric  consumption"
          annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
        Modelica.Blocks.Math.MultiSum multiSum(nu=6)
          annotation (Placement(transformation(extent={{6,-86},{18,-74}})));
        Modelica.Blocks.Math.Gain gain1(k=Area)
          annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
        Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
          table=data.Sch,
          smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
          extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
          timeScale(displayUnit="h") = 3600)
          annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
        Modelica.Blocks.Sources.Constant const(k=data.MatEmi)
          annotation (Placement(transformation(extent={{-84,-84},{-64,-64}})));

        Modelica.Blocks.Math.Add add
          annotation (Placement(transformation(extent={{30,-68},{50,-48}})));
      equation
        connect(occ.rad, sumRad.u[1]) annotation (Line(points={{-63,46},{-60,46},{-60,
                43.3667},{4,43.3667}},   color={0,0,127}));
        connect(equ.rad, sumRad.u[2]) annotation (Line(points={{-63,4},{-34,4},{-34,45},
                {4,45}},   color={0,0,127}));
        connect(Lig.rad, sumRad.u[3]) annotation (Line(points={{-63,-36},{-34,-36},{
                -34,46.6333},{4,46.6333}},
                                         color={0,0,127}));
        connect(occ.con, sumCon.u[1]) annotation (Line(points={{-63,42},{-22,42},{-22,
                -0.633333},{4,-0.633333}},   color={0,0,127}));
        connect(equ.con, sumCon.u[2]) annotation (Line(points={{-63,0},{-60,0},{-60,1},
                {4,1}},   color={0,0,127}));
        connect(Lig.con, sumCon.u[3]) annotation (Line(points={{-63,-40},{-22,-40},{-22,
                2.63333},{4,2.63333}},   color={0,0,127}));
        connect(sumLat.u[1], occ.lat) annotation (Line(points={{4,-36.6333},{-38,
                -36.6333},{-38,38},{-63,38}},
                                    color={0,0,127}));
        connect(equ.lat, sumLat.u[2]) annotation (Line(points={{-63,-4},{-38,-4},{-38,
                -35},{4,-35}},   color={0,0,127}));
        connect(Lig.lat, sumLat.u[3]) annotation (Line(points={{-63,-44},{-6,-44},{-6,
                -33.3667},{4,-33.3667}},   color={0,0,127}));
        connect(sumRad.y, multiplex3_1.u1[1]) annotation (Line(points={{19.19,45},{19.19,
                44},{46,44},{46,7},{54,7}}, color={0,0,127}));
        connect(sumCon.y, multiplex3_1.u2[1])
          annotation (Line(points={{19.19,1},{19.19,0},{54,0}},
                                                              color={0,0,127}));
        connect(sumLat.y, multiplex3_1.u3[1]) annotation (Line(points={{19.19,-35},{48,
                -35},{48,-7},{54,-7}}, color={0,0,127}));
        connect(multiplex3_1.y, intGai)
          annotation (Line(points={{77,0},{110,0}}, color={0,0,127}));
        connect(gain.y, CO2)
          annotation (Line(points={{81,-40},{110,-40}}, color={0,0,127}));
        connect(equ.rad, multiSum.u[1]) annotation (Line(points={{-63,4},{-46,4},{-46,
                -80},{-20,-80},{-20,-81.75},{6,-81.75}},   color={0,0,127}));
        connect(equ.con, multiSum.u[2]) annotation (Line(points={{-63,0},{-42,0},{-42,
                -81.05},{6,-81.05}},   color={0,0,127}));
        connect(equ.lat, multiSum.u[3]) annotation (Line(points={{-63,-4},{-38,-4},{-38,
                -80.35},{6,-80.35}},       color={0,0,127}));
        connect(Lig.rad, multiSum.u[4]) annotation (Line(points={{-63,-36},{-20,-36},{
                -20,-79.65},{6,-79.65}},    color={0,0,127}));
        connect(Lig.con, multiSum.u[5]) annotation (Line(points={{-63,-40},{-16,-40},{
                -16,-78.95},{6,-78.95}},    color={0,0,127}));
        connect(Lig.lat, multiSum.u[6]) annotation (Line(points={{-63,-44},{-12,-44},{
                -12,-78.25},{6,-78.25}},    color={0,0,127}));
        connect(multiSum.y, gain1.u)
          annotation (Line(points={{19.02,-80},{58,-80}},color={0,0,127}));
        connect(gain1.y, elCon)
          annotation (Line(points={{81,-80},{110,-80}}, color={0,0,127}));
        connect(combiTimeTable.y[1], occ.occ) annotation (Line(points={{-79,90},{-74,90},
                {-74,54},{-92,54},{-92,40},{-84,40}}, color={0,0,127}));
        connect(combiTimeTable.y[2], equ.she) annotation (Line(points={{-79,90},{-74,90},
                {-74,54},{-92,54},{-92,0},{-84,0}}, color={0,0,127}));
        connect(combiTimeTable.y[3], Lig.she) annotation (Line(points={{-79,90},{-74,90},
                {-74,54},{-92,54},{-92,-40},{-84,-40}}, color={0,0,127}));
        connect(const.y, add.u2) annotation (Line(points={{-63,-74},{0,-74},{0,-64},{28,
                -64}}, color={0,0,127}));
        connect(occ.CO2, add.u1) annotation (Line(points={{-63,34},{-18,34},{-18,-52},
                {28,-52}}, color={0,0,127}));
        connect(add.y, gain.u)
          annotation (Line(points={{51,-58},{58,-58},{58,-40}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={28,108,200},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-20,8},{-18,8},{-12,8},{0,28},{10,8},{18,8}}, color={28,108,
                    200}),
              Line(points={{0,28},{0,48}}, color={28,108,200}),
              Line(points={{-16,34},{0,48},{14,36}}, color={28,108,200}),
              Ellipse(extent={{-6,58},{6,48}}, lineColor={28,108,200}),
              Line(points={{22,-12},{-8,-48},{26,-42},{-22,-86},{-16,-66}}, color={28,
                    108,200}),
              Line(points={{-22,-86},{0,-82}}, color={28,108,200})}),  Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end InternalGains;

      package BaseClasses
        model InternalLoad "A model for internal loads"
          import Buildings;
          parameter Modelica.SIunits.HeatFlux senPower_nominal "Nominal sensible heat gain";
          parameter Modelica.SIunits.DimensionlessRatio radFraction "Fraction of sensible gain that is radiant";
          parameter Modelica.SIunits.HeatFlux latPower_nominal "Nominal latent heat gain";
          Modelica.Blocks.Interfaces.RealOutput rad "Radiant load in W/m^2"
            annotation (Placement(transformation(extent={{100,30},{120,50}})));
          Modelica.Blocks.Interfaces.RealOutput con "Convective load in W/m^2"
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          Modelica.Blocks.Interfaces.RealOutput lat "Latent load in W/m^2"
            annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
          Modelica.Blocks.Math.Gain gaiRad(k=senPower_nominal*radFraction)
            annotation (Placement(transformation(extent={{40,30},{60,50}})));
          Modelica.Blocks.Math.Gain gaiCon(k=senPower_nominal*(1 - radFraction))
            annotation (Placement(transformation(extent={{40,-10},{60,10}})));
          Modelica.Blocks.Math.Gain gaiLat(k=latPower_nominal)
            annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
          Modelica.Blocks.Interfaces.RealInput she "input shedual W/m2"
            annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
        equation
          connect(gaiRad.y, rad)
            annotation (Line(points={{61,40},{110,40}}, color={0,0,127}));
          connect(gaiCon.y, con)
            annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
          connect(gaiLat.y, lat)
            annotation (Line(points={{61,-40},{110,-40}}, color={0,0,127}));
          connect(gaiRad.u, she) annotation (Line(points={{38,40},{-28,40},{-28,0},{
                  -100,0}}, color={0,0,127}));
          connect(she, gaiCon.u)
            annotation (Line(points={{-100,0},{38,0}}, color={0,0,127}));
          connect(she, gaiLat.u) annotation (Line(points={{-100,0},{-28,0},{-28,-40},{
                  38,-40}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end InternalLoad;

        model OccupancyLoad "A model for occupancy and resulting internal loads"
          import Buildings;
          parameter Modelica.SIunits.Power senPower "Sensible heat gain per person";
          parameter Modelica.SIunits.MassFlowRate CO2production=8.64e-6
                                                                "CO2 production per person";
          parameter Modelica.SIunits.DimensionlessRatio radFraction "Fraction of sensible gain that is radiant";
          parameter Modelica.SIunits.Power latPower "Latent heat gain per person";
          parameter Modelica.SIunits.DimensionlessRatio occ_density "Number of occupants per m^2";
          Modelica.Blocks.Interfaces.RealOutput rad "Radiant load in W/m^2"
            annotation (Placement(transformation(extent={{100,50},{120,70}})));
          Modelica.Blocks.Interfaces.RealOutput con "Convective load in W/m^2"
            annotation (Placement(transformation(extent={{100,10},{120,30}})));
          Modelica.Blocks.Interfaces.RealOutput lat "Latent load in W/m^2"
            annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
          Modelica.Blocks.Math.Gain gaiRad(k=senPower*radFraction*occ_density)
            annotation (Placement(transformation(extent={{40,50},{60,70}})));
          Modelica.Blocks.Math.Gain gaiCon(k=senPower*(1 - radFraction)*occ_density)
            annotation (Placement(transformation(extent={{40,10},{60,30}})));
          Modelica.Blocks.Math.Gain gaiLat(k=latPower*occ_density)
            annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
          Modelica.Blocks.Math.Gain gaiCO2(k=CO2production*occ_density)
            annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
          Modelica.Blocks.Interfaces.RealOutput CO2 "CO2 production from people"
            annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
          Modelica.Blocks.Interfaces.RealInput occ "input for occupancy per/m2"
            annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
        equation
          connect(gaiRad.y, rad)
            annotation (Line(points={{61,60},{110,60}}, color={0,0,127}));
          connect(gaiCon.y, con)
            annotation (Line(points={{61,20},{110,20}},
                                                      color={0,0,127}));
          connect(gaiLat.y, lat)
            annotation (Line(points={{61,-20},{110,-20}}, color={0,0,127}));
          connect(gaiCO2.y, CO2)
            annotation (Line(points={{61,-60},{110,-60}}, color={0,0,127}));
          connect(gaiRad.u, occ) annotation (Line(points={{38,60},{-30,60},{-30,0},{
                  -100,0}}, color={0,0,127}));
          connect(occ, gaiCon.u) annotation (Line(points={{-100,0},{-30,0},{-30,20},{38,
                  20}}, color={0,0,127}));
          connect(occ, gaiLat.u) annotation (Line(points={{-100,0},{-30,0},{-30,-20},{
                  38,-20}}, color={0,0,127}));
          connect(occ, gaiCO2.u) annotation (Line(points={{-100,0},{-30,0},{-30,-60},{
                  38,-60}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end OccupancyLoad;
      end BaseClasses;

      package Data "Predefiend tabels for internal gains"
        record Generic "Generic record for internal load inputs"
          extends Modelica.Icons.Record;

          parameter Real Sch[:,:]=[0,0.02,0.96154,0.31319; 1,0.019993867,0.96154,0.31319;
              2,0.019993867,0.96154,0.31319; 3,0.019993867,0.96154,0.31319; 4,0.019993867,
              0.96154,0.31319; 5,0.019993867,0.96154,0.31319; 6,0.019993867,0.96154,1.71313;
              7,0.019993867,1.92308,1.71313; 8,0.019993867,1.92308,1.71313; 9,0.019993867,
              0.96154,1.71313; 10,0.019993867,0.96154,1.71313; 11,0.019993867,0.96154,1.71313;
              12,0.019993867,0.96154,1.71313; 13,0.019993867,0.96154,1.71313; 14,0.019993867,
              1.92308,1.71313; 15,0.019993867,3.36538,1.71313; 16,0.019993867,4.32692,1.71313;
              17,0.019993867,4.32692,1.71313; 18,0.019993867,4.32692,1.71313; 19,0.019993867,
              3.84615,1.71313; 20,0.019993867,3.84615,1.71313; 21,0.019993867,3.36538,1.71313;
              22,0.019993867,2.40385,1.71313; 23,0.019993867,0.96154,0.31319]
            "Schedual for occupants, equipment and ligthing"
            annotation (Dialog(group="Schedual"));

          parameter Modelica.SIunits.Power occSenPow=75 "Sensible heat gain per person"
            annotation (Dialog(group="Occupants"));
          parameter Modelica.SIunits.DimensionlessRatio occDen=1
            "Number of occupants per m^2" annotation (Dialog(group="Occupants"));

          parameter Modelica.SIunits.HeatFlux equSenPowNom=1
            "Nominal sensible heat gain equipment"
            annotation (Dialog(group="Equpipment"));

          parameter Modelica.SIunits.HeatFlux ligSenPowNom=1
            "Nominal sensible heat gain lighting" annotation (Dialog(group="Lighting"));

            parameter Real MatEmi=0 "Emissions from materials per m2 in CO2 equivalents"
            annotation (Dialog(group="Materials"));

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end Generic;

        record SNTS3031_Office
          extends Generic(
          Sch=[0,0,0.6577,0.4346,0; 1,0,0.6577,0.4346,
                0; 2,0,0.6577,0.4346,0; 3,0,0.6577,0.4346,0; 4,0,0.6577,0.4346,0; 5,0,0.6577,
                0.4346,0; 6,0,1.9731,0.4346,0; 7,0.04,3.2885,3.7377,1.9231; 8,0.04,3.2885,
                3.7377,1.9231; 9,0.1067,8.55,3.7377,0.9615; 10,0.1067,8.55,3.7377,0.9615;
                11,0.04,3.2885,3.7377,3.8462; 12,0.04,3.2885,3.7377,3.8462; 13,0.1067,8.55,
                3.7377,0.9615; 14,0.1067,8.55,3.7377,0.9615; 15,0.04,3.2885,3.7377,1.9231;
                16,0.04,3.2885,3.7377,1.9231; 17,0,1.9731,0.4346,0; 18,0,0.6577,0.4346,0;
                19,0,0.6577,0.4346,0; 20,0,0.6577,0.4346,0; 21,0,0.6577,0.4346,0; 22,0,0.6577,
                0.4346,0; 23,0,0.6577,0.4346,0; 24,0,0.6577,0.4346,0; 25,0,0.6577,0.4346,
                0; 26,0,0.6577,0.4346,0; 27,0,0.6577,0.4346,0; 28,0,0.6577,0.4346,0; 29,
                0,0.6577,0.4346,0; 30,0,1.9731,0.4346,0; 31,0.04,3.2885,3.7377,1.9231; 32,
                0.04,3.2885,3.7377,1.9231; 33,0.1067,8.55,3.7377,0.9615; 34,0.1067,8.55,
                3.7377,0.9615; 35,0.04,3.2885,3.7377,3.8462; 36,0.04,3.2885,3.7377,3.8462;
                37,0.1067,8.55,3.7377,0.9615; 38,0.1067,8.55,3.7377,0.9615; 39,0.04,3.2885,
                3.7377,1.9231; 40,0.04,3.2885,3.7377,1.9231; 41,0,1.9731,0.4346,0; 42,0,
                0.6577,0.4346,0; 43,0,0.6577,0.4346,0; 44,0,0.6577,0.4346,0; 45,0,0.6577,
                0.4346,0; 46,0,0.6577,0.4346,0; 47,0,0.6577,0.4346,0; 48,0,0.6577,0.4346,
                0; 49,0,0.6577,0.4346,0; 50,0,0.6577,0.4346,0; 51,0,0.6577,0.4346,0; 52,
                0,0.6577,0.4346,0; 53,0,0.6577,0.4346,0; 54,0,1.9731,0.4346,0; 55,0.04,3.2885,
                3.7377,1.9231; 56,0.04,3.2885,3.7377,1.9231; 57,0.1067,8.55,3.7377,0.9615;
                58,0.1067,8.55,3.7377,0.9615; 59,0.04,3.2885,3.7377,3.8462; 60,0.04,3.2885,
                3.7377,3.8462; 61,0.1067,8.55,3.7377,0.9615; 62,0.1067,8.55,3.7377,0.9615;
                63,0.04,3.2885,3.7377,1.9231; 64,0.04,3.2885,3.7377,1.9231; 65,0,1.9731,
                0.4346,0; 66,0,0.6577,0.4346,0; 67,0,0.6577,0.4346,0; 68,0,0.6577,0.4346,
                0; 69,0,0.6577,0.4346,0; 70,0,0.6577,0.4346,0; 71,0,0.6577,0.4346,0; 72,
                0,0.6577,0.4346,0; 73,0,0.6577,0.4346,0; 74,0,0.6577,0.4346,0; 75,0,0.6577,
                0.4346,0; 76,0,0.6577,0.4346,0; 77,0,0.6577,0.4346,0; 78,0,1.9731,0.4346,
                0; 79,0.04,3.2885,3.7377,1.9231; 80,0.04,3.2885,3.7377,1.9231; 81,0.1067,
                8.55,3.7377,0.9615; 82,0.1067,8.55,3.7377,0.9615; 83,0.04,3.2885,3.7377,
                3.8462; 84,0.04,3.2885,3.7377,3.8462; 85,0.1067,8.55,3.7377,0.9615; 86,0.1067,
                8.55,3.7377,0.9615; 87,0.04,3.2885,3.7377,1.9231; 88,0.04,3.2885,3.7377,
                1.9231; 89,0,1.9731,0.4346,0; 90,0,0.6577,0.4346,0; 91,0,0.6577,0.4346,0;
                92,0,0.6577,0.4346,0; 93,0,0.6577,0.4346,0; 94,0,0.6577,0.4346,0; 95,0,0.6577,
                0.4346,0; 96,0,0.6577,0.4346,0; 97,0,0.6577,0.4346,0; 98,0,0.6577,0.4346,
                0; 99,0,0.6577,0.4346,0; 100,0,0.6577,0.4346,0; 101,0,0.6577,0.4346,0; 102,
                0,1.9731,0.4346,0; 103,0.04,3.2885,3.7377,1.9231; 104,0.04,3.2885,3.7377,
                1.9231; 105,0.1067,8.55,3.7377,0.9615; 106,0.1067,8.55,3.7377,0.9615; 107,
                0.04,3.2885,3.7377,3.8462; 108,0.04,3.2885,3.7377,3.8462; 109,0.1067,8.55,
                3.7377,0.9615; 110,0.1067,8.55,3.7377,0.9615; 111,0.04,3.2885,3.7377,1.9231;
                112,0.04,3.2885,3.7377,1.9231; 113,0,1.9731,0.4346,0; 114,0,0.6577,0.4346,
                0; 115,0,0.6577,0.4346,0; 116,0,0.6577,0.4346,0; 117,0,0.6577,0.4346,0;
                118,0,0.6577,0.4346,0; 119,0,0.6577,0.4346,0; 120,0,0.6577,0.4346,0; 121,
                0,0.6577,0.4346,0; 122,0,0.6577,0.4346,0; 123,0,0.6577,0.4346,0; 124,0,0.6577,
                0.4346,0; 125,0,0.6577,0.4346,0; 126,0,0.6577,0.4346,0; 127,0,0.6577,0.4346,
                0; 128,0,0.6577,0.4346,0; 129,0,0.6577,0.4346,0; 130,0,0.6577,0.4346,0;
                131,0,0.6577,0.4346,0; 132,0,0.6577,0.4346,0; 133,0,0.6577,0.4346,0; 134,
                0,0.6577,0.4346,0; 135,0,0.6577,0.4346,0; 136,0,0.6577,0.4346,0; 137,0,0.6577,
                0.4346,0; 138,0,0.6577,0.4346,0; 139,0,0.6577,0.4346,0; 140,0,0.6577,0.4346,
                0; 141,0,0.6577,0.4346,0; 142,0,0.6577,0.4346,0; 143,0,0.6577,0.4346,0;
                144,0,0.6577,0.4346,0; 145,0,0.6577,0.4346,0; 146,0,0.6577,0.4346,0; 147,
                0,0.6577,0.4346,0; 148,0,0.6577,0.4346,0; 149,0,0.6577,0.4346,0; 150,0,0.6577,
                0.4346,0; 151,0,0.6577,0.4346,0; 152,0,0.6577,0.4346,0; 153,0,0.6577,0.4346,
                0; 154,0,0.6577,0.4346,0; 155,0,0.6577,0.4346,0; 156,0,0.6577,0.4346,0;
                157,0,0.6577,0.4346,0; 158,0,0.6577,0.4346,0; 159,0,0.6577,0.4346,0; 160,
                0,0.6577,0.4346,0; 161,0,0.6577,0.4346,0; 162,0,0.6577,0.4346,0; 163,0,0.6577,
                0.4346,0; 164,0,0.6577,0.4346,0; 165,0,0.6577,0.4346,0; 166,0,0.6577,0.4346,
                0; 167,0,0.6577,0.4346,0],
          occSenPow = 75.0,
          occDen = 1.0,
          equSenPowNom = 1.0,
          ligSenPowNom = 1.0);
        end SNTS3031_Office;
      end Data;

      package Tester

        model InternalGains
          .TwinRooms.Components.InternalGains.InternalGains internalGains(
              redeclare
              .TwinRooms.Components.InternalGains.Data.SNTS3031_Office data,
              combiTimeTable(
              tableOnFile=true,
              tableName="tab1",
              fileName=
                  "C:/Users/hwaln/Documents/Adrenalin/Emulators/Adrenalin2_training/models/Resources/intGains.txt"))
            annotation (Placement(transformation(extent={{-94,-2},{-74,18}})));
          annotation (
            Icon(coordinateSystem(preserveAspectRatio=false)),
            Diagram(coordinateSystem(preserveAspectRatio=false)),
            experiment(
              StopTime=1209600,
              Interval=60,
              __Dymola_Algorithm="Dassl"));
        end InternalGains;
      end Tester;
    end InternalGains;

    package Sensors "Sensors for fluid system"
      model EnergyDiffCalc
        "Calculates energy difference from two enthalpy flow rate meaters. Outputs both accumulated energy and instant power"
        Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-6})));
        Modelica.Blocks.Continuous.Integrator integrator annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={20,52})));

         extends Modelica.Icons.RotationalSensor;

          Modelica.Blocks.Interfaces.RealInput H_flowSup(final unit="W")
          "Enthalpy flow rate, supply flow"
          annotation (Placement(transformation(
              origin={-20,-104},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Blocks.Interfaces.RealInput H_flowRet(final unit="W")
          "Enthalpy flow rate, return flow"
          annotation (Placement(transformation(
              origin={20,-104},
              extent={{-10,-10},{10,10}},
              rotation=90)));

          Modelica.Blocks.Interfaces.RealOutput Power(final unit="W")
          "Enthalpy flow rate, positive if from port_a to port_b"
          annotation (Placement(transformation(
              origin={-20,106},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Blocks.Interfaces.RealOutput Energy(final unit="J")
          "Enthalpy flow rate, positive if from port_a to port_b"
          annotation (Placement(transformation(
              origin={20,106},
              extent={{-10,-10},{10,10}},
              rotation=90)));

      equation
        connect(H_flowSup, add.u1)
          annotation (Line(points={{-20,-104},{-20,-18},{-6,-18}}, color={0,0,127}));
        connect(H_flowRet, add.u2)
          annotation (Line(points={{20,-104},{20,-18},{6,-18}}, color={0,0,127}));
        connect(add.y, Power) annotation (Line(points={{6.66134e-16,5},{-20,5},{-20,
                106}}, color={0,0,127}));
        connect(add.y, integrator.u) annotation (Line(points={{6.66134e-16,5},{20,5},
                {20,40}}, color={0,0,127}));
        connect(integrator.y, Energy)
          annotation (Line(points={{20,63},{20,63},{20,106}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Line(points={{-20,-96},{-20,-80},{0,-80},{0,-70}}, color={28,108,200}),
              Line(points={{20,-94},{20,-80},{0,-80},{0,-68}}, color={28,108,200}),
              Line(points={{-20,96},{-20,92},{-20,80},{0,80},{0,70}}, color={28,108,200}),
              Line(points={{20,96},{20,80},{0,80},{0,70}}, color={28,108,200})}),
                                                                       Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end EnergyDiffCalc;

      model EnergyMeter "Energy meter"
        extends Buildings.Fluid.Interfaces.PartialFourPortInterface
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));

        Buildings.Fluid.Sensors.EnthalpyFlowRate senEntFloSup(
          redeclare package Medium = Medium1,
          allowFlowReversal=allowFlowReversal1,
          m_flow_nominal=m1_flow_nominal,
          m_flow_small=m1_flow_small)
          annotation (Placement(transformation(extent={{-40,70},{-20,50}})));
        Buildings.Fluid.Sensors.EnthalpyFlowRate senEntFloSup1(
          redeclare package Medium = Medium2,
          allowFlowReversal=allowFlowReversal2,
          m_flow_nominal=m2_flow_nominal,
          m_flow_small=m2_flow_small)
          annotation (Placement(transformation(extent={{-20,-70},{-40,-50}})));
        EnergyDiffCalc energyDiffCalc annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-14,8})));
        Modelica.Blocks.Interfaces.RealOutput Power( final unit="W")
          "Power flow positive between 1 and 2" annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={20,106})));
        Modelica.Blocks.Interfaces.RealOutput Energy( final unit="J")
          "Accumulated energy, positive between 1 and 2" annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={40,106})));
      equation
        connect(port_a1, senEntFloSup.port_a)
          annotation (Line(points={{-100,60},{-40,60}}, color={0,127,255}));
        connect(senEntFloSup.port_b, port_b1)
          annotation (Line(points={{-20,60},{100,60}}, color={0,127,255}));
        connect(energyDiffCalc.H_flowSup, senEntFloSup.H_flow)
          annotation (Line(points={{-24.4,10},{-30,10},{-30,49}}, color={0,0,127}));
        connect(energyDiffCalc.H_flowRet, senEntFloSup1.H_flow)
          annotation (Line(points={{-24.4,6},{-30,6},{-30,-49}}, color={0,0,127}));
        connect(energyDiffCalc.Power, Power)
          annotation (Line(points={{-3.4,10},{20,10},{20,106}}, color={0,0,127}));
        connect(energyDiffCalc.Energy, Energy) annotation (Line(points={{-3.4,6},{26,6},
                {26,10},{40,10},{40,106}}, color={0,0,127}));
        connect(senEntFloSup1.port_a, port_a2)
          annotation (Line(points={{-20,-60},{100,-60}}, color={0,127,255}));
        connect(senEntFloSup1.port_b, port_b2)
          annotation (Line(points={{-40,-60},{-100,-60}}, color={0,127,255}));
        annotation (Icon(graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-100,60},{102,60}},
                color={255,0,0},
                thickness=0.5),
              Line(
                points={{100,-60},{-100,-60}},
                color={28,108,200},
                thickness=0.5),
              Line(
                points={{40,-80},{-40,-80}},
                color={28,108,200},
                thickness=0.5),
              Line(
                points={{-20,-70},{-40,-80},{-20,-90}},
                color={28,108,200},
                thickness=0.5),
              Line(
                points={{-40,80},{40,80}},
                color={255,0,0},
                thickness=0.5),
              Line(
                points={{20,90},{40,80},{20,70}},
                color={255,0,0},
                thickness=0.5),
                Ellipse(
                  extent={{-24,22},{16,-18}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                Line(points={{6,12},{-14,-10}},  color={0,0,0}),
                Line(points={{6,12},{0,10}}, color={0,0,0}),
                Line(points={{6,12},{4,6}},  color={0,0,0}),
              Line(points={{-4,22},{-4,60}}, color={0,0,0}),
              Line(points={{-4,-18},{-4,-60}}, color={0,0,0})}));
      end EnergyMeter;
    end Sensors;

    model AirJoinerManifold5Zone
      extends
        .TwinRooms.Components.BaseClasses.Interfaces.PartialTwoPortVectorRev(
          nPorts=5);

      parameter Modelica.SIunits.MassFlowRate[5] m_flow_nominal
        "Nominal flow of each outgoing port"
        annotation (Dialog(group="Nominal condition"));
        parameter Modelica.SIunits.Pressure dp_nominal_branch(displayUnit="Pa")=0
        "Pressure drop at nominal mass flow rate, for each branch."
        annotation(Dialog(group = "Nominal condition"));

            parameter Modelica.SIunits.Pressure dp_nominal_common(displayUnit="Pa")=
         0
        "Pressure drop at nominal mass flow rate, for common section."
        annotation(Dialog(group = "Nominal condition"));

      Buildings.Fluid.FixedResistances.Junction jun1(
        redeclare package Medium = Medium,
        m_flow_nominal={sum(m_flow_nominal) - m_flow_nominal[1],m_flow_nominal[1],
            sum(m_flow_nominal)},
        dp_nominal={0,dp_nominal_common,dp_nominal_branch})
                            annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-90})));
      Buildings.Fluid.FixedResistances.Junction jun2(
        redeclare package Medium = Medium,
        m_flow_nominal={m_flow_nominal[3] + m_flow_nominal[4] + m_flow_nominal[5],
            m_flow_nominal[2],sum(m_flow_nominal) - m_flow_nominal[1]},
        dp_nominal={0,0,dp_nominal_branch})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-40})));
      Buildings.Fluid.FixedResistances.Junction jun3(
        redeclare package Medium = Medium,
        m_flow_nominal={m_flow_nominal[4] + m_flow_nominal[5],m_flow_nominal[3] +
            m_flow_nominal[4] + m_flow_nominal[5],m_flow_nominal[3]},
        dp_nominal={0,0,dp_nominal_branch})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270)));

      Buildings.Fluid.FixedResistances.Junction jun4(
        redeclare package Medium = Medium,
        m_flow_nominal={m_flow_nominal[5],m_flow_nominal[5] + m_flow_nominal[4],
            m_flow_nominal[4]},
        dp_nominal={dp_nominal_branch,0,dp_nominal_branch})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,40})));
    equation
      connect(jun1.port_2, port_b) annotation (Line(points={{-1.77636e-15,-100},{
              -1.77636e-15,-102},{86,-102},{86,0},{100,0}}, color={0,127,255}));
      connect(jun1.port_3, ports_a[1]) annotation (Line(points={{-10,-90},{-80,-90},
              {-80,-16},{-100,-16}}, color={0,127,255}));
      connect(jun1.port_1, jun2.port_2) annotation (Line(points={{1.77636e-15,-80},{
              1.77636e-15,-65},{-1.77636e-15,-65},{-1.77636e-15,-50}},  color={0,
              127,255}));
      connect(jun2.port_3, ports_a[2]) annotation (Line(points={{-10,-40},{-60,-40},
              {-60,-8},{-100,-8}},color={0,127,255}));
      connect(jun2.port_1, jun3.port_2) annotation (Line(points={{1.77636e-15,-30},{
              1.77636e-15,-19},{-1.77636e-15,-19},{-1.77636e-15,-10}},
                                                                    color={0,127,
              255}));
      connect(jun3.port_3, ports_a[3]) annotation (Line(points={{-10,1.77636e-15},{-86,
              1.77636e-15},{-86,0},{-100,0}},
                                color={0,127,255}));
      connect(jun3.port_1, jun4.port_2) annotation (Line(points={{1.77636e-15,10},{1.77636e-15,
              33},{-1.77636e-15,33},{-1.77636e-15,30}}, color={0,127,255}));
      connect(jun4.port_3, ports_a[4]) annotation (Line(points={{-10,40},{-60,40},{-60,
              8},{-100,8}},                   color={0,127,255}));
      connect(jun4.port_1, ports_a[5]) annotation (Line(points={{1.77636e-15,50},{1.77636e-15,
              100},{-80,100},{-80,16},{-100,16}},                   color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,46},{40,34}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,26},{40,14}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,6},{40,-6}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,-14},{40,-26}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,-34},{40,-46}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,40},{-40,40}},
                                           color={28,108,200}),
            Line(points={{-90,20},{-40,20}},
                                           color={28,108,200}),
            Line(points={{-90,0},{-40,0}},
                                         color={28,108,200}),
            Line(points={{-90,-20},{-40,-20}},
                                             color={28,108,200}),
            Line(points={{-90,-40},{-40,-40}},
                                             color={28,108,200}),
            Line(points={{40,40},{80,40},{80,0},{90,0}}, color={28,108,200}),
            Line(points={{134,-42}}, color={28,108,200}),
            Line(points={{40,-40},{80,-40},{80,0}}, color={28,108,200}),
            Line(points={{40,20},{80,20}}, color={28,108,200}),
            Line(points={{40,0},{80,0}}, color={28,108,200}),
            Line(points={{40,-20},{80,-20}}, color={28,108,200})}),  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,
                120}})));
    end AirJoinerManifold5Zone;

    model WaterJoinerManifold4Zone
      extends
        .TwinRooms.Components.BaseClasses.Interfaces.PartialTwoPortVectorRev(
          nPorts=4);

      parameter Modelica.SIunits.MassFlowRate[4] m_flow_nominal
        "Nominal flow of each outgoing port"
        annotation (Dialog(group="Nominal condition"));

      Buildings.Fluid.FixedResistances.Junction jun1(
        redeclare package Medium = Medium,
        m_flow_nominal={sum(m_flow_nominal) - m_flow_nominal[1],m_flow_nominal[1],
            sum(m_flow_nominal)},
        dp_nominal={0,0,0}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-90})));
      Buildings.Fluid.FixedResistances.Junction jun2(
        redeclare package Medium = Medium,
        m_flow_nominal={m_flow_nominal[3] + m_flow_nominal[4],m_flow_nominal[2],sum(
            m_flow_nominal) - m_flow_nominal[1]},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-4})));
      Buildings.Fluid.FixedResistances.Junction jun3(
        redeclare package Medium = Medium,
        m_flow_nominal={m_flow_nominal[4],m_flow_nominal[3] + m_flow_nominal[4],
            m_flow_nominal[3]},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,50})));

    equation
      connect(jun1.port_2, port_b) annotation (Line(points={{-1.77636e-15,-100},{
              -1.77636e-15,-102},{86,-102},{86,0},{100,0}}, color={0,127,255}));
      connect(jun1.port_3, ports_a[1]) annotation (Line(points={{-10,-90},{-78,-90},
              {-78,-15},{-100,-15}}, color={0,127,255}));
      connect(jun1.port_1, jun2.port_2) annotation (Line(points={{1.77636e-15,-80},
              {1.77636e-15,-45},{-1.77636e-15,-45},{-1.77636e-15,-14}}, color={0,
              127,255}));
      connect(jun2.port_3, ports_a[2]) annotation (Line(points={{-10,-4},{-80,-4},{
              -80,-5},{-100,-5}}, color={0,127,255}));
      connect(jun2.port_1, jun3.port_2) annotation (Line(points={{1.77636e-15,6},{
              1.77636e-15,28},{-1.77636e-15,28},{-1.77636e-15,40}}, color={0,127,
              255}));
      connect(jun3.port_3, ports_a[3]) annotation (Line(points={{-10,50},{-78,50},{
              -78,5},{-100,5}}, color={0,127,255}));
      connect(jun3.port_1, ports_a[4]) annotation (Line(points={{1.77636e-15,60},{
              1.77636e-15,100},{-84,100},{-84,15},{-100,15}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,46},{40,34}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,18},{40,6}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,-8},{40,-20}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,-34},{40,-46}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Line(points={{40,40},{72,40},{72,0},{90,0}},      color={28,108,200}),
            Line(points={{40,12},{72,12}},   color={28,108,200}),
            Line(points={{40,-14},{72,-14}},   color={28,108,200}),
            Line(points={{-90,40},{-40,40}},
                                           color={28,108,200}),
            Line(points={{-90,12},{-40,12}},
                                           color={28,108,200}),
            Line(points={{-90,-14},{-40,-14}},
                                             color={28,108,200}),
            Line(points={{-90,-40},{-40,-40}},
                                             color={28,108,200}),
            Line(points={{40,-40},{72,-40},{72,0}}, color={28,108,200})}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,
                120}})));
    end WaterJoinerManifold4Zone;

    model WaterJoinerManifold3Zone
      extends
        .TwinRooms.Components.BaseClasses.Interfaces.PartialTwoPortVectorRev(
          nPorts=3);

      parameter Modelica.SIunits.MassFlowRate[3] m_flow_nominal
        "Nominal flow of each outgoing port"
        annotation (Dialog(group="Nominal condition"));

      Buildings.Fluid.FixedResistances.Junction jun1(
        redeclare package Medium = Medium,
        m_flow_nominal={sum(m_flow_nominal) - m_flow_nominal[1],m_flow_nominal[1],
            sum(m_flow_nominal)},
        dp_nominal={0,0,0}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-42})));
      Buildings.Fluid.FixedResistances.Junction jun2(
        redeclare package Medium = Medium,
        m_flow_nominal={m_flow_nominal[3],m_flow_nominal[2],sum(m_flow_nominal) -
            m_flow_nominal[1]},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=270)));

    equation
      connect(jun1.port_2, port_b) annotation (Line(points={{0,-52},{0,-74},{84,-74},
              {84,0},{100,0}},                              color={0,127,255}));
      connect(jun1.port_3, ports_a[1]) annotation (Line(points={{-10,-42},{-46,-42},
              {-46,-13.3333},{-100,-13.3333}},
                                     color={0,127,255}));
      connect(jun1.port_1, jun2.port_2) annotation (Line(points={{0,-32},{0,-10}},
                                                                        color={0,
              127,255}));
      connect(jun2.port_3, ports_a[2]) annotation (Line(points={{-10,0},{-100,0}},
                                  color={0,127,255}));
      connect(ports_a[3], jun2.port_1) annotation (Line(points={{-100,13.3333},{-100,
              12},{0,12},{0,10}},color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,46},{40,34}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,18},{40,6}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,-8},{40,-20}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,-34},{40,-46}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Line(points={{40,40},{72,40},{72,0},{90,0}},      color={28,108,200}),
            Line(points={{40,12},{72,12}},   color={28,108,200}),
            Line(points={{40,-14},{72,-14}},   color={28,108,200}),
            Line(points={{-90,40},{-40,40}},
                                           color={28,108,200}),
            Line(points={{-90,12},{-40,12}},
                                           color={28,108,200}),
            Line(points={{-90,-14},{-40,-14}},
                                             color={28,108,200}),
            Line(points={{-90,-40},{-40,-40}},
                                             color={28,108,200}),
            Line(points={{40,-40},{72,-40},{72,0}}, color={28,108,200})}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,
                120}})));
    end WaterJoinerManifold3Zone;

    model WaterJoinerManifold2Zone
       extends
        .TwinRooms.Components.BaseClasses.Interfaces.PartialTwoPortVectorRev(
          nPorts=2);

       parameter Modelica.SIunits.MassFlowRate[2] m_flow_nominal
         "Nominal flow of each outgoing port"
         annotation (Dialog(group="Nominal condition"));

       Buildings.Fluid.FixedResistances.Junction jun1(
         redeclare package Medium = Medium,
        m_flow_nominal={m_flow_nominal[1],m_flow_nominal[2],sum(m_flow_nominal)},
         dp_nominal={0,0,0}) annotation (Placement(transformation(
             extent={{-10,-10},{10,10}},
             rotation=270,
             origin={0,-90})));

    equation
       connect(jun1.port_2, port_b) annotation (Line(points={{-1.77636e-15,-100},{
               -1.77636e-15,-102},{86,-102},{86,0},{100,0}}, color={0,127,255}));
       connect(jun1.port_3, ports_a[1]) annotation (Line(points={{-10,-90},{-42,-90},
              {-42,-10},{-100,-10}},  color={0,127,255}));
      connect(ports_a[2], jun1.port_1) annotation (Line(points={{-100,10},{0,10},{0,
              -80}},                   color={0,127,255}));
       annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
             Rectangle(
               extent={{-100,100},{100,-100}},
               lineColor={28,108,200},
               fillColor={255,255,255},
               fillPattern=FillPattern.Solid),
             Rectangle(
               extent={{-40,46},{40,34}},
               lineColor={215,215,215},
               fillColor={215,215,215},
               fillPattern=FillPattern.Solid),
             Rectangle(
               extent={{-40,18},{40,6}},
               lineColor={215,215,215},
               fillColor={215,215,215},
               fillPattern=FillPattern.Solid),
             Rectangle(
               extent={{-40,-8},{40,-20}},
               lineColor={215,215,215},
               fillColor={215,215,215},
               fillPattern=FillPattern.Solid),
             Rectangle(
               extent={{-40,-34},{40,-46}},
               lineColor={215,215,215},
               fillColor={215,215,215},
               fillPattern=FillPattern.Solid),
             Line(points={{40,40},{72,40},{72,0},{90,0}},      color={28,108,200}),
             Line(points={{40,12},{72,12}},   color={28,108,200}),
             Line(points={{40,-14},{72,-14}},   color={28,108,200}),
             Line(points={{-90,40},{-40,40}},
                                            color={28,108,200}),
             Line(points={{-90,12},{-40,12}},
                                            color={28,108,200}),
             Line(points={{-90,-14},{-40,-14}},
                                              color={28,108,200}),
             Line(points={{-90,-40},{-40,-40}},
                                              color={28,108,200}),
             Line(points={{40,-40},{72,-40},{72,0}}, color={28,108,200})}),
                                                                      Diagram(
             coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,
                 120}})));
    end WaterJoinerManifold2Zone;

    model WaterTRVSplitterManifold4Zone
      extends Buildings.Fluid.Interfaces.PartialTwoPortVector(nPorts=4);

      parameter Modelica.SIunits.MassFlowRate[4] m_flow_nominal
        "Nominal flow of each outgoing port"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dpValve_nominal[4](displayUnit=
            "Pa")=fill(5000, 4)
        "Pressure drop of fully open damper at nominal mass flow rate"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dpFixed_nominal[4](displayUnit=
            "Pa")=fill(10000, 4)
        "Pressure drop of duct and resistances other than the damper in series, at nominal mass flow rate"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.Temperature TSet_fixed=294.15 "Fixed temperatur setpoint";

      Buildings.Fluid.FixedResistances.Junction jun1(
        redeclare package Medium = Medium,
        m_flow_nominal={sum(m_flow_nominal),sum(m_flow_nominal) - m_flow_nominal[1],
            m_flow_nominal[1]},
        dp_nominal={0,0,0}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,-80})));
      Buildings.Fluid.FixedResistances.Junction jun2(
        redeclare package Medium = Medium,
        m_flow_nominal={sum(m_flow_nominal) - m_flow_nominal[1],m_flow_nominal[3] +
            m_flow_nominal[4],m_flow_nominal[2]},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,-40})));
      Buildings.Fluid.FixedResistances.Junction jun3(
        redeclare package Medium = Medium,
        m_flow_nominal={m_flow_nominal[3] + m_flow_nominal[4],m_flow_nominal[4],
            m_flow_nominal[3]},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,0})));

      Modelica.Blocks.Routing.DeMultiplex5 deMultiplex5_1 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,94})));
      Modelica.Blocks.Interfaces.RealInput TMea[5]
        "Connector for measuremed temperature" annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,128}), iconTransformation(extent={{-120,80},{-80,120}})));

      TwoWayPIDV valSou(
        redeclare package Medium = Medium,
        allowFlowReversal=allowFlowReversal,
        m_flow_nominal=m_flow_nominal[1],
        dpValve_nominal=dpValve_nominal[1],
        use_TSet_in=true,
        dpFixed_nominal=dpFixed_nominal[1]) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={0,-80})));
      TwoWayPIDV valEas(
        redeclare package Medium = Medium,
        allowFlowReversal=allowFlowReversal,
        m_flow_nominal=m_flow_nominal[2],
        dpValve_nominal=dpValve_nominal[2],
        use_TSet_in=true,
        dpFixed_nominal=dpFixed_nominal[2]) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={0,-40})));
      TwoWayPIDV valNor(
        redeclare package Medium = Medium,
        allowFlowReversal=allowFlowReversal,
        m_flow_nominal=m_flow_nominal[3],
        dpValve_nominal=dpValve_nominal[3],
        use_TSet_in=true,
        dpFixed_nominal=dpFixed_nominal[3]) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}}, rotation=0)));
      TwoWayPIDV valWes(
        redeclare package Medium = Medium,
        allowFlowReversal=allowFlowReversal,
        m_flow_nominal=m_flow_nominal[4],
        dpValve_nominal=dpValve_nominal[4],
        use_TSet_in=true,
        dpFixed_nominal=dpFixed_nominal[4]) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={0,40})));

      Buildings.Utilities.IO.SignalExchange.Overwrite TSetRadWes(description="Radiator setpoint for zone west",
          u(
          unit="K",
          min=285.15,
          max=313.15)) "Zone west radiator setpoint"
        annotation (Placement(transformation(extent={{-32,42},{-20,54}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite TSetRadNor(description="Radiator setpoint for zone north",
          u(
          unit="K",
          min=285.15,
          max=313.15)) "Zone north radiator setpoint"
        annotation (Placement(transformation(extent={{-32,2},{-20,14}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite TSetRadEas(description="Radiator setpoint for zone east",
          u(
          unit="K",
          min=285.15,
          max=313.15)) "Zone east radiator setpoint"
        annotation (Placement(transformation(extent={{-34,-38},{-22,-26}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite TSetRadSou(description="Radiator setpoint for zone south",
          u(
          unit="K",
          min=285.15,
          max=313.15)) "Zone south radiator setpoint"
        annotation (Placement(transformation(extent={{-32,-78},{-20,-66}})));
      Buildings.Controls.SetPoints.OccupancySchedule
                                           occSch(occupancy=3600*{8,18})
                                                  "Occupancy schedule"
        annotation (Placement(transformation(extent={{-182,88},{-162,108}})));
      Modelica.Blocks.Sources.Constant TRooNig(k=273.15 + 15)
        "Room temperature set point at night"
        annotation (Placement(transformation(extent={{-182,62},{-162,82}})));
      Modelica.Blocks.Sources.Constant TRooSet(k=273.15 + 22)
        annotation (Placement(transformation(extent={{-182,118},{-162,138}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{-108,110},{-88,130}})));
    equation
      connect(port_a, jun1.port_1) annotation (Line(points={{-100,0},{-96,0},{-96,-90},
              {-60,-90}}, color={0,127,255}));
      connect(jun1.port_2, jun2.port_1)
        annotation (Line(points={{-60,-70},{-60,-50}}, color={0,127,255}));
      connect(jun2.port_2, jun3.port_1)
        annotation (Line(points={{-60,-30},{-60,-10}}, color={0,127,255}));
      connect(deMultiplex5_1.u, TMea) annotation (Line(points={{30,106},{30,120},{0,
              120},{0,128}},                  color={0,0,127},
          pattern=LinePattern.Dash));
      connect(jun3.port_3, valNor.port_a) annotation (Line(points={{-50,-6.10623e-16},
              {-30,-6.10623e-16},{-30,0},{-10,0}}, color={0,127,255}));
      connect(jun2.port_3, valEas.port_a)
        annotation (Line(points={{-50,-40},{-10,-40}}, color={0,127,255}));
      connect(jun1.port_3, valSou.port_a)
        annotation (Line(points={{-50,-80},{-10,-80}}, color={0,127,255}));
      connect(valSou.port_b, ports_b[1]) annotation (Line(points={{10,-80},{80,-80},
              {80,-15},{100,-15}}, color={0,127,255}));
      connect(valEas.port_b, ports_b[2]) annotation (Line(points={{10,-40},{60,-40},
              {60,-5},{100,-5}}, color={0,127,255}));
      connect(valNor.port_b, ports_b[3]) annotation (Line(points={{10,0},{56,0},{56,
              5},{100,5}}, color={0,127,255}));
      connect(valWes.port_b, ports_b[4]) annotation (Line(points={{10,40},{60,40},{60,
              15},{100,15}}, color={0,127,255}));
      connect(deMultiplex5_1.y4[1], valWes.T) annotation (Line(
          points={{26,83},{26,56},{0,56},{0,50.6}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(deMultiplex5_1.y3[1], valNor.T) annotation (Line(
          points={{30,83},{30,16},{0,16},{0,10.6}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(deMultiplex5_1.y2[1], valEas.T) annotation (Line(
          points={{34,83},{34,-20},{0,-20},{0,-29.4}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(deMultiplex5_1.y1[1], valSou.T) annotation (Line(
          points={{38,83},{38,-69.4},{0,-69.4}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(valWes.port_a, jun3.port_2)
        annotation (Line(points={{-10,40},{-60,40},{-60,10}}, color={0,127,255}));
      connect(TSetRadWes.y, valWes.TSet_in) annotation (Line(
          points={{-19.4,48},{-16,48},{-16,47.8},{-11.6,47.8}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(TSetRadNor.y, valNor.TSet_in) annotation (Line(
          points={{-19.4,8},{-16,8},{-16,7.8},{-11.6,7.8}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(TSetRadEas.y, valEas.TSet_in) annotation (Line(
          points={{-21.4,-32},{-16,-32},{-16,-32.2},{-11.6,-32.2}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(TSetRadSou.y, valSou.TSet_in) annotation (Line(
          points={{-19.4,-72},{-16,-72},{-16,-72.2},{-11.6,-72.2}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(occSch.occupied, switch1.u2) annotation (Line(points={{-161,92},{-154,
              92},{-154,114},{-110,114},{-110,120}}, color={255,0,255}));
      connect(TRooNig.y, switch1.u3) annotation (Line(points={{-161,72},{-146,72},{
              -146,112},{-110,112}},  color={0,0,127}));
      connect(TRooSet.y, switch1.u1) annotation (Line(points={{-161,128},{-110,128}},
                                                            color={0,0,127}));
      connect(switch1.y, TSetRadNor.u) annotation (Line(points={{-87,120},{-72,120},
              {-72,114},{-46,114},{-46,8},{-33.2,8}}, color={0,0,127}));
      connect(switch1.y, TSetRadEas.u) annotation (Line(points={{-87,120},{-76,120},
              {-76,96},{-44,96},{-44,-32},{-35.2,-32}}, color={0,0,127}));
      connect(switch1.y, TSetRadWes.u) annotation (Line(points={{-87,120},{-74,120},
              {-74,92},{-62,92},{-62,48},{-33.2,48}}, color={0,0,127}));
      connect(switch1.y, TSetRadSou.u) annotation (Line(points={{-87,120},{-86,120},
              {-86,-72},{-33.2,-72}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,46},{40,34}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,18},{40,6}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,-8},{40,-20}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,-34},{40,-46}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Line(points={{-100,0},{-72,0},{-72,40},{-40,40}}, color={28,108,200}),
            Line(points={{-72,12},{-40,12}}, color={28,108,200}),
            Line(points={{-72,0},{-72,-40},{-40,-40}}, color={28,108,200}),
            Line(points={{-72,-14},{-40,-14}}, color={28,108,200}),
            Line(points={{40,40},{90,40}}, color={28,108,200}),
            Line(points={{40,12},{90,12}}, color={28,108,200}),
            Line(points={{40,-14},{90,-14}}, color={28,108,200}),
            Line(points={{40,-40},{90,-40}}, color={28,108,200})}),  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,
                120}})));
    end WaterTRVSplitterManifold4Zone;

    model WaterTRVSplitterManifold3Zone
      extends Buildings.Fluid.Interfaces.PartialTwoPortVector(nPorts=3);

      parameter Modelica.SIunits.MassFlowRate[3] m_flow_nominal
        "Nominal flow of each outgoing port"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dpValve_nominal[3](displayUnit=
            "Pa")=fill(5000, 3)
        "Pressure drop of fully open damper at nominal mass flow rate"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dpFixed_nominal[3](displayUnit=
            "Pa")=fill(10000, 3)
        "Pressure drop of duct and resistances other than the damper in series, at nominal mass flow rate"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.Temperature TSet_fixed=294.15 "Fixed temperatur setpoint";

      Buildings.Fluid.FixedResistances.Junction jun2(
        redeclare package Medium = Medium,
        m_flow_nominal={sum(m_flow_nominal),m_flow_nominal[2] + m_flow_nominal[3],
            m_flow_nominal[1]},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,-40})));
      Buildings.Fluid.FixedResistances.Junction jun3(
        redeclare package Medium = Medium,
        m_flow_nominal={m_flow_nominal[2] + m_flow_nominal[3],m_flow_nominal[3],
            m_flow_nominal[2]},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,0})));

      Modelica.Blocks.Routing.DeMultiplex5 deMultiplex5_1 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,94})));
      Modelica.Blocks.Interfaces.RealInput TMea[5]
        "Connector for measuremed temperature" annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,128}), iconTransformation(extent={{-120,80},{-80,120}})));

      TwoWayPIDV val3rd(
        redeclare package Medium = Medium,
        allowFlowReversal=allowFlowReversal,
        m_flow_nominal=m_flow_nominal[1],
        dpValve_nominal=dpValve_nominal[1],
        use_TSet_in=true,
        dpFixed_nominal=dpFixed_nominal[1]) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={0,-40})));
      TwoWayPIDV val1st(
        redeclare package Medium = Medium,
        allowFlowReversal=allowFlowReversal,
        m_flow_nominal=m_flow_nominal[2],
        dpValve_nominal=dpValve_nominal[2],
        use_TSet_in=true,
        dpFixed_nominal=dpFixed_nominal[2]) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}}, rotation=0)));
      TwoWayPIDV val2nd(
        redeclare package Medium = Medium,
        allowFlowReversal=allowFlowReversal,
        m_flow_nominal=m_flow_nominal[3],
        dpValve_nominal=dpValve_nominal[3],
        use_TSet_in=true,
        dpFixed_nominal=dpFixed_nominal[3]) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={0,40})));

      Buildings.Utilities.IO.SignalExchange.Overwrite TSetRadWes(description="Radiator setpoint for zone west",
          u(
          unit="K",
          min=285.15,
          max=313.15)) "Zone west radiator setpoint"
        annotation (Placement(transformation(extent={{-32,42},{-20,54}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite TSetRadNor(description="Radiator setpoint for zone north",
          u(
          unit="K",
          min=285.15,
          max=313.15)) "Zone north radiator setpoint"
        annotation (Placement(transformation(extent={{-32,2},{-20,14}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite TSetRadEas(description="Radiator setpoint for zone east",
          u(
          unit="K",
          min=285.15,
          max=313.15)) "Zone east radiator setpoint"
        annotation (Placement(transformation(extent={{-34,-38},{-22,-26}})));
      Modelica.Blocks.Interfaces.RealInput Tset
        "Connector for measuremed temperature" annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={-72,124}), iconTransformation(extent={{-120,80},{-80,120}})));
    equation
      connect(jun2.port_2, jun3.port_1)
        annotation (Line(points={{-60,-30},{-60,-10}}, color={0,127,255}));
      connect(deMultiplex5_1.u, TMea) annotation (Line(points={{30,106},{30,120},{0,
              120},{0,128}},                  color={0,0,127},
          pattern=LinePattern.Dash));
      connect(jun3.port_3,val1st. port_a) annotation (Line(points={{-50,-6.10623e-16},
              {-30,-6.10623e-16},{-30,0},{-10,0}}, color={0,127,255}));
      connect(jun2.port_3,val3rd. port_a)
        annotation (Line(points={{-50,-40},{-10,-40}}, color={0,127,255}));
      connect(val3rd.port_b, ports_b[1]) annotation (Line(points={{10,-40},{60,-40},
              {60,-13.3333},{100,-13.3333}},
                                 color={0,127,255}));
      connect(val1st.port_b, ports_b[2]) annotation (Line(points={{10,0},{56,0},{56,
              0},{100,0}}, color={0,127,255}));
      connect(val2nd.port_b, ports_b[3]) annotation (Line(points={{10,40},{60,40},
              {60,13.3333},{100,13.3333}},
                             color={0,127,255}));
      connect(deMultiplex5_1.y4[1],val2nd. T) annotation (Line(
          points={{26,83},{26,56},{0,56},{0,50.6}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(deMultiplex5_1.y3[1],val1st. T) annotation (Line(
          points={{30,83},{30,16},{0,16},{0,10.6}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(deMultiplex5_1.y2[1],val3rd. T) annotation (Line(
          points={{34,83},{34,-20},{0,-20},{0,-29.4}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(val2nd.port_a, jun3.port_2)
        annotation (Line(points={{-10,40},{-60,40},{-60,10}}, color={0,127,255}));
      connect(TSetRadWes.y,val2nd. TSet_in) annotation (Line(
          points={{-19.4,48},{-16,48},{-16,47.8},{-11.6,47.8}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(TSetRadNor.y,val1st. TSet_in) annotation (Line(
          points={{-19.4,8},{-16,8},{-16,7.8},{-11.6,7.8}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(TSetRadEas.y,val3rd. TSet_in) annotation (Line(
          points={{-21.4,-32},{-16,-32},{-16,-32.2},{-11.6,-32.2}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(port_a, jun2.port_1) annotation (Line(points={{-100,0},{-100,-90},{-56,
              -90},{-56,-50},{-60,-50}}, color={0,127,255}));
      connect(TSetRadWes.u, Tset)
        annotation (Line(points={{-33.2,48},{-72,48},{-72,124}}, color={0,0,127}));
      connect(TSetRadNor.u, Tset)
        annotation (Line(points={{-33.2,8},{-72,8},{-72,124}}, color={0,0,127}));
      connect(TSetRadEas.u, Tset) annotation (Line(points={{-35.2,-32},{-72,-32},{
              -72,124}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,46},{40,34}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,18},{40,6}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,-8},{40,-20}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,-34},{40,-46}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Line(points={{-100,0},{-72,0},{-72,40},{-40,40}}, color={28,108,200}),
            Line(points={{-72,12},{-40,12}}, color={28,108,200}),
            Line(points={{-72,0},{-72,-40},{-40,-40}}, color={28,108,200}),
            Line(points={{-72,-14},{-40,-14}}, color={28,108,200}),
            Line(points={{40,40},{90,40}}, color={28,108,200}),
            Line(points={{40,12},{90,12}}, color={28,108,200}),
            Line(points={{40,-14},{90,-14}}, color={28,108,200}),
            Line(points={{40,-40},{90,-40}}, color={28,108,200})}),  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,
                120}})));
    end WaterTRVSplitterManifold3Zone;

    model WaterTRVSplitterManifold2Zone
      extends Buildings.Fluid.Interfaces.PartialTwoPortVector(nPorts=2);

      parameter Modelica.SIunits.MassFlowRate[2] m_flow_nominal
        "Nominal flow of each outgoing port"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dpValve_nominal[2](displayUnit=
            "Pa")=fill(5000, 2)
        "Pressure drop of fully open damper at nominal mass flow rate"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dpFixed_nominal[2](displayUnit=
            "Pa")=fill(10000, 2)
        "Pressure drop of duct and resistances other than the damper in series, at nominal mass flow rate"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.Temperature TSet_fixed=294.15 "Fixed temperatur setpoint";

      Buildings.Fluid.FixedResistances.Junction jun3(
        redeclare package Medium = Medium,
        m_flow_nominal={m_flow_nominal[1] + m_flow_nominal[2],m_flow_nominal[2],
            m_flow_nominal[1]},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,0})));

      Modelica.Blocks.Interfaces.RealInput TMea[2]
        "Connector for measuremed temperature" annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={30,130}),iconTransformation(extent={{-120,80},{-80,120}})));

      TwoWayTRVtanh val219(
        redeclare package Medium = Medium,
        allowFlowReversal=allowFlowReversal,
        m_flow_nominal=m_flow_nominal[1],
        dpValve_nominal=dpValve_nominal[1],
        use_TSet_in=true,
        dpFixed_nominal=dpFixed_nominal[1]) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}}, rotation=0)));
      TwoWayTRVtanh val220(
        redeclare package Medium = Medium,
        allowFlowReversal=allowFlowReversal,
        m_flow_nominal=m_flow_nominal[2],
        dpValve_nominal=dpValve_nominal[2],
        use_TSet_in=true,
        dpFixed_nominal=dpFixed_nominal[2]) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={0,40})));

      Buildings.Utilities.IO.SignalExchange.Overwrite TSetRadWes(description="Radiator setpoint for zone west",
          u(
          unit="K",
          min=285.15,
          max=313.15)) "Zone west radiator setpoint"
        annotation (Placement(transformation(extent={{-32,42},{-20,54}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite TSetRadNor(description="Radiator setpoint for zone north",
          u(
          unit="K",
          min=285.15,
          max=313.15)) "Zone north radiator setpoint"
        annotation (Placement(transformation(extent={{-32,2},{-20,14}})));
      Modelica.Blocks.Interfaces.RealInput TSet
        "Connector for measuremed temperature" annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={-74,126}), iconTransformation(extent={{-120,80},{-80,120}})));
      Modelica.Blocks.Routing.DeMultiplex2 deMultiplex2_1 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={38,80})));
    equation
      connect(jun3.port_3,val219. port_a) annotation (Line(points={{-50,-6.10623e-16},
              {-30,-6.10623e-16},{-30,0},{-10,0}}, color={0,127,255}));
      connect(val219.port_b, ports_b[1]) annotation (Line(points={{10,0},{56,0},{56,
              -10},{100,-10}},
                           color={0,127,255}));
      connect(val220.port_b, ports_b[2]) annotation (Line(points={{10,40},{60,40},{60,
              10},{100,10}}, color={0,127,255}));
      connect(val220.port_a, jun3.port_2)
        annotation (Line(points={{-10,40},{-60,40},{-60,10}}, color={0,127,255}));
      connect(TSetRadWes.y,val220. TSet_in) annotation (Line(
          points={{-19.4,48},{-16,48},{-16,48},{-12,48}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(TSetRadNor.y,val219. TSet_in) annotation (Line(
          points={{-19.4,8},{-16,8},{-16,8},{-12,8}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(port_a, jun3.port_1) annotation (Line(points={{-100,0},{-100,-56},{-60,
              -56},{-60,-10}}, color={0,127,255}));
      connect(TSet, TSetRadWes.u)
        annotation (Line(points={{-74,126},{-74,48},{-33.2,48}}, color={0,0,127}));
      connect(TSetRadNor.u, TSet)
        annotation (Line(points={{-33.2,8},{-74,8},{-74,126}}, color={0,0,127}));
      connect(deMultiplex2_1.y2[1], val220.T)
        annotation (Line(points={{32,69},{32,50.6},{0,50.6}}, color={0,0,127}));
      connect(deMultiplex2_1.y1[1], val219.T) annotation (Line(points={{44,69},{44,14},
              {0,14},{0,10.6}}, color={0,0,127}));
      connect(deMultiplex2_1.u, TMea) annotation (Line(points={{38,92},{38,106},{30,
              106},{30,130}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,46},{40,34}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,18},{40,6}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,-8},{40,-20}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,-34},{40,-46}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Line(points={{-100,0},{-72,0},{-72,40},{-40,40}}, color={28,108,200}),
            Line(points={{-72,12},{-40,12}}, color={28,108,200}),
            Line(points={{-72,0},{-72,-40},{-40,-40}}, color={28,108,200}),
            Line(points={{-72,-14},{-40,-14}}, color={28,108,200}),
            Line(points={{40,40},{90,40}}, color={28,108,200}),
            Line(points={{40,12},{90,12}}, color={28,108,200}),
            Line(points={{40,-14},{90,-14}}, color={28,108,200}),
            Line(points={{40,-40},{90,-40}}, color={28,108,200})}),  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,
                120}})));
    end WaterTRVSplitterManifold2Zone;

    model WaterPIDSplitterManifold2Zone
      extends Buildings.Fluid.Interfaces.PartialTwoPortVector(nPorts=2);

      parameter Modelica.SIunits.MassFlowRate[2] m_flow_nominal
        "Nominal flow of each outgoing port"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dpValve_nominal[2](displayUnit=
            "Pa")=fill(5000, 2)
        "Pressure drop of fully open damper at nominal mass flow rate"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dpFixed_nominal[2](displayUnit=
            "Pa")=fill(10000, 2)
        "Pressure drop of duct and resistances other than the damper in series, at nominal mass flow rate"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.Temperature TSet_fixed=294.15 "Fixed temperatur setpoint";

      Buildings.Fluid.FixedResistances.Junction jun3(
        redeclare package Medium = Medium,
        m_flow_nominal={m_flow_nominal[1] + m_flow_nominal[2],m_flow_nominal[2],
            m_flow_nominal[1]},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,0})));

      Modelica.Blocks.Interfaces.RealInput TMea[2]
        "Connector for measuremed temperature" annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={30,130}),iconTransformation(extent={{-120,80},{-80,120}})));

      TwoWayPIDV val219(
        redeclare package Medium = Medium,
        allowFlowReversal=allowFlowReversal,
        m_flow_nominal=m_flow_nominal[1],
        dpValve_nominal=dpValve_nominal[1],
        use_TSet_in=true,
        dpFixed_nominal=dpFixed_nominal[1]) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}}, rotation=0)));
      TwoWayPIDV val220(
        redeclare package Medium = Medium,
        allowFlowReversal=allowFlowReversal,
        m_flow_nominal=m_flow_nominal[2],
        dpValve_nominal=dpValve_nominal[2],
        use_TSet_in=true,
        dpFixed_nominal=dpFixed_nominal[2]) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={0,40})));

      Buildings.Utilities.IO.SignalExchange.Overwrite TSetRadWes(description="Radiator setpoint for zone west",
          u(
          unit="K",
          min=285.15,
          max=313.15)) "Zone west radiator setpoint"
        annotation (Placement(transformation(extent={{-32,42},{-20,54}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite TSetRadNor(description="Radiator setpoint for zone north",
          u(
          unit="K",
          min=285.15,
          max=313.15)) "Zone north radiator setpoint"
        annotation (Placement(transformation(extent={{-32,2},{-20,14}})));
      Modelica.Blocks.Interfaces.RealInput TSet
        "Connector for measuremed temperature" annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={-74,126}), iconTransformation(extent={{-120,80},{-80,120}})));
      Modelica.Blocks.Routing.DeMultiplex2 deMultiplex2_1 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={38,80})));
    equation
      connect(jun3.port_3,val219. port_a) annotation (Line(points={{-50,-6.10623e-16},
              {-30,-6.10623e-16},{-30,0},{-10,0}}, color={0,127,255}));
      connect(val219.port_b, ports_b[1]) annotation (Line(points={{10,0},{56,0},{56,
              -10},{100,-10}},
                           color={0,127,255}));
      connect(val220.port_b, ports_b[2]) annotation (Line(points={{10,40},{60,40},{60,
              10},{100,10}}, color={0,127,255}));
      connect(val220.port_a, jun3.port_2)
        annotation (Line(points={{-10,40},{-60,40},{-60,10}}, color={0,127,255}));
      connect(TSetRadWes.y,val220. TSet_in) annotation (Line(
          points={{-19.4,48},{-16,48},{-16,47.8},{-11.6,47.8}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(TSetRadNor.y,val219. TSet_in) annotation (Line(
          points={{-19.4,8},{-16,8},{-16,7.8},{-11.6,7.8}},
          color={0,0,127},
          pattern=LinePattern.Dash));
      connect(port_a, jun3.port_1) annotation (Line(points={{-100,0},{-100,-56},{-60,
              -56},{-60,-10}}, color={0,127,255}));
      connect(TSet, TSetRadWes.u)
        annotation (Line(points={{-74,126},{-74,48},{-33.2,48}}, color={0,0,127}));
      connect(TSetRadNor.u, TSet)
        annotation (Line(points={{-33.2,8},{-74,8},{-74,126}}, color={0,0,127}));
      connect(deMultiplex2_1.y2[1], val220.T)
        annotation (Line(points={{32,69},{32,50.6},{0,50.6}}, color={0,0,127}));
      connect(deMultiplex2_1.y1[1], val219.T) annotation (Line(points={{44,69},{44,14},
              {0,14},{0,10.6}}, color={0,0,127}));
      connect(deMultiplex2_1.u, TMea) annotation (Line(points={{38,92},{38,106},{30,
              106},{30,130}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,46},{40,34}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,18},{40,6}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,-8},{40,-20}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,-34},{40,-46}},
              lineColor={215,215,215},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Line(points={{-100,0},{-72,0},{-72,40},{-40,40}}, color={28,108,200}),
            Line(points={{-72,12},{-40,12}}, color={28,108,200}),
            Line(points={{-72,0},{-72,-40},{-40,-40}}, color={28,108,200}),
            Line(points={{-72,-14},{-40,-14}}, color={28,108,200}),
            Line(points={{40,40},{90,40}}, color={28,108,200}),
            Line(points={{40,12},{90,12}}, color={28,108,200}),
            Line(points={{40,-14},{90,-14}}, color={28,108,200}),
            Line(points={{40,-40},{90,-40}}, color={28,108,200})}),  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,
                120}})));
    end WaterPIDSplitterManifold2Zone;

    model AirDCVSplitterManifold5Zone
      extends Buildings.Fluid.Interfaces.PartialTwoPortVector(nPorts=5);

      parameter Modelica.SIunits.MassFlowRate[5] m_flow_nominal=fill(1,5)
        "Nominal flow of each outgoing port"
        annotation(Dialog(group = "Nominal condition"));
        parameter Real CO2Set_fixed=800 "CO2 set point in ppm";
      parameter Real Kp[5]=fill(1,5) "Controller Gain";

      Buildings.Fluid.FixedResistances.Junction jun1(
        redeclare package Medium = Medium,
        m_flow_nominal={sum(m_flow_nominal),sum(m_flow_nominal) - m_flow_nominal[1],
            m_flow_nominal[1]},
        dp_nominal={0,0,0}) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,-80})));
      Buildings.Fluid.FixedResistances.Junction jun2(
        redeclare package Medium = Medium,
        m_flow_nominal={sum(m_flow_nominal) - m_flow_nominal[1],m_flow_nominal[3]+m_flow_nominal[4]+m_flow_nominal[5],
            m_flow_nominal[2]},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,-40})));
      Buildings.Fluid.FixedResistances.Junction jun3(
        redeclare package Medium = Medium,
        m_flow_nominal={m_flow_nominal[3]+m_flow_nominal[4]+m_flow_nominal[5],m_flow_nominal[4]+m_flow_nominal[5],
            m_flow_nominal[3]},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,0})));
      Buildings.Fluid.FixedResistances.Junction jun4(
        redeclare package Medium = Medium,
        m_flow_nominal={m_flow_nominal[4]+m_flow_nominal[5], m_flow_nominal[5],
            m_flow_nominal[4]},
        dp_nominal={0,0,0})
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-60,40})));
      DCVDamperCO2Setpoint dCVDamperCO2Setpoint_5(
        redeclare package Medium = Medium,
        m_flow_nominal=m_flow_nominal[5],
        use_CO2Set_in=true,
        Kp=Kp[5],
        dpDamper_nominal=dpDamper_nominal[5],
        dpFixed_nominal=dpFixed_nominal[5],
        yMin=yMin[5]) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={0,80})));

      DCVDamperCO2Setpoint dCVDamperCO2Setpoint_4(
        redeclare package Medium = Medium,
        m_flow_nominal=m_flow_nominal[4],
        use_CO2Set_in=true,
        Kp=Kp[4],
        dpDamper_nominal=dpDamper_nominal[4],
        dpFixed_nominal=dpFixed_nominal[4],
        yMin=yMin[4]) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={0,40})));
      DCVDamperCO2Setpoint dCVDamperCO2Setpoint_3(
        redeclare package Medium = Medium,
        m_flow_nominal=m_flow_nominal[3],
        use_CO2Set_in=true,
        Kp=Kp[3],
        dpDamper_nominal=dpDamper_nominal[3],
        dpFixed_nominal=dpFixed_nominal[3],
        yMin=yMin[3]) annotation (Placement(transformation(extent={{-10,10},{10,-10}},
              rotation=270)));
      DCVDamperCO2Setpoint dCVDamperCO2Setpoint_2(
        redeclare package Medium = Medium,
        m_flow_nominal=m_flow_nominal[2],
        use_CO2Set_in=true,
        Kp=Kp[2],
        dpDamper_nominal=dpDamper_nominal[2],
        dpFixed_nominal=dpFixed_nominal[2],
        yMin=yMin[2]) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={0,-40})));
      DCVDamperCO2Setpoint dCVDamperCO2Setpoint_1(
        redeclare package Medium = Medium,
        m_flow_nominal=m_flow_nominal[1],
        use_CO2Set_in=true,
        Kp=Kp[1],
        dpDamper_nominal=dpDamper_nominal[1],
        dpFixed_nominal=dpFixed_nominal[1],
        yMin=yMin[1]) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={0,-80})));
      Modelica.Blocks.Routing.DeMultiplex5 deMultiplex5_1 annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,110})));
      Modelica.Blocks.Interfaces.RealInput CO2Mea[5] "Measured CO2 content"
        annotation (Placement(transformation(extent={{-120,60},{-80,100}}),
            iconTransformation(extent={{-120,60},{-80,100}})));
      parameter Real yMin[5]=fill(0.05, 5)
                                  "Lower limit of damper position";
      parameter Modelica.SIunits.PressureDifference dpDamper_nominal[5](displayUnit=
           "Pa")=fill(0.27, 5)
        "Pressure drop of fully open damper at nominal mass flow rate"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dpFixed_nominal[5](displayUnit=
            "Pa")=fill(1E2 - 0.27, 5)
        "Pressure drop of duct and resistances other than the damper in series, at nominal mass flow rate"
        annotation (Dialog(group="Nominal condition"));
      Modelica.Blocks.Sources.Constant CO2set(k=CO2Set_fixed)
        annotation (Placement(transformation(extent={{-100,100},{-80,120}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite CO2SetCor(description="CO2 setpoint for zone core",
          u(
          unit="ppm",
          min=400,
          max=1000)) "Zone core CO2 setpoint"
        annotation (Placement(transformation(extent={{-32,92},{-20,104}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite CO2SetWes(description="CO2 setpoint for zone west",
          u(
          unit="ppm",
          min=400,
          max=1000)) "Zone west CO2 setpoint"
        annotation (Placement(transformation(extent={{-32,48},{-20,60}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite CO2SetNor(description="CO2 setpoint for zone north",
          u(
          unit="ppm",
          min=400,
          max=1000)) "Zone north CO2 setpoint"
        annotation (Placement(transformation(extent={{-32,10},{-20,22}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite CO2SetEas(description="CO2 setpoint for zone east",
          u(
          unit="ppm",
          min=400,
          max=1000)) "Zone west CO2 setpoint"
        annotation (Placement(transformation(extent={{-32,-30},{-20,-18}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite CO2SetSou(description="CO2 setpoint for zone south",
          u(
          unit="ppm",
          min=400,
          max=1000)) "Zone South CO2 setpoint"
        annotation (Placement(transformation(extent={{-32,-70},{-20,-58}})));
    equation
      connect(port_a, jun1.port_1) annotation (Line(points={{-100,0},{-96,0},{-96,-90},
              {-60,-90}}, color={0,127,255}));
      connect(jun1.port_2, jun2.port_1)
        annotation (Line(points={{-60,-70},{-60,-50}}, color={0,127,255}));
      connect(jun2.port_2, jun3.port_1)
        annotation (Line(points={{-60,-30},{-60,-10}}, color={0,127,255}));
      connect(jun3.port_2, jun4.port_1)
        annotation (Line(points={{-60,10},{-60,30}}, color={0,127,255}));
      connect(jun4.port_2, dCVDamperCO2Setpoint_5.portIn)
        annotation (Line(points={{-60,50},{-60,80},{-10,80}},color={0,127,255}));
      connect(dCVDamperCO2Setpoint_5.portOut, ports_b[5]) annotation (Line(points={{10,80},
              {80,80},{80,16},{100,16}},      color={0,127,255}));
      connect(jun4.port_3,dCVDamperCO2Setpoint_4. portIn)
        annotation (Line(points={{-50,40},{-10,40}}, color={0,127,255}));
      connect(dCVDamperCO2Setpoint_4.portOut, ports_b[4]) annotation (Line(points={{10,40},
              {74,40},{74,8},{100,8}},          color={0,127,255}));
      connect(jun3.port_3, dCVDamperCO2Setpoint_3.portIn) annotation (Line(points={{
              -50,-4.44089e-16},{-30,-4.44089e-16},{-30,1.77636e-15},{-10,1.77636e-15}},
            color={0,127,255}));
      connect(dCVDamperCO2Setpoint_3.portOut, ports_b[3]) annotation (Line(points={{
              10,-1.77636e-15},{80,-1.77636e-15},{80,0},{100,0}}, color={0,127,255}));
      connect(jun2.port_3, dCVDamperCO2Setpoint_2.portIn)
        annotation (Line(points={{-50,-40},{-10,-40}}, color={0,127,255}));
      connect(dCVDamperCO2Setpoint_2.portOut, ports_b[2]) annotation (Line(points={{10,-40},
              {74,-40},{74,-8},{100,-8}},       color={0,127,255}));
      connect(jun1.port_3, dCVDamperCO2Setpoint_1.portIn)
        annotation (Line(points={{-50,-80},{-10,-80}}, color={0,127,255}));
      connect(dCVDamperCO2Setpoint_1.portOut, ports_b[1]) annotation (Line(points={{10,-80},
              {80,-80},{80,-16},{100,-16}},       color={0,127,255}));
      connect(deMultiplex5_1.y1[1], dCVDamperCO2Setpoint_1.meaPPM) annotation (Line(
            points={{38,99},{38,-66},{1.88738e-15,-66},{1.88738e-15,-70}}, color={0,
              0,127}));
      connect(deMultiplex5_1.y2[1], dCVDamperCO2Setpoint_2.meaPPM) annotation (Line(
            points={{34,99},{34,-26},{1.88738e-15,-26},{1.88738e-15,-30}}, color={0,
              0,127}));
      connect(deMultiplex5_1.y3[1], dCVDamperCO2Setpoint_3.meaPPM) annotation (Line(
            points={{30,99},{30,14},{1.88738e-15,14},{1.88738e-15,10}}, color={0,0,
              127}));
      connect(deMultiplex5_1.y4[1], dCVDamperCO2Setpoint_4.meaPPM) annotation (Line(
            points={{26,99},{26,54},{1.88738e-15,54},{1.88738e-15,50}}, color={0,0,
              127}));
      connect(deMultiplex5_1.y5[1], dCVDamperCO2Setpoint_5.meaPPM) annotation (Line(
            points={{22,99},{22,90},{14,90},{14,96},{1.88738e-15,96},{1.88738e-15,90}},
                    color={0,0,127}));
      connect(deMultiplex5_1.u, CO2Mea) annotation (Line(points={{30,122},{-70,122},
              {-70,80},{-100,80}}, color={0,0,127}));
      connect(CO2set.y,CO2SetCor. u) annotation (Line(points={{-79,110},{-44,110},{-44,
              98},{-33.2,98}}, color={0,0,127}));
      connect(CO2SetCor.y, dCVDamperCO2Setpoint_5.CO2Set_in)
        annotation (Line(points={{-19.4,98},{-8,98},{-8,90}}, color={0,0,127}));
      connect(CO2set.y, CO2SetWes.u) annotation (Line(points={{-79,110},{-44,110},{-44,
              54},{-33.2,54}}, color={0,0,127}));
      connect(CO2SetWes.y, dCVDamperCO2Setpoint_4.CO2Set_in)
        annotation (Line(points={{-19.4,54},{-8,54},{-8,50}}, color={0,0,127}));
      connect(CO2set.y, CO2SetNor.u) annotation (Line(points={{-79,110},{-44,110},{-44,
              16},{-33.2,16}}, color={0,0,127}));
      connect(CO2SetNor.y, dCVDamperCO2Setpoint_3.CO2Set_in)
        annotation (Line(points={{-19.4,16},{-8,16},{-8,10}}, color={0,0,127}));
      connect(CO2set.y, CO2SetEas.u) annotation (Line(points={{-79,110},{-44,110},{-44,
              -24},{-33.2,-24}}, color={0,0,127}));
      connect(CO2SetEas.y, dCVDamperCO2Setpoint_2.CO2Set_in)
        annotation (Line(points={{-19.4,-24},{-8,-24},{-8,-30}}, color={0,0,127}));
      connect(CO2set.y, CO2SetSou.u) annotation (Line(points={{-79,110},{-44,110},{-44,
              -64},{-33.2,-64}}, color={0,0,127}));
      connect(CO2SetSou.y, dCVDamperCO2Setpoint_1.CO2Set_in)
        annotation (Line(points={{-19.4,-64},{-8,-64},{-8,-70}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,46},{40,34}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,26},{40,14}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,6},{40,-6}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,-14},{40,-26}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,-34},{40,-46}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Line(points={{-100,0},{-72,0},{-72,40},{-40,40}}, color={28,108,200}),
            Line(points={{-72,20},{-40,20}}, color={28,108,200}),
            Line(points={{-72,0},{-40,0}}, color={28,108,200}),
            Line(points={{-72,0},{-72,-40},{-40,-40}}, color={28,108,200}),
            Line(points={{-72,-20},{-40,-20}}, color={28,108,200}),
            Line(points={{40,40},{90,40}}, color={28,108,200}),
            Line(points={{40,20},{90,20}}, color={28,108,200}),
            Line(points={{40,0},{90,0}}, color={28,108,200}),
            Line(points={{40,-20},{90,-20}}, color={28,108,200}),
            Line(points={{40,-40},{90,-40}}, color={28,108,200})}),  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,
                120}})));
    end AirDCVSplitterManifold5Zone;

    model TwoWayTRV "Two way thermostatic radiator valve"
      extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(
         show_T=false,
         dp(start=0,
            nominal=6000),
         m_flow(
            nominal=if m_flow_nominal_pos > Modelica.Constants.eps
              then m_flow_nominal_pos else 1),
         final m_flow_small = 1E-4*abs(m_flow_nominal));

      extends Buildings.Fluid.Actuators.BaseClasses.ValveParameters(
        rhoStd=Medium.density_pTX(101325, 273.15+4, Medium.X_default));

      parameter Boolean use_TSet_in= false
        "Get the temperature setpoint from the input connector"
        annotation(Evaluate=true, HideResult=true,Dialog(group="Conditional inputs"));
      parameter Modelica.SIunits.Temperature TSet = 294.15
        "Fixed value of temperature"
        annotation (Dialog(enable = not use_TSet_in,group="Fixed inputs"));

      Modelica.Blocks.Interfaces.RealInput TSet_in(final unit="K",
                                                displayUnit="degC") if use_TSet_in
        "Prescribed temperature setpoint"
        annotation (Placement(transformation(extent={{-140,60},{-100,100}})));

      parameter Modelica.SIunits.Temperature P(displayUnit="K") = 2 "Proportional band of valve";

      parameter Boolean use_inputFilter=true
        "= true, if opening is filtered with a 2nd order CriticalDamping filter"
        annotation(Dialog(tab="Dynamics", group="Filtered opening"));
      parameter Modelica.SIunits.Time riseTime=1200
        "Rise time of the filter (time to reach 99.6 % of an opening step)"
        annotation(Dialog(tab="Dynamics", group="Filtered opening",enable=use_inputFilter));
      parameter Modelica.Blocks.Types.Init init=Modelica.Blocks.Types.Init.InitialOutput
        "Type of initialization (no init/steady state/initial state/initial output)"
        annotation(Dialog(tab="Dynamics", group="Filtered opening",enable=use_inputFilter));
      parameter Real y_start=1 "Initial value of control signal"
        annotation(Dialog(tab="Dynamics", group="Filtered opening",enable=use_inputFilter));
      parameter Modelica.SIunits.PressureDifference dpFixed_nominal(displayUnit="Pa", min=0) = 0
        "Pressure drop of pipe and other resistances that are in series"
         annotation(Dialog(group = "Nominal condition"));

      parameter Real l(min=1e-10, max=1) = 0.0001
        "Valve leakage, l=Kv(y=0)/Kv(y=1)";

      parameter Boolean from_dp = false
        "= true, use m_flow = f(dp) else dp = f(m_flow)"
        annotation (Evaluate=true, Dialog(tab="Advanced"));

      final parameter Modelica.SIunits.PressureDifference dp_nominal(displayUnit="Pa")=dpValve_nominal + dpFixed_nominal
        "Pressure drop at nominal mass flow rate"
        annotation(Dialog(group = "Nominal condition"));
      constant Boolean homotopyInitialization = true "= true, use homotopy method"
        annotation(Evaluate=true, Dialog(tab="Advanced"));
      parameter Boolean linearized = false
        "= true, use linear relation between m_flow and dp for any flow rate"
        annotation(Evaluate=true, Dialog(tab="Advanced"));

      final parameter Modelica.SIunits.MassFlowRate m_flow_turbulent(min=0)=deltaM * abs(m_flow_nominal)
        "Turbulent flow if |m_flow| >= m_flow_turbulent";

      Buildings.Fluid.Actuators.Valves.TwoWayLinear
                                                val(
        redeclare package Medium = Medium,
        m_flow_nominal=m_flow_nominal,
        dpValve_nominal=dpValve_nominal,
        allowFlowReversal=allowFlowReversal,
        show_T=show_T,
        from_dp=from_dp,
        homotopyInitialization=homotopyInitialization,
        linearized=linearized,
        deltaM=deltaM,
        rhoStd=rhoStd,
        use_inputFilter=use_inputFilter,
        riseTime=riseTime,
        init=init,
        y_start=y_start,
        dpFixed_nominal=dpFixed_nominal,
        l=l,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint) "Linear valve"
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

      Modelica.Blocks.Interfaces.RealInput T(unit="K") "Temperature measurement" annotation (
          Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,106})));
      Modelica.Blocks.Sources.RealExpression yExp(y=
            Buildings.Utilities.Math.Functions.smoothHeaviside(((TSet_in_internal
             + P/2) - T)/P - 0.5, 0.5))
          "Smooth control signal"
        annotation (Placement(transformation(extent={{-46,36},{-8,54}})));
      Modelica.Blocks.Interfaces.RealOutput y "Valve set point"
        annotation (Placement(transformation(extent={{40,60},{60,80}}),
            iconTransformation(extent={{40,60},{60,80}})));

    protected
      parameter Medium.ThermodynamicState sta_default=
         Medium.setState_pTX(T=Medium.T_default, p=Medium.p_default, X=Medium.X_default);
      parameter Modelica.SIunits.DynamicViscosity eta_default=Medium.dynamicViscosity(sta_default)
        "Dynamic viscosity, used to compute transition to turbulent flow regime";

      final parameter Modelica.SIunits.MassFlowRate m_flow_nominal_pos = abs(m_flow_nominal)
        "Absolute value of nominal flow rate";
      final parameter Modelica.SIunits.PressureDifference dp_nominal_pos(displayUnit="Pa") = abs(dp_nominal)
        "Absolute value of nominal pressure difference";
        Modelica.Blocks.Interfaces.RealInput TSet_in_internal(final unit="K",
                                                         displayUnit="degC")
                                                                            "Needed to connect to conditional connector";

    equation
      connect(yExp.y, val.y)
        annotation (Line(points={{-6.1,45},{0,45},{0,12}}, color={0,0,127}));
      connect(val.y_actual, y)
        annotation (Line(points={{5,7},{20,7},{20,70},{50,70}}, color={0,0,127}));
      connect(port_a, val.port_a)
        annotation (Line(points={{-100,0},{-56,0},{-10,0}}, color={0,127,255}));
      connect(val.port_b, port_b)
        annotation (Line(points={{10,0},{56,0},{100,0}}, color={0,127,255}));
      connect(TSet_in, TSet_in_internal);
      if not use_TSet_in then
        TSet_in_internal = TSet;
      end if;

    annotation (
    defaultComponentName="val",
    Documentation(info="<html>
<p>
Two way valve with thermostatic radiator knob. 
This model assumes no hysteresis and an 
ideal opening characteristic with a proportional band of <code>P</code> K.
The default value of <code>riseTime</code> has been set
to reflect the typical delay of radiator knobs.
</p>
</html>",
    revisions="<html>
<ul>
<li>
March 31, 2020 by Filip Jorissen:<br/>
Revised implementation using <code>smoothHeaviside</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1022\">#1022</a>.
</li>
<li>
October 26, 2018 by Filip Jorissen:<br/>
Using <code>smoothLimit</code> for P controller.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/948\">#948</a>.
</li>
<li>
September 24, 2018 by Filip Jorissen:<br/>
Modified displayUnit of proportional band P to Kelvin to avoid displaying -271.15C.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/919\">#919</a>.
</li>
<li>
November 15, 2016 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"),
        Icon(graphics={
            Rectangle(
              extent={{-100,40},{100,-42}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{-100,22},{100,-24}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,127,255}),
            Polygon(
              points={{2,-2},{-76,60},{-76,-60},{2,-2}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-50,40},{0,-2},{54,40},{54,40},{-50,40}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-52,-42},{0,-4},{60,40},{60,-42},{-52,-42}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{0,-2},{82,60},{82,-60},{0,-2}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,40},{0,-4}}),
            Polygon(
              points={{-60,44},{0,-2},{60,40},{-60,44}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{0,-2},{-76,60},{-76,-60},{0,-2}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-52,-42},{0,-4},{60,40},{60,-42},{-52,-42}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{0,-2},{82,60},{82,-60},{0,-2}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,88},{0,-4}}),
            Line(
              points={{0,40},{0,100}}),
            Line(
              points={{0,70},{40,70}}),
            Rectangle(
              visible=use_inputFilter,
              extent={{-32,40},{32,100}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Ellipse(
              visible=use_inputFilter,
              extent={{-32,100},{32,40}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Text(
              visible=use_inputFilter,
              extent={{-20,92},{20,48}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid,
              textString="M",
              textStyle={TextStyle.Bold})}));
    end TwoWayTRV;

    model TwoWayTRVtanh "Two way thermostatic radiator valve"
      extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(
         show_T=false,
         dp(start=0,
            nominal=6000),
         m_flow(
            nominal=if m_flow_nominal_pos > Modelica.Constants.eps
              then m_flow_nominal_pos else 1),
         final m_flow_small = 1E-4*abs(m_flow_nominal));

      extends Buildings.Fluid.Actuators.BaseClasses.ValveParameters(
        rhoStd=Medium.density_pTX(101325, 273.15+4, Medium.X_default));

      parameter Boolean use_TSet_in= false
        "Get the temperature setpoint from the input connector"
        annotation(Evaluate=true, HideResult=true,Dialog(group="Conditional inputs"));
      parameter Modelica.SIunits.Temperature TSet = 294.15
        "Fixed value of temperature"
        annotation (Dialog(enable = not use_TSet_in,group="Fixed inputs"));

      Modelica.Blocks.Interfaces.RealInput TSet_in(final unit="K",
                                                displayUnit="degC") if use_TSet_in
        "Prescribed temperature setpoint"
        annotation (Placement(transformation(extent={{-140,60},{-100,100}})));

      parameter Modelica.SIunits.Temperature P(displayUnit="K") = 2 "Proportional band of valve";

      parameter Boolean use_inputFilter=true
        "= true, if opening is filtered with a 2nd order CriticalDamping filter"
        annotation(Dialog(tab="Dynamics", group="Filtered opening"));
      parameter Modelica.SIunits.Time riseTime=1200
        "Rise time of the filter (time to reach 99.6 % of an opening step)"
        annotation(Dialog(tab="Dynamics", group="Filtered opening",enable=use_inputFilter));
      parameter Modelica.Blocks.Types.Init init=Modelica.Blocks.Types.Init.InitialOutput
        "Type of initialization (no init/steady state/initial state/initial output)"
        annotation(Dialog(tab="Dynamics", group="Filtered opening",enable=use_inputFilter));
      parameter Real y_start=1 "Initial value of control signal"
        annotation(Dialog(tab="Dynamics", group="Filtered opening",enable=use_inputFilter));
      parameter Modelica.SIunits.PressureDifference dpFixed_nominal(displayUnit="Pa", min=0) = 0
        "Pressure drop of pipe and other resistances that are in series"
         annotation(Dialog(group = "Nominal condition"));

      parameter Real l(min=1e-10, max=1) = 0.0001
        "Valve leakage, l=Kv(y=0)/Kv(y=1)";

      parameter Boolean from_dp = false
        "= true, use m_flow = f(dp) else dp = f(m_flow)"
        annotation (Evaluate=true, Dialog(tab="Advanced"));

      final parameter Modelica.SIunits.PressureDifference dp_nominal(displayUnit="Pa")=dpValve_nominal + dpFixed_nominal
        "Pressure drop at nominal mass flow rate"
        annotation(Dialog(group = "Nominal condition"));
      constant Boolean homotopyInitialization = true "= true, use homotopy method"
        annotation(Evaluate=true, Dialog(tab="Advanced"));
      parameter Boolean linearized = false
        "= true, use linear relation between m_flow and dp for any flow rate"
        annotation(Evaluate=true, Dialog(tab="Advanced"));

      final parameter Modelica.SIunits.MassFlowRate m_flow_turbulent(min=0)=deltaM * abs(m_flow_nominal)
        "Turbulent flow if |m_flow| >= m_flow_turbulent";

      Buildings.Fluid.Actuators.Valves.TwoWayLinear
                                                val(
        redeclare package Medium = Medium,
        m_flow_nominal=m_flow_nominal,
        dpValve_nominal=dpValve_nominal,
        allowFlowReversal=allowFlowReversal,
        show_T=show_T,
        from_dp=from_dp,
        homotopyInitialization=homotopyInitialization,
        linearized=linearized,
        deltaM=deltaM,
        rhoStd=rhoStd,
        use_inputFilter=use_inputFilter,
        riseTime=riseTime,
        init=init,
        y_start=y_start,
        dpFixed_nominal=dpFixed_nominal,
        l=l,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint) "Linear valve"
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

      Modelica.Blocks.Interfaces.RealInput T(unit="K") "Temperature measurement" annotation (
          Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,106})));
      Modelica.Blocks.Sources.RealExpression yExp(y=max(tanh(TSet_in_internal
             - T), 0))
          "Smooth control signal"
        annotation (Placement(transformation(extent={{-46,36},{-8,54}})));
      Modelica.Blocks.Interfaces.RealOutput y "Valve set point"
        annotation (Placement(transformation(extent={{40,60},{60,80}}),
            iconTransformation(extent={{40,60},{60,80}})));

    protected
      parameter Medium.ThermodynamicState sta_default=
         Medium.setState_pTX(T=Medium.T_default, p=Medium.p_default, X=Medium.X_default);
      parameter Modelica.SIunits.DynamicViscosity eta_default=Medium.dynamicViscosity(sta_default)
        "Dynamic viscosity, used to compute transition to turbulent flow regime";

      final parameter Modelica.SIunits.MassFlowRate m_flow_nominal_pos = abs(m_flow_nominal)
        "Absolute value of nominal flow rate";
      final parameter Modelica.SIunits.PressureDifference dp_nominal_pos(displayUnit="Pa") = abs(dp_nominal)
        "Absolute value of nominal pressure difference";
        Modelica.Blocks.Interfaces.RealInput TSet_in_internal(final unit="K",
                                                         displayUnit="degC")
                                                                            "Needed to connect to conditional connector";

    equation
      connect(yExp.y, val.y)
        annotation (Line(points={{-6.1,45},{0,45},{0,12}}, color={0,0,127}));
      connect(val.y_actual, y)
        annotation (Line(points={{5,7},{20,7},{20,70},{50,70}}, color={0,0,127}));
      connect(port_a, val.port_a)
        annotation (Line(points={{-100,0},{-56,0},{-10,0}}, color={0,127,255}));
      connect(val.port_b, port_b)
        annotation (Line(points={{10,0},{56,0},{100,0}}, color={0,127,255}));
      connect(TSet_in, TSet_in_internal);
      if not use_TSet_in then
        TSet_in_internal = TSet;
      end if;

    annotation (
    defaultComponentName="val",
    Documentation(info="<html>
<p>
Two way valve with thermostatic radiator knob. 
This model assumes no hysteresis and an 
ideal opening characteristic with a proportional band of <code>P</code> K.
The default value of <code>riseTime</code> has been set
to reflect the typical delay of radiator knobs.
</p>
</html>",
    revisions="<html>
<ul>
<li>
March 31, 2020 by Filip Jorissen:<br/>
Revised implementation using <code>smoothHeaviside</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1022\">#1022</a>.
</li>
<li>
October 26, 2018 by Filip Jorissen:<br/>
Using <code>smoothLimit</code> for P controller.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/948\">#948</a>.
</li>
<li>
September 24, 2018 by Filip Jorissen:<br/>
Modified displayUnit of proportional band P to Kelvin to avoid displaying -271.15C.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/919\">#919</a>.
</li>
<li>
November 15, 2016 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"),
        Icon(graphics={
            Rectangle(
              extent={{-100,40},{100,-42}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{-100,22},{100,-24}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,127,255}),
            Polygon(
              points={{2,-2},{-76,60},{-76,-60},{2,-2}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-50,40},{0,-2},{54,40},{54,40},{-50,40}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-52,-42},{0,-4},{60,40},{60,-42},{-52,-42}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{0,-2},{82,60},{82,-60},{0,-2}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,40},{0,-4}}),
            Polygon(
              points={{-60,44},{0,-2},{60,40},{-60,44}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{0,-2},{-76,60},{-76,-60},{0,-2}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-52,-42},{0,-4},{60,40},{60,-42},{-52,-42}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{0,-2},{82,60},{82,-60},{0,-2}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,88},{0,-4}}),
            Line(
              points={{0,40},{0,100}}),
            Line(
              points={{0,70},{40,70}}),
            Rectangle(
              visible=use_inputFilter,
              extent={{-32,40},{32,100}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Ellipse(
              visible=use_inputFilter,
              extent={{-32,100},{32,40}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Text(
              visible=use_inputFilter,
              extent={{-20,92},{20,48}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid,
              textString="M",
              textStyle={TextStyle.Bold})}));
    end TwoWayTRVtanh;

    model TwoWayPIDV "Two way thermostatic radiator valve"
      extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(
         show_T=false,
         dp(start=0,
            nominal=6000),
         m_flow(
            nominal=if m_flow_nominal_pos > Modelica.Constants.eps
              then m_flow_nominal_pos else 1),
         final m_flow_small = 1E-4*abs(m_flow_nominal));

      extends Buildings.Fluid.Actuators.BaseClasses.ValveParameters(
        rhoStd=Medium.density_pTX(101325, 273.15+4, Medium.X_default));

      parameter Boolean use_TSet_in= false
        "Get the temperature setpoint from the input connector"
        annotation(Evaluate=true, HideResult=true,Dialog(group="Conditional inputs"));
      parameter Modelica.SIunits.Temperature TSet = 294.15
        "Fixed value of temperature"
        annotation (Dialog(enable = not use_TSet_in,group="Fixed inputs"));

      Modelica.Blocks.Interfaces.RealInput TSet_in(final unit="K",
                                                displayUnit="degC") if use_TSet_in
        "Prescribed temperature setpoint"
        annotation (Placement(transformation(extent={{-160,58},{-120,98}})));

      parameter Modelica.SIunits.Temperature P(displayUnit="K") = 2 "Proportional band of valve";

      parameter Boolean use_inputFilter=true
        "= true, if opening is filtered with a 2nd order CriticalDamping filter"
        annotation(Dialog(tab="Dynamics", group="Filtered opening"));
      parameter Modelica.SIunits.Time riseTime=1200
        "Rise time of the filter (time to reach 99.6 % of an opening step)"
        annotation(Dialog(tab="Dynamics", group="Filtered opening",enable=use_inputFilter));
      parameter Modelica.Blocks.Types.Init init=Modelica.Blocks.Types.Init.InitialOutput
        "Type of initialization (no init/steady state/initial state/initial output)"
        annotation(Dialog(tab="Dynamics", group="Filtered opening",enable=use_inputFilter));
      parameter Real y_start=1 "Initial value of control signal"
        annotation(Dialog(tab="Dynamics", group="Filtered opening",enable=use_inputFilter));
      parameter Modelica.SIunits.PressureDifference dpFixed_nominal(displayUnit="Pa", min=0) = 0
        "Pressure drop of pipe and other resistances that are in series"
         annotation(Dialog(group = "Nominal condition"));

      parameter Real l(min=1e-10, max=1) = 0.0001
        "Valve leakage, l=Kv(y=0)/Kv(y=1)";

      parameter Boolean from_dp = false
        "= true, use m_flow = f(dp) else dp = f(m_flow)"
        annotation (Evaluate=true, Dialog(tab="Advanced"));

      final parameter Modelica.SIunits.PressureDifference dp_nominal(displayUnit="Pa")=dpValve_nominal + dpFixed_nominal
        "Pressure drop at nominal mass flow rate"
        annotation(Dialog(group = "Nominal condition"));
      constant Boolean homotopyInitialization = true "= true, use homotopy method"
        annotation(Evaluate=true, Dialog(tab="Advanced"));
      parameter Boolean linearized = false
        "= true, use linear relation between m_flow and dp for any flow rate"
        annotation(Evaluate=true, Dialog(tab="Advanced"));

      final parameter Modelica.SIunits.MassFlowRate m_flow_turbulent(min=0)=deltaM * abs(m_flow_nominal)
        "Turbulent flow if |m_flow| >= m_flow_turbulent";

      Buildings.Fluid.Actuators.Valves.TwoWayLinear
                                                val(
        redeclare package Medium = Medium,
        m_flow_nominal=m_flow_nominal,
        dpValve_nominal=dpValve_nominal,
        allowFlowReversal=allowFlowReversal,
        show_T=show_T,
        from_dp=from_dp,
        homotopyInitialization=homotopyInitialization,
        linearized=linearized,
        deltaM=deltaM,
        rhoStd=rhoStd,
        use_inputFilter=use_inputFilter,
        riseTime=riseTime,
        init=init,
        y_start=y_start,
        dpFixed_nominal=dpFixed_nominal,
        l=l,
        CvData=Buildings.Fluid.Types.CvTypes.OpPoint) "Linear valve"
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

      Modelica.Blocks.Interfaces.RealInput T(unit="K") "Temperature measurement" annotation (
          Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,106})));
      Modelica.Blocks.Interfaces.RealOutput y "Valve set point"
        annotation (Placement(transformation(extent={{40,60},{60,80}}),
            iconTransformation(extent={{40,60},{60,80}})));

      Buildings.Controls.Continuous.LimPID conPID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.1,
        Ti=900,
        Td=900,
        yMax=100,
        Ni=0.9,
        Nd=0.5,
        xi_start=0,
        reset=Buildings.Types.Reset.Disabled)
        annotation (Placement(transformation(extent={{-84,68},{-64,88}})));
      Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
        annotation (Placement(transformation(extent={{-32,50},{-12,70}})));
      Buildings.Utilities.IO.SignalExchange.Overwrite oveValRad(description=
            "Radiator valve control signal [0-1]", u(
          min=0,
          max=1,
          unit="1")) "Overwrite for radiator valve"                  annotation (
          Placement(transformation(
            extent={{9,-9},{-9,9}},
            rotation=90,
            origin={9,35})));
    protected
      parameter Medium.ThermodynamicState sta_default=
         Medium.setState_pTX(T=Medium.T_default, p=Medium.p_default, X=Medium.X_default);
      parameter Modelica.SIunits.DynamicViscosity eta_default=Medium.dynamicViscosity(sta_default)
        "Dynamic viscosity, used to compute transition to turbulent flow regime";

      final parameter Modelica.SIunits.MassFlowRate m_flow_nominal_pos = abs(m_flow_nominal)
        "Absolute value of nominal flow rate";
      final parameter Modelica.SIunits.PressureDifference dp_nominal_pos(displayUnit="Pa") = abs(dp_nominal)
        "Absolute value of nominal pressure difference";
        Modelica.Blocks.Interfaces.RealInput TSet_in_internal(final unit="K",
                                                         displayUnit="degC")
                                                                            "Needed to connect to conditional connector";

    equation
      connect(val.y_actual, y)
        annotation (Line(points={{5,7},{20,7},{20,70},{50,70}}, color={0,0,127}));
      connect(port_a, val.port_a)
        annotation (Line(points={{-100,0},{-56,0},{-10,0}}, color={0,127,255}));
      connect(val.port_b, port_b)
        annotation (Line(points={{10,0},{56,0},{100,0}}, color={0,127,255}));
      connect(TSet_in, TSet_in_internal);
      if not use_TSet_in then
        TSet_in_internal = TSet;
      end if;

      connect(conPID.u_s, TSet_in)
        annotation (Line(points={{-86,78},{-140,78}}, color={0,0,127}));
      connect(conPID.y, limiter.u) annotation (Line(points={{-63,78},{-40,78},{
              -40,60},{-34,60}},
                             color={0,0,127}));
      connect(T, conPID.u_m) annotation (Line(points={{0,106},{0,48},{-74,48},{
              -74,66}},      color={0,0,127}));
      connect(limiter.y, oveValRad.u)
        annotation (Line(points={{-11,60},{9,60},{9,45.8}}, color={0,0,127}));
      connect(oveValRad.y, val.y)
        annotation (Line(points={{9,25.1},{9,12},{0,12}}, color={0,0,127}));
    annotation (
    defaultComponentName="val",
    Documentation(info="<html>
<p>
Two way valve with thermostatic radiator knob. 
This model assumes no hysteresis and an 
ideal opening characteristic with a proportional band of <code>P</code> K.
The default value of <code>riseTime</code> has been set
to reflect the typical delay of radiator knobs.
</p>
</html>",
    revisions="<html>
<ul>
<li>
March 31, 2020 by Filip Jorissen:<br/>
Revised implementation using <code>smoothHeaviside</code>.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/1022\">#1022</a>.
</li>
<li>
October 26, 2018 by Filip Jorissen:<br/>
Using <code>smoothLimit</code> for P controller.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/948\">#948</a>.
</li>
<li>
September 24, 2018 by Filip Jorissen:<br/>
Modified displayUnit of proportional band P to Kelvin to avoid displaying -271.15C.
See <a href=\"https://github.com/open-ideas/IDEAS/issues/919\">#919</a>.
</li>
<li>
November 15, 2016 by Filip Jorissen:<br/>
First implementation.
</li>
</ul>
</html>"),
        Icon(graphics={
            Rectangle(
              extent={{-100,40},{100,-42}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192}),
            Rectangle(
              extent={{-100,22},{100,-24}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,127,255}),
            Polygon(
              points={{2,-2},{-76,60},{-76,-60},{2,-2}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-50,40},{0,-2},{54,40},{54,40},{-50,40}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-52,-42},{0,-4},{60,40},{60,-42},{-52,-42}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{0,-2},{82,60},{82,-60},{0,-2}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,40},{0,-4}}),
            Polygon(
              points={{-60,44},{0,-2},{60,40},{-60,44}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{0,-2},{-76,60},{-76,-60},{0,-2}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-52,-42},{0,-4},{60,40},{60,-42},{-52,-42}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{0,-2},{82,60},{82,-60},{0,-2}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{0,88},{0,-4}}),
            Line(
              points={{0,40},{0,100}}),
            Line(
              points={{0,70},{40,70}}),
            Rectangle(
              visible=use_inputFilter,
              extent={{-32,40},{32,100}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Ellipse(
              visible=use_inputFilter,
              extent={{-32,100},{32,40}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Text(
              visible=use_inputFilter,
              extent={{-20,92},{20,48}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid,
              textString="M",
              textStyle={TextStyle.Bold})}));
    end TwoWayPIDV;

    model DCVDamperCO2Setpoint "DCV damper controlled by CO2 setpoint"
      replaceable package Medium = Buildings.Media.Air constrainedby
        Modelica.Media.Interfaces.PartialMedium;

      parameter Modelica.SIunits.MassFlowRate m_flow_nominal
        "Nominal mass flow rate"
        annotation (Dialog(group="Nominal condition"));
      parameter Real l(
        min=1e-10,
        max=1) = 0.0001 "Damper leakage, ratio of flow coefficients k(y=0)/k(y=1)"
        annotation (Dialog(group="Damper coefficients"));
        parameter Boolean use_CO2Set_in=false
        "Get the CO2 setpoint from the input connector"
        annotation(Evaluate=true, HideResult=true,Dialog(group="Conditional inputs"));
      parameter Real CO2Set=800    "CO2 set point in volume fraction"
      annotation (Dialog(enable = not use_CO2Set_in,group="Fixed inputs"));
      Modelica.Blocks.Interfaces.RealInput CO2Set_in if use_CO2Set_in
        "Prescribed CO2 setpoint"
        annotation (Placement(transformation(extent={{-120,60},{-80,100}})));
      parameter Real Kp=1 "Controller Gain";
      parameter Modelica.SIunits.PressureDifference dpDamper_nominal(displayUnit="Pa")=
         0.27   "Pressure drop of fully open damper at nominal mass flow rate"
        annotation (Dialog(group="Nominal condition"));
      parameter Modelica.SIunits.PressureDifference dpFixed_nominal(displayUnit="Pa")=
         1E2 - 0.27
        "Pressure drop of duct and resistances other than the damper in series, at nominal mass flow rate"
        annotation (Dialog(group="Nominal condition"));

      Buildings.Fluid.Actuators.Dampers.Exponential vav(
        redeclare package Medium = Medium,
        m_flow_nominal=m_flow_nominal,
        from_dp=false,
        dpDamper_nominal=dpDamper_nominal,
        dpFixed_nominal=dpFixed_nominal,
        final l=l)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Fluid.Interfaces.FluidPort_a portIn(redeclare package Medium =
            Medium) "Fluid port"
        annotation (Placement(transformation(extent={{-10,90},{10,110}})));
      Modelica.Blocks.Interfaces.RealOutput yDam "Damper control signal"
        annotation (Placement(transformation(extent={{100,-10},{120,10}}),
            iconTransformation(extent={{100,-10},{120,10}})));
      BaseClasses.DamperControlVarSetpnt con(Kp=Kp, yMin=yMin) "Damper controller"
        annotation (Placement(transformation(extent={{-44,-56},{-24,-36}})));

      Modelica.Blocks.Interfaces.RealInput meaPPM "mesured ppm trace substance"
        annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
      Modelica.Fluid.Interfaces.FluidPort_b portOut(redeclare package Medium =
            Medium)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

      Buildings.Fluid.Sensors.VolumeFlowRate senVolFlo(
        redeclare package Medium = Medium,             m_flow_nominal=
            m_flow_nominal,
        tau=10)             annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,52})));
      Modelica.Blocks.Interfaces.RealOutput V_flow1
        "Volume flow rate from port_a to port_b"
        annotation (Placement(transformation(extent={{100,42},{120,62}})));
      parameter Real yMin=0.05 "Lower limit of damper position";

    protected
      Modelica.Blocks.Interfaces.RealInput CO2Set_in_internal(final unit="K",
          displayUnit="degC") "Needed to connect to conditional connector";
    equation
      connect(con.y, yDam) annotation (Line(
          points={{-23,-46},{50,-46},{50,0},{110,0}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(con.y, vav.y) annotation (Line(
          points={{-23,-46},{50,-46},{50,-2.22045e-15},{12,-2.22045e-15}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(meaPPM, con.u) annotation (Line(points={{-100,0},{-50,0},{-50,-46},{
              -46,-46}},
                     color={0,0,127}));
      connect(vav.port_b, portOut)
        annotation (Line(points={{0,-10},{0,-100}}, color={0,127,255}));
      connect(portIn, senVolFlo.port_a) annotation (Line(points={{5.55112e-16,100},
              {5.55112e-16,81},{1.77636e-15,81},{1.77636e-15,62}}, color={0,127,255}));
      connect(senVolFlo.port_b, vav.port_a) annotation (Line(points={{-1.83187e-15,
              42},{5.55112e-16,10},{1.77636e-15,10}}, color={0,127,255}));
      connect(senVolFlo.V_flow, V_flow1)
        annotation (Line(points={{11,52},{110,52}}, color={0,0,127}));
     connect(con.u_s, CO2Set_in_internal);
     connect(CO2Set_in, CO2Set_in_internal);
      if not use_CO2Set_in then
        CO2Set_in_internal = CO2Set;
      end if;
       annotation (
        Diagram(coordinateSystem(preserveAspectRatio=true)),
        Icon(                                               graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              visible=use_inputFilter,
              extent={{42,-30},{100,26}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Ellipse(
              visible=use_inputFilter,
              extent={{42,24},{100,-30}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-10,100},{8,-102}},
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Text(
              extent={{-92,-50},{94,-84}},
              pattern=LinePattern.None,
              fillColor={0,127,255},
              fillPattern=FillPattern.Solid,
              textString="%name",
              lineColor={0,0,0}),
            Rectangle(
              extent={{-100,23},{100,-23}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,127,255},
              origin={2,-1},
              rotation=90),
            Rectangle(
              extent={{-100,41},{100,-41}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={192,192,192},
              origin={2,-1},
              rotation=90),
            Rectangle(
              extent={{-100,23},{100,-23}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,127,255},
              origin={0,-1},
              rotation=90),            Polygon(
              points={{-24,-15},{24,27},{24,15},{-24,-27},{-24,-15}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Solid,
              origin={0,27},
              rotation=90),                   Polygon(
              points={{-24,-15},{24,27},{24,15},{-24,-27},{-24,-15}},
              lineColor={0,0,0},
              fillPattern=FillPattern.Solid,
              origin={4,-17},
              rotation=90),
            Text(
              visible=use_inputFilter,
              extent={{54,18},{88,-22}},
              textColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid,
              textString="M",
              textStyle={TextStyle.Bold})}),
        Documentation(info="<html>
<p>
Model of a room and a plenum. CO2 is injected into the room.
An air damper controls how much air flows into the room to track
the CO2 level.
</p>
</html>",     revisions="<html>
<ul>
<li>
January 23, 2017, by Michael Wetter:<br/>
Removed <code>allowFlowReversal=false</code> as
<code>roo.roo49.dpPle.port_a.m_flow</code> and
<code>roo.roo50.dpPle.port_a.m_flow</code>
have negative mass flow rates.
</li>
<li>
January 20, 2017, by Michael Wetter:<br/>
Removed the use of <code>TraceSubstancesFlowSource</code>
and instead used the input connector <code>C_flow</code>
of the volume. This reduces computing time from <i>25</i>
to <i>12</i> seconds.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/628\">#628</a>.
</li>
<li>
July 20, 2007 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end DCVDamperCO2Setpoint;

    model ControlledEffectivenessNTU
      "Heat exchanger with controlled effectiveness e.g rotary wheel, for variable flow"
      extends Buildings.Fluid.HeatExchangers.BaseClasses.PartialEffectivenessNTU(
        configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
          UA=UA_nominal*rel_eps_contr,
          use_Q_flow_nominal=false);

      Modelica.Blocks.Interfaces.RealInput rel_eps_contr(max=1, min=0)
      "control input for relative effectiveness"
       annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,108}), iconTransformation(
            extent={{-12,-12},{12,12}},
            rotation=270,
            origin={0,88})));

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Rectangle(
              extent={{-70,78},{70,-82}},
              lineColor={0,0,255},
              pattern=LinePattern.None,
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid), Text(
              extent={{-56,-12},{54,-72}},
              lineColor={255,255,255},
              textString="eps=%eps")}),
              preferredView="info",
    defaultComponentName="hex",
    Documentation(info="<html>
<p>
Model for a heat exchanger with constant effectiveness.
</p>
<p>
This model transfers heat in the amount of
</p>
<p align=\"center\" style=\"font-style:italic;\">
  Q = Q<sub>max</sub> &epsilon;,
</p>
<p>
where <i>&epsilon;</i> is a constant effectiveness and
<i>Q<sub>max</sub></i> is the maximum heat that can be transferred.
</p>
<p>
For a heat and moisture exchanger, use
<a href=\"modelica://Buildings.Fluid.MassExchangers.ConstantEffectiveness\">
Buildings.Fluid.MassExchangers.ConstantEffectiveness</a>
instead of this model.
</p>
</html>",
    revisions="<html>
<ul>
<li>
August 13, 2013 by Michael Wetter:<br/>
Corrected error in the documentation.
</li>
<li>
July 30, 2013 by Michael Wetter:<br/>
Updated model to use new variable <code>mWat_flow</code>
in the base class.
</li>
<li>
January 28, 2010, by Michael Wetter:<br/>
Added regularization near zero flow.
</li>
<li>
October 2, 2009, by Michael Wetter:<br/>
Changed computation of inlet temperatures to use
<code>state_*_inflow</code> which is already known in base class.
</li>
<li>
April 28, 2008, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
    end ControlledEffectivenessNTU;
  end Components;
annotation (uses(
    Modelica(version="3.2.3"),
    Buildings(version="8.1.0"),
    SintefBuildings(version="1"),
      ModelicaServices(version="4.0.0")));
end TwinRooms;
