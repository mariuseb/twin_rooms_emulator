within Adrenalin2_training.Components.Sensors;
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
