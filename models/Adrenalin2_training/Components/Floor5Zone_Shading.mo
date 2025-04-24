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
    final VRooEas=ThirdFloor.AFlo*hRoo,
    final VRooWes=FirstFloor.AFlo*hRoo,
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
    use_C_flow=false,
    C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel,
    nPorts=6) "Room 2.19"
    annotation (Placement(transformation(extent={{134,-178},{248,-86}})));

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
    use_C_flow=false,
    C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel,
    nPorts=6)                      "Room 2.20"
    annotation (Placement(transformation(extent={{-64,-260},{52,-160}})));
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
    use_C_flow=false,
    C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel,
    nPorts=6)                      "Rest of 2nd floor"
    annotation (Placement(transformation(extent={{104,230},{202,324}})));

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
  Modelica.Blocks.Interfaces.RealOutput CO2Roo[5]
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
  Buildings.Utilities.IO.SignalExchange.Overwrite oveShaSecFloor(description="Overwrite shading position for second floor",
      u(
      unit="1",
      min=0,
      max=1)) annotation (Placement(transformation(extent={{14,134},{24,144}})));
  Buildings.ThermalZones.Detailed.MixedAir ThirdFloor(
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
    use_C_flow=false,
    C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel,
    nPorts=3) "Room 2.19"
    annotation (Placement(transformation(extent={{604,58},{726,160}})));

  Buildings.ThermalZones.Detailed.MixedAir FirstFloor(
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
    use_C_flow=false,
    C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel,
    nPorts=3) "Room 2.19"
    annotation (Placement(transformation(extent={{564,-206},{690,-108}})));

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAirThirdFloor
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{294,246},{314,266}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temAirFirstFloor
    "Air temperature sensor"
    annotation (Placement(transformation(extent={{290,216},{310,236}})));
  InternalGains.InternalGains gai
    annotation (Placement(transformation(extent={{-414,-30},{-300,58}})));
  Buildings.Fluid.Sensors.PPM senCO2FirstFloor(redeclare package Medium =
        Medium, warnAboutOnePortConnection=false)
    annotation (Placement(transformation(extent={{292,108},{312,128}})));
  Buildings.Utilities.IO.SignalExchange.Read reaCO2FirstFloor(
    description="Temperature of north zone",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    zone="4",
    y(unit="ppm"))
    annotation (Placement(transformation(extent={{322,114},{330,122}})));

  Buildings.Fluid.Sensors.PPM senCO2ThirdFloor(redeclare package Medium =
        Medium, warnAboutOnePortConnection=false)
    annotation (Placement(transformation(extent={{294,72},{314,92}})));
  Buildings.Utilities.IO.SignalExchange.Read reaCO2ThirdFloor(
    description="Temperature of north zone",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.CO2Concentration,
    zone="5",
    y(unit="ppm"))
    annotation (Placement(transformation(extent={{324,78},{332,86}})));

  Modelica.Blocks.Routing.Multiplex5 multiplex5_1
    annotation (Placement(transformation(extent={{356,118},{376,138}})));
equation
  connect(room219.weaBus, weaBus) annotation (Line(
      points={{242.015,-90.83},{242.015,144},{210,144},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(room220.weaBus, weaBus) annotation (Line(
      points={{45.91,-165.25},{45.91,-32},{240,-32},{240,144},{210,144},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(secFloor.weaBus, weaBus) annotation (Line(
      points={{196.855,319.065},{196.855,336},{232,336},{232,200},{210,200}},
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
  connect(oveSha219.y, room219.uSha[1]) annotation (Line(points={{268.5,-67},{268.5,
          -48},{184,-48},{184,-64},{112,-64},{112,-90.6},{129.44,-90.6}},
                                                               color={0,0,127}));
  connect(oveShaSecFloor.y, secFloor.uSha[1]) annotation (Line(points={{24.5,139},
          {32,139},{32,319.3},{100.08,319.3}},
                                         color={0,0,127}));
  connect(oveShaSecFloor.u, shading_control[3].y) annotation (Line(points={{13,139},
          {6,139},{6,184},{-37,184}}, color={0,0,127}));
  connect(oveSha220.y, room220.uSha[1]) annotation (Line(points={{0.5,75},{0.5,56},
          {-56,56},{-56,-48},{-96,-48},{-96,-96},{-104,-96},{-104,-165},{-68.64,
          -165}},                                    color={0,0,127}));
  connect(heaPorAirWes, room220.heaPorAir) annotation (Line(points={{-99,-45},{-96,
          -45},{-96,-288},{-8.9,-288},{-8.9,-210}},
                                     color={191,0,0}));
  connect(room220.heaPorRad, heaPorRadWes) annotation (Line(points={{-8.9,-219.5},
          {-8.9,-59},{-101,-59}},            color={191,0,0}));
  connect(room219.heaPorRad, heaPorRadSou) annotation (Line(points={{188.15,-140.74},
          {192,-140.74},{192,-200},{272,-200},{272,-88},{304,-88},{304,-45},{271,
          -45}},                                                    color={191,0,
          0}));
  connect(room219.heaPorAir, heaPorAirSou) annotation (Line(points={{188.15,-132},
          {188.15,-208},{280,-208},{280,-96},{376,-96},{376,-48},{320,-48},{320,
          -31},{271,-31}},
        color={191,0,0}));
  connect(heaPorAirNor, secFloor.heaPorAir)
    annotation (Line(points={{43,123},{44,123},{44,216},{150.55,216},{150.55,277}},
                                                          color={191,0,0}));
  connect(heaPorRadNor, secFloor.heaPorRad) annotation (Line(points={{43,107},{44,
          107},{44,124},{56,124},{56,212},{150.55,212},{150.55,268.07}},
                                       color={191,0,0}));
  connect(lea219.port_b, room219.ports[1]) annotation (Line(points={{-20,320},{
          -8,320},{-8,360},{-200,360},{-200,-158.833},{148.25,-158.833}},
                                                                 color={0,127,255}));
  connect(ope219.port_a1, room219.ports[2]) annotation (Line(points={{320,-16},{
          304,-16},{304,16},{384,16},{384,-144},{392,-144},{392,-224},{112,-224},
          {112,-157.3},{148.25,-157.3}},          color={0,127,255}));
  connect(multiplex5_2.y, TRooAir) annotation (Line(points={{401,300},{426,300},
          {426,280},{430,280},{430,190},{364,190},{364,160},{390,160}}, color={0,
          0,127}));
  connect(ports3rd[1], ThirdFloor.ports[1]) annotation (Line(points={{541,128},{
          540,128},{540,80.1},{619.25,80.1}},
                                          color={0,127,255}));
  connect(ThirdFloor.ports[2], ports3rd[2]) annotation (Line(points={{619.25,83.5},
          {551,83.5},{551,128}},color={0,127,255}));
  connect(heaPorRad1, FirstFloor.heaPorRad) annotation (Line(points={{798,-74},{
          820,-74},{820,-220},{623.85,-220},{623.85,-166.31}},          color={191,
          0,0}));
  connect(heaPorAir1, heaPorAir1)
    annotation (Line(points={{798,-92},{798,-92}}, color={191,0,0}));
  connect(heaPorAir1, FirstFloor.heaPorAir) annotation (Line(points={{798,-92},{
          623.85,-92},{623.85,-157}},                       color={191,0,0}));
  connect(ope219.port_b2, room219.ports[3]) annotation (Line(points={{320,-28},
          {300,-28},{300,-200},{132,-200},{132,-155.767},{148.25,-155.767}},
                                                                    color={0,127,
          255}));

  connect(secFloor.ports[1], senRelPre.port_a) annotation (Line(points={{116.25,
          249.583},{112,250},{60,250}},                          color={0,127,255}));
  connect(ope220.port_b1, secFloor.ports[2]) annotation (Line(points={{-110,-14},
          {72,-14},{72,140},{128,140},{128,220},{92,220},{92,251.15},{116.25,251.15}},
                                                                      color={0,127,
          255}));
  connect(ope220.port_a2, secFloor.ports[3]) annotation (Line(points={{-110,-26},
          {-104,-26},{-104,-16},{72,-16},{72,140},{128,140},{128,220},{92,220},
          {92,252.717},{116.25,252.717}},                           color={0,127,
          255}));
  connect(ope219.port_b1, secFloor.ports[4]) annotation (Line(points={{340,-16},
          {348,-16},{348,56},{264,56},{264,136},{252,136},{252,172},{128,172},{
          128,220},{92,220},{92,254.283},{116.25,254.283}},
                                        color={0,127,255}));
  connect(ope219.port_a2, secFloor.ports[5]) annotation (Line(points={{340,-28},
          {348,-28},{348,56},{264,56},{264,136},{252,136},{252,172},{128,172},{128,
          220},{92,220},{92,255.85},{116.25,255.85}},
        color={0,127,255}));
  connect(FirstFloor.ports[1], ports1st[1]) annotation (Line(points={{579.75,
          -184.767},{579.75,-180},{528,-180},{528,-48},{519,-48},{519,-46}},
                                                                   color={0,127,
          255}));
  connect(FirstFloor.ports[2], ports1st[2]) annotation (Line(points={{579.75,-181.5},
          {579.75,-184},{529,-184},{529,-46}}, color={0,127,255}));
  connect(ports219[1], room219.ports[4]) annotation (Line(points={{331,-74},{
          331,-258},{148.25,-258},{148.25,-154.233}},
                                                  color={0,127,255}));
  connect(ports219[2], room219.ports[5]) annotation (Line(points={{341,-74},{341,
          -280},{86,-280},{86,-152.7},{148.25,-152.7}}, color={0,127,255}));
  connect(senCO2SecFloor.port, secFloor.ports[6]) annotation (Line(points={{304,144},
          {304,136},{252,136},{252,172},{128,172},{128,220},{92,220},{92,
          257.417},{116.25,257.417}},                      color={0,127,255}));
  connect(senCO2Roo219.port, room219.ports[6]) annotation (Line(points={{304,192},
          {284,192},{284,194},{248,194},{248,-190},{148.25,-190},{148.25,
          -151.167}},
        color={0,127,255}));
  connect(weaBus, ThirdFloor.weaBus) annotation (Line(
      points={{210,200},{212,200},{212,144},{244,144},{244,32},{744,32},{744,172},
          {719.595,172},{719.595,154.645}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus, FirstFloor.weaBus) annotation (Line(
      points={{210,200},{212,200},{212,144},{240,144},{240,32},{683.385,32},{683.385,
          -113.145}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(temAirThirdFloor.T, reaTAir1st.u) annotation (Line(points={{314,256},{
          318,256},{318,258},{323.2,258},{323.2,256}}, color={0,0,127}));
  connect(temAirFirstFloor.T, reaTAir3rd.u) annotation (Line(points={{310,226},{
          312,226},{312,224},{319.2,224},{319.2,222}}, color={0,0,127}));
  connect(FirstFloor.uSha[1], shading_control[1].y) annotation (Line(points={{558.96,
          -112.9},{460,-112.9},{460,-42},{-18,-42},{-18,184},{-37,184}}, color={
          0,0,127}));
  connect(ThirdFloor.uSha[1], shading_control[1].y) annotation (Line(points={{599.12,
          154.9},{476,154.9},{476,48},{28,48},{28,186},{-37,186},{-37,184}},
        color={0,0,127}));
  connect(gai.intGai, room220.qGai_flow) annotation (Line(points={{-294.3,14},{-238,
          14},{-238,-190},{-68.64,-190}}, color={0,0,127}));
  connect(gai.intGai, room219.qGai_flow) annotation (Line(points={{-294.3,14},{-294.3,
          -304},{74,-304},{74,-113.6},{129.44,-113.6}}, color={0,0,127}));
  connect(gai.intGai, FirstFloor.qGai_flow) annotation (Line(points={{-294.3,14},
          {-294.3,-284},{464,-284},{464,-137.4},{558.96,-137.4}}, color={0,0,127}));
  connect(gai.intGai, ThirdFloor.qGai_flow) annotation (Line(points={{-294.3,14},
          {-294.3,-2},{494,-2},{494,129.4},{599.12,129.4}}, color={0,0,127}));
  connect(gai.intGai, secFloor.qGai_flow) annotation (Line(points={{-294.3,14},{
          -294.3,295.8},{100.08,295.8}}, color={0,0,127}));
  connect(senCO2FirstFloor.ppm, reaCO2FirstFloor.u)
    annotation (Line(points={{313,118},{321.2,118}}, color={0,0,127}));
  connect(senCO2ThirdFloor.ppm, reaCO2ThirdFloor.u)
    annotation (Line(points={{315,82},{323.2,82}}, color={0,0,127}));
  connect(ThirdFloor.ports[3], senCO2ThirdFloor.port) annotation (Line(points={{
          619.25,86.9},{326,86.9},{326,72},{304,72}}, color={0,127,255}));
  connect(FirstFloor.ports[3], senCO2FirstFloor.port) annotation (Line(points={{579.75,
          -178.233},{474,-178.233},{474,-10},{274,-10},{274,108},{302,108}},
        color={0,127,255}));
  connect(reaCO2Sou.y, multiplex5_1.u1[1]) annotation (Line(points={{330.4,202},
          {336,202},{336,196},{344,196},{344,138},{354,138}}, color={0,0,127}));
  connect(reaCO2Eas.y, multiplex5_1.u2[1]) annotation (Line(points={{330.4,178},
          {334,178},{334,174},{338,174},{338,133},{354,133}}, color={0,0,127}));
  connect(reaCO2Nor.y, multiplex5_1.u3[1]) annotation (Line(points={{330.4,154},
          {330.4,128},{354,128}}, color={0,0,127}));
  connect(reaCO2FirstFloor.y, multiplex5_1.u4[1]) annotation (Line(points={{330.4,
          118},{336,118},{336,123},{354,123}}, color={0,0,127}));
  connect(reaCO2ThirdFloor.y, multiplex5_1.u5[1]) annotation (Line(points={{332.4,
          82},{336,82},{336,118},{354,118}}, color={0,0,127}));
  connect(multiplex5_1.y, CO2Roo) annotation (Line(points={{377,128},{386,128},{
          386,124},{406,124},{406,108},{350,108},{350,80},{390,80}}, color={0,0,
          127}));
  connect(ports220[1], room220.ports[1]) annotation (Line(points={{-121,-78},{
          -121,-239.167},{-49.5,-239.167}},
                         color={0,127,255}));
  connect(room220.ports[2], ports220[2]) annotation (Line(points={{-49.5,-237.5},
          {-111,-237.5},{-111,-78}}, color={0,127,255}));
  connect(room220.ports[3], ope220.port_b2) annotation (Line(points={{-49.5,
          -235.833},{-174,-235.833},{-174,-26},{-130,-26}}, color={0,127,255}));
  connect(room220.ports[4], ope220.port_a1) annotation (Line(points={{-49.5,
          -234.167},{-184,-234.167},{-184,-14},{-130,-14}}, color={0,127,255}));
  connect(room220.ports[5], senCO2Roo220.port) annotation (Line(points={{-49.5,
          -232.5},{-138,-232.5},{-138,168},{304,168}}, color={0,127,255}));
  connect(lea220.port_b, room220.ports[6]) annotation (Line(points={{-20,280},{
          -6,280},{-6,78},{-86,78},{-86,-230.833},{-49.5,-230.833}}, color={0,
          127,255}));
  connect(room219.heaPorAir, temAir219.port) annotation (Line(points={{188.15,
          -132},{166,-132},{166,350},{290,350}}, color={191,0,0}));
  connect(room220.heaPorAir, temAir220.port) annotation (Line(points={{-8.9,
          -210},{-8.9,350},{246,350},{246,320},{292,320}}, color={191,0,0}));
  connect(secFloor.heaPorAir, temAir2nd.port) annotation (Line(points={{150.55,
          277},{260,277},{260,288},{296,288}}, color={191,0,0}));
  connect(FirstFloor.heaPorAir, temAirThirdFloor.port) annotation (Line(points=
          {{623.85,-157},{623.85,6},{216,6},{216,256},{294,256}}, color={191,0,
          0}));
  connect(ThirdFloor.heaPorAir, temAirFirstFloor.port) annotation (Line(points=
          {{661.95,109},{252,109},{252,226},{290,226}}, color={191,0,0}));
end Floor5Zone_Shading;
