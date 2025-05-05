within Adrenalin2_training.Components.BaseClasses;
model shading "Control signal for shading"
  parameter Modelica.SIunits.Irradiance threshold=150
    "Shading closed when total external sola irradation is above this threshold";
  parameter Modelica.SIunits.Angle til "Surface tilt";
  parameter Modelica.SIunits.Angle lat "Latitude";
  parameter Modelica.SIunits.Angle azi "Surface azimuth";

  Buildings.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTilPerez(
    til=til,
    lat=lat,
    azi=azi) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface HDirTil(
    til=til,
    lat=lat,
    azi=azi)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data"
    annotation (Placement(transformation(extent={{-100,84},{-80,104}})));

  Modelica.Blocks.Logical.Greater          greater
    "Greater comparison"
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Modelica.Blocks.Math.BooleanToReal booToRea(realTrue=1, realFalse=0)
    "Boolean to real conversion"
    annotation (Placement(transformation(extent={{28,-10},{48,10}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-38,-10},{-18,10}})));

  parameter Integer nout=1 "Number of outputs";
  Modelica.Blocks.Interfaces.RealOutput y "Connector for shade position"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.Constant const(k=threshold)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
equation
  connect(HDifTilPerez.weaBus, weaBus) annotation (Line(
      points={{-80,30},{-82,30},{-82,94},{-90,94}},
      color={255,204,51},
      thickness=0.5));
  connect(HDirTil.weaBus, weaBus) annotation (Line(
      points={{-80,-30},{-82,-30},{-82,94},{-90,94}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(booToRea.u,greater. y)
    annotation (Line(points={{26,0},{13,0}}, color={255,0,255}));
  connect(HDifTilPerez.H, add.u1)
    annotation (Line(points={{-59,30},{-40,30},{-40,6}}, color={0,0,127}));
  connect(HDirTil.H, add.u2)
    annotation (Line(points={{-59,-30},{-40,-30},{-40,-6}}, color={0,0,127}));
  connect(booToRea.y, y)
    annotation (Line(points={{49,0},{110,0}}, color={0,0,127}));
  connect(add.y, greater.u1)
    annotation (Line(points={{-17,0},{-10,0}}, color={0,0,127}));
  connect(greater.u2, const.y)
    annotation (Line(points={{-10,-8},{-10,-60},{-59,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(
          points={{-40,60},{-40,66},{-40,100},{10,100}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{-40,60},{-20,60},{-20,80},{10,80}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{-36,60},{-36,-20}},
          color={0,0,0},
          thickness=0.5,
          smooth=Smooth.None),
        Polygon(
          points={{-90,80},{-40,60},{-36,60},{-36,-20},{-90,0},{-90,80}},
          smooth=Smooth.None,
          pattern=LinePattern.None,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Polygon(
          points={{-36,40},{10,20},{10,-32},{-20,-20},{-36,-20},{-36,40}},
          smooth=Smooth.None,
          pattern=LinePattern.None,
          fillColor={179,179,179},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Line(
          points={{-40,-20},{-20,-20},{-20,-70},{-20,-70},{10,-70}},
          color={95,95,95},
          smooth=Smooth.None),
        Line(
          points={{-40,-20},{-40,-90},{10,-90}},
          color={95,95,95},
          smooth=Smooth.None)}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end shading;
