within Adrenalin2_training.Components.InternalGains.Data;
record Generic "Generic record for internal load inputs"
  extends Modelica.Icons.Record;

  parameter Real Sch[:,:]=[0,0.02,0.96154,0.31319; 1,0.019993867,0.96154,0.31319;
      2,0.019993867,0.96154,0.31319; 3,0.019993867,0.96154,0.31319; 4,0.019993867,
      0.96154,0.31319; 5,0.019993867,0.96154,0.31319; 6,0.019993867,0.96154,1.71313;
      7,0.019993867,1.92308,1.71313; 8,0.019993867,1.92308,1.71313; 9,0.019993867,
      0.96154,1.71313; 10,0.019993867,0.96154,1.71313; 11,0.019993867,0.96154,1.71313;
      12,0.019993867,0.96154,1.71313; 13,0.019993867,0.96154,1.71313; 14,0.019993867,
      1.92308,1.71313; 15,0.019993867,3.36538,1.71313; 16,0.019993867,4.32692,1.71313;
      17,0.019993867,4.32692,1.71313; 18,0.019993867,4.32692,1.71313; 19,0.019993867,
      3.84615,1.71313; 20,0.019993867,3.84615,1.71313; 21,0.019993867,3.36538,1.71313;
      22,0.019993867,2.40385,1.71313; 23,0.019993867,0.96154,0.31319]
    "Schedual for occupants, equipment and ligthing"
    annotation (Dialog(group="Schedual"));

  parameter Modelica.SIunits.Power occSenPow=75 "Sensible heat gain per person"
    annotation (Dialog(group="Occupants"));
  parameter Modelica.SIunits.DimensionlessRatio occDen=1
    "Number of occupants per m^2" annotation (Dialog(group="Occupants"));


  parameter Modelica.SIunits.HeatFlux equSenPowNom=1
    "Nominal sensible heat gain equipment"
    annotation (Dialog(group="Equpipment"));

  parameter Modelica.SIunits.HeatFlux ligSenPowNom=1
    "Nominal sensible heat gain lighting" annotation (Dialog(group="Lighting"));

    parameter Real MatEmi=0 "Emissions from materials per m2 in CO2 equivalents"
    annotation (Dialog(group="Materials"));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generic;
