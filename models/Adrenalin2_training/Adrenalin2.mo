within Adrenalin2_training;
model Adrenalin2
  extends Modelica.Icons.Example;

  package MediumA = Buildings.Media.Air (extraPropertiesNames={"CO2"}) "Medium model for air";
  package MediumW = Buildings.Media.Water "Medium model for water";

  Components.Floor5Zone_Shading floor5Zone_Shading(
    lat=lat,
    gai(data(MatEmi=8.64E-6*0.01)),
    fixedTempBoundary(T=288.15))
    annotation (Placement(transformation(extent={{50,114},{156,174}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3
                                            weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "Resources/NOR_OS_Oslo.Blindern.014920_TMYx.mos"),
      computeWetBulbTemperature=false)
    annotation (Placement(transformation(extent={{-200,182},{-180,202}})));
  Buildings.BoundaryConditions.WeatherData.Bus
                                     weaBus "Weather Data Bus"
    annotation (Placement(transformation(extent={{-164,170},{-144,190}}),
        iconTransformation(extent={{-360,170},{-340,190}})));
  parameter Modelica.SIunits.Angle lat=1.0454522219446 "Latitude";
  Components.AHUPresHHB AHU(
    m_flow_nominal_air=m_flow_nominal_air,
    m_flow_nominal_water=m_flow_nominal_water_AHU,
    dp_nominal_ext=200,
    dp_nominal_coilWat=10000,
    Q_flow_nominal_coil=37000,
    redeclare package Air = MediumA,
    redeclare package Water = MediumW)
    annotation (Placement(transformation(extent={{-164,108},{-132,128}})));
  Modelica.Blocks.Sources.Constant SupPreSet(k=200) "Supply pressure setpoint"
    annotation (Placement(transformation(extent={{-200,124},{-180,144}})));
  Modelica.Blocks.Sources.Constant TAirSupSet(k=273.15 + 19)
    annotation (Placement(transformation(extent={{-200,154},{-180,174}})));
  Components.TwoWayHeatBattery twoWayHeatBattery(
    redeclare package Medium = MediumW,
    m_flow_nominal=m_flow_nominal_water_AHU,
    dpValve_nominal(displayUnit="Pa"),
    dpFixed_nominal(displayUnit="Pa"),
    dpExternal_nominal(displayUnit="Pa") = AHU.dp_nominal_coilWat,
    m_flow_nominal_bypass=m_flow_nominal_water_AHU/1000,
    conPIDcoil(k=0.01, Ti=30))
    annotation (Placement(transformation(extent={{-132,80},{-152,100}})));
  Components.AirDCVSplitterManifold5Zone venSupManDam(
    redeclare package Medium = MediumA,
    m_flow_nominal={0.1,0.1,0.1,1E-3,1E-3},
    Kp=fill(10, 5),
    yMin=fill(0.1, 5),
    dpFixed_nominal=fill(200 - 0.27, 5),
    nPorts=5) "Ventilation supply manifold with dampers"
    annotation (Placement(transformation(extent={{-32,84},{-12,104}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 radEas(
    redeclare package Medium = MediumW,
    Q_flow_nominal(displayUnit="W") = 1,
    T_a_nominal=328.15,
    T_b_nominal=308.15,
    TAir_nominal=294.15,
    dp_nominal=0) "radiator for east facade"
    annotation (Placement(transformation(extent={{164,112},{184,132}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad219(
    redeclare package Medium = MediumW,
    Q_flow_nominal(displayUnit="W") = 30*floor5Zone_Shading.AFlo219,
    T_a_nominal=320.15,
    T_b_nominal=308.15,
    TAir_nominal=294.15,
    VWat=5.68E-5*abs(rad219.Q_flow_nominal),
    mDry=0.263*abs(rad219.Q_flow_nominal),
    dp_nominal=0) "radiator for room 2.19"
    annotation (Placement(transformation(extent={{100,90},{120,110}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad220(
    redeclare package Medium = MediumW,
    Q_flow_nominal(displayUnit="W") = 30*floor5Zone_Shading.AFlo220,
    T_a_nominal=320.15,
    T_b_nominal=308.15,
    TAir_nominal=294.15,
    dp_nominal=0) "radiator for room 2.20"
    annotation (Placement(transformation(extent={{22,114},{42,134}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad2nd(
    redeclare package Medium = MediumW,
    Q_flow_nominal(displayUnit="W") = 30*floor5Zone_Shading.AFlo2nd,
    T_a_nominal=320.15,
    T_b_nominal=308.15,
    TAir_nominal=294.15,
    dp_nominal=0) "radiator for rest of 2nd floor"
    annotation (Placement(transformation(extent={{68,172},{88,192}})));
  Components.WaterTRVSplitterManifold4Zone radSupMan(
    redeclare package Medium = MediumW,
    m_flow_nominal={rad219.m_flow_nominal,radEas.m_flow_nominal,rad2nd.m_flow_nominal,
        rad220.m_flow_nominal},
    nPorts=4,
    TRooSet(k=273.15 + 22),
    valSou(conPID(k=0.5, yMin=0,
        initType=Modelica.Blocks.Types.InitPID.InitialState,
        xi_start=0,
        xd_start=0)))
              "Radiator manifold with valves" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={14,4})));
  Components.WaterJoinerManifold4Zone radRetMan(
    redeclare package Medium = MediumW,
    m_flow_nominal=fill(m_flow_nominal_water_rad/4, 4),
    nPorts=4) "Radiator circuit return manifold" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,4})));
  Components.AirJoinerManifold5Zone VenRetMan(redeclare package Medium =
        MediumA, m_flow_nominal={0.1,0.1,0.1,1E-3,1E-3})
    "Ventilation return manifold"
    annotation (Placement(transformation(extent={{-12,132},{-32,152}})));
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
    annotation (Placement(transformation(extent={{-142,-98},{-122,-118}})));
  Buildings.Fluid.FixedResistances.Junction jun2(redeclare package Medium =
        MediumW,
    m_flow_nominal={m_flow_nominal_water_rad,m_flow_nominal_water_AHU,
        m_flow_nominal_water_AHU + m_flow_nominal_water_rad},
                 dp_nominal={0,0,0})
    annotation (Placement(transformation(extent={{-142,-136},{-162,-156}})));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal_air=3
    "Nominal mass flow rate - air"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal_water_AHU=0.3
    "Nominal mass flow rate - water in AHU"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal_water_rad=0.6
    "Nominal mass flow rate - water in rad"
    annotation (Dialog(group="Nominal condition"));
  Modelica.Blocks.Sources.Constant pumDP(k=15000 + 20000)
    annotation (Placement(transformation(extent={{-200,-180},{-180,-160}})));
  Buildings.Utilities.IO.SignalExchange.Read reaFanPow(
    description="AHU Fan power",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W"))
    annotation (Placement(transformation(extent={{-188,86},{-200,98}})));

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

  Buildings.Utilities.IO.SignalExchange.Read reaVenHeaPow(
    description="Ventilation heating power",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="W"))
    annotation (Placement(transformation(extent={{-188,62},{-200,74}})));

  Components.Sensors.EnergyMeter energyMeter(
    redeclare package Medium1 = MediumW,
    redeclare package Medium2 = MediumW,
    m1_flow_nominal=m_flow_nominal_water_rad,
    m2_flow_nominal=m_flow_nominal_water_rad) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-4,-68})));
  Buildings.Utilities.IO.SignalExchange.Read reaVenHeaEne(
    description="Ventilation heating energy",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="J"))
    annotation (Placement(transformation(extent={{-188,50},{-200,62}})));

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

  Buildings.Fluid.FixedResistances.Pipe pipSupCoil(
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
  Buildings.Fluid.FixedResistances.Pipe pipRetCoil(
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

  connect(floor5Zone_Shading.ports1st[2], VenRetMan.ports_a[3]) annotation (
      Line(points={{92.1696,159.231},{90,159.231},{90,142},{-12,142}}, color={
          255,170,85}));
  connect(floor5Zone_Shading.ports220[2], VenRetMan.ports_a[4]) annotation (
      Line(points={{63.5957,143.538},{21.2217,143.538},{21.2217,142},{-12,142}},
        color={255,170,85}));
  connect(floor5Zone_Shading.ports2nd[2], VenRetMan.ports_a[5]) annotation (
      Line(points={{92.1696,143.538},{35.5087,143.538},{35.5087,142},{-12,142}},
        color={255,170,85}));
  connect(floor5Zone_Shading.ports219[2], VenRetMan.ports_a[1]) annotation (
      Line(points={{92.1696,126.923},{92.1696,124},{90,124},{90,142},{-12,142}},
        color={255,170,85}));
  connect(floor5Zone_Shading.ports3rd[2], VenRetMan.ports_a[2]) annotation (
      Line(points={{144.709,143.538},{146,143.538},{146,142},{-12,142}}, color=
          {255,170,85}));
  connect(AHU.weaBus, weaBus) annotation (Line(
      points={{-163,127.4},{-163,150},{-168,150},{-168,170},{-154,170},{-154,
          180}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(SupPreSet.y, AHU.y) annotation (Line(
      points={{-179,134},{-154,134},{-154,129}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TAirSupSet.y, AHU.TsupSet) annotation (Line(
      points={{-179,164},{-148.4,164},{-148.4,129}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(AHU.Tsu, twoWayHeatBattery.TemMea) annotation (Line(
      points={{-131.4,110},{-124,110},{-124,91.4},{-132,91.4}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TAirSupSet.y, twoWayHeatBattery.TemSet) annotation (Line(points={{-179,
          164},{-114,164},{-114,88},{-132,88}},
        color={0,0,127},
      pattern=LinePattern.Dash));
  connect(twoWayHeatBattery.secSup, AHU.port_a2) annotation (Line(points={{-132,
          100},{-138,100},{-138,108}},
                                     color={102,44,145}));
  connect(AHU.port_b2, twoWayHeatBattery.secRet) annotation (Line(points={{-144,
          108},{-144,100},{-151.8,100}},
                                       color={0,127,255}));
  connect(venSupManDam.ports_b[5], floor5Zone_Shading.ports2nd[1]) annotation (
      Line(points={{-12,95.6},{12,95.6},{12,143.538},{89.8652,143.538}}, color=
          {0,140,72}));
  connect(venSupManDam.ports_b[1], floor5Zone_Shading.ports219[1]) annotation (
      Line(points={{-12,92.4},{12,92.4},{12,140},{82,140},{82,142},{89.8652,142},
          {89.8652,126.923}}, color={0,140,72}));
  connect(venSupManDam.ports_b[3], floor5Zone_Shading.ports1st[1]) annotation (
      Line(points={{-12,94},{12,94},{12,142},{89.8652,142},{89.8652,159.231}},
        color={0,140,72}));
  connect(venSupManDam.ports_b[4], floor5Zone_Shading.ports220[1]) annotation (
      Line(points={{-12,94.8},{12,94.8},{12,143.538},{61.2913,143.538}}, color=
          {0,140,72}));
  connect(venSupManDam.ports_b[2], floor5Zone_Shading.ports3rd[1]) annotation (
      Line(points={{-12,93.2},{12,93.2},{12,140},{82,140},{82,143.538},{142.404,
          143.538}}, color={0,140,72}));
  connect(floor5Zone_Shading.CO2Roo, venSupManDam.CO2Mea) annotation (Line(
      points={{158.304,150.923},{162,150.923},{162,124},{158,124},{158,76},{-42,
          76},{-42,102},{-32,102}},
      color={0,0,127},
      pattern=LinePattern.Dash));
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
  connect(floor5Zone_Shading.heaPorRad1st,rad2nd. heatPortRad) annotation (Line(
        points={{99.0826,158.538},{99.0826,156},{94,156},{94,192},{80,192},{80,
          189.2}},
        color={191,0,0}));
  connect(rad2nd.heatPortCon,floor5Zone_Shading.heaPorAir1st)  annotation (Line(
        points={{76,189.2},{76,196},{96,196},{96,178},{99.0826,178},{99.0826,
          162.231}},
        color={191,0,0}));
  connect(radSupMan.ports_b[1],rad219. port_a) annotation (Line(points={{15.5,14},
          {15.5,100},{100,100}}, color={102,44,145}));
  connect(radSupMan.ports_b[2], radEas.port_a) annotation (Line(points={{14.5,14},
          {14.5,84},{164,84},{164,122}}, color={102,44,145}));
  connect(radSupMan.ports_b[3],rad2nd. port_a) annotation (Line(points={{13.5,14},
          {13.5,182},{68,182}}, color={102,44,145}));
  connect(radSupMan.ports_b[4],rad220. port_a) annotation (Line(points={{12.5,14},
          {12.5,124},{22,124}}, color={102,44,145}));
  connect(floor5Zone_Shading.TRooAir, radSupMan.TMea) annotation (Line(
      points={{158.304,144},{160,144},{160,70},{-4,70},{-4,-6},{4,-6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(rad219.port_b, radRetMan.ports_a[1]) annotation (Line(points={{120,100},
          {122,100},{122,68},{-21.5,68},{-21.5,14}}, color={0,127,255}));
  connect(radEas.port_b, radRetMan.ports_a[2]) annotation (Line(points={{184,122},
          {190,122},{190,68},{-20.5,68},{-20.5,14}}, color={0,127,255}));
  connect(rad2nd.port_b, radRetMan.ports_a[3]) annotation (Line(points={{88,182},
          {98,182},{98,198},{10,198},{10,74},{-19.5,74},{-19.5,14}}, color={0,127,
          255}));
  connect(rad220.port_b, radRetMan.ports_a[4]) annotation (Line(points={{42,124},
          {42,68},{-18.5,68},{-18.5,14}}, color={0,127,255}));
  connect(jun2.port_2, districtHeating.port_a) annotation (Line(points={{-162,-146},
          {-166,-146},{-166,-134},{-172,-134}}, color={0,127,255}));
  connect(jun.port_1, districtHeating.port_b) annotation (Line(points={{-142,-108},
          {-166,-108},{-166,-122},{-172,-122}}, color={102,44,145}));
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
  connect(AHU.qel, reaFanPow.u) annotation (Line(
      points={{-158,107.4},{-158,92},{-186.8,92}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(districtHeating.qel, reaPumPow.u) annotation (Line(
      points={{-176,-117.4},{-176,-82},{-186.8,-82}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(VenRetMan.port_b, AHU.port_a1) annotation (Line(points={{-32,142},{-100,
          142},{-100,122},{-132,122}}, color={244,125,35}));
  connect(AHU.port_b1, venSupManDam.port_a) annotation (Line(points={{-132,114},
          {-100,114},{-100,94},{-32,94}}, color={0,140,72}));
  connect(districtHeating.pdh, reaDHPow.u) annotation (Line(
      points={{-186.8,-117},{-186.8,-94},{-186.8,-94}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(twoWayHeatBattery.Pow, reaVenHeaPow.u) annotation (Line(points={{-152.8,
          93},{-152.8,90},{-162,90},{-162,68},{-186.8,68}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(twoWayHeatBattery.Ene, reaVenHeaEne.u) annotation (Line(
      points={{-152.8,91},{-152.8,88},{-158,88},{-158,56},{-186.8,56}},
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
  connect(jun.port_2, energyMeter.port_a1) annotation (Line(points={{-122,-108},
          {2,-108},{2,-78}}, color={0,127,255}));
  connect(jun.port_3, pipSupCoil.port_a)
    annotation (Line(points={{-132,-98},{-132,-54}}, color={0,127,255}));
  connect(pipSupCoil.port_b, twoWayHeatBattery.priSup)
    annotation (Line(points={{-132,-34},{-132,80}}, color={0,127,255}));
  connect(twoWayHeatBattery.priRet, pipRetCoil.port_a)
    annotation (Line(points={{-152,80},{-152,-34}}, color={0,127,255}));
  connect(energyMeter.port_b1, pipSupRad.port_a) annotation (Line(points={{2,-58},
          {2,-54},{14,-54},{14,-44}},      color={0,127,255}));
  connect(pipSupRad.port_b, radSupMan.port_a)
    annotation (Line(points={{14,-24},{14,-6}}, color={0,127,255}));
  connect(energyMeter.port_a2, pipRetRad.port_b) annotation (Line(points={{-10,-58},
          {-10,-54},{-20,-54},{-20,-42}},      color={0,127,255}));
  connect(pipRetRad.port_a, radRetMan.port_b)
    annotation (Line(points={{-20,-22},{-20,-6}}, color={0,127,255}));
  connect(tPipHeaLoss.port, pipRetCoil.heatPort)
    annotation (Line(points={{-80,-4},{-147,-4},{-147,-44}}, color={191,0,0}));
  connect(tPipHeaLoss.port, pipSupCoil.heatPort) annotation (Line(points={{-80,
          -4},{-116,-4},{-116,-44},{-127,-44}}, color={191,0,0}));
  connect(tPipHeaLoss.port, pipRetRad.heatPort) annotation (Line(points={{-80,
          -4},{-116,-4},{-116,-50},{-4,-50},{-4,-32},{-15,-32}}, color={191,0,0}));
  connect(tPipHeaLoss.port, pipSupRad.heatPort) annotation (Line(points={{-80,-4},
          {-116,-4},{-116,-50},{30,-50},{30,-34},{19,-34}},
                              color={191,0,0}));
  connect(jun2.port_1, senTemRadRet.port_b) annotation (Line(points={{-142,-146},
          {-10,-146},{-10,-104}}, color={0,127,255}));
  connect(senTemRadRet.port_a, energyMeter.port_b2)
    annotation (Line(points={{-10,-84},{-10,-78}}, color={0,127,255}));
  connect(pipRetCoil.port_b, senTemVenRet.port_a)
    annotation (Line(points={{-152,-54},{-152,-74}}, color={0,127,255}));
  connect(senTemVenRet.port_b, jun2.port_3)
    annotation (Line(points={{-152,-94},{-152,-136}}, color={0,127,255}));
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
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}})),
    experiment(
      StopTime=1209600,
      Interval=29.9999808,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end Adrenalin2;
