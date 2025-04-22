within Adrenalin2_training.Components.BaseClasses;
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
