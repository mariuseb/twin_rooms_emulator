within Adrenalin2_training.Components;
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
  Modelica.Blocks.Sources.Constant TRooNig(k=273.15 + 16)
    "Room temperature set point at night"
    annotation (Placement(transformation(extent={{-182,60},{-162,80}})));
  Modelica.Blocks.Sources.Constant TRooSet(k=273.15 + 21)
    annotation (Placement(transformation(extent={{-182,120},{-162,140}})));
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
      points={{-19.4,48},{-12,48}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TSetRadNor.y, valNor.TSet_in) annotation (Line(
      points={{-19.4,8},{-12,8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TSetRadEas.y, valEas.TSet_in) annotation (Line(
      points={{-21.4,-32},{-12,-32}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TSetRadSou.y, valSou.TSet_in) annotation (Line(
      points={{-19.4,-72},{-12,-72}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(occSch.occupied, switch1.u2) annotation (Line(points={{-161,92},{-154,
          92},{-154,114},{-110,114},{-110,120}}, color={255,0,255}));
  connect(TRooNig.y, switch1.u3) annotation (Line(points={{-161,70},{-146,70},
          {-146,112},{-110,112}}, color={0,0,127}));
  connect(TRooSet.y, switch1.u1) annotation (Line(points={{-161,130},{-146,130},
          {-146,138},{-134,138},{-134,128},{-110,128}}, color={0,0,127}));
  connect(switch1.y, TSetRadWes.u) annotation (Line(points={{-87,120},{-72,120},
          {-72,104},{-54,104},{-54,48},{-33.2,48}}, color={0,0,127}));
  connect(switch1.y, TSetRadNor.u) annotation (Line(points={{-87,120},{-72,120},
          {-72,114},{-46,114},{-46,8},{-33.2,8}}, color={0,0,127}));
  connect(switch1.y, TSetRadEas.u) annotation (Line(points={{-87,120},{-76,120},
          {-76,96},{-44,96},{-44,-32},{-35.2,-32}}, color={0,0,127}));
  connect(switch1.y, TSetRadSou.u) annotation (Line(points={{-87,120},{-74,120},
          {-74,112},{-44,112},{-44,-72},{-33.2,-72}}, color={0,0,127}));
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
