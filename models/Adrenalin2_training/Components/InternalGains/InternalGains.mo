within Adrenalin2_training.Components.InternalGains;
model InternalGains "InternalGains to heat to zone"
  parameter Modelica.SIunits.Area Area=100;
  BaseClasses.InternalLoad equ(
    radFraction=0.7,
    latPower_nominal=0,
    senPower_nominal=data.equSenPowNom)
    annotation (Placement(transformation(extent={{-84,-10},{-64,10}})));
  BaseClasses.OccupancyLoad occ(
    radFraction=0.6,
    latPower=0,
    occ_density=data.occDen,
    senPower=data.occSenPow)
    annotation (Placement(transformation(extent={{-84,30},{-64,50}})));
  BaseClasses.InternalLoad Lig(
    radFraction=0.5,
    latPower_nominal=0,
    senPower_nominal=data.ligSenPowNom)
    annotation (Placement(transformation(extent={{-84,-50},{-64,-30}})));
  replaceable parameter Data.Generic data             constrainedby Data.Generic
    "Record with internal gains data data" annotation (choicesAllMatching=true,
      Placement(transformation(extent={{78,78},{98,98}})));
  Modelica.Blocks.Math.MultiSum sumRad(k=fill(Area, sumRad.nu), nu=3)
    annotation (Placement(transformation(extent={{4,38},{18,52}})));
  Modelica.Blocks.Math.MultiSum sumCon(k=fill(Area, sumCon.nu), nu=3)
    annotation (Placement(transformation(extent={{4,-6},{18,8}})));
  Modelica.Blocks.Math.MultiSum sumLat(k=fill(Area, sumLat.nu), nu=3)
    annotation (Placement(transformation(extent={{4,-42},{18,-28}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1
    annotation (Placement(transformation(extent={{56,-10},{76,10}})));
  Modelica.Blocks.Interfaces.RealOutput intGai[3]
    "Connector of radiant, convective and latent heat gain"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput CO2 "CO2 production from people"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Math.Gain gain(k=Area)
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  Modelica.Blocks.Interfaces.RealOutput elCon "Connector electric  consumption"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=6)
    annotation (Placement(transformation(extent={{6,-86},{18,-74}})));
  Modelica.Blocks.Math.Gain gain1(k=Area)
    annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    table=data.Sch,
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Constant const(k=data.MatEmi)
    annotation (Placement(transformation(extent={{-84,-84},{-64,-64}})));

  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{30,-68},{50,-48}})));
equation
  connect(occ.rad, sumRad.u[1]) annotation (Line(points={{-63,46},{-60,46},{-60,
          43.3667},{4,43.3667}},   color={0,0,127}));
  connect(equ.rad, sumRad.u[2]) annotation (Line(points={{-63,4},{-34,4},{-34,45},
          {4,45}},   color={0,0,127}));
  connect(Lig.rad, sumRad.u[3]) annotation (Line(points={{-63,-36},{-34,-36},{
          -34,46.6333},{4,46.6333}},
                                   color={0,0,127}));
  connect(occ.con, sumCon.u[1]) annotation (Line(points={{-63,42},{-22,42},{-22,
          -0.633333},{4,-0.633333}},   color={0,0,127}));
  connect(equ.con, sumCon.u[2]) annotation (Line(points={{-63,0},{-60,0},{-60,1},
          {4,1}},   color={0,0,127}));
  connect(Lig.con, sumCon.u[3]) annotation (Line(points={{-63,-40},{-22,-40},{-22,
          2.63333},{4,2.63333}},   color={0,0,127}));
  connect(sumLat.u[1], occ.lat) annotation (Line(points={{4,-36.6333},{-38,
          -36.6333},{-38,38},{-63,38}},
                              color={0,0,127}));
  connect(equ.lat, sumLat.u[2]) annotation (Line(points={{-63,-4},{-38,-4},{-38,
          -35},{4,-35}},   color={0,0,127}));
  connect(Lig.lat, sumLat.u[3]) annotation (Line(points={{-63,-44},{-6,-44},{-6,
          -33.3667},{4,-33.3667}},   color={0,0,127}));
  connect(sumRad.y, multiplex3_1.u1[1]) annotation (Line(points={{19.19,45},{19.19,
          44},{46,44},{46,7},{54,7}}, color={0,0,127}));
  connect(sumCon.y, multiplex3_1.u2[1])
    annotation (Line(points={{19.19,1},{19.19,0},{54,0}},
                                                        color={0,0,127}));
  connect(sumLat.y, multiplex3_1.u3[1]) annotation (Line(points={{19.19,-35},{48,
          -35},{48,-7},{54,-7}}, color={0,0,127}));
  connect(multiplex3_1.y, intGai)
    annotation (Line(points={{77,0},{110,0}}, color={0,0,127}));
  connect(gain.y, CO2)
    annotation (Line(points={{81,-40},{110,-40}}, color={0,0,127}));
  connect(equ.rad, multiSum.u[1]) annotation (Line(points={{-63,4},{-46,4},{-46,
          -80},{-20,-80},{-20,-81.75},{6,-81.75}},   color={0,0,127}));
  connect(equ.con, multiSum.u[2]) annotation (Line(points={{-63,0},{-42,0},{-42,
          -81.05},{6,-81.05}},   color={0,0,127}));
  connect(equ.lat, multiSum.u[3]) annotation (Line(points={{-63,-4},{-38,-4},{-38,
          -80.35},{6,-80.35}},       color={0,0,127}));
  connect(Lig.rad, multiSum.u[4]) annotation (Line(points={{-63,-36},{-20,-36},{
          -20,-79.65},{6,-79.65}},    color={0,0,127}));
  connect(Lig.con, multiSum.u[5]) annotation (Line(points={{-63,-40},{-16,-40},{
          -16,-78.95},{6,-78.95}},    color={0,0,127}));
  connect(Lig.lat, multiSum.u[6]) annotation (Line(points={{-63,-44},{-12,-44},{
          -12,-78.25},{6,-78.25}},    color={0,0,127}));
  connect(multiSum.y, gain1.u)
    annotation (Line(points={{19.02,-80},{58,-80}},color={0,0,127}));
  connect(gain1.y, elCon)
    annotation (Line(points={{81,-80},{110,-80}}, color={0,0,127}));
  connect(combiTimeTable.y[1], occ.occ) annotation (Line(points={{-79,90},{-74,90},
          {-74,54},{-92,54},{-92,40},{-84,40}}, color={0,0,127}));
  connect(combiTimeTable.y[2], equ.she) annotation (Line(points={{-79,90},{-74,90},
          {-74,54},{-92,54},{-92,0},{-84,0}}, color={0,0,127}));
  connect(combiTimeTable.y[3], Lig.she) annotation (Line(points={{-79,90},{-74,90},
          {-74,54},{-92,54},{-92,-40},{-84,-40}}, color={0,0,127}));
  connect(const.y, add.u2) annotation (Line(points={{-63,-74},{0,-74},{0,-64},{28,
          -64}}, color={0,0,127}));
  connect(occ.CO2, add.u1) annotation (Line(points={{-63,34},{-18,34},{-18,-52},
          {28,-52}}, color={0,0,127}));
  connect(add.y, gain.u)
    annotation (Line(points={{51,-58},{58,-58},{58,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-20,8},{-18,8},{-12,8},{0,28},{10,8},{18,8}}, color={28,108,
              200}),
        Line(points={{0,28},{0,48}}, color={28,108,200}),
        Line(points={{-16,34},{0,48},{14,36}}, color={28,108,200}),
        Ellipse(extent={{-6,58},{6,48}}, lineColor={28,108,200}),
        Line(points={{22,-12},{-8,-48},{26,-42},{-22,-86},{-16,-66}}, color={28,
              108,200}),
        Line(points={{-22,-86},{0,-82}}, color={28,108,200})}),  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end InternalGains;
