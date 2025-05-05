within Adrenalin2_training.Components.BaseClasses;
record Glass4mm =
               Buildings.HeatTransfer.Data.Glasses.Generic (
    x=0.004,
    k=1.0,
    tauSol={0.74},
    rhoSol_a={0.18},
    rhoSol_b={0.18},
    tauIR=0,
    absIR_a=0.16,
    absIR_b=0.16) "Low emissivity 4mm. Manufacturer: Generic."
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datGla");
