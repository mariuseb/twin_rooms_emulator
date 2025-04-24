within Adrenalin2_training.Components.BaseClasses;
partial model PartialFloor "Interface for a model of a floor of a building"

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for air" annotation (choicesAllMatching=true);

  parameter Boolean use_windPressure=true
    "Set to true to enable wind pressure";

  parameter Real kIntNor(min=0, max=1) = 1
    "Gain factor to scale internal heat gain in north zone";

  parameter Modelica.SIunits.Volume VRoo219 "Room volume corridor";
  parameter Modelica.SIunits.Volume VRoo220 "Room volume south";
  parameter Modelica.SIunits.Volume VRoo2nd "Room volume north";

  parameter Modelica.SIunits.Area AFlo219 "Floor area 219";
  parameter Modelica.SIunits.Area AFlo220 "Floor area 220";
  parameter Modelica.SIunits.Area AFlo2nd "Floor area 2nd";

  final parameter Modelica.SIunits.Area AFloTot = AFlo219+AFlo220+AFlo2nd "Floor area total";

  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports219[2](
      redeclare package Medium = Medium) "Fluid inlets and outlets"
    annotation (Placement(transformation(extent={{70,-44},{110,-28}}),
        iconTransformation(extent={{78,-32},{118,-16}})));

  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports3rd[2](
      redeclare package Medium = Medium) "Fluid inlets and outlets"
    annotation (Placement(transformation(extent={{310,28},{350,44}}),
        iconTransformation(extent={{306,40},{346,56}})));

  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports1st[2](
      redeclare package Medium = Medium) "Fluid inlets and outlets"
    annotation (Placement(transformation(extent={{70,116},{110,132}}),
        iconTransformation(extent={{78,108},{118,124}})));

  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports220[2](
      redeclare package Medium = Medium) "Fluid inlets and outlets"
    annotation (Placement(transformation(extent={{-50,36},{-10,52}}),
        iconTransformation(extent={{-46,40},{-6,56}})));

  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports2nd[2](
      redeclare package Medium = Medium) "Fluid inlets and outlets"
    annotation (Placement(transformation(extent={{70,38},{110,54}}),
        iconTransformation(extent={{78,40},{118,56}})));

  Modelica.Blocks.Interfaces.RealOutput TRooAir[5](
    each unit="K",
    each displayUnit="degC") "Room air temperatures"
    annotation (Placement(transformation(extent={{380,150},{400,170}}),
        iconTransformation(extent={{380,40},{400,60}})));

  Modelica.Blocks.Interfaces.RealOutput p_rel
    "Relative pressure signal of building static pressure" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-170,220}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,50})));

  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather bus"
    annotation (Placement(transformation(extent={{200,190},{220,210}})));

  Buildings.Examples.VAVReheat.BaseClasses.RoomLeakage lea219(
    redeclare package Medium = Medium,
    VRoo=VRoo219,
    s=49.91/33.27,
    azi=Buildings.Types.Azimuth.S,
    final use_windPressure=use_windPressure)
    "Model for air infiltration through the envelope"
    annotation (Placement(transformation(extent={{-58,380},{-22,420}})));


  Buildings.Examples.VAVReheat.BaseClasses.RoomLeakage lea2nd(
    redeclare package Medium = Medium,
    VRoo=VRoo2nd,
    s=49.91/33.27,
    azi=Buildings.Types.Azimuth.N,
    final use_windPressure=use_windPressure)
    "Model for air infiltration through the envelope"
    annotation (Placement(transformation(extent={{-56,300},{-20,340}})));

  Buildings.Examples.VAVReheat.BaseClasses.RoomLeakage lea220(
    redeclare package Medium = Medium,
    VRoo=VRoo220,
    s=33.27/49.91,
    azi=Buildings.Types.Azimuth.W,
    final use_windPressure=use_windPressure)
    "Model for air infiltration through the envelope"
    annotation (Placement(transformation(extent={{-56,260},{-20,300}})));

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAir219
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{290,340},{310,360}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAir3rd
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,310},{312,330}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAir1st
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,280},{312,300}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAir220
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,248},{312,268}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAir2nd
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{294,218},{314,238}})));
  Modelica.Blocks.Routing.Multiplex5 multiplex5_1
    annotation (Placement(transformation(extent={{350,280},{370,300}})));

  Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium = Medium)
    "Building pressure measurement"
    annotation (Placement(transformation(extent={{60,240},{40,260}})));
  Buildings.Fluid.Sources.Outside out(nPorts=1, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-58,240},{-38,260}})));

  Buildings.Utilities.IO.SignalExchange.Read reaT219(
    description="Temperature of room 219",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    zone="1",
    y(unit="K"))
    annotation (Placement(transformation(extent={{320,346},{328,354}})));

  Buildings.Utilities.IO.SignalExchange.Read reaTEas(
    description="Temperature of 3rd floor",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    zone="2",
    y(unit="K"))
    annotation (Placement(transformation(extent={{322,316},{330,324}})));

  Buildings.Utilities.IO.SignalExchange.Read reaTNor(
    description="Temperature of 1st floor",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    zone="3",
    y(unit="K"))
    annotation (Placement(transformation(extent={{320,286},{328,294}})));

  Buildings.Utilities.IO.SignalExchange.Read reaTWea(
    description="Temperature of room 220",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    zone="4",
    y(unit="K"))
    annotation (Placement(transformation(extent={{318,254},{326,262}})));

  Buildings.Utilities.IO.SignalExchange.Read reaTCor(
    description="Temperature of 2nd floor",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,
    zone="5",
    y(unit="K"))
    annotation (Placement(transformation(extent={{322,224},{330,232}})));

equation
  connect(weaBus, lea219.weaBus) annotation (Line(
      points={{210,200},{-80,200},{-80,400},{-58,400}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(weaBus, lea2nd.weaBus) annotation (Line(
      points={{210,200},{-80,200},{-80,320},{-56,320}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(weaBus, lea220.weaBus) annotation (Line(
      points={{210,200},{-80,200},{-80,280},{-56,280}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(out.weaBus, weaBus) annotation (Line(
      points={{-58,250.2},{-70,250.2},{-70,250},{-80,250},{-80,200},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(multiplex5_1.y, TRooAir) annotation (Line(
      points={{371,290},{372,290},{372,160},{390,160}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(senRelPre.p_rel, p_rel) annotation (Line(
      points={{50,241},{50,220},{-170,220}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(out.ports[1], senRelPre.port_b) annotation (Line(
      points={{-38,250},{40,250}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(temAir219.T,reaT219. u) annotation (Line(
      points={{310,350},{319.2,350}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(reaT219.y, multiplex5_1.u1[1]) annotation (Line(
      points={{328.4,350},{342,350},{342,300},{348,300}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(temAir3rd.T, reaTEas.u) annotation (Line(
      points={{312,320},{321.2,320}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(reaTEas.y, multiplex5_1.u2[1]) annotation (Line(
      points={{330.4,320},{336,320},{336,295},{348,295}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(temAir1st.T, reaTNor.u) annotation (Line(
      points={{312,290},{319.2,290}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(reaTNor.y, multiplex5_1.u3[1]) annotation (Line(
      points={{328.4,290},{348,290}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(temAir220.T, reaTWea.u) annotation (Line(
      points={{312,258},{317.2,258}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(reaTWea.y, multiplex5_1.u4[1]) annotation (Line(
      points={{326.4,258},{326.4,256},{336,256},{336,285},{348,285}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(temAir2nd.T, reaTCor.u) annotation (Line(
      points={{314,228},{321.2,228}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(reaTCor.y, multiplex5_1.u5[1]) annotation (Line(
      points={{330.4,228},{342,228},{342,280},{348,280}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,
        extent={{-160,-100},{380,500}},
        initialScale=0.1)),   Icon(coordinateSystem(extent={{-80,-80},{380,160}},
        preserveAspectRatio=true),
         graphics={Rectangle(
          extent={{-80,160},{380,-80}},
          lineColor={95,95,95},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-118,94},{-96,60}},
          textColor={0,0,255},
          textString="dP")}),
    Documentation(info="<html>
<p>
This is a partial model for one floor of the DOE reference office building.
</p>
</html>",
revisions="<html>
<ul>
<li>
January 25, 2021, by Michael Wetter:<br/>
Replaced door model with the new model <a href=\"modelica://Buildings.Airflow.Multizone.DoorOpen\">
Buildings.Airflow.Multizone.DoorOpen</a>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1353\">IBPSA, #1353</a>.
</li>
<li>
November 15, 2019, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end PartialFloor;
