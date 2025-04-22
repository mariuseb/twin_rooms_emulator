within Adrenalin2_training.Components;
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
    Buildings.Fluid.Sensors.VolumeFlowRate senVolFloSu(redeclare package Medium =
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
