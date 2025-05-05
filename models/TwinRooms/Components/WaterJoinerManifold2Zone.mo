within Adrenalin2_training.Components;
model WaterJoinerManifold2Zone
   extends
    Adrenalin2_training.Components.BaseClasses.Interfaces.PartialTwoPortVectorRev(       nPorts=2);

   parameter Modelica.SIunits.MassFlowRate[2] m_flow_nominal
     "Nominal flow of each outgoing port"
     annotation (Dialog(group="Nominal condition"));

   Buildings.Fluid.FixedResistances.Junction jun1(
     redeclare package Medium = Medium,
    m_flow_nominal={m_flow_nominal[1],m_flow_nominal[2],sum(m_flow_nominal)},
     dp_nominal={0,0,0}) annotation (Placement(transformation(
         extent={{-10,-10},{10,10}},
         rotation=270,
         origin={0,-90})));

equation
   connect(jun1.port_2, port_b) annotation (Line(points={{-1.77636e-15,-100},{
           -1.77636e-15,-102},{86,-102},{86,0},{100,0}}, color={0,127,255}));
   connect(jun1.port_3, ports_a[1]) annotation (Line(points={{-10,-90},{-42,-90},
          {-42,-10},{-100,-10}},  color={0,127,255}));
  connect(ports_a[2], jun1.port_1) annotation (Line(points={{-100,10},{0,10},{0,
          -80}},                   color={0,127,255}));
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
         Line(points={{40,40},{72,40},{72,0},{90,0}},      color={28,108,200}),
         Line(points={{40,12},{72,12}},   color={28,108,200}),
         Line(points={{40,-14},{72,-14}},   color={28,108,200}),
         Line(points={{-90,40},{-40,40}},
                                        color={28,108,200}),
         Line(points={{-90,12},{-40,12}},
                                        color={28,108,200}),
         Line(points={{-90,-14},{-40,-14}},
                                          color={28,108,200}),
         Line(points={{-90,-40},{-40,-40}},
                                          color={28,108,200}),
         Line(points={{40,-40},{72,-40},{72,0}}, color={28,108,200})}),
                                                                  Diagram(
         coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,
             120}})));
end WaterJoinerManifold2Zone;
