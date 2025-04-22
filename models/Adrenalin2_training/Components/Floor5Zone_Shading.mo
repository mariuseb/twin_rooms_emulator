within Adrenalin2_training.Components;
model Floor5Zone_Shading
  "Model of a floor of the building with automatic solar shading"
  extends Adrenalin2_training.Components.BaseClasses.PartialFloor(
  redeclare final package Medium = MediumA,
    final VRooCor=cor.AFlo * hRoo,
    final VRooSou=sou.AFlo * hRoo,
    final VRooNor=nor.AFlo * hRoo,
    final VRooEas=eas.AFlo * hRoo,
    final VRooWes=wes.AFlo * hRoo,
    AFloCor = 2698/hRoo,
    AFloSou = 568.77/hRoo,
    AFloNor = 568.77/hRoo,
    AFloEas = 360.0785/hRoo,
    AFloWes = 360.0785/hRoo,
    leaSou(amb(C=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
            /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC))),
    leaEas(amb(C=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
            /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC))),
    leaNor(amb(C=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
            /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC))),
    leaWes(amb(C=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM
            /Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC))));

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

  Buildings.ThermalZones.Detailed.MixedAir sou(
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
      til={Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall}),
    nSurBou=0,
    use_C_flow=true,
    C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
    nPorts=6,
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "South zone"
    annotation (Placement(transformation(extent={{144,-44},{184,-4}})));
  Buildings.ThermalZones.Detailed.MixedAir eas(
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=AFloEas,
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
      azi={Buildings.Types.Azimuth.E}),
    nConPar=2,
    datConPar(
      layers={conFlo,conFur},
      A={AFloEas,262.52},
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
      til={Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall}),
    use_C_flow=true,
    C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
    nPorts=6,
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "East zone"
    annotation (Placement(transformation(extent={{304,56},{344,96}})));
  Buildings.ThermalZones.Detailed.MixedAir nor(
    redeclare package Medium = Medium,
    lat=lat,
    AFlo=AFloNor,
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
      azi={Buildings.Types.Azimuth.N}),
    nConPar=2,
    datConPar(
      layers={conFlo,conFur},
      A={AFloNor,414.68},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall}),
    nConBou=3,
    datConBou(
      layers={conIntWal,conIntWal,conIntWal},
      A={6.47,40.76,6.47}*hRoo,
      til={Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall}),
    nSurBou=0,
    use_C_flow=true,
    C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
    nPorts=6,
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "North zone"
    annotation (Placement(transformation(extent={{144,116},{184,156}})));
  Buildings.ThermalZones.Detailed.MixedAir wes(
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
      til={Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall}),
    use_C_flow=true,
    C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
    nPorts=6,
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "West zone"
    annotation (Placement(transformation(extent={{12,36},{52,76}})));
  Buildings.ThermalZones.Detailed.MixedAir cor(
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
      til={Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall, Buildings.Types.Tilt.Wall}),
    use_C_flow=true,
    C_start=fill(400e-6*Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM/
        Modelica.Media.IdealGases.Common.SingleGasesData.Air.MM, Medium.nC),
    nPorts=12,
    intConMod=intConMod,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=sampleModel) "Core zone"
    annotation (Placement(transformation(extent={{144,36},{184,76}})));

  InternalGains.InternalGains                           gai(Area=1, redeclare
      Adrenalin2_training.Components.InternalGains.Data.SNTS3031_Office data(
        equSenPowNom=0.5, ligSenPowNom=0.5),
    combiTimeTable(
      tableOnFile=true,
      tableName="tab1",
      fileName=ModelicaServices.ExternalReferences.loadResource(
          "Resources/intGains.txt")))
    "Matrix gain to split up heat gain in radiant, convective and latent gain"
    annotation (Placement(transformation(extent={{-116,104},{-96,124}})));
  Modelica.Blocks.Math.Gain gaiIntNor[3](each k=kIntNor)
    "Gain for internal heat gain amplification for north zone"
    annotation (Placement(transformation(extent={{-60,134},{-40,154}})));
  Modelica.Blocks.Math.Gain gaiIntSou[3](each k=2 - kIntNor)
    "Gain to change the internal heat gain for south"
    annotation (Placement(transformation(extent={{-60,-38},{-40,-18}})));

    Modelica.Blocks.Sources.RealExpression CO2GenWes(y=gai.CO2*AFloWes)
               "CO2 generated by people in the west zone"
  annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Blocks.Sources.RealExpression CO2GenCor(y=gai.CO2*AFloCor)
               "CO2 generated by people in the corridor zone"
  annotation (Placement(transformation(extent={{82,56},{102,76}})));
  Modelica.Blocks.Sources.RealExpression CO2GenEas(y=gai.CO2*AFloEas)
               "CO2 generated by people in the east zone"
  annotation (Placement(transformation(extent={{254,64},{274,84}})));
  Modelica.Blocks.Sources.RealExpression CO2GenNor(y=gai.CO2*AFloNor)
               "CO2 generated by people in the north zone"
  annotation (Placement(transformation(extent={{80,142},{100,162}})));
  Modelica.Blocks.Sources.RealExpression CO2GenSou(y=gai.CO2*AFloSou)
               "CO2 generated by people in the south zone"
  annotation (Placement(transformation(extent={{84,-20},{104,0}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAirWes
    "Heat port to air volume" annotation (Placement(transformation(extent={{-34,
            26},{-24,36}}), iconTransformation(extent={{-34,26},{-24,36}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRadWes
    "Heat port for radiative heat gain and radiative temperature" annotation (
      Placement(transformation(extent={{-34,12},{-24,22}}), iconTransformation(
          extent={{-34,12},{-24,22}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAirSou
    "Heat port to air volume" annotation (Placement(transformation(extent={{128,
            -22},{138,-12}}), iconTransformation(extent={{128,-22},{138,-12}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRadSou
    "Heat port for radiative heat gain and radiative temperature" annotation (
      Placement(transformation(extent={{128,-38},{138,-28}}),
        iconTransformation(extent={{128,-38},{138,-28}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAirCor
    "Heat port to air volume" annotation (Placement(transformation(extent={{128,
            50},{138,60}}), iconTransformation(extent={{128,50},{138,60}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRadCor
    "Heat port for radiative heat gain and radiative temperature" annotation (
      Placement(transformation(extent={{128,34},{138,44}}), iconTransformation(
          extent={{128,34},{138,44}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAirNor
    "Heat port to air volume" annotation (Placement(transformation(extent={{128,
            124},{138,134}}), iconTransformation(extent={{128,124},{138,134}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRadNor
    "Heat port for radiative heat gain and radiative temperature" annotation (
      Placement(transformation(extent={{128,108},{138,118}}),
        iconTransformation(extent={{128,108},{138,118}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorAir1
    "Heat port to air volume" annotation (Placement(transformation(extent={{322,
            26},{332,36}}), iconTransformation(extent={{322,26},{332,36}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heaPorRad1
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
  BaseClasses.shading              shading_control[4](
    each threshold=150,
    each til=Buildings.Types.Tilt.Wall,
    each lat=lat,
    azi={Buildings.Types.Azimuth.S,Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.N,
        Buildings.Types.Azimuth.W})
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

  Buildings.Utilities.IO.SignalExchange.Overwrite oveShaEas(description="Overwrite shading position for east facade",
      u(unit="1",
      min=0,
      max=1))
    annotation (Placement(transformation(extent={{272,90},{282,100}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveShaSou(description=
        "Overwrite shading position for south facade", u(
      unit="1",
      min=0,
      max=1)) annotation (Placement(transformation(extent={{126,-10},{136,0}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveShaNor(description=
        "Overwrite shading position for north facade", u(
      unit="1",
      min=0,
      max=1))
    annotation (Placement(transformation(extent={{126,150},{136,160}})));
  Buildings.Utilities.IO.SignalExchange.Overwrite oveShaWes(description=
        "Overwrite shading position for west facade", u(
      unit="1",
      min=0,
      max=1)) annotation (Placement(transformation(extent={{-10,70},{0,80}})));
  Buildings.Utilities.IO.SignalExchange.Read reaAuxPow(
    description="Aux power consumption",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W", displayUnit="W"))
    annotation (Placement(transformation(extent={{-142,80},{-160,98}})));

  Modelica.Blocks.Math.Gain gaiArea(k=AFloSou + AFloEas + AFloNor + AFloWes +
        AFloCor)
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
equation
  connect(sou.surf_conBou[1], wes.surf_surBou[2]) annotation (Line(
      points={{170,-40.3333},{170,-54},{62,-54},{62,20},{28.2,20},{28.2,42.25}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sou.surf_conBou[2], cor.surf_surBou[1]) annotation (Line(
      points={{170,-40},{170,-54},{200,-54},{200,20},{160.2,20},{160.2,41.625}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sou.surf_conBou[3], eas.surf_surBou[1]) annotation (Line(
      points={{170,-39.6667},{170,-54},{320.2,-54},{320.2,61.75}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(eas.surf_conBou[1], cor.surf_surBou[2]) annotation (Line(
      points={{330,60},{330,20},{160.2,20},{160.2,41.875}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(eas.surf_surBou[2], nor.surf_conBou[1]) annotation (Line(
      points={{320.2,62.25},{320.2,24},{220,24},{220,100},{170,100},{170,
          119.667}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(nor.surf_conBou[2], cor.surf_surBou[3]) annotation (Line(
      points={{170,120},{170,100},{200,100},{200,26},{160.2,26},{160.2,42.125}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(nor.surf_conBou[3], wes.surf_surBou[1]) annotation (Line(
      points={{170,120.333},{170,100},{60,100},{60,20},{28.2,20},{28.2,41.75}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(wes.surf_conBou[1], cor.surf_surBou[4]) annotation (Line(
      points={{38,40},{38,30},{160.2,30},{160.2,42.375}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sou.weaBus, weaBus) annotation (Line(
      points={{181.9,-6.1},{181.9,8},{210,8},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(eas.weaBus, weaBus) annotation (Line(
      points={{341.9,93.9},{341.9,120},{210,120},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(nor.weaBus, weaBus) annotation (Line(
      points={{181.9,153.9},{182,160},{182,168},{210,168},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(wes.weaBus, weaBus) annotation (Line(
      points={{49.9,73.9},{49.9,168},{210,168},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(cor.weaBus, weaBus) annotation (Line(
      points={{181.9,73.9},{181.9,90},{210,90},{210,200}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  connect(multiplex5_1.y, TRooAir) annotation (Line(
      points={{371,290},{372,290},{372,160},{390,160}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(sou.heaPorAir, temAirSou.port) annotation (Line(
      points={{163,-24},{224,-24},{224,100},{264,100},{264,350},{290,350}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(eas.heaPorAir, temAirEas.port) annotation (Line(
      points={{323,76},{286,76},{286,320},{292,320}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(nor.heaPorAir, temAirNor.port) annotation (Line(
      points={{163,136},{164,136},{164,290},{292,290}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(wes.heaPorAir, temAirWes.port) annotation (Line(
      points={{31,56},{70,56},{70,114},{186,114},{186,258},{292,258}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(cor.heaPorAir, temAirCor.port) annotation (Line(
      points={{163,56},{162,56},{162,228},{294,228}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(sou.ports[1], portsSou[1]) annotation (Line(
      points={{149,-35.6667},{114,-35.6667},{114,-36},{85,-36}},
      color={0,127,255},
      thickness=0.5));
  connect(sou.ports[2], portsSou[2]) annotation (Line(
      points={{149,-35},{124,-35},{124,-36},{95,-36}},
      color={0,127,255},
      thickness=0.5));
  connect(eas.ports[1], portsEas[1]) annotation (Line(
      points={{309,64.3333},{300,64.3333},{300,36},{325,36}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(eas.ports[2], portsEas[2]) annotation (Line(
      points={{309,65},{298,65},{298,34},{320,34},{320,36},{335,36}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(nor.ports[1], portsNor[1]) annotation (Line(
      points={{149,124.333},{114,124.333},{114,124},{85,124}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(nor.ports[2], portsNor[2]) annotation (Line(
      points={{149,125},{124,125},{124,124},{95,124}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(wes.ports[1], portsWes[1]) annotation (Line(
      points={{17,44.3333},{-12,44.3333},{-12,44},{-35,44}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(wes.ports[2], portsWes[2]) annotation (Line(
      points={{17,45},{-2,45},{-2,44},{-25,44}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(cor.ports[1], portsCor[1]) annotation (Line(
      points={{149,44.1667},{114,44.1667},{114,46},{85,46}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(cor.ports[2], portsCor[2]) annotation (Line(
      points={{149,44.5},{124,44.5},{124,46},{95,46}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(leaSou.port_b, sou.ports[3]) annotation (Line(
      points={{-22,400},{-2,400},{-2,-72},{134,-72},{134,-34.3333},{149,
          -34.3333}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(leaEas.port_b, eas.ports[3]) annotation (Line(
      points={{-22,360},{50,360},{50,65.6667},{309,65.6667}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(leaNor.port_b, nor.ports[3]) annotation (Line(
      points={{-20,320},{138,320},{138,125.667},{149,125.667}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(leaWes.port_b, wes.ports[3]) annotation (Line(
      points={{-20,280},{4,280},{4,45.6667},{17,45.6667}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(opeSouCor.port_b1, cor.ports[3]) annotation (Line(
      points={{104,16},{116,16},{116,44.8333},{149,44.8333}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(opeSouCor.port_a2, cor.ports[4]) annotation (Line(
      points={{104,4},{118,4},{118,45.1667},{149,45.1667}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(opeSouCor.port_a1, sou.ports[4]) annotation (Line(
      points={{84,16},{74,16},{74,-20},{134,-20},{134,-33.6667},{149,-33.6667}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(opeSouCor.port_b2, sou.ports[5]) annotation (Line(
      points={{84,4},{72,4},{72,-22},{132,-22},{132,-33},{149,-33}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(opeEasCor.port_b1, eas.ports[4]) annotation (Line(
      points={{270,54},{290,54},{290,66.3333},{309,66.3333}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(opeEasCor.port_a2, eas.ports[5]) annotation (Line(
      points={{270,42},{292,42},{292,67},{309,67}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(opeEasCor.port_a1, cor.ports[5]) annotation (Line(
      points={{250,54},{190,54},{190,34},{142,34},{142,45.5},{149,45.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(opeEasCor.port_b2, cor.ports[6]) annotation (Line(
      points={{250,42},{190,42},{190,34},{142,34},{142,45.8333},{149,45.8333}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(opeNorCor.port_b1, nor.ports[4]) annotation (Line(
      points={{100,90},{124,90},{124,126.333},{149,126.333}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(opeNorCor.port_a2, nor.ports[5]) annotation (Line(
      points={{100,78},{126,78},{126,127},{149,127}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(opeNorCor.port_a1, cor.ports[7]) annotation (Line(
      points={{80,90},{76,90},{76,60},{142,60},{142,46.1667},{149,46.1667}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(opeNorCor.port_b2, cor.ports[8]) annotation (Line(
      points={{80,78},{76,78},{76,60},{142,60},{142,46.5},{149,46.5}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(opeWesCor.port_b1, cor.ports[9]) annotation (Line(
      points={{40,-4},{54,-4},{54,36},{112,36},{112,46.8333},{149,46.8333}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(opeWesCor.port_a2, cor.ports[10]) annotation (Line(
      points={{40,-16},{56,-16},{56,34},{114,34},{114,47.1667},{149,47.1667}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(opeWesCor.port_a1, wes.ports[4]) annotation (Line(
      points={{20,-4},{6,-4},{6,46.3333},{17,46.3333}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(opeWesCor.port_b2, wes.ports[5]) annotation (Line(
      points={{20,-16},{2,-16},{2,47},{17,47}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(cor.ports[11], senRelPre.port_a) annotation (Line(
      points={{149,47.5},{112,47.5},{112,250},{60,250}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(senRelPre.p_rel, p_rel) annotation (Line(
      points={{50,241},{50,220},{-170,220}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(gaiIntNor.y, nor.qGai_flow) annotation (Line(
      points={{-39,144},{142.4,144}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gaiIntSou.y, sou.qGai_flow) annotation (Line(
      points={{-39,-28},{68,-28},{68,-16},{142.4,-16}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(CO2GenNor.y, nor.C_flow[1]) annotation (Line(points={{101,152},{122,152},
          {122,138.8},{142.4,138.8}}, color={0,0,127}));
  connect(CO2GenWes.y, wes.C_flow[1]) annotation (Line(points={{-89,60},{-40,60},
          {-40,58.8},{10.4,58.8}}, color={0,0,127}));
  connect(CO2GenCor.y, cor.C_flow[1]) annotation (Line(points={{103,66},{124,66},
          {124,58.8},{142.4,58.8}}, color={0,0,127}));
  connect(CO2GenEas.y, eas.C_flow[1]) annotation (Line(points={{275,74},{288,74},
          {288,78.8},{302.4,78.8}}, color={0,0,127}));
  connect(wes.heaPorAir, heaPorAirWes) annotation (Line(points={{31,56},{30,56},
          {30,31},{-29,31}}, color={191,0,0}));
  connect(wes.heaPorRad, heaPorRadWes) annotation (Line(points={{31,52.2},{30,52.2},
          {30,17},{-29,17}}, color={191,0,0}));
  connect(sou.heaPorAir, heaPorAirSou) annotation (Line(points={{163,-24},{192,-24},
          {192,-17},{133,-17}}, color={191,0,0}));
  connect(sou.heaPorRad, heaPorRadSou) annotation (Line(points={{163,-27.8},{162,
          -27.8},{162,-48},{126,-48},{126,-33},{133,-33}}, color={191,0,0}));
  connect(cor.heaPorAir, heaPorAirCor) annotation (Line(points={{163,56},{134,56},
          {134,55},{133,55}}, color={191,0,0}));
  connect(cor.heaPorRad, heaPorRadCor) annotation (Line(points={{163,52.2},{133,
          52.2},{133,39}}, color={191,0,0}));
  connect(nor.heaPorAir, heaPorAirNor) annotation (Line(points={{163,136},{134,136},
          {134,129},{133,129}}, color={191,0,0}));
  connect(nor.heaPorRad, heaPorRadNor) annotation (Line(points={{163,132.2},{134.5,
          132.2},{134.5,113},{133,113}}, color={191,0,0}));
  connect(eas.heaPorAir, heaPorAir1) annotation (Line(points={{323,76},{330,76},
          {330,31},{327,31}}, color={191,0,0}));
  connect(eas.heaPorRad, heaPorRad1) annotation (Line(points={{323,72.2},{323,43.1},
          {327,43.1},{327,17}}, color={191,0,0}));
  connect(CO2GenSou.y, sou.C_flow[1]) annotation (Line(points={{105,-10},{142.4,
          -10},{142.4,-21.2}}, color={0,0,127}));
  connect(senCO2Sou.port, sou.ports[6]) annotation (Line(points={{304,192},{216,
          192},{216,-44},{128,-44},{128,-32.3333},{149,-32.3333}}, color={0,127,
          255}));
  connect(senCO2Eas.port, eas.ports[6]) annotation (Line(points={{304,168},{290,
          168},{290,67.6667},{309,67.6667}}, color={0,127,255}));
  connect(senCO2Nor.port, nor.ports[6]) annotation (Line(points={{304,144},{304,
          138},{192,138},{192,112},{140,112},{140,127.667},{149,127.667}},
        color={0,127,255}));
  connect(senCO2Wes.port, wes.ports[6]) annotation (Line(points={{304,120},{8,
          120},{8,47.6667},{17,47.6667}}, color={0,127,255}));
  connect(senCO2Cor.port, cor.ports[12]) annotation (Line(points={{304,100},{
          288,100},{288,28},{228,28},{228,40},{188,40},{188,32},{140,32},{140,
          47.8333},{149,47.8333}}, color={0,127,255}));
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
  connect(weaBus, shading_control[4].weaBus) annotation (Line(
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
  connect(oveShaEas.y, eas.uSha[1]) annotation (Line(points={{282.5,95},{292.45,
          95},{292.45,94},{302.4,94}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(shading_control[2].y, oveShaEas.u) annotation (Line(points={{-37,184},
          {266,184},{266,95},{271,95}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(oveShaSou.y, sou.uSha[1]) annotation (Line(
      points={{136.5,-5},{139.45,-5},{139.45,-6},{142.4,-6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(shading_control[1].y, oveShaSou.u) annotation (Line(
      points={{-37,184},{116,184},{116,-5},{125,-5}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(shading_control[3].y, oveShaNor.u) annotation (Line(
      points={{-37,184},{116,184},{116,156},{125,156},{125,155}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(shading_control[4].y, oveShaWes.u) annotation (Line(
      points={{-37,184},{-16,184},{-16,76},{-11,76},{-11,75}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(oveShaNor.y, nor.uSha[1]) annotation (Line(
      points={{136.5,155},{139.45,155},{139.45,154},{142.4,154}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(oveShaWes.y, wes.uSha[1]) annotation (Line(
      points={{0.5,75},{5.45,75},{5.45,74},{10.4,74}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gai.intGai, gaiIntNor.u) annotation (Line(points={{-95,114},{-72,114},
          {-72,144},{-62,144}}, color={0,0,127}));
  connect(gai.intGai, gaiIntSou.u) annotation (Line(points={{-95,114},{-80,114},
          {-80,76},{-116,76},{-116,-28},{-62,-28}}, color={0,0,127}));
  connect(gai.intGai, wes.qGai_flow) annotation (Line(points={{-95,114},{-80,114},
          {-80,64},{10.4,64}}, color={0,0,127}));
  connect(gai.intGai, cor.qGai_flow) annotation (Line(points={{-95,114},{-80,114},
          {-80,64},{4,64},{4,32},{120,32},{120,68},{132,68},{132,76},{142.4,76},
          {142.4,64}}, color={0,0,127}));
  connect(gai.intGai, eas.qGai_flow) annotation (Line(points={{-95,114},{-80,114},
          {-80,64},{4,64},{4,32},{120,32},{120,68},{132,68},{132,104},{268,104},
          {268,108},{284,108},{284,84},{302.4,84}}, color={0,0,127}));
  connect(gai.elCon, gaiArea.u) annotation (Line(points={{-95,106},{-92,106},{
          -92,89},{-108,90}}, color={0,0,127}));
  connect(gaiArea.y, reaAuxPow.u) annotation (Line(points={{-131,90},{-135.6,90},
          {-135.6,89},{-140.2,89}}, color={0,0,127}));
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
