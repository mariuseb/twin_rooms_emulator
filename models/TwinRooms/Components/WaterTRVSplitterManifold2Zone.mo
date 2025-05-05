within Adrenalin2_training.Components;
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
end WaterTRVSplitterManifold2Zone;
