within Adrenalin2_training;
model Adrenalin2
  extends Modelica.Icons.Example;

  package MediumA = Buildings.Media.Air (extraPropertiesNames={"CO2"}) "Medium model for air";
  package MediumW = Buildings.Media.Water "Medium model for water";

  Components.Floor5Zone_Shading floor5Zone_Shading(lat=lat, gai(data(MatEmi=
            8.64E-6*0.01)))
    annotation (Placement(transformation(extent={{50,114},{156,174}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3
                                            weaDat(filNam=
        "/home/marius/Desktop/twin_rooms_emulator/models/Resources/NOR_TD_Trondheim-Voll.012570_TMYx.2009-2023.mos",
      computeWetBulbTemperature=false)
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
    Q_flow_nominal(displayUnit="W") = 60*floor5Zone_Shading.AFlo219,
    T_a_nominal=320.15,
    T_b_nominal=308.15,
    TAir_nominal=294.15,
    VWat=5.68E-6*abs(rad219.Q_flow_nominal),
    mDry=0.0263*abs(rad219.Q_flow_nominal),
    dp_nominal=0) "radiator for room 2.19"
    annotation (Placement(transformation(extent={{100,90},{120,110}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad220(
    redeclare package Medium = MediumW,
    Q_flow_nominal(displayUnit="W") = 60*floor5Zone_Shading.AFlo220,
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
  Components.WaterTRVSplitterManifold2Zone waterTRVSplitterManifold2Zone(
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
  connect(jun.port_2, energyMeter.port_a1) annotation (Line(points={{-86,-110},{
          14,-110},{14,-78},{2,-78}},
                             color={0,127,255}));
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
  connect(jun2.port_1, senTemRadRet.port_b) annotation (Line(points={{-96,-146},
          {-10,-146},{-10,-104}}, color={0,127,255}));
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
        points={{-132,114},{-96,114},{-96,90},{89.8652,90},{89.8652,126.923}},
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
        points={{-298,64},{-174,64},{-174,28},{-52,28},{-52,76},{63.5957,76},{
          63.5957,143.538}},
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
    annotation (Line(points={{158.304,143.231},{174,143.231},{174,40},{70,40},{
          70,-16},{18.75,-16},{18.75,16}}, color={0,0,127}));
  connect(floor5Zone_Shading.TRooAir[2], waterTRVSplitterManifold2Zone.TMea[2])
    annotation (Line(points={{158.304,144},{182,144},{182,-12},{60,-12},{60,-24},
          {17.25,-24},{17.25,16}}, color={0,0,127}));
  connect(floor5Zone_Shading.CO2Roo[1], AHU219.CO2meas) annotation (Line(points
        ={{158.304,150},{158.304,162},{-52,162},{-52,152},{-144.2,152},{-144.2,
          129}}, color={0,0,127}));
  connect(floor5Zone_Shading.CO2Roo[2], AHU220.CO2meas) annotation (Line(points
        ={{158.304,150.462},{158.304,174},{-82,174},{-82,148},{-310.2,148},{
          -310.2,79}}, color={0,0,127}));
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
      Interval=29.9999808,
      Tolerance=1e-06,
      __Dymola_Algorithm="Radau"));
end Adrenalin2;
