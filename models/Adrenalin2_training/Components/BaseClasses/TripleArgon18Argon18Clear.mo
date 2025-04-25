within Adrenalin2_training.Components.BaseClasses;
record TripleArgon18Argon18Clear =
    Buildings.HeatTransfer.Data.GlazingSystems.Generic (
    final glass={Glass4mm(), Glass4mm(),Glass4mm()},
    final gas={Buildings.HeatTransfer.Data.Gases.Argon(
                         x=0.018),Buildings.HeatTransfer.Data.Gases.Argon(
                                             x=0.018)},
    UFra=0.8)
  "Triple pane, clear glass 4mm, argon 18, clear glass 4mm, argon 18, clear glass 4mm"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datGlaSys");
