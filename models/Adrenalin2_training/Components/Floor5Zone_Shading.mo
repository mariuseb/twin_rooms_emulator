within Adrenalin2_training.Components;
model Floor5Zone_Shading
  "Model of a floor of the building with automatic solar shading"
  extends Adrenalin2_training.Components.BaseClasses.PartialFloor(
    redeclare final package Medium = MediumA,
    final VRoo2nd=SecFloor.AFlo*hRoo,
    final VRoo219=room219.AFlo*hRoo,
    final VRoo220=room220.AFlo*hRoo,
    final wWesFac=16.546,
    final wSouFac=24.073,
    AFlo219=66.7,
    AFlo220=66.7,
    AFlo2nd=308.16,
    lea219(amb(C=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
            /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC))),
    lea220(amb(C=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
            /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC))),
    lea2nd(amb(C=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
            /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC))),
    door220To2nd(wOpe=1.710),
    door219To2nd(wOpe=1.710));

  package MediumA = Buildings.Media.Air(extraPropertiesNames={"CO2"}) "Medium model for air";

  parameter Buildings.HeatTransfer.Types.InteriorConvection intConMod=Buildings.HeatTransfer.Types.InteriorConvection.Temperature
    "Convective heat transfer model for room-facing surfaces of opaque constructions";
  parameter Modelica.SIunits.Angle lat "Latitude";
  parameter Real winWalRat(
    min=0.01,
    max=0.99) = 0.33 "Window to wall ratio for exterior walls";

  parameter Modelica.SIunits.Height hWin = 1.775 "Height of windows";
  parameter Modelica.SIunits.Length wWin = 0.9 "Width of windows";
  parameter Modelica.SIunits.DimensionlessRatio nWinTwin = 8 "# of windows in each twin room";
  parameter Modelica.SIunits.Height hWinNor = 2.210 "Height of windows, north facace";
  parameter Modelica.SIunits.Length wWinNor = 1.890 "Width of windows, north facade";
  parameter Modelica.SIunits.DimensionlessRatio nWinNor = 7 "# of windows on north facade";
  parameter Modelica.SIunits.Height hWinWes = 2.290 "Height of windows, west facace";
  parameter Modelica.SIunits.Length wWinWes = 3.34 "Width of windows, west facade";
  parameter Modelica.SIunits.Height hWinEas = 2.290 "Height of windows, east facace";
  parameter Modelica.SIunits.Length wWinEas = 2.34 "Width of windows, east facade";

  parameter Modelica.SIunits.DimensionlessRatio ach = 0.3 "ACH nominal at 50 Pa";

  parameter Buildings.HeatTransfer.Data.Solids.Plywood matFur(x=0.15, nStaRef=5)
    "Material for furniture"
    annotation (Placement(transformation(extent={{140,460},{160,480}})));
parameter Buildings.HeatTransfer.Data.Resistances.Carpet matCar "Carpet"
  annotation (Placement(transformation(extent={{180,460},{200,480}})));
parameter Buildings.HeatTransfer.Data.Solids.Concrete matCon(
  x=0.1,
  k=1.311,
  c=836,
  nStaRef=5) "Concrete"
  annotation (Placement(transformation(extent={{140,430},{160,450}})));
parameter Buildings.HeatTransfer.Data.Solids.Plywood matWoo(
  x=0.01,
  k=0.11,
  d=544,
  nStaRef=1) "Wood for exterior construction"
  annotation (Placement(transformation(extent={{140,400},{160,420}})));
parameter Buildings.HeatTransfer.Data.Solids.Generic matIns(
  x=0.250,
  k=0.049,
  c=852,
  d=214,
  nStaRef=5) "Steelframe construction with insulation"
  annotation (Placement(transformation(extent={{180,398},{200,418}})));
 parameter Buildings.HeatTransfer.Data.Solids.Generic matDoubleBevel(
   x=0.019,
   k=0.13,
   c=1600,
   d=500) "Vertical panel double bevel square edge"
   annotation (Placement(transformation(extent={{-360,518},{-340,538}})));
 parameter Buildings.HeatTransfer.Data.Solids.Generic matHorBatt(
   x=0.068,
   k=0.12,
   c=1600,
   d=450) "Horizontal batten"
   annotation (Placement(transformation(extent={{-360,498},{-340,518}})));
 parameter Buildings.HeatTransfer.Data.Solids.Generic matVerBatt(
   x=0.036,
   k=0.12,
   c=1600,
   d=450) "Vertical batten"
   annotation (Placement(transformation(extent={{-360,478},{-340,498}})));
 parameter Buildings.HeatTransfer.Data.Solids.Generic matWinBar(
   x=0.002,
   k=0.04,
   c=1400,
   d=60) "Wind barrier fabric, black"
   annotation (Placement(transformation(extent={{-358,458},{-338,478}})));
 parameter Buildings.HeatTransfer.Data.Solids.Generic matGUx(
   x=0.09,
   k=0.22,
   c=1000,
   d=1000) "GUx"
   annotation (Placement(transformation(extent={{-360,438},{-340,458}})));
 parameter Buildings.HeatTransfer.Data.Solids.Generic matMinWooFra(
   x=0.223,
   k=0.046,
   c=1900,
   d=74) "Frame with mineral wool"
   annotation (Placement(transformation(extent={{-360,418},{-340,438}})));
 parameter Buildings.HeatTransfer.Data.Solids.Generic matVapBar(
   x=0.005,
   k=0.22,
   c=1700,
   d=130) "Vapor barrier"
   annotation (Placement(transformation(extent={{-360,398},{-340,418}})));
 parameter Buildings.HeatTransfer.Data.Solids.Generic matMinWooFur(
   x=0.073,
   k=0.046,
   c=1900,
   d=74) "Inner furring with mineral wool"
   annotation (Placement(transformation(extent={{-332,510},{-312,530}})));
 parameter Buildings.HeatTransfer.Data.Solids.GypsumBoard matGyp(
    x=0.013,
    k=0.25,
    c=960,
    d=680,
   nStaRef=2) "Gypsum board"
   annotation (Placement(transformation(extent={{-332,484},{-312,504}})));
parameter Buildings.HeatTransfer.Data.Solids.GypsumBoard matGyp3(
  x=0.0127,
  k=0.16,
  c=830,
  d=784,
  nStaRef=2) "Gypsum board"
  annotation (Placement(transformation(extent={{138,372},{158,392}})));
parameter Buildings.HeatTransfer.Data.Solids.GypsumBoard matGyp2(
  x=0.025,
  k=0.16,
  c=830,
  d=784,
  nStaRef=2) "Gypsum board"
  annotation (Placement(transformation(extent={{178,372},{198,392}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conExtWal(final
      nLay=4, material={matGUx,matMinWooFra,matMinWooFur,matGyp})
                                               "Exterior construction"
    annotation (Placement(transformation(extent={{278,460},{298,480}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conIntWal(final
      nLay=3, material={matGyp1,matMinWooFraWoo,matGyp1})
                                  "Interior wall construction"
    annotation (Placement(transformation(extent={{320,460},{340,480}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conFlo(final
      nLay=3, material={matChiBoa,matMinWoo,matCLT})
                                 "Floor construction (opa_a is carpet)"
    annotation (Placement(transformation(extent={{276,420},{296,440}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conFur(final
      nLay=1, material={matFur}) "Construction for internal mass of furniture"
    annotation (Placement(transformation(extent={{320,420},{340,440}})));
  parameter Buildings.HeatTransfer.Data.Solids.Plywood matCarTra(
    k=0.11,
    d=544,
    nStaRef=1,
    x=0.215/0.11) "Wood for floor"
    annotation (Placement(transformation(extent={{102,460},{122,480}})));
  parameter Buildings.HeatTransfer.Data.GlazingSystems.DoubleClearAir13Clear glaSys(
    UFra=2,
    shade=Buildings.HeatTransfer.Data.Shades.Gray(),
    haveInteriorShade=false,
    haveExteriorShade=true)  "Data record for the glazing system"
    annotation (Placement(transformation(extent={{240,460},{260,480}})));

  constant Modelica.SIunits.Height hRoo=3.850 "Room height";

  parameter Boolean sampleModel = false
    "Set to true to time-sample the model, which can give shorter simulation time if there is already time sampling in the system model"
    annotation (
      Evaluate=true,
      Dialog(tab="Experimental (may be changed in future releases)"));

  Buildings.ThermalZones.Detailed.MixedAir room219(
    datConExt(
      layers={conExtWal},
      A={(4.073 + 1.8)*hRoo},
      til={Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.E}),
    datConPar(
      layers={conFlo,conFlo},
      A={AFlo2nd,AFlo2nd},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Ceiling}),
    surBou(
      A={(wSouFac/2)*hRoo,5.89*hRoo},
      absIR={0.9,0.9},
      absSol={0.9,0.9},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=AFlo219,
    hRoo=hRoo,
    nConExt=1,
    nConExtWin=1,
    datConExtWin(
      layers={conExtWal},
      A={12*hRoo},
      glaSys={datGlaSys},
      wWin={nWinTwin*wWin*hWin},
      each hWin=hWin,
      fFra={0.1},
      til={Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.S}),
    nConPar=2,
    nConBou=0,
    nSurBou=2,
    use_C_flow=true,
    C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
    nPorts=6,
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal=(AFlo219*hRoo)*1.2*ach/3600,
    final sampleModel=sampleModel) "Room 2.19"
    annotation (Placement(transformation(extent={{142,-44},{182,-4}})));

  Buildings.ThermalZones.Detailed.MixedAir room220(
    datConExt(
      layers={conExtWal},
      A={(4.073 + 1.8)*hRoo},
      til={Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.W}),
    datConPar(
      layers={conFlo,conFlo},
      A={AFlo2nd,AFlo2nd},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Ceiling}),
    surBou(
      A={(wSouFac/2)*hRoo,5.89*hRoo},
      absIR={0.9,0.9},
      absSol={0.9,0.9},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=AFlo220,
    hRoo=hRoo,
    nConExt=1,
    nConExtWin=1,
    datConExtWin(
      layers={conExtWal},
      A={12*hRoo},
      glaSys={datGlaSys},
      wWin={nWinTwin*wWin*hWin},
      each hWin=hWin,
      fFra={0.1},
      til={Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.S}),
    nConPar=2,
    nConBou=0,
    nSurBou=2,
    use_C_flow=true,
    C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
    nPorts=6,
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal=(AFlo220*hRoo)*1.2*ach/3600,
    final sampleModel=sampleModel) "Room 2.20"
    annotation (Placement(transformation(extent={{20,-46},{60,-6}})));
  Buildings.ThermalZones.Detailed.MixedAir SecFloor(
    datConExtWin(
      layers={conExtWal,conExtWal,conExtWal},
      A={(4.073 + 1.8 + 4.8)*hRoo,28.873*hRoo,(4.073 + 1.8 + 4.8)*hRoo},
      glaSys={datGlaSys,datGlaSys,datGlaSys},
      wWin={wWinWes,nWinTwin*wWinNor,wWinEas},
      hWin={hWinWes,hWinNor,hWinEas},
      fFra={0.1,0.1,0.1},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.W,Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.E}),
    surBou(
      each A=(wSouFac/2)*hRoo,
      each absIR=0.9,
      each absSol=0.9,
      each til=Buildings.Types.Tilt.Wall),
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=AFlo2nd,
    hRoo=hRoo,
    nConExt=0,
    nConExtWin=3,
    nConPar=2,
    datConPar(
      layers={conFlo,conFlo},
      A={AFlo2nd,AFlo2nd},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Ceiling}),
    nConBou=0,
    nSurBou=2,
    use_C_flow=true,
    C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
    nPorts=7,
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal=(AFlo219*hRoo)*1.2*ach/3600,
    final sampleModel=sampleModel) "Rest of 2nd floor lumped as one zone"
    annotation (Placement(transformation(extent={{146,36},{186,76}})));

  InternalGains.InternalGains                           gai(
    Area=1,                                                               redeclare
      Adrenalin2_training.Components.InternalGains.Data.SNTS3031_Office data(
        equSenPowNom=0.5, ligSenPowNom=0.5),
    combiTimeTable(
      tableOnFile=true,
      tableName="tab1",
      fileName=ModelicaServices.ExternalReferences.loadResource(
          "Resources/intGains.txt")))
    "Matrix gain to split up heat gain in radiant, convective and latent gain"
    annotation (Placement(transformation(extent={{-116,104},{-96,124}})));

    Modelica.Blocks.Sources.RealExpression CO2Gen220(y=gai.CO2*AFlo220)
               "CO2 generated by people in the west zone"
  annotation (Placement(transformation(extent={{-110,52},{-90,72}})));
  Modelica.Blocks.Sources.RealExpression CO2Gen2nd(y=gai.CO2*AFlo2nd)
               "CO2 generated by people in the corridor zone"
  annotation (Placement(transformation(extent={{82,52},{102,72}})));
  Modelica.Blocks.Sources.RealExpression CO2Gen219(y=gai.CO2*AFlo219)
               "CO2 generated by people in the south zone"
  annotation (Placement(transformation(extent={{74,-30},{94,-10}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAir220
    "Heat port to air volume" annotation (Placement(transformation(extent={{-34,
            26},{-24,36}}), iconTransformation(extent={{-34,26},{-24,36}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRad220
    "Heat port for radiative heat gain and radiative temperature" annotation (
      Placement(transformation(extent={{-34,12},{-24,22}}), iconTransformation(
          extent={{-34,12},{-24,22}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAir219
    "Heat port to air volume" annotation (Placement(transformation(extent={{128,
            -22},{138,-12}}), iconTransformation(extent={{128,-22},{138,-12}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRad219
    "Heat port for radiative heat gain and radiative temperature" annotation (
      Placement(transformation(extent={{128,-38},{138,-28}}),
        iconTransformation(extent={{128,-38},{138,-28}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAir2nd
    "Heat port to air volume" annotation (Placement(transformation(extent={{128,
            50},{138,60}}), iconTransformation(extent={{128,50},{138,60}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRad2nd
    "Heat port for radiative heat gain and radiative temperature" annotation (
      Placement(transformation(extent={{128,34},{138,44}}), iconTransformation(
          extent={{128,34},{138,44}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAir1st
    "Heat port to air volume" annotation (Placement(transformation(extent={{128,
            124},{138,134}}), iconTransformation(extent={{128,124},{138,134}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRad1st
    "Heat port for radiative heat gain and radiative temperature" annotation (
      Placement(transformation(extent={{128,108},{138,118}}),
        iconTransformation(extent={{128,108},{138,118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAir3rd
    "Heat port to air volume" annotation (Placement(transformation(extent={{320,
            20},{330,30}}), iconTransformation(extent={{320,20},{330,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRad3rd
    "Heat port for radiative heat gain and radiative temperature" annotation (
      Placement(transformation(extent={{322,12},{332,22}}), iconTransformation(
          extent={{322,12},{332,22}})));
  Buildings.Fluid.Sensors.PPM senCO2Sou(redeclare package Medium = Medium,
      warnAboutOnePortConnection=false)
    annotation (Placement(transformation(extent={{294,192},{314,212}})));
  Buildings.Fluid.Sensors.PPM senCO2Eas(redeclare package Medium = Medium,
      warnAboutOnePortConnection=false)
    annotation (Placement(transformation(extent={{294,168},{314,188}})));
  Buildings.Fluid.Sensors.PPM senCO2Nor(redeclare package Medium = Medium,
      warnAboutOnePortConnection=false)
    annotation (Placement(transformation(extent={{294,144},{314,164}})));
  Buildings.Fluid.Sensors.PPM senCO2Wes(redeclare package Medium = Medium,
      warnAboutOnePortConnection=false)
    annotation (Placement(transformation(extent={{294,120},{314,140}})));
  Buildings.Fluid.Sensors.PPM senCO2Cor(redeclare package Medium = Medium,
      warnAboutOnePortConnection=false)
    annotation (Placement(transformation(extent={{294,100},{314,120}})));
  Modelica.Blocks.Routing.Multiplex5 multiplex5_2
    annotation (Placement(transformation(extent={{350,144},{370,164}})));
  Modelica.Blocks.Interfaces.RealOutput CO2Roo[5]
    "Connector of Real output signals" annotation (Placement(transformation(
          extent={{380,70},{400,90}}), iconTransformation(extent={{380,70},{400,
            90}})));
  BaseClasses.shading              shading_control[5](
    each threshold=150,
    each til=Buildings.Types.Tilt.Wall,
    each lat=lat,
    azi={Buildings.Types.Azimuth.S,Buildings.Types.Azimuth.S,Buildings.Types.Azimuth.W,Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.E})
    annotation (Placement(transformation(extent={{-58,174},{-38,194}})));
  Buildings.Utilities.IO.SignalExchange.Read reaCO2Cor(
    description="Temperature of core zone",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    zone="5",
    y(unit="ppm"))
    annotation (Placement(transformation(extent={{322,106},{330,114}})));

  Buildings.Utilities.IO.SignalExchange.Read reaCO2Wes(
    description="Temperature of west zone",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    zone="4",
    y(unit="ppm"))
    annotation (Placement(transformation(extent={{322,126},{330,134}})));

  Buildings.Utilities.IO.SignalExchange.Read reaCO2Nor(
    description="Temperature of north zone",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    zone="3",
    y(unit="ppm"))
    annotation (Placement(transformation(extent={{322,150},{330,158}})));

  Buildings.Utilities.IO.SignalExchange.Read reaCO2Eas(
    description="Temperature of east zone",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    zone="2",
    y(unit="ppm"))
    annotation (Placement(transformation(extent={{322,174},{330,182}})));

  Buildings.Utilities.IO.SignalExchange.Read reaCO2Sou(
    description="Temperature of south zone",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    zone="1",
    y(unit="ppm"))
    annotation (Placement(transformation(extent={{322,198},{330,206}})));

  Buildings.Utilities.IO.SignalExchange.Overwrite oveSha219(description="Overwrite shading position for 2.19",
                                                       u(
      unit="1",
      min=0,
      max=1)) annotation (Placement(transformation(extent={{126,-10},{136,0}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveSha220(description="Overwrite shading position for 2.20",
                                                      u(
      unit="1",
      min=0,
      max=1)) annotation (Placement(transformation(extent={{-10,70},{0,80}})));
  Buildings.Utilities.IO.SignalExchange.Read reaAuxPow(
    description="Aux power consumption",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W", displayUnit="W"))
    annotation (Placement(transformation(extent={{-142,80},{-160,98}})));

  Modelica.Blocks.Math.Gain gaiArea(k=1)
    annotation (Placement(transformation(extent={{-110,80},{-130,100}})));
  parameter Buildings.HeatTransfer.Data.Solids.Concrete matConExt(
    x=0.15,
    k=1.311,
    c=836,
    nStaRef=5) "Concrete for external facade"
    annotation (Placement(transformation(extent={{178,432},{198,452}})));
 parameter Buildings.HeatTransfer.Data.Solids.GypsumBoard matGyp1(
    x=0.026,
    k=0.25,
    c=960,
    d=680,
    nStaRef=2) "Gypsum board"
   annotation (Placement(transformation(extent={{-356,246},{-336,266}})));
 parameter Buildings.HeatTransfer.Data.Solids.Generic matMinWooFraWoo(
    x=0.098,
    k=0.046,
    c=1900,
    d=74) "Wooden frame and mineral wool"
    annotation (Placement(transformation(extent={{-356,216},{-336,236}})));
  parameter Buildings.HeatTransfer.Data.Solids.Generic matChiBoa(
    x=0.044,
    k=0.14,
    c=1800,
    d=650) "Chipboard"
    annotation (Placement(transformation(extent={{566,450},{586,470}})));
  parameter Buildings.HeatTransfer.Data.Solids.Generic matMinWoo(
    x=0.068,
    k=0.035,
    c=830,
    d=20) "Mineral Wool"
    annotation (Placement(transformation(extent={{566,424},{586,444}})));
  parameter Buildings.HeatTransfer.Data.Solids.Generic matCLT(
    x=0.21,
    k=0.13,
    c=1600,
    d=471) "CLT"
    annotation (Placement(transformation(extent={{566,398},{586,418}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTempBoundary(T=288.15)
    annotation (Placement(transformation(extent={{282,-24},{302,-4}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol1(redeclare package Medium =
        Medium,
    m_flow_nominal=1E-3,
    V=10,       nPorts=3)
    annotation (Placement(transformation(extent={{356,10},{376,30}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol2(
    redeclare package Medium = Medium,
    m_flow_nominal=1E-3,
    V=10,
    nPorts=3)
    annotation (Placement(transformation(extent={{228,144},{248,164}})));
  Buildings.HeatTransfer.Conduction.MultiLayer parWal220To2nd(
    A=(wSouFac/2)*hRoo,
    layers=conIntWal,
    stateAtSurface_a=true,
    stateAtSurface_b=true)
    "Partition wall between room 2.20 to rest of 2nd floor" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={78,16})));
  Buildings.HeatTransfer.Conduction.MultiLayer parWal219To2nd(
    A=(wSouFac/2)*hRoo,
    layers=conIntWal,
    stateAtSurface_a=true,
    stateAtSurface_b=true)
    "Partition wall between room 2.19 to rest of 2nd floor" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={238,14})));
  parameter BaseClasses.TripleArgon18Argon18Clear datGlaSys(haveExteriorShade=
        true, shade=Buildings.HeatTransfer.Data.Shades.Gray())
    annotation (Placement(transformation(extent={{240,422},{260,442}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-128,-152},{-108,-132}})));
  Buildings.HeatTransfer.Conduction.MultiLayer parWal220To219(
    A=5.89*hRoo,
    layers=conIntWal,
    stateAtSurface_a=true,
    stateAtSurface_b=true) "Partition wall between room 2.20 and room 2.19"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={212,-114})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveShaSecFloorWes(description
      ="Overwrite shading position for second floor", u(
      unit="1",
      min=0,
      max=1)) annotation (Placement(transformation(extent={{72,148},{82,158}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveShaSecFloorNor(description
      ="Overwrite shading position for second floor", u(
      unit="1",
      min=0,
      max=1)) annotation (Placement(transformation(extent={{72,166},{82,176}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveShaSecFloorEas(description
      ="Overwrite shading position for second floor", u(
      unit="1",
      min=0,
      max=1)) annotation (Placement(transformation(extent={{72,182},{82,192}})));
  Modelica.Blocks.Sources.Constant intGains2nd[3](k=0)
    annotation (Placement(transformation(extent={{-124,12},{-104,32}})));
equation
  connect(room219.weaBus, weaBus) annotation (Line(
      points={{179.9,-6.1},{179.9,8},{210,8},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(room220.weaBus, weaBus) annotation (Line(
      points={{57.9,-8.1},{57.9,200},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(SecFloor.weaBus, weaBus) annotation (Line(
      points={{183.9,73.9},{183.9,90},{210,90},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(multiplex5_1.y, TRooAir) annotation (Line(
      points={{371,290},{372,290},{372,160},{390,160}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(room219.heaPorAir,temAir219.port)  annotation (Line(
      points={{161,-24},{224,-24},{224,100},{264,100},{264,350},{290,350}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(room220.heaPorAir,temAir220.port)  annotation (Line(
      points={{39,-26},{-28,-26},{-28,248},{-8,248},{-8,284},{280,284},{280,258},
          {292,258}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(SecFloor.heaPorAir,temAir2nd.port)  annotation (Line(
      points={{165,56},{162,56},{162,228},{294,228}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(room219.ports[1],ports219 [1]) annotation (Line(
      points={{147,-35.6667},{114,-35.6667},{114,-36},{85,-36}},
      color={0,127,255},
      thickness=0.5));
  connect(room219.ports[2],ports219 [2]) annotation (Line(
      points={{147,-35},{122,-35},{122,-50},{108,-50},{108,-36},{95,-36}},
      color={0,127,255},
      thickness=0.5));
  connect(room220.ports[1],ports220 [1]) annotation (Line(
      points={{25,-37.6667},{25,-32},{-32,-32},{-32,4},{-35,4},{-35,44}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(room220.ports[2],ports220 [2]) annotation (Line(
      points={{25,-37},{-32,-37},{-32,4},{-36,4},{-36,44},{-25,44}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(SecFloor.ports[1],ports2nd [1]) annotation (Line(
      points={{151,44.2857},{114,44.2857},{114,46},{85,46}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(SecFloor.ports[2],ports2nd [2]) annotation (Line(
      points={{151,44.8571},{124,44.8571},{124,46},{95,46}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senRelPre2nd.p_rel, p_rel) annotation (Line(
      points={{50,241},{50,220},{-170,220}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(CO2Gen220.y, room220.C_flow[1]) annotation (Line(points={{-89,62},{
          -64,62},{-64,32},{0,32},{0,-23.2},{18.4,-23.2}},
                                                       color={0,0,127}));
  connect(CO2Gen2nd.y, SecFloor.C_flow[1]) annotation (Line(points={{103,62},{
          124,62},{124,58.8},{144.4,58.8}},
                                        color={0,0,127}));
  connect(room220.heaPorAir,heaPorAir220)
    annotation (Line(points={{39,-26},{-29,-26},{-29,31}}, color={191,0,0}));
  connect(room220.heaPorRad,heaPorRad220)  annotation (Line(points={{39,-29.8},{
          16,-29.8},{16,-16},{8,-16},{8,32},{-24,32},{-24,17},{-29,17}}, color={
          191,0,0}));
  connect(room219.heaPorAir,heaPorAir219)  annotation (Line(points={{161,-24},{
          192,-24},{192,-17},{133,-17}},
                                     color={191,0,0}));
  connect(room219.heaPorRad,heaPorRad219)  annotation (Line(points={{161,-27.8},
          {162,-27.8},{162,-48},{126,-48},{126,-33},{133,-33}}, color={191,0,0}));
  connect(SecFloor.heaPorAir,heaPorAir2nd)  annotation (Line(points={{165,56},{134,
          56},{134,55},{133,55}}, color={191,0,0}));
  connect(SecFloor.heaPorRad,heaPorRad2nd)  annotation (Line(points={{165,52.2},
          {133,52.2},{133,39}}, color={191,0,0}));
  connect(CO2Gen219.y, room219.C_flow[1]) annotation (Line(points={{95,-20},{95,
          4},{120,4},{120,8},{140.4,8},{140.4,-21.2}},
                               color={0,0,127}));
  connect(senCO2Sou.port, room219.ports[3]) annotation (Line(points={{304,192},
          {216,192},{216,-44},{128,-44},{128,-34.3333},{147,-34.3333}},
                                                                 color={0,127,255}));
  connect(senCO2Wes.port, room220.ports[3]) annotation (Line(points={{304,120},
          {282,120},{282,196},{226,196},{226,200},{190,200},{190,196},{46,196},
          {46,68},{6,68},{6,44},{-38,44},{-38,4},{-34,4},{-34,-36.3333},{25,
          -36.3333}},
        color={0,127,255}));
  connect(senCO2Cor.port, SecFloor.ports[3]) annotation (Line(points={{304,100},
          {288,100},{288,28},{228,28},{228,40},{188,40},{188,32},{140,32},{140,
          45.4286},{151,45.4286}},
                          color={0,127,255}));
  connect(multiplex5_2.y, CO2Roo) annotation (Line(points={{371,154},{372,154},{
          372,80},{390,80}},  color={0,0,127},
      pattern=LinePattern.Dash));
  connect(weaBus, shading_control[1].weaBus) annotation (Line(
      points={{210,200},{-60,200},{-60,193.4},{-57,193.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus, shading_control[2].weaBus) annotation (Line(
      points={{210,200},{-57,200},{-57,193.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus, shading_control[3].weaBus) annotation (Line(
      points={{210,200},{-57,200},{-57,193.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(senCO2Sou.ppm, reaCO2Sou.u) annotation (Line(
      points={{315,202},{321.2,202}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senCO2Eas.ppm, reaCO2Eas.u) annotation (Line(
      points={{315,178},{321.2,178}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senCO2Nor.ppm, reaCO2Nor.u) annotation (Line(
      points={{315,154},{321.2,154}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senCO2Wes.ppm, reaCO2Wes.u) annotation (Line(
      points={{315,130},{321.2,130}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senCO2Cor.ppm, reaCO2Cor.u) annotation (Line(
      points={{315,110},{321.2,110}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(reaCO2Cor.y, multiplex5_2.u5[1]) annotation (Line(
      points={{330.4,110},{340,110},{340,144},{348,144}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(reaCO2Wes.y, multiplex5_2.u4[1]) annotation (Line(
      points={{330.4,130},{336,130},{336,148},{348,148},{348,149}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(reaCO2Nor.y, multiplex5_2.u3[1]) annotation (Line(
      points={{330.4,154},{348,154}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(reaCO2Eas.y, multiplex5_2.u2[1]) annotation (Line(
      points={{330.4,178},{336,178},{336,160},{348,160},{348,159}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(reaCO2Sou.y, multiplex5_2.u1[1]) annotation (Line(
      points={{330.4,202},{340,202},{340,164},{348,164}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(oveSha219.y, room219.uSha[1]) annotation (Line(
      points={{136.5,-5},{139.45,-5},{139.45,-6},{140.4,-6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(oveSha220.y, room220.uSha[1]) annotation (Line(
      points={{0.5,75},{12,75},{12,-8},{18.4,-8}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gai.elCon, gaiArea.u) annotation (Line(points={{-95,106},{-92,106},{
          -92,89},{-108,90}}, color={0,0,127}));
  connect(gaiArea.y, reaAuxPow.u) annotation (Line(points={{-131,90},{-135.6,90},
          {-135.6,89},{-140.2,89}}, color={0,0,127}));
  connect(fixedTempBoundary.port, heaPorAir3rd) annotation (Line(points={{302,-14},
          {316,-14},{316,25},{325,25}}, color={191,0,0}));
  connect(fixedTempBoundary.port, heaPorRad3rd)
    annotation (Line(points={{302,-14},{327,-14},{327,17}}, color={191,0,0}));
  connect(fixedTempBoundary.port,heaPorRad1st)  annotation (Line(points={{302,-14},
          {308,-14},{308,113},{133,113}}, color={191,0,0}));
  connect(fixedTempBoundary.port,heaPorAir1st)
    annotation (Line(points={{302,-14},{302,129},{133,129}}, color={191,0,0}));
  connect(vol1.heatPort,temAir3rd.port)  annotation (Line(points={{356,20},{356,
          240},{214,240},{214,320},{292,320}}, color={191,0,0}));
  connect(vol2.heatPort,temAir1st.port)  annotation (Line(points={{228,154},{224,
          154},{224,256},{240,256},{240,290},{292,290}}, color={191,0,0}));
  connect(ports1st[1], vol2.ports[1]) annotation (Line(points={{85,124},{85,88},
          {236.667,88},{236.667,144}},
                      color={0,127,255}));
  connect(ports3rd[1], vol1.ports[1]) annotation (Line(points={{325,36},{336,36},
          {336,-2},{364.667,-2},{364.667,10}},
                                  color={0,127,255}));
  connect(ports1st[2], vol2.ports[2]) annotation (Line(points={{95,124},{238,124},
          {238,144}}, color={0,127,255}));
  connect(ports3rd[2], vol1.ports[2]) annotation (Line(points={{335,36},{335,-38},
          {366,-38},{366,10}}, color={0,127,255}));
  connect(vol2.ports[3], senCO2Eas.port) annotation (Line(points={{239.333,144},
          {248,144},{248,128},{254,128},{254,168},{304,168}}, color={0,127,255}));
  connect(vol1.ports[3], senCO2Nor.port) annotation (Line(points={{367.333,10},
          {376,10},{376,-18},{424,-18},{424,46},{250,46},{250,144},{304,144}},
        color={0,127,255}));
  connect(gai.intGai, room219.qGai_flow) annotation (Line(points={{-95,114},{
          -46,114},{-46,110},{32,110},{32,18},{110,18},{110,-16},{140.4,-16}},
        color={0,0,127}));
  connect(gai.intGai, room220.qGai_flow) annotation (Line(points={{-95,114},{-80,
          114},{-80,138},{-72,138},{-72,-18},{18.4,-18}}, color={0,0,127}));
  connect(SecFloor.surf_surBou[1], parWal219To2nd.port_b) annotation (Line(
        points={{162.2,41.75},{184,41.75},{184,40},{238,40},{238,24}}, color={
          191,0,0}));
  connect(room219.surf_surBou[1], parWal219To2nd.port_a) annotation (Line(
        points={{158.2,-38.25},{158.2,-74},{238,-74},{238,4}},
                                                            color={191,0,0}));
  connect(room220.surf_surBou[1], parWal220To2nd.port_a) annotation (Line(
        points={{36.2,-40.25},{36,-40.25},{36,-74},{62,-74},{62,-4},{78,-4},{78,
          6}},
        color={191,0,0}));
  connect(parWal220To2nd.port_b, SecFloor.surf_surBou[2]) annotation (Line(
        points={{78,26},{78,28},{162,28},{162,36},{162.2,36},{162.2,42.25}},
        color={191,0,0}));
  connect(room220.ports[4], door220To2nd.port_a1) annotation (Line(points={{25,
          -35.6667},{-86,-35.6667},{-86,-92},{-54,-92},{-54,-94}},
                                                             color={0,127,255}));
  connect(door220To2nd.port_b2, room220.ports[5]) annotation (Line(points={{-54,
          -106},{-122,-106},{-122,-28},{-30,-28},{-30,-35},{25,-35}},
        color={0,127,255}));
  connect(door220To2nd.port_b1, SecFloor.ports[3]) annotation (Line(points={{-34,-94},
          {22,-94},{22,45.4286},{151,45.4286}},
                                           color={0,127,255}));
  connect(door220To2nd.port_a2, SecFloor.ports[4]) annotation (Line(points={{-34,
          -106},{-8,-106},{-8,46},{151,46}},
        color={0,127,255}));
  connect(room219.ports[4], door219To2nd.port_b2) annotation (Line(points={{147,
          -33.6667},{147,-136},{58,-136},{58,-106},{88,-106}},
                                                            color={0,127,255}));
  connect(room219.ports[5], door219To2nd.port_a1) annotation (Line(points={{147,-33},
          {132,-33},{132,-76},{60,-76},{60,-94},{88,-94}},          color={0,127,
          255}));
  connect(door219To2nd.port_b1, SecFloor.ports[5]) annotation (Line(points={{108,-94},
          {118,-94},{118,46.5714},{151,46.5714}},      color={0,127,255}));
  connect(door219To2nd.port_a2, SecFloor.ports[6]) annotation (Line(points={{108,
          -106},{110,-106},{110,47.1429},{151,47.1429}}, color={0,127,255}));
  connect(const.y, door220To2nd.y) annotation (Line(points={{-107,-142},{-88,
          -142},{-88,-140},{-90,-140},{-90,-100},{-55,-100}}, color={0,0,127}));
  connect(const.y, door219To2nd.y) annotation (Line(points={{-107,-142},{34,
          -142},{34,-100},{87,-100}}, color={0,0,127}));
  connect(room220.surf_surBou[2], parWal220To219.port_b) annotation (Line(
        points={{36.2,-39.75},{68,-39.75},{68,-116},{186,-116},{186,-114},{202,-114}},
                  color={191,0,0}));
  connect(parWal220To219.port_a, room219.surf_surBou[2]) annotation (Line(
        points={{222,-114},{250,-114},{250,-64},{158.2,-64},{158.2,-37.75}},
                                color={191,0,0}));
  connect(shading_control[1].y, oveSha220.u) annotation (Line(points={{-37,184},
          {-20,184},{-20,138},{-16,138},{-16,-10},{-11,-10},{-11,75}}, color={0,
          0,127}));
  connect(shading_control[2].y, oveSha219.u) annotation (Line(points={{-37,184},
          {-4,184},{-4,122},{42,122},{42,-5},{125,-5}}, color={0,0,127}));
  connect(shading_control[3].y, oveShaSecFloorWes.u) annotation (Line(points={{
          -37,184},{-4,184},{-4,124},{60,124},{60,153},{71,153}}, color={0,0,
          127}));
  connect(oveShaSecFloorWes.y, SecFloor.uSha[1]) annotation (Line(points={{82.5,
          153},{82.5,73.4667},{144.4,73.4667}}, color={0,0,127}));
  connect(shading_control[4].y, oveShaSecFloorNor.u) annotation (Line(points={{
          -37,184},{-6,184},{-6,152},{26,152},{26,171},{71,171}}, color={0,0,
          127}));
  connect(oveShaSecFloorNor.y, SecFloor.uSha[2]) annotation (Line(points={{82.5,
          171},{82.5,74},{144.4,74}}, color={0,0,127}));
  connect(shading_control[5].y, oveShaSecFloorEas.u) annotation (Line(points={{
          -37,184},{8,184},{8,187},{71,187}}, color={0,0,127}));
  connect(oveShaSecFloorEas.y, SecFloor.uSha[3]) annotation (Line(points={{82.5,
          187},{82.5,74.5333},{144.4,74.5333}}, color={0,0,127}));
  connect(shading_control[4].weaBus, out.weaBus) annotation (Line(
      points={{-57,193.4},{-92,193.4},{-92,250.2},{-54,250.2}},
      color={255,204,51},
      thickness=0.5));
  connect(shading_control[5].weaBus, out.weaBus) annotation (Line(
      points={{-57,193.4},{-108,193.4},{-108,250.2},{-54,250.2}},
      color={255,204,51},
      thickness=0.5));
  connect(SecFloor.ports[7], senRelPre2nd.port_a) annotation (Line(points={{151,
          47.7143},{151,36},{132,36},{132,250},{60,250}},
                                                        color={0,127,255}));
  connect(lea219.port_b, room219.ports[6]) annotation (Line(points={{-20,376},{
          22,376},{22,-46},{147,-46},{147,-32.3333}},
                                                   color={0,127,255}));
  connect(lea220.port_b, room220.ports[6]) annotation (Line(points={{-20,334},{
          -8,334},{-8,-34.3333},{25,-34.3333}}, color={0,127,255}));
  connect(intGains2nd.y, SecFloor.qGai_flow) annotation (Line(points={{-103,22},
          {-68,22},{-68,120},{40,120},{40,64},{60,64},{60,84},{144.4,84},{144.4,
          64}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,
        extent={{-160,-100},{380,500}},
        initialScale=0.1), graphics={
        Text(
          extent={{-420,576},{-228,538}},
          lineColor={28,108,200},
          textString="External wall (ZEB YV-223+73)"),
        Rectangle(extent={{-442,580},{-206,378}}, lineColor={28,108,200}),
        Text(
          extent={{-424,314},{-232,276}},
          lineColor={28,108,200},
          textString="Internal Wall (ZEB IV-98 GG)"),
        Rectangle(extent={{-442,320},{-206,118}}, lineColor={28,108,200}),
        Text(
          extent={{490,536},{682,498}},
          lineColor={28,108,200},
          textString="Internal Slab"),
        Rectangle(extent={{476,552},{688,360}}, lineColor={28,108,200})}),
                                Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-80,-80},{380,180}}), graphics={
        Rectangle(
          extent={{-80,-80},{380,180}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,160},{360,-60}},
          pattern=LinePattern.None,
          lineColor={117,148,176},
          fillColor={170,213,255},
          fillPattern=FillPattern.Sphere),
        Rectangle(
          extent={{0,-80},{294,-60}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,-74},{294,-66}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{8,8},{294,100}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,88},{280,22}},
          pattern=LinePattern.None,
          lineColor={117,148,176},
          fillColor={170,213,255},
          fillPattern=FillPattern.Sphere),
        Polygon(
          points={{-56,170},{20,94},{12,88},{-62,162},{-56,170}},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{290,16},{366,-60},{358,-66},{284,8},{290,16}},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{284,96},{360,168},{368,162},{292,90},{284,96}},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-80,120},{-60,-20}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-74,120},{-66,-20}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-64,-56},{18,22},{26,16},{-58,-64},{-64,-56}},
          smooth=Smooth.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{360,122},{380,-18}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{366,122},{374,-18}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,170},{296,178}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,160},{296,180}},
          lineColor={95,95,95},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,166},{296,174}},
          lineColor={95,95,95},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
    <ul>
<li>
April 30, 2021, by Michael Wetter:<br/>
Reformulated replaceable class and introduced floor areas in base class
to avoid access of components that are not in the constraining type.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2471\">issue #2471</a>.
</li>
<li>
January 23, 2020, by Milica Grahovac:<br/>
Updated core zone geometry parameters related to
room heat and mass balance.
</li>
<li>
November 15, 2019, by Milica Grahovac:<br/>
Added extend from a partial floor model.
</li>
<li>
May 1, 2013, by Michael Wetter:<br/>
Declared the parameter record to be a parameter, as declaring its elements
to be parameters does not imply that the whole record has the variability of a parameter.
</li>
</ul>
</html>", info="<html>
<p>
Model of a floor that consists
of five thermal zones that are representative of one floor of the
new construction medium office building for Chicago, IL,
as described in the set of DOE Commercial Building Benchmarks.
There are four perimeter zones and one core zone.
The envelope thermal properties meet ASHRAE Standard 90.1-2004.
</p>
</html>"),
    experiment(StopTime=604800, __Dymola_Algorithm="Dassl"));
end Floor5Zone_Shading;
