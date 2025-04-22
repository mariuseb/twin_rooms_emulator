within Adrenalin2_training.Components.InternalGains.Tester;
model InternalGains
  Adrenalin2_training.Components.InternalGains.InternalGains internalGains(
      redeclare
      Adrenalin2_training.Components.InternalGains.Data.SNTS3031_Office data,
      combiTimeTable(
      tableOnFile=true,
      tableName="tab1",
      fileName=
          "C:/Users/hwaln/Documents/Adrenalin/Emulators/Adrenalin2_training/models/Resources/intGains.txt"))
    annotation (Placement(transformation(extent={{-94,-2},{-74,18}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=1209600,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end InternalGains;
