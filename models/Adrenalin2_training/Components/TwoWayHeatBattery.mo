within Adrenalin2_training.Components;
model TwoWayHeatBattery
  "Circuit for controlling heating battery supply flow with two way valve and bypass"

    replaceable package Medium = Buildings.Media.Water constrainedby
    Modelica.Media.Interfaces.PartialMedium;

  Buildings.Fluid.Sensors.EnthalpyFlowRate senEntFloSup(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-40,18})));
  Buildings.Fluid.Sensors.EnthalpyFlowRate senEntFloRet(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={40,20})));
  Sensors.EnergyDiffCalc energyDiffCalc
    annotation (Placement(transformation(extent={{-12,4},{8,24}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemSup(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,58})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemRet(redeclare package Medium =
        Medium, m_flow_nominal=m_flow_nominal) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,56})));
  Modelica.Fluid.Interfaces.FluidPort_b secSup(redeclare package Medium =
        Medium) "Supply (outlet) of secondary circuit"
    annotation (Placement(transformation(extent={{-110,90},{-90,110}}),
        iconTransformation(extent={{-110,90},{-90,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a secRet(redeclare package Medium =
        Medium) "Return (inlet) of secondary circuit"
    annotation (Placement(transformation(extent={{88,90},{108,110}}),
        iconTransformation(extent={{88,90},{108,110}})));
  Modelica.Blocks.Interfaces.RealOutput TemSup "Temperature of supply water"
    annotation (Placement(transformation(extent={{98,60},{118,80}}),
        iconTransformation(extent={{98,60},{118,80}})));
  Modelica.Blocks.Interfaces.RealOutput TemRet
    "Temperature of the returning water"
    annotation (Placement(transformation(extent={{98,40},{118,60}}),
        iconTransformation(extent={{98,40},{118,60}})));
  Modelica.Blocks.Interfaces.RealOutput Ene(final unit="J") "Accumulated Energy"
    annotation (Placement(transformation(extent={{98,0},{118,20}}),
        iconTransformation(extent={{98,0},{118,20}})));
  Modelica.Blocks.Interfaces.RealOutput Pow(final unit="W") "Instant Power"
    annotation (Placement(transformation(extent={{98,20},{118,40}}),
        iconTransformation(extent={{98,20},{118,40}})));
Buildings.Fluid.Actuators.Valves.TwoWayLinear   valCoil(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dpValve_nominal,
    y_start=0,
    dpFixed_nominal=dpFixed_nominal)
                     annotation (Placement(transformation(
      extent={{-10,10},{10,-10}},
      rotation=270,
      origin={40,-20})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemCoiRet(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal)
    "Sensor for AHU heating coil return water temperature" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={40,-72})));
  Buildings.Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal_bypass,
    dp_nominal=dpValve_nominal + dpFixed_nominal + dpExternal_nominal)
    annotation (Placement(transformation(extent={{-4,-58},{6,-38}})));
Buildings.Fluid.FixedResistances.Junction junSup(
    redeclare package Medium = Medium,
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    m_flow_nominal={m_flow_nominal,-m_flow_nominal,-m_flow_nominal_bypass},
    dp_nominal={0,0,0},
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
    annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=-90,
        origin={-40,-48})));
Buildings.Fluid.FixedResistances.Junction junRet(
    redeclare package Medium = Medium,
    dp_nominal={0,0,0},
    portFlowDirection_1=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_2=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    portFlowDirection_3=Modelica.Fluid.Types.PortFlowDirection.Bidirectional,
    m_flow_nominal={m_flow_nominal,-m_flow_nominal,m_flow_nominal_bypass},
    energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial)
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={40,-48})));
  Buildings.Controls.Continuous.LimPID conPIDcoil(
    Ti=300,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.01)
    annotation (Placement(transformation(extent={{-68,-12},{-52,-28}})));
  Modelica.Fluid.Interfaces.FluidPort_a priSup(redeclare package Medium =
        Medium)                                "Primary inlet"
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b priRet(redeclare package Medium =
        Medium)                                "Primary outlet"
    annotation (Placement(transformation(extent={{90,-110},{110,-90}})));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.PressureDifference dpValve_nominal=5000
    "Nominal pressure drop of fully open valve, used if CvData=Buildings.Fluid.Types.CvTypes.OpPoint"
    annotation (Dialog(group="Nominal condition"));
  parameter Modelica.SIunits.PressureDifference dpFixed_nominal=0
    "Pressure drop of pipe and other resistances that are in series"
    annotation (Dialog(group="Nominal condition"));
    parameter Modelica.SIunits.PressureDifference dpExternal_nominal=0
    "Pressure drop of external components in secondary circuit"
    annotation (Dialog(group="Nominal condition"));
  Modelica.Blocks.Interfaces.RealInput TemSet
    "Connector of setpoint temperature"
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}})));
  Modelica.Blocks.Interfaces.RealInput TemMea
    "Connector of measurement temperature"
    annotation (Placement(transformation(extent={{-120,-6},{-80,34}})));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal_bypass=m_flow_nominal/
      1000 "Nominal mass flow rate";
equation
  connect(senEntFloSup.H_flow,energyDiffCalc. H_flowSup) annotation (Line(
        points={{-29,18},{-26,18},{-26,3.6},{-4,3.6}},       color={0,0,127}));
  connect(energyDiffCalc.H_flowRet,senEntFloRet. H_flow) annotation (Line(
        points={{0,3.6},{8,3.6},{8,4},{16,4},{16,20},{29,20}},
                                                          color={0,0,127}));
  connect(senEntFloSup.port_b,senTemSup. port_a)
    annotation (Line(points={{-40,28},{-40,48}},   color={0,127,255}));
  connect(senTemRet.port_b,senEntFloRet. port_a)
    annotation (Line(points={{40,46},{40,30}},   color={0,127,255}));
  connect(senTemSup.port_b,secSup)
    annotation (Line(points={{-40,68},{-82,68},{-82,100},{-100,100}},
                                                   color={0,127,255}));
  connect(senTemRet.port_a,secRet)
    annotation (Line(points={{40,66},{88,66},{88,100},{98,100}},
                                                 color={0,127,255}));
  connect(senTemSup.T,TemSup)  annotation (Line(points={{-51,58},{-54,58},{-54,70},
          {108,70}},           color={0,0,127}));
  connect(senTemRet.T,TemRet)  annotation (Line(points={{51,56},{80,56},{80,50},
          {108,50}},       color={0,0,127}));
  connect(energyDiffCalc.Energy,Ene)  annotation (Line(points={{0,24.6},{0,32},{
          92,32},{92,10},{108,10}},      color={0,0,127}));
  connect(energyDiffCalc.Power,Pow)  annotation (Line(points={{-4,24.6},{-4,34},
          {92,34},{92,30},{108,30}},                                      color=
         {0,0,127}));
  connect(conPIDcoil.y, valCoil.y) annotation (Line(points={{-51.2,-20},{28,-20}},
                                 color={0,0,127}));
  connect(senEntFloRet.port_b, valCoil.port_a)
    annotation (Line(points={{40,10},{40,-10}}, color={0,127,255}));
  connect(junRet.port_2, senTemCoiRet.port_a)
    annotation (Line(points={{40,-56},{40,-62}}, color={0,127,255}));
  connect(res.port_b, junRet.port_3)
    annotation (Line(points={{6,-48},{32,-48}}, color={0,127,255}));
  connect(valCoil.port_b, junRet.port_1)
    annotation (Line(points={{40,-30},{40,-40}}, color={0,127,255}));
  connect(junSup.port_2, senEntFloSup.port_a)
    annotation (Line(points={{-40,-40},{-40,8}}, color={0,127,255}));
  connect(junSup.port_3, res.port_a)
    annotation (Line(points={{-32,-48},{-4,-48}}, color={0,127,255}));
  connect(junSup.port_1, priSup) annotation (Line(points={{-40,-56},{-40,-100},{
          -100,-100}}, color={0,127,255}));
  connect(senTemCoiRet.port_b, priRet) annotation (Line(points={{40,-82},{40,-100},
          {100,-100}}, color={0,127,255}));
  connect(conPIDcoil.u_s, TemSet)
    annotation (Line(points={{-69.6,-20},{-100,-20}}, color={0,0,127}));
  connect(conPIDcoil.u_m, TemMea) annotation (Line(points={{-60,-10.4},{-60,14},
          {-100,14}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={205,205,205},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-96,-100},{-38,-100},{-38,99.8262},{-98,100}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{102,100},{42,100},{42,-100},{102,-100}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-38,-36},{42,-36}},
          color={28,108,200},
          thickness=0.5),
        Polygon(
          points={{24,-10},{62,-10},{42,14},{24,-10}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{42,14},{60,40},{24,40},{42,14}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-7,-2},{3,14},{-17,14},{-7,-2}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={0,-29},
          rotation=90),
        Polygon(
          points={{7,2},{-3,-14},{17,-14},{7,2}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={4,-43},
          rotation=90)}),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TwoWayHeatBattery;
