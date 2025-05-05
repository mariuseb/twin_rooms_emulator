within Adrenalin2_training.Components;
model DCVDamperCO2Setpoint "DCV damper controlled by CO2 setpoint"
  replaceable package Medium = Buildings.Media.Air constrainedby
    Modelica.Media.Interfaces.PartialMedium;

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate"
    annotation (Dialog(group="Nominal condition"));
  parameter Real l(
    min=1e-10,
    max=1) = 0.0001 "Damper leakage, ratio of flow coefficients k(y=0)/k(y=1)"
    annotation (Dialog(group="Damper coefficients"));
    parameter Boolean use_CO2Set_in=false
    "Get the CO2 setpoint from the input connector"
    annotation(Evaluate=true, HideResult=true,Dialog(group="Conditional inputs"));
  parameter Real CO2Set=800    "CO2 set point in volume fraction"
  annotation (Dialog(enable = not use_CO2Set_in,group="Fixed inputs"));
  Modelica.Blocks.Interfaces.RealInput CO2Set_in if use_CO2Set_in
    "Prescribed CO2 setpoint"
    annotation (Placement(transformation(extent={{-120,60},{-80,100}})));
  parameter Real Kp=1 "Controller Gain";
  parameter Modelica.SIunits.PressureDifference dpDamper_nominal(displayUnit="Pa")=
     0.27   "Pressure drop of fully open damper at nominal mass flow rate"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.PressureDifference dpFixed_nominal(displayUnit="Pa")=
     1E2 - 0.27
    "Pressure drop of duct and resistances other than the damper in series, at nominal mass flow rate"
    annotation (Dialog(group="Nominal condition"));

  Buildings.Fluid.Actuators.Dampers.Exponential vav(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    from_dp=false,
    dpDamper_nominal=dpDamper_nominal,
    dpFixed_nominal=dpFixed_nominal,
    final l=l)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Fluid.Interfaces.FluidPort_a portIn(redeclare package Medium =
        Medium) "Fluid port"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Blocks.Interfaces.RealOutput yDam "Damper control signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
  BaseClasses.DamperControlVarSetpnt con(Kp=Kp, yMin=yMin) "Damper controller"
    annotation (Placement(transformation(extent={{-44,-56},{-24,-36}})));

  Modelica.Blocks.Interfaces.RealInput meaPPM "mesured ppm trace substance"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Fluid.Interfaces.FluidPort_b portOut(redeclare package Medium =
        Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));

  Buildings.Fluid.Sensors.VolumeFlowRate senVolFlo(
    redeclare package Medium = Medium,             m_flow_nominal=
        m_flow_nominal,
    tau=10)             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,52})));
  Modelica.Blocks.Interfaces.RealOutput V_flow1
    "Volume flow rate from port_a to port_b"
    annotation (Placement(transformation(extent={{100,42},{120,62}})));
  parameter Real yMin=0.05 "Lower limit of damper position";

protected
  Modelica.Blocks.Interfaces.RealInput CO2Set_in_internal(final unit="K",
      displayUnit="degC") "Needed to connect to conditional connector";
equation
  connect(con.y, yDam) annotation (Line(
      points={{-23,-46},{50,-46},{50,0},{110,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(con.y, vav.y) annotation (Line(
      points={{-23,-46},{50,-46},{50,-2.22045e-15},{12,-2.22045e-15}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(meaPPM, con.u) annotation (Line(points={{-100,0},{-50,0},{-50,-46},{
          -46,-46}},
                 color={0,0,127}));
  connect(vav.port_b, portOut)
    annotation (Line(points={{0,-10},{0,-100}}, color={0,127,255}));
  connect(portIn, senVolFlo.port_a) annotation (Line(points={{5.55112e-16,100},
          {5.55112e-16,81},{1.77636e-15,81},{1.77636e-15,62}}, color={0,127,255}));
  connect(senVolFlo.port_b, vav.port_a) annotation (Line(points={{-1.83187e-15,
          42},{5.55112e-16,10},{1.77636e-15,10}}, color={0,127,255}));
  connect(senVolFlo.V_flow, V_flow1)
    annotation (Line(points={{11,52},{110,52}}, color={0,0,127}));
 connect(con.u_s, CO2Set_in_internal);
 connect(CO2Set_in, CO2Set_in_internal);
  if not use_CO2Set_in then
    CO2Set_in_internal = CO2Set;
  end if;
   annotation (
    Diagram(coordinateSystem(preserveAspectRatio=true)),
    Icon(                                               graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          visible=use_inputFilter,
          extent={{42,-30},{100,26}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Ellipse(
          visible=use_inputFilter,
          extent={{42,24},{100,-30}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,100},{8,-102}},
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Text(
          extent={{-92,-50},{94,-84}},
          pattern=LinePattern.None,
          fillColor={0,127,255},
          fillPattern=FillPattern.Solid,
          textString="%name",
          lineColor={0,0,0}),
        Rectangle(
          extent={{-100,23},{100,-23}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          origin={2,-1},
          rotation=90),
        Rectangle(
          extent={{-100,41},{100,-41}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192},
          origin={2,-1},
          rotation=90),
        Rectangle(
          extent={{-100,23},{100,-23}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          origin={0,-1},
          rotation=90),            Polygon(
          points={{-24,-15},{24,27},{24,15},{-24,-27},{-24,-15}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={0,27},
          rotation=90),                   Polygon(
          points={{-24,-15},{24,27},{24,15},{-24,-27},{-24,-15}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={4,-17},
          rotation=90),
        Text(
          visible=use_inputFilter,
          extent={{54,18},{88,-22}},
          textColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="M",
          textStyle={TextStyle.Bold})}),
    Documentation(info="<html>
<p>
Model of a room and a plenum. CO2 is injected into the room.
An air damper controls how much air flows into the room to track
the CO2 level.
</p>
</html>", revisions="<html>
<ul>
<li>
January 23, 2017, by Michael Wetter:<br/>
Removed <code>allowFlowReversal=false</code> as
<code>roo.roo49.dpPle.port_a.m_flow</code> and
<code>roo.roo50.dpPle.port_a.m_flow</code>
have negative mass flow rates.
</li>
<li>
January 20, 2017, by Michael Wetter:<br/>
Removed the use of <code>TraceSubstancesFlowSource</code>
and instead used the input connector <code>C_flow</code>
of the volume. This reduces computing time from <i>25</i>
to <i>12</i> seconds.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/628\">#628</a>.
</li>
<li>
July 20, 2007 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end DCVDamperCO2Setpoint;
