within Adrenalin2_training.Components.BaseClasses;
partial model PartialFloor "Interface for a model of a floor of a building"

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for air" annotation (choicesAllMatching=true);

  parameter Boolean use_windPressure=true
    "Set to true to enable wind pressure";

  parameter Real kIntNor(min=0, max=1) = 1
    "Gain factor to scale internal heat gain in north zone";

  parameter Modelica.SIunits.Volume VRooCor "Room volume corridor";
  parameter Modelica.SIunits.Volume VRooSou "Room volume south";
  parameter Modelica.SIunits.Volume VRooNor "Room volume north";
  parameter Modelica.SIunits.Volume VRooEas "Room volume east";
  parameter Modelica.SIunits.Volume VRooWes "Room volume west";

  parameter Modelica.SIunits.Area AFloCor "Floor area corridor";
  parameter Modelica.SIunits.Area AFloSou "Floor area south";
  parameter Modelica.SIunits.Area AFloNor "Floor area north";
  parameter Modelica.SIunits.Area AFloEas "Floor area east";
  parameter Modelica.SIunits.Area AFloWes "Floor area west";

  final parameter Modelica.SIunits.Area AFloTot = AFloCor+AFloSou+AFloNor+AFloEas+AFloWes "Floor area total";

  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports220[2](
      redeclare package Medium = Medium) "Fluid inlets and outlets"
    annotation (Placement(transformation(extent={{-136,-86},{-96,-70}}),
        iconTransformation(extent={{78,-32},{118,-16}})));

  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports219[2](
      redeclare package Medium = Medium) "Fluid inlets and outlets"
    annotation (Placement(transformation(extent={{316,-82},{356,-66}}),
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
    VRoo=VRooNor,
    s=49.91/33.27,
    azi=Buildings.Types.Azimuth.N,
    final use_windPressure=use_windPressure)
    "Model for air infiltration through the envelope"
    annotation (Placement(transformation(extent={{-56,300},{-20,340}})));

  Buildings.Examples.VAVReheat.BaseClasses.RoomLeakage lea220(
    redeclare package Medium = Medium,
    VRoo=VRooWes,
    s=33.27/49.91,
    azi=Buildings.Types.Azimuth.W,
    final use_windPressure=use_windPressure)
    "Model for air infiltration through the envelope"
    annotation (Placement(transformation(extent={{-56,260},{-20,300}})));

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAir219
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{290,340},{310,360}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAir220
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{292,310},{312,330}})));

  Buildings.Airflow.Multizone.DoorOpen ope220(redeclare package Medium = Medium,
      wOpe=1) "Opening between perimeter2 and core"
    annotation (Placement(transformation(extent={{-130,-30},{-110,-10}})));
  Buildings.Airflow.Multizone.DoorOpen ope219(redeclare package Medium = Medium,
      wOpe=1) "Opening between perimeter3 and core"
    annotation (Placement(transformation(extent={{320,-32},{340,-12}})));
  Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium
      =                                                                         Medium)
    "Building pressure measurement"
    annotation (Placement(transformation(extent={{60,240},{40,260}})));
  Buildings.Fluid.Sources.Outside out(nPorts=1, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-58,240},{-38,260}})));

  Buildings.Utilities.IO.SignalExchange.Read reaTAir219(
    description="Temperature of room 219",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,

    zone="1",
    y(unit="K"))
    annotation (Placement(transformation(extent={{320,346},{328,354}})));

  Buildings.Utilities.IO.SignalExchange.Read reaTAir220(
    description="Temperature of room 220",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,

    zone="2",
    y(unit="K"))
    annotation (Placement(transformation(extent={{322,316},{330,324}})));

  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports2nd[2](redeclare
      package Medium = Medium) "Fluid inlets and outlets" annotation (Placement(
        transformation(extent={{74,152},{114,168}}), iconTransformation(extent=
            {{78,-32},{118,-16}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports1st[2](redeclare
      package Medium = Medium) "Fluid inlets and outlets" annotation (Placement(
        transformation(extent={{530,142},{570,158}}), iconTransformation(extent
          ={{78,-32},{118,-16}})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports3rd[2](redeclare
      package Medium = Medium) "Fluid inlets and outlets" annotation (Placement(
        transformation(extent={{534,-34},{574,-18}}), iconTransformation(extent
          ={{78,-32},{118,-16}})));
  Modelica.Blocks.Routing.Multiplex5 multiplex5_2
    annotation (Placement(transformation(extent={{380,290},{400,310}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAir2nd
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{296,278},{316,298}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTAir2nd(
    description="Temperature of 2nd floor rest",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,

    zone="3",
    y(unit="K"))
    annotation (Placement(transformation(extent={{326,284},{334,292}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTAir1st(
    description="Temperature of 1st floor",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,

    zone="4",
    y(unit="K"))
    annotation (Placement(transformation(extent={{324,252},{332,260}})));
  Buildings.Utilities.IO.SignalExchange.Read reaTAir3rd(
    description="Temperature of 3rd floor",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.AirZoneTemperature,

    zone="5",
    y(unit="K"))
    annotation (Placement(transformation(extent={{320,218},{328,226}})));
equation
  connect(weaBus,lea219. weaBus) annotation (Line(
      points={{210,200},{-80,200},{-80,320},{-56,320}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(weaBus,lea220. weaBus) annotation (Line(
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
  connect(temAir219.T, reaTAir219.u) annotation (Line(
      points={{310,350},{319.2,350}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(temAir220.T, reaTAir220.u) annotation (Line(
      points={{312,320},{321.2,320}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(temAir2nd.T, reaTAir2nd.u) annotation (Line(
      points={{316,288},{325.2,288}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(multiplex5_2.u1[1], reaTAir219.y) annotation (Line(points={{378,310},
          {356,310},{356,350},{328.4,350}}, color={0,0,127}));
  connect(reaTAir220.y, multiplex5_2.u2[1]) annotation (Line(points={{330.4,320},
          {342,320},{342,305},{378,305}}, color={0,0,127}));
  connect(reaTAir2nd.y, multiplex5_2.u3[1]) annotation (Line(points={{334.4,288},
          {352,288},{352,300},{378,300}}, color={0,0,127}));
  connect(reaTAir1st.y, multiplex5_2.u4[1]) annotation (Line(points={{332.4,256},
          {346,256},{346,248},{358,248},{358,295},{378,295}}, color={0,0,127}));
  connect(reaTAir3rd.y, multiplex5_2.u5[1]) annotation (Line(points={{328.4,222},
          {354,222},{354,212},{362,212},{362,290},{378,290}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,
        extent={{-160,-160},{660,500}},
        initialScale=0.1)),   Icon(coordinateSystem(extent={{-160,-160},{660,
            500}},
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
