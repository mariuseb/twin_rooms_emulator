within Adrenalin2_training.Components;
model AirDCVSplitterManifold5Zone
  extends Buildings.Fluid.Interfaces.PartialTwoPortVector(nPorts=5);

  parameter Modelica.SIunits.MassFlowRate[5] m_flow_nominal=fill(1,5)
    "Nominal flow of each outgoing port"
    annotation(Dialog(group = "Nominal condition"));
    parameter Real CO2Set_fixed=800 "CO2 set point in ppm";
  parameter Real Kp[5]=fill(1,5) "Controller Gain";

  Buildings.Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Medium,
    m_flow_nominal={sum(m_flow_nominal),sum(m_flow_nominal) - m_flow_nominal[1],
        m_flow_nominal[1]},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-80})));
  Buildings.Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = Medium,
    m_flow_nominal={sum(m_flow_nominal) - m_flow_nominal[1],m_flow_nominal[3]+m_flow_nominal[4]+m_flow_nominal[5],
        m_flow_nominal[2]},
    dp_nominal={0,0,0})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-40})));
  Buildings.Fluid.FixedResistances.Junction jun3(
    redeclare package Medium = Medium,
    m_flow_nominal={m_flow_nominal[3]+m_flow_nominal[4]+m_flow_nominal[5],m_flow_nominal[4]+m_flow_nominal[5],
        m_flow_nominal[3]},
    dp_nominal={0,0,0})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,0})));
  Buildings.Fluid.FixedResistances.Junction jun4(
    redeclare package Medium = Medium,
    m_flow_nominal={m_flow_nominal[4]+m_flow_nominal[5], m_flow_nominal[5],
        m_flow_nominal[4]},
    dp_nominal={0,0,0})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,40})));
  DCVDamperCO2Setpoint dCVDamperCO2Setpoint_5(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal[5],
    use_CO2Set_in=true,
    Kp=Kp[5],
    dpDamper_nominal=dpDamper_nominal[5],
    dpFixed_nominal=dpFixed_nominal[5],
    yMin=yMin[5]) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,80})));

  DCVDamperCO2Setpoint dCVDamperCO2Setpoint_4(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal[4],
    use_CO2Set_in=true,
    Kp=Kp[4],
    dpDamper_nominal=dpDamper_nominal[4],
    dpFixed_nominal=dpFixed_nominal[4],
    yMin=yMin[4]) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,40})));
  DCVDamperCO2Setpoint dCVDamperCO2Setpoint_3(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal[3],
    use_CO2Set_in=true,
    Kp=Kp[3],
    dpDamper_nominal=dpDamper_nominal[3],
    dpFixed_nominal=dpFixed_nominal[3],
    yMin=yMin[3]) annotation (Placement(transformation(extent={{-10,10},{10,-10}},
          rotation=270)));
  DCVDamperCO2Setpoint dCVDamperCO2Setpoint_2(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal[2],
    use_CO2Set_in=true,
    Kp=Kp[2],
    dpDamper_nominal=dpDamper_nominal[2],
    dpFixed_nominal=dpFixed_nominal[2],
    yMin=yMin[2]) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,-40})));
  DCVDamperCO2Setpoint dCVDamperCO2Setpoint_1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal[1],
    use_CO2Set_in=true,
    Kp=Kp[1],
    dpDamper_nominal=dpDamper_nominal[1],
    dpFixed_nominal=dpFixed_nominal[1],
    yMin=yMin[1]) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,-80})));
  Modelica.Blocks.Routing.DeMultiplex5 deMultiplex5_1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,110})));
  Modelica.Blocks.Interfaces.RealInput CO2Mea[5] "Measured CO2 content"
    annotation (Placement(transformation(extent={{-120,60},{-80,100}}),
        iconTransformation(extent={{-120,60},{-80,100}})));
  parameter Real yMin[5]=fill(0.05, 5)
                              "Lower limit of damper position";
  parameter Modelica.SIunits.PressureDifference dpDamper_nominal[5](displayUnit=
       "Pa")=fill(0.27, 5)
    "Pressure drop of fully open damper at nominal mass flow rate"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.PressureDifference dpFixed_nominal[5](displayUnit=
        "Pa")=fill(1E2 - 0.27, 5)
    "Pressure drop of duct and resistances other than the damper in series, at nominal mass flow rate"
    annotation (Dialog(group="Nominal condition"));
  Modelica.Blocks.Sources.Constant CO2set(k=CO2Set_fixed)
    annotation (Placement(transformation(extent={{-100,100},{-80,120}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite CO2SetCor(description="CO2 setpoint for zone core",
      u(
      unit="ppm",
      min=400,
      max=1000)) "Zone core CO2 setpoint"
    annotation (Placement(transformation(extent={{-32,92},{-20,104}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite CO2SetWes(description="CO2 setpoint for zone west",
      u(
      unit="ppm",
      min=400,
      max=1000)) "Zone west CO2 setpoint"
    annotation (Placement(transformation(extent={{-32,48},{-20,60}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite CO2SetNor(description="CO2 setpoint for zone north",
      u(
      unit="ppm",
      min=400,
      max=1000)) "Zone north CO2 setpoint"
    annotation (Placement(transformation(extent={{-32,10},{-20,22}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite CO2SetEas(description="CO2 setpoint for zone east",
      u(
      unit="ppm",
      min=400,
      max=1000)) "Zone west CO2 setpoint"
    annotation (Placement(transformation(extent={{-32,-30},{-20,-18}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite CO2SetSou(description="CO2 setpoint for zone south",
      u(
      unit="ppm",
      min=400,
      max=1000)) "Zone South CO2 setpoint"
    annotation (Placement(transformation(extent={{-32,-70},{-20,-58}})));
equation
  connect(port_a, jun1.port_1) annotation (Line(points={{-100,0},{-96,0},{-96,-90},
          {-60,-90}}, color={0,127,255}));
  connect(jun1.port_2, jun2.port_1)
    annotation (Line(points={{-60,-70},{-60,-50}}, color={0,127,255}));
  connect(jun2.port_2, jun3.port_1)
    annotation (Line(points={{-60,-30},{-60,-10}}, color={0,127,255}));
  connect(jun3.port_2, jun4.port_1)
    annotation (Line(points={{-60,10},{-60,30}}, color={0,127,255}));
  connect(jun4.port_2, dCVDamperCO2Setpoint_5.portIn)
    annotation (Line(points={{-60,50},{-60,80},{-10,80}},color={0,127,255}));
  connect(dCVDamperCO2Setpoint_5.portOut, ports_b[5]) annotation (Line(points={{10,80},
          {80,80},{80,16},{100,16}},      color={0,127,255}));
  connect(jun4.port_3,dCVDamperCO2Setpoint_4. portIn)
    annotation (Line(points={{-50,40},{-10,40}}, color={0,127,255}));
  connect(dCVDamperCO2Setpoint_4.portOut, ports_b[4]) annotation (Line(points={{10,40},
          {74,40},{74,8},{100,8}},          color={0,127,255}));
  connect(jun3.port_3, dCVDamperCO2Setpoint_3.portIn) annotation (Line(points={{
          -50,-4.44089e-16},{-30,-4.44089e-16},{-30,1.77636e-15},{-10,1.77636e-15}},
        color={0,127,255}));
  connect(dCVDamperCO2Setpoint_3.portOut, ports_b[3]) annotation (Line(points={{
          10,-1.77636e-15},{80,-1.77636e-15},{80,0},{100,0}}, color={0,127,255}));
  connect(jun2.port_3, dCVDamperCO2Setpoint_2.portIn)
    annotation (Line(points={{-50,-40},{-10,-40}}, color={0,127,255}));
  connect(dCVDamperCO2Setpoint_2.portOut, ports_b[2]) annotation (Line(points={{10,-40},
          {74,-40},{74,-8},{100,-8}},       color={0,127,255}));
  connect(jun1.port_3, dCVDamperCO2Setpoint_1.portIn)
    annotation (Line(points={{-50,-80},{-10,-80}}, color={0,127,255}));
  connect(dCVDamperCO2Setpoint_1.portOut, ports_b[1]) annotation (Line(points={{10,-80},
          {80,-80},{80,-16},{100,-16}},       color={0,127,255}));
  connect(deMultiplex5_1.y1[1], dCVDamperCO2Setpoint_1.meaPPM) annotation (Line(
        points={{38,99},{38,-66},{1.88738e-15,-66},{1.88738e-15,-70}}, color={0,
          0,127}));
  connect(deMultiplex5_1.y2[1], dCVDamperCO2Setpoint_2.meaPPM) annotation (Line(
        points={{34,99},{34,-26},{1.88738e-15,-26},{1.88738e-15,-30}}, color={0,
          0,127}));
  connect(deMultiplex5_1.y3[1], dCVDamperCO2Setpoint_3.meaPPM) annotation (Line(
        points={{30,99},{30,14},{1.88738e-15,14},{1.88738e-15,10}}, color={0,0,
          127}));
  connect(deMultiplex5_1.y4[1], dCVDamperCO2Setpoint_4.meaPPM) annotation (Line(
        points={{26,99},{26,54},{1.88738e-15,54},{1.88738e-15,50}}, color={0,0,
          127}));
  connect(deMultiplex5_1.y5[1], dCVDamperCO2Setpoint_5.meaPPM) annotation (Line(
        points={{22,99},{22,90},{14,90},{14,96},{1.88738e-15,96},{1.88738e-15,90}},
                color={0,0,127}));
  connect(deMultiplex5_1.u, CO2Mea) annotation (Line(points={{30,122},{-70,122},
          {-70,80},{-100,80}}, color={0,0,127}));
  connect(CO2set.y,CO2SetCor. u) annotation (Line(points={{-79,110},{-44,110},{-44,
          98},{-33.2,98}}, color={0,0,127}));
  connect(CO2SetCor.y, dCVDamperCO2Setpoint_5.CO2Set_in)
    annotation (Line(points={{-19.4,98},{-8,98},{-8,90}}, color={0,0,127}));
  connect(CO2set.y, CO2SetWes.u) annotation (Line(points={{-79,110},{-44,110},{-44,
          54},{-33.2,54}}, color={0,0,127}));
  connect(CO2SetWes.y, dCVDamperCO2Setpoint_4.CO2Set_in)
    annotation (Line(points={{-19.4,54},{-8,54},{-8,50}}, color={0,0,127}));
  connect(CO2set.y, CO2SetNor.u) annotation (Line(points={{-79,110},{-44,110},{-44,
          16},{-33.2,16}}, color={0,0,127}));
  connect(CO2SetNor.y, dCVDamperCO2Setpoint_3.CO2Set_in)
    annotation (Line(points={{-19.4,16},{-8,16},{-8,10}}, color={0,0,127}));
  connect(CO2set.y, CO2SetEas.u) annotation (Line(points={{-79,110},{-44,110},{-44,
          -24},{-33.2,-24}}, color={0,0,127}));
  connect(CO2SetEas.y, dCVDamperCO2Setpoint_2.CO2Set_in)
    annotation (Line(points={{-19.4,-24},{-8,-24},{-8,-30}}, color={0,0,127}));
  connect(CO2set.y, CO2SetSou.u) annotation (Line(points={{-79,110},{-44,110},{-44,
          -64},{-33.2,-64}}, color={0,0,127}));
  connect(CO2SetSou.y, dCVDamperCO2Setpoint_1.CO2Set_in)
    annotation (Line(points={{-19.4,-64},{-8,-64},{-8,-70}}, color={0,0,127}));
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
        Line(points={{-100,0},{-72,0},{-72,40},{-40,40}}, color={28,108,200}),
        Line(points={{-72,20},{-40,20}}, color={28,108,200}),
        Line(points={{-72,0},{-40,0}}, color={28,108,200}),
        Line(points={{-72,0},{-72,-40},{-40,-40}}, color={28,108,200}),
        Line(points={{-72,-20},{-40,-20}}, color={28,108,200}),
        Line(points={{40,40},{90,40}}, color={28,108,200}),
        Line(points={{40,20},{90,20}}, color={28,108,200}),
        Line(points={{40,0},{90,0}}, color={28,108,200}),
        Line(points={{40,-20},{90,-20}}, color={28,108,200}),
        Line(points={{40,-40},{90,-40}}, color={28,108,200})}),  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},{100,
            120}})));
end AirDCVSplitterManifold5Zone;
