within Adrenalin2_training.Components;
model Floor5Zone_Shading
  "Model of a floor of the building with automatic solar shading"
  extends Adrenalin2_training.Components.BaseClasses.PartialFloor(
    lea220(amb(C=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
            /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC))),
    lea219(amb(C=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
            /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC))),
    redeclare final package Medium = MediumA,
    final VRooCor=secFloor.AFlo*hRoo,
    final VRooSou=room219.AFlo*hRoo,
    final VRooNor=room220.AFlo*hRoo,
    final VRooEas=ThirdFloor.VAir,
    final VRooWes=FirstFloor.VAir,
    AFloCor=2698/hRoo,
    AFloSou=568.77/hRoo,
    AFloNor=568.77/hRoo,
    AFloEas=360.0785/hRoo,
    AFloWes=360.0785/hRoo);

  package MediumA = Buildings.Media.Air(extraPropertiesNames={"CO2"}) "Medium model for air";

  parameter Buildings.HeatTransfer.Types.InteriorConvection intConMod=Buildings.HeatTransfer.Types.InteriorConvection.Temperature
    "Convective heat transfer model for room-facing surfaces of opaque constructions";
  parameter Modelica.SIunits.Angle lat "Latitude";
  parameter Real winWalRat(
    min=0.01,
    max=0.99) = 0.33 "Window to wall ratio for exterior walls";
  parameter Modelica.SIunits.Length hWin = 1.5 "Height of windows";
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
      nLay=9, material={matDoubleBevel, matHorBatt, matVerBatt, matWinBar, matGUx, matMinWooFra, matVapBar, matMinWooFur, matGyp})
                                               "Exterior construction"
    annotation (Placement(transformation(extent={{278,460},{298,480}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conIntWal(final
      nLay=3, material={matGyp1,matMinWooFraWoo,matGyp1})
                                  "Interior wall construction"
    annotation (Placement(transformation(extent={{320,460},{340,480}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic conFlo(final
      nLay=1, material={matCon}) "Floor construction (opa_a is carpet)"
    annotation (Placement(transformation(extent={{280,420},{300,440}})));
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

  constant Modelica.SIunits.Height hRoo=2.74 "Room height";

  parameter Boolean sampleModel = false
    "Set to true to time-sample the model, which can give shorter simulation time if there is already time sampling in the system model"
    annotation (
      Evaluate=true,
      Dialog(tab="Experimental (may be changed in future releases)"));

  Buildings.ThermalZones.Detailed.MixedAir room219(
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=AFloSou,
    hRoo=hRoo,
    nConExt=0,
    nConExtWin=1,
    datConExtWin(
      layers={conExtWal},
      A={49.91*hRoo},
      glaSys={glaSys},
      wWin={winWalRat/hWin*49.91*hRoo},
      each hWin=hWin,
      fFra={0.1},
      til={Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.S}),
    nConPar=2,
    datConPar(
      layers={conFlo,conFur},
      A={AFloSou,414.68},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall}),
    nConBou=3,
    datConBou(
      layers={conIntWal,conIntWal,conIntWal},
      A={6.47,40.76,6.47}*hRoo,
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),
    nSurBou=0,
    use_C_flow=true,
    C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel,
    nPorts=4)                      "Room 2.19"
    annotation (Placement(transformation(extent={{198,-134},{248,-86}})));

  Buildings.ThermalZones.Detailed.MixedAir room220(
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=AFloWes,
    hRoo=hRoo,
    nConExt=0,
    nConExtWin=1,
    datConExtWin(
      layers={conExtWal},
      A={33.27*hRoo},
      glaSys={glaSys},
      wWin={winWalRat/hWin*33.27*hRoo},
      each hWin=hWin,
      fFra={0.1},
      til={Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.W}),
    nConPar=2,
    datConPar(
      layers={conFlo,conFur},
      A={AFloWes,262.52},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall}),
    nConBou=1,
    datConBou(
      layers={conIntWal},
      A={24.13}*hRoo,
      til={Buildings.Types.Tilt.Wall}),
    nSurBou=2,
    surBou(
      each A=6.47*hRoo,
      each absIR=0.9,
      each absSol=0.9,
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),
    use_C_flow=true,
    C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel,
    nPorts=4)                      "Room 2.20"
    annotation (Placement(transformation(extent={{-82,-72},{-42,-32}})));
  Buildings.ThermalZones.Detailed.MixedAir secFloor(
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=AFloCor,
    hRoo=hRoo,
    nConExt=0,
    nConExtWin=0,
    nConPar=2,
    datConPar(
      layers={conFlo,conFur},
      A={AFloCor,1967.01},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall}),
    nConBou=0,
    nSurBou=4,
    surBou(
      A={40.76,24.13,40.76,24.13}*hRoo,
      each absIR=0.9,
      each absSol=0.9,
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,
          Buildings.Types.Tilt.Wall}),
    use_C_flow=true,
    C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel,
    nPorts=6)                      "Rest of 2nd floor"
    annotation (Placement(transformation(extent={{78,100},{118,140}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAirWes
    "Heat port to air volume" annotation (Placement(transformation(extent={{-104,
            -50},{-94,-40}}),
                            iconTransformation(extent={{-104,-50},{-94,-40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRadWes
    "Heat port for radiative heat gain and radiative temperature" annotation (
      Placement(transformation(extent={{-106,-64},{-96,-54}}),
                                                            iconTransformation(
          extent={{-106,-64},{-96,-54}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAirSou
    "Heat port to air volume" annotation (Placement(transformation(extent={{266,-36},
            {276,-26}}),      iconTransformation(extent={{266,-36},{276,-26}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRadSou
    "Heat port for radiative heat gain and radiative temperature" annotation (
      Placement(transformation(extent={{266,-50},{276,-40}}),
        iconTransformation(extent={{266,-50},{276,-40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAirNor
    "Heat port to air volume" annotation (Placement(transformation(extent={{38,118},
            {48,128}}),       iconTransformation(extent={{38,118},{48,128}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRadNor
    "Heat port for radiative heat gain and radiative temperature" annotation (
      Placement(transformation(extent={{38,102},{48,112}}),
        iconTransformation(extent={{38,102},{48,112}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAir1
    "Heat port to air volume" annotation (Placement(transformation(extent={{810,-80},
            {786,-104}}),   iconTransformation(extent={{810,-80},{786,-104}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRad1
    "Heat port for radiative heat gain and radiative temperature" annotation (
      Placement(transformation(extent={{786,-86},{810,-62}}),
                                                            iconTransformation(
          extent={{786,-86},{810,-62}})));
  Buildings.Fluid.Sensors.PPM senCO2Roo219(redeclare package Medium = Medium,
      warnAboutOnePortConnection=false)
    annotation (Placement(transformation(extent={{294,192},{314,212}})));
  Buildings.Fluid.Sensors.PPM senCO2Roo220(redeclare package Medium = Medium,
      warnAboutOnePortConnection=false)
    annotation (Placement(transformation(extent={{294,168},{314,188}})));
  Buildings.Fluid.Sensors.PPM senCO2SecFloor(redeclare package Medium = Medium,
      warnAboutOnePortConnection=false)
    annotation (Placement(transformation(extent={{294,144},{314,164}})));
  Modelica.Blocks.Interfaces.RealOutput CO2Roo[3]
    "Connector of Real output signals" annotation (Placement(transformation(
          extent={{380,70},{400,90}}), iconTransformation(extent={{380,70},{400,
            90}})));
  BaseClasses.shading              shading_control[4](
    each threshold=150,
    each til=Buildings.Types.Tilt.Wall,
    each lat=lat,
    azi={Buildings.Types.Azimuth.S,Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.N,
        Buildings.Types.Azimuth.W})
    annotation (Placement(transformation(extent={{-58,174},{-38,194}})));

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

  Buildings.Utilities.IO.SignalExchange.Overwrite oveSha219(description=
        "Overwrite shading position for south facade", u(
      unit="1",
      min=0,
      max=1)) annotation (Placement(transformation(extent={{258,-72},{268,-62}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveSha220(description=
        "Overwrite shading position for west facade", u(
      unit="1",
      min=0,
      max=1)) annotation (Placement(transformation(extent={{-10,70},{0,80}})));

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
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1
    annotation (Placement(transformation(extent={{340,104},{360,124}})));
  Buildings.ThermalZones.ReducedOrder.RC.OneElement ThirdFloor(
    redeclare package Medium = Buildings.Media.Air,
    VAir=100,
    hRad=0.15,
    nOrientations=1,
    AWin={1},
    ATransparent={1},
    hConWin=0.15,
    RWin=10,
    gWin=1,
    ratioWinConRad=1,
    AExt={1},
    hConExt=0.15,
    nExt=1,
    RExt={1},
    RExtRem=1,
    CExt={1e7},
    use_moisture_balance=false,
    use_C_flow=true,
    nPorts=2)
    annotation (Placement(transformation(extent={{570,122},{716,230}})));
  Buildings.ThermalZones.ReducedOrder.RC.OneElement FirstFloor(
    redeclare package Medium = Buildings.Media.Air,
      VAir=100,
    hRad=0.15,
    nOrientations=1,
    AWin={1},
    ATransparent={1},
    hConWin=0.15,
    RWin=10,
    gWin=1,
    ratioWinConRad=1,
    AExt={1},
    hConExt=0.15,
    nExt=1,
    RExt={1},
    RExtRem=1,
    CExt={1e7},
    use_C_flow=true,
    nPorts=2)
    annotation (Placement(transformation(extent={{574,-150},{746,-52}})));
  Buildings.BoundaryConditions.SolarIrradiation.DiffusePerez
                                                   HDifTil[1](
    each outSkyCon=true,
    each outGroCon=true,
    each til=1.5707963267949,
    each lat=0.87266462599716,
    azi={4.7123889803847})
    "Calculates diffuse solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{784,280},{804,300}})));
  Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface
                                                          HDirTil[1](
    each til=1.5707963267949,
    each lat=0.87266462599716,
    azi={4.7123889803847})
    "Calculates direct solar radiation on titled surface for both directions"
    annotation (Placement(transformation(extent={{784,312},{804,332}})));
  Buildings.ThermalZones.ReducedOrder.SolarGain.CorrectionGDoublePane
                                  corGDouPan(UWin=2.1, n=1)
    "Correction factor for solar transmission"
    annotation (Placement(transformation(extent={{858,306},{878,326}})));
  Buildings.ThermalZones.ReducedOrder.EquivalentAirTemperature.VDI6007WithWindow
                                             eqAirTemp(
    wfGro=0,
    withLongwave=true,
    aExt=0.7,
    hConWallOut=20,
    hRad=5,
    hConWinOut=20,
    n=1,
    wfWall={1},
    wfWin={1},
    TGro=285.15) "Computes equivalent air temperature"
    annotation (Placement(transformation(extent={{828,246},{848,266}})));
  Modelica.Blocks.Math.Add solRad[1]
    "Sums up solar radiation of both directions"
    annotation (Placement(transformation(extent={{814,266},{824,276}})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature preTem
    "Prescribed temperature for exterior walls outdoor surface temperature"
    annotation (Placement(transformation(extent={{860,254},{872,266}})));
  Buildings.HeatTransfer.Sources.PrescribedTemperature preTem1
    "Prescribed temperature for windows outdoor surface temperature"
    annotation (Placement(transformation(extent={{860,274},{872,286}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWin
    "Outdoor convective heat transfer of windows"
    annotation (Placement(transformation(extent={{890,276},{880,286}})));
  Modelica.Thermal.HeatTransfer.Components.Convection theConWall
    "Outdoor convective heat transfer of walls"
    annotation (Placement(transformation(extent={{888,266},{878,256}})));
  Modelica.Blocks.Sources.Constant const[1](each k=0)
    "Sets sunblind signal to zero (open)"
    annotation (Placement(transformation(extent={{832,274},{838,280}})));
  Modelica.Blocks.Sources.Constant hConWall(k=25*11.5)
    "Outdoor coefficient of heat transfer for walls"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}}, rotation=90,
    origin={882,244})));
  Modelica.Blocks.Sources.Constant hConWin(k=20*14)
    "Outdoor coefficient of heat transfer for windows"
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
    rotation=90,origin={884,298})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveShaSecFloor(description="Overwrite shading position for second floor",
      u(
      unit="1",
      min=0,
      max=1)) annotation (Placement(transformation(extent={{14,134},{24,144}})));
equation
  connect(room219.weaBus, weaBus) annotation (Line(
      points={{245.375,-88.52},{245.375,200},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(room220.weaBus, weaBus) annotation (Line(
      points={{-44.1,-34.1},{88,-34.1},{88,84},{136,84},{136,100},{210,100},{210,
          200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(secFloor.weaBus, weaBus) annotation (Line(
      points={{115.9,137.9},{210,137.9},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(senRelPre.p_rel, p_rel) annotation (Line(
      points={{50,241},{50,220},{-170,220}},
      color={0,0,127},
      smooth=Smooth.None,
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
  connect(weaBus, shading_control[4].weaBus) annotation (Line(
      points={{210,200},{-57,200},{-57,193.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(senCO2Roo219.ppm, reaCO2Sou.u) annotation (Line(
      points={{315,202},{321.2,202}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senCO2Roo220.ppm, reaCO2Eas.u) annotation (Line(
      points={{315,178},{321.2,178}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senCO2SecFloor.ppm, reaCO2Nor.u) annotation (Line(
      points={{315,154},{321.2,154}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(shading_control[1].y,oveSha219. u) annotation (Line(
      points={{-37,184},{-16,184},{-16,88},{200,88},{200,24},{196,24},{196,-67},
          {257,-67}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(shading_control[4].y,oveSha220. u) annotation (Line(
      points={{-37,184},{-16,184},{-16,76},{-11,76},{-11,75}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(reaCO2Sou.y, multiplex3_1.u1[1]) annotation (Line(points={{330.4,202},
          {346,202},{346,134},{324,134},{324,121},{338,121}}, color={0,0,127}));
  connect(reaCO2Eas.y, multiplex3_1.u2[1]) annotation (Line(points={{330.4,178},
          {340,178},{340,136},{306,136},{306,114},{338,114}}, color={0,0,127}));
  connect(reaCO2Nor.y, multiplex3_1.u3[1]) annotation (Line(points={{330.4,154},
          {336,154},{336,138},{294,138},{294,107},{338,107}}, color={0,0,127}));
  connect(CO2Roo, multiplex3_1.y) annotation (Line(points={{390,80},{368,80},{368,
          114},{361,114}}, color={0,0,127}));
  connect(heaPorAir1, FirstFloor.intGainsConv) annotation (Line(points={{798,-92},
          {746,-92},{746,-90.1111}}, color={191,0,0}));
  connect(FirstFloor.intGainsRad, heaPorRad1) annotation (Line(points={{746,
          -79.2222},{798,-79.2222},{798,-74}},
                                     color={191,0,0}));
  connect(eqAirTemp.TEqAirWin,preTem1. T)
    annotation (Line(points={{849,259.8},{852,259.8},{852,280},{858.8,280}},
    color={0,0,127}));
  connect(eqAirTemp.TEqAir,preTem. T)
    annotation (Line(points={{849,256},{856,256},{856,260},{858.8,260}},
    color={0,0,127}));
  connect(const.y,eqAirTemp. sunblind)
    annotation (Line(points={{838.3,277},{840,277},{840,268},{838,268}},
    color={0,0,127}));
  connect(HDifTil.HSkyDifTil,corGDouPan. HSkyDifTil)
    annotation (Line(points={{805,296},{846,296},{846,318},{852,318},{852,317.8},
          {856,317.8},{856,318}},
    color={0,0,127}));
  connect(HDirTil.H,corGDouPan. HDirTil)
    annotation (Line(points={{805,322},{856,322}},     color={0,0,127}));
  connect(HDirTil.H,solRad. u1)
    annotation (Line(points={{805,322},{810,322},{810,274},{813,274}},
    color={0,0,127}));
  connect(HDifTil.H,solRad. u2)
    annotation (Line(points={{805,290},{808,290},{808,268},{813,268}},
    color={0,0,127}));
  connect(HDifTil.HGroDifTil,corGDouPan. HGroDifTil)
    annotation (Line(points={{805,284},{848,284},{848,314},{856,314}},
    color={0,0,127}));
  connect(solRad.y,eqAirTemp. HSol)
    annotation (Line(points={{824.5,271},{826,271},{826,262}},
    color={0,0,127}));
  connect(preTem1.port,theConWin. fluid)
    annotation (Line(points={{872,280},{880,280},{880,281}},
                                                       color={191,0,0}));
  connect(theConWall.fluid,preTem. port)
    annotation (Line(points={{878,261},{876,261},{876,260},{872,260}},
                                                           color={191,0,0}));
  connect(hConWall.y,theConWall. Gc)
    annotation (Line(points={{882,248.4},{882,256},{883,256}},
                                                          color={0,0,127}));
  connect(hConWin.y,theConWin. Gc)
    annotation (Line(points={{884,293.6},{884,286},{885,286}},
                                                         color={0,0,127}));
  connect(HDirTil.inc,corGDouPan. inc)
    annotation (Line(points={{805,318},{842,318},{842,310},{856,310}},
    color={0,0,127}));
  connect(corGDouPan.solarRadWinTrans, ThirdFloor.solRad) annotation (Line(
        points={{879,316},{918,316},{918,286},{974,286},{974,230},{732,230},{
          732,268},{528,268},{528,221},{566.958,221}},
                                                   color={0,0,127}));
  connect(theConWin.solid, ThirdFloor.window) annotation (Line(points={{890,281},
          {900,281},{900,280},{940,280},{940,374},{724,374},{724,298},{488,298},
          {488,188},{570,188}}, color={191,0,0}));
  connect(theConWall.solid, ThirdFloor.extWall) annotation (Line(points={{888,261},
          {960,261},{960,340},{514,340},{514,164},{570,164}}, color={191,0,0}));
  connect(weaBus, HDirTil[1].weaBus) annotation (Line(
      points={{210,200},{258,200},{258,232},{334,232},{334,322},{784,322}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, HDifTil[1].weaBus) annotation (Line(
      points={{210,200},{260,200},{260,246},{590,246},{590,290},{784,290}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.TBlaSky, eqAirTemp.TBlaSky) annotation (Line(
      points={{210,200},{222,200},{222,252},{254,252},{254,256},{826,256}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.TDryBul, eqAirTemp.TDryBul) annotation (Line(
      points={{210,200},{206,200},{206,218},{458,218},{458,250},{826,250}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ThirdFloor.extWall, FirstFloor.extWall) annotation (Line(points={{570,164},
          {530,164},{530,108},{474,108},{474,-111.889},{574,-111.889}},
        color={191,0,0}));
  connect(ThirdFloor.window, FirstFloor.window) annotation (Line(points={{570,188},
          {544,188},{544,-90.1111},{574,-90.1111}}, color={191,0,0}));
  connect(ThirdFloor.solRad[1], FirstFloor.solRad[1]) annotation (Line(points={{566.958,
          221},{506,221},{506,-60.1667},{570.417,-60.1667}},         color={0,0,
          127}));
  connect(oveSha219.y, room219.uSha[1]) annotation (Line(points={{268.5,-67},{272,
          -67},{272,-152},{188,-152},{188,-88.4},{196,-88.4}}, color={0,0,127}));
  connect(oveShaSecFloor.y, secFloor.uSha[1]) annotation (Line(points={{24.5,139},
          {48,139},{48,138},{76.4,138}}, color={0,0,127}));
  connect(oveShaSecFloor.u, shading_control[3].y) annotation (Line(points={{13,139},
          {6,139},{6,184},{-37,184}}, color={0,0,127}));
  connect(oveSha220.y, room220.uSha[1]) annotation (Line(points={{0.5,75},{48,75},
          {48,12},{-100,12},{-100,-34},{-83.6,-34}}, color={0,0,127}));
  connect(heaPorAirWes, room220.heaPorAir) annotation (Line(points={{-99,-45},{-86,
          -45},{-86,-52},{-63,-52}}, color={191,0,0}));
  connect(room220.heaPorRad, heaPorRadWes) annotation (Line(points={{-63,-55.8},
          {-92,-55.8},{-92,-59},{-101,-59}}, color={191,0,0}));
  connect(room219.heaPorRad, heaPorRadSou) annotation (Line(points={{221.75,-114.56},
          {184,-114.56},{184,-156},{284,-156},{284,-45},{271,-45}}, color={191,0,
          0}));
  connect(room219.heaPorAir, heaPorAirSou) annotation (Line(points={{221.75,-110},
          {221.75,-112},{180,-112},{180,-160},{288,-160},{288,-31},{271,-31}},
        color={191,0,0}));
  connect(ThirdFloor.TAir, reaTAir3rd.u) annotation (Line(points={{719.042,224},
          {710,224},{710,290},{456,290},{456,274},{162,274},{162,222},{319.2,
          222}},
        color={0,0,127}));
  connect(FirstFloor.TAir, reaTAir1st.u) annotation (Line(points={{749.583,
          -57.4444},{749.583,40},{254,40},{254,256},{323.2,256}},
                                                        color={0,0,127}));
  connect(heaPorAirNor, secFloor.heaPorAir)
    annotation (Line(points={{43,123},{97,123},{97,120}}, color={191,0,0}));
  connect(heaPorRadNor, secFloor.heaPorRad) annotation (Line(points={{43,107},{66,
          107},{66,116.2},{97,116.2}}, color={191,0,0}));
  connect(room219.heaPorAir, temAir219.port) annotation (Line(points={{221.75,-110},
          {221.75,-112},{180,-112},{180,-160},{288,-160},{288,304},{284,304},{284,
          350},{290,350}}, color={191,0,0}));
  connect(room220.heaPorAir, temAir220.port) annotation (Line(points={{-63,-52},
          {174,-52},{174,320},{292,320}}, color={191,0,0}));
  connect(secFloor.heaPorAir, temAir2nd.port) annotation (Line(points={{97,120},
          {97,310},{256,310},{256,288},{296,288}}, color={191,0,0}));
  connect(secFloor.ports[1], senRelPre.port_a) annotation (Line(points={{83,
          108.333},{78,108.333},{78,250},{60,250}},
                                           color={0,127,255}));
  connect(lea219.port_b, room219.ports[1]) annotation (Line(points={{-20,320},{-6,
          320},{-6,300},{156,300},{156,-123.8},{204.25,-123.8}}, color={0,127,255}));
  connect(ports219[2], room219.ports[2]) annotation (Line(points={{341,-74},{341,
          -162},{196,-162},{196,-122.6},{204.25,-122.6}}, color={0,127,255}));
  connect(lea220.port_b, room220.ports[1]) annotation (Line(points={{-20,280},{2,
          280},{2,268},{14,268},{14,-86},{-86,-86},{-86,-63.5},{-77,-63.5}},
        color={0,127,255}));
  connect(ports220[2], room220.ports[2]) annotation (Line(points={{-111,-78},{-111,
          -122},{-94,-122},{-94,-62.5},{-77,-62.5}}, color={0,127,255}));
  connect(ports2nd[2], secFloor.ports[2]) annotation (Line(points={{99,160},{50,
          160},{50,150},{64,150},{64,109},{83,109}}, color={0,127,255}));
  connect(ope220.port_b2, room220.ports[3]) annotation (Line(points={{-130,-26},
          {-134,-26},{-134,-52},{-77,-52},{-77,-61.5}}, color={0,127,255}));
  connect(ope220.port_a1, room220.ports[4]) annotation (Line(points={{-130,-14},
          {-138,-14},{-138,-10},{-142,-10},{-142,-60.5},{-77,-60.5}}, color={0,127,
          255}));
  connect(ope220.port_b1, secFloor.ports[3]) annotation (Line(points={{-110,-14},
          {-80,-14},{-80,-10},{-60,-10},{-60,109.667},{83,109.667}}, color={0,127,
          255}));
  connect(ope220.port_a2, secFloor.ports[4]) annotation (Line(points={{-110,-26},
          {-96,-26},{-96,-20},{-88,-20},{-88,92},{83,92},{83,110.333}}, color={0,
          127,255}));
  connect(ope219.port_b2, room219.ports[3]) annotation (Line(points={{320,-28},{
          310,-28},{310,-32},{304,-32},{304,-72},{164,-72},{164,-121.4},{204.25,
          -121.4}}, color={0,127,255}));
  connect(ope219.port_a1, room219.ports[4]) annotation (Line(points={{320,-16},{
          118,-16},{118,-120.2},{204.25,-120.2}}, color={0,127,255}));
  connect(ope219.port_b1, secFloor.ports[5]) annotation (Line(points={{340,-16},
          {354,-16},{354,30},{70,30},{70,111},{83,111}}, color={0,127,255}));
  connect(ope219.port_a2, secFloor.ports[6]) annotation (Line(points={{340,-28},
          {374,-28},{374,10},{58,10},{58,111.667},{83,111.667}}, color={0,127,255}));
  connect(heaPorRad1, ThirdFloor.intGainsRad) annotation (Line(points={{798,-74},
          {796,-74},{796,96},{756,96},{756,200},{716,200}}, color={191,0,0}));
  connect(heaPorAir1, ThirdFloor.intGainsConv) annotation (Line(points={{798,-92},
          {892,-92},{892,188},{716,188}}, color={191,0,0}));
  connect(multiplex5_2.y, TRooAir) annotation (Line(points={{401,300},{426,300},
          {426,280},{430,280},{430,190},{364,190},{364,160},{390,160}}, color={0,
          0,127}));
  connect(ThirdFloor.ports[1], ports3rd[1]) annotation (Line(points={{686.306,
          122.15},{686.306,60},{539.333,60},{539.333,128}},
                                                    color={0,127,255}));
  connect(ThirdFloor.ports[2], ports3rd[2]) annotation (Line(points={{690.944,
          122.15},{622,122.15},{622,76},{546,76},{546,128}},
                                                     color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true,
        extent={{-160,-260},{1000,500}},
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
          preserveAspectRatio=true, extent={{-160,-260},{1000,500}}),
                                                                   graphics={
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
