within Adrenalin2_training.Components.Sensors;
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
