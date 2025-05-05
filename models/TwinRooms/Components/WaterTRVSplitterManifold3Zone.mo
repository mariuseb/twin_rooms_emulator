within Adrenalin2_training.Components;
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
  connect(val2nd.port_b, ports_b[3]) annotation (Line(points={{10,40},{60,40},{
          60,13.3333},{100,13.3333}},
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
