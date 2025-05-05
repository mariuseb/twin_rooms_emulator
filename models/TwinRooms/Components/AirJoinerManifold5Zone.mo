within Adrenalin2_training.Components;
model AirJoinerManifold5Zone
  extends Adrenalin2_training.Components.BaseClasses.Interfaces.PartialTwoPortVectorRev(nPorts=5);

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
