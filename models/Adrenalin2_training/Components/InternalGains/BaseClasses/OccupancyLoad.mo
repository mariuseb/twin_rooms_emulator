within Adrenalin2_training.Components.InternalGains.BaseClasses;
model OccupancyLoad "A model for occupancy and resulting internal loads"
  import Buildings;
  parameter Modelica.SIunits.Power senPower "Sensible heat gain per person";
  parameter Modelica.SIunits.MassFlowRate CO2production=8.64e-6
                                                        "CO2 production per person";
  parameter Modelica.SIunits.DimensionlessRatio radFraction "Fraction of sensible gain that is radiant";
  parameter Modelica.SIunits.Power latPower "Latent heat gain per person";
  parameter Modelica.SIunits.DimensionlessRatio occ_density "Number of occupants per m^2";
  Modelica.Blocks.Interfaces.RealOutput rad "Radiant load in W/m^2"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput con "Convective load in W/m^2"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealOutput lat "Latent load in W/m^2"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Math.Gain gaiRad(k=senPower*radFraction*occ_density)
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Modelica.Blocks.Math.Gain gaiCon(k=senPower*(1 - radFraction)*occ_density)
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Modelica.Blocks.Math.Gain gaiLat(k=latPower*occ_density)
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Modelica.Blocks.Math.Gain gaiCO2(k=CO2production*occ_density)
    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  Modelica.Blocks.Interfaces.RealOutput CO2 "CO2 production from people"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealInput occ "input for occupancy per/m2"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
equation
  connect(gaiRad.y, rad)
    annotation (Line(points={{61,60},{110,60}}, color={0,0,127}));
  connect(gaiCon.y, con)
    annotation (Line(points={{61,20},{110,20}},
                                              color={0,0,127}));
  connect(gaiLat.y, lat)
    annotation (Line(points={{61,-20},{110,-20}}, color={0,0,127}));
  connect(gaiCO2.y, CO2)
    annotation (Line(points={{61,-60},{110,-60}}, color={0,0,127}));
  connect(gaiRad.u, occ) annotation (Line(points={{38,60},{-30,60},{-30,0},{
          -100,0}}, color={0,0,127}));
  connect(occ, gaiCon.u) annotation (Line(points={{-100,0},{-30,0},{-30,20},{38,
          20}}, color={0,0,127}));
  connect(occ, gaiLat.u) annotation (Line(points={{-100,0},{-30,0},{-30,-20},{
          38,-20}}, color={0,0,127}));
  connect(occ, gaiCO2.u) annotation (Line(points={{-100,0},{-30,0},{-30,-60},{
          38,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end OccupancyLoad;
