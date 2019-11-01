using PowerSystems
using TimeSeries
using Dates


dates  = collect(DateTime("1/1/2024  0:00:00", "d/m/y  H:M:S"):Hour(1):DateTime("1/1/2024  23:00:00", "d/m/y  H:M:S"))

nodes14= [
                Bus(1 , "Bus 1"  , "REF" ,0.0, 1.06  , (min=0.94, max=1.06), 69),
                Bus(2 , "Bus 2"  , "PV" , -0.08691739674931762,  1.045 , (min=0.94, max=1.06), 69),
                Bus(3 , "Bus 3"  , "PV" , -0.22200588085367873,  1.01  , (min=0.94, max=1.06), 69),
                Bus(4 , "Bus 4"  , "PQ" , -0.18029251173101424,  1.019 , (min=0.94, max=1.06), 69),
                Bus(5 , "Bus 5"  , "PQ" , -0.15323990832510212,  1.02  , (min=0.94, max=1.06), 69),
                Bus(6 , "Bus 6"  , "PV" , -0.24818581963359368,  1.07  , (min=0.94, max=1.06), 13.8),
                Bus(7 , "Bus 7"  , "PQ" , -0.23335052099164186,  1.062 , (min=0.94, max=1.06), 13.8),
                Bus(8 , "Bus 8"  , "PV" , -0.2331759880664424,  1.09  , (min=0.94, max=1.06), 18),
                Bus(9 , "Bus 9"  , "PQ" , -0.2607521902479528,  1.056 , (min=0.94, max=1.06), 13.8),
                Bus(10, "Bus 10" , "PQ" , -0.26354471705114374,  1.051 , (min=0.94, max=1.06), 13.8),
                Bus(11, "Bus 11" , "PQ" , -0.2581341963699613,  1.057 , (min=0.94, max=1.06), 13.8),
                Bus(12, "Bus 12" , "PQ" , -0.2630211182755455,  1.055 , (min=0.94, max=1.06), 13.8),
                Bus(13, "Bus 13" , "PQ" , -0.2645919146023404,  1.05  , (min=0.94, max=1.06), 13.8),
                Bus(14, "Bus 14" , "PQ" , -0.27995081201989047,  1.036 , (min=0.94, max=1.06), 13.8)
            ]
branches14_dc = [
                Line("Line1",  true, 0.0, 0.0, Arc(from=nodes14[1],to=nodes14[2]), 0.01938, 0.05917, (from=0.0264, to=0.0264), 18.046, 1.04),
                Line("Line2",  true, 0.0, 0.0, Arc(from=nodes14[1],to=nodes14[5]),   0.05403, 0.22304, (from=0.0246, to=0.0246), 4.896, 1.04),
                HVDCLine("DCLine3", true, 0.0, Arc(from=nodes14[2],to=nodes14[3]), (min = -600.0, max = 600), (min = -600.0, max = 600), (min = -600.0, max = 600), (min = -600.0, max = 600), (l0 = 0.01, l1 = 0.001)),
                HVDCLine("DCLine4", true, 0.0, Arc(from=nodes14[2],to=nodes14[4]), (min = -600.0, max = 600), (min = -600.0, max = 600), (min = -600.0, max = 600), (min = -600.0, max = 600), (l0 = 0.01, l1 = 0.001)),
                #Line("Line3",  true, 0.0, 0.0, Arc(from=nodes14[2],to=nodes14[3]),   0.04699, 0.19797, (from=0.0219, to=0.0219), 5.522, 1.04),
                #Line("Line4",  true, 0.0, 0.0, Arc(from=nodes14[2],to=nodes14[4]),   0.05811, 0.17632, (from=0.017,  to=0.017), 6.052, 1.04),
                Line("Line5",  true, 0.0, 0.0, Arc(from=nodes14[2],to=nodes14[5]),   0.05695, 0.17388, (from=0.0173, to=0.0173), 6.140, 1.04),
                Line("Line6",  true, 0.0, 0.0, Arc(from=nodes14[3],to=nodes14[4]),   0.06701, 0.17103, (from=0.0064, to=0.0064), 6.116, 1.04),
                Line("Line7",  true, 0.0, 0.0, Arc(from=nodes14[4],to=nodes14[5]),   0.01335, 0.04211, (from=0.0, to=0.0), 25.434, 1.04),
                TapTransformer("Trans3", true, 0.0, 0.0, Arc(from=nodes14[4],to=nodes14[7]),  0.0    , 0.20912,  0.0, 0.978,  20.0),
                TapTransformer("Trans1", true, 0.0, 0.0, Arc(from=nodes14[4],to=nodes14[9]),  0.0    , 0.55618,  0.0, 0.969,  20.0),
                TapTransformer("Trans2", true, 0.0, 0.0, Arc(from=nodes14[5],to=nodes14[6]),  0.0    , 0.25202,  0.0, 0.932,  20.0),
                Line("Line8",  true, 0.0, 0.0, Arc(from=nodes14[6],to=nodes14[11]),  0.09498, 0.19890, (from=0.0, to=0.0), 5.373, 1.04),
                Line("Line9",  true, 0.0, 0.0, Arc(from=nodes14[6],to=nodes14[12]),  0.12291, 0.25581, (from=0.0, to=0.0), 2.020, 1.04),
                Line("Line10", true, 0.0, 0.0, Arc(from=nodes14[6],to=nodes14[13]),  0.06615, 0.13027, (from=0.0, to=0.0), 4.458, 1.04),
                Transformer2W("Trans4", true, 0.0, 0.0, Arc(from=nodes14[7],to=nodes14[8]),  0.0      , 0.17615,  0.0,    20.0),
                Line("Line16", true, 0.0, 0.0, Arc(from=nodes14[7],to=nodes14[9]),   0.0,     0.11001, (from=0.0, to=0.0), 12.444, 1.04),
                Line("Line11", true, 0.0, 0.0, Arc(from=nodes14[9],to=nodes14[10]),  0.03181, 0.08450, (from=0.0, to=0.0), 5.097, 1.04),
                Line("Line12", true, 0.0, 0.0, Arc(from=nodes14[9],to=nodes14[14]),  0.12711, 0.27038, (from=0.0, to=0.0), 3.959, 1.04),
                Line("Line13", true, 0.0, 0.0, Arc(from=nodes14[10],to=nodes14[11]), 0.08205, 0.19207, (from=0.0, to=0.0), 7.690, 1.04),
                Line("Line14", true, 0.0, 0.0, Arc(from=nodes14[12],to=nodes14[13]), 0.22092, 0.19988, (from=0.0, to=0.0), 6.378, 1.04),
                Line("Line15", true, 0.0, 0.0, Arc(from=nodes14[13],to=nodes14[14]), 0.17093, 0.34802, (from=0.0, to=0.0), 10.213, 1.04)
            ]

branches14 = [
                Line("Line1",  true, 0.0, 0.0, Arc(from=nodes14[1],to=nodes14[2]),   0.01938, 0.05917, (from=0.0264, to=0.0264), 18.046, 1.04),
                Line("Line2",  true, 0.0, 0.0, Arc(from=nodes14[1],to=nodes14[5]),   0.05403, 0.22304, (from=0.0246, to=0.0246), 4.896, 1.04),
                Line("Line3",  true, 0.0, 0.0, Arc(from=nodes14[2],to=nodes14[3]),   0.04699, 0.19797, (from=0.0219, to=0.0219), 5.522, 1.04),
                Line("Line4",  true, 0.0, 0.0, Arc(from=nodes14[2],to=nodes14[4]),   0.05811, 0.17632, (from=0.017,  to=0.017), 6.052, 1.04),
                Line("Line5",  true, 0.0, 0.0, Arc(from=nodes14[2],to=nodes14[5]),   0.05695, 0.17388, (from=0.0173, to=0.0173), 6.140, 1.04),
                Line("Line6",  true, 0.0, 0.0, Arc(from=nodes14[3],to=nodes14[4]),   0.06701, 0.17103, (from=0.0064, to=0.0064), 6.116, 1.04),
                Line("Line7",  true, 0.0, 0.0, Arc(from=nodes14[4],to=nodes14[5]),   0.01335, 0.04211, (from=0.0, to=0.0), 25.434, 1.04),
                TapTransformer("Trans3", true, 0.0, 0.0, Arc(from=nodes14[4],to=nodes14[7]),  0.0    , 0.20912,  0.0, 0.978,  20.0),
                TapTransformer("Trans1", true, 0.0, 0.0, Arc(from=nodes14[4],to=nodes14[9]),  0.0    , 0.55618,  0.0, 0.969,  20.0),
                TapTransformer("Trans2", true, 0.0, 0.0, Arc(from=nodes14[5],to=nodes14[6]),  0.0    , 0.25202,  0.0, 0.932,  20.0),
                Line("Line8",  true, 0.0, 0.0, Arc(from=nodes14[6],to=nodes14[11]),  0.09498, 0.19890, (from=0.0, to=0.0), 5.373, 1.04),
                Line("Line9",  true, 0.0, 0.0, Arc(from=nodes14[6],to=nodes14[12]),  0.12291, 0.25581, (from=0.0, to=0.0), 2.020, 1.04),
                Line("Line10", true, 0.0, 0.0, Arc(from=nodes14[6],to=nodes14[13]),  0.06615, 0.13027, (from=0.0, to=0.0), 4.458, 1.04),
                Transformer2W("Trans4", true, 0.0, 0.0, Arc(from=nodes14[7],to=nodes14[8]),  0.0      , 0.17615,  0.0,    20.0),
                Line("Line16", true, 0.0, 0.0, Arc(from=nodes14[7],to=nodes14[9]),   0.0,     0.11001, (from=0.0, to=0.0), 12.444, 1.04),
                Line("Line11", true, 0.0, 0.0, Arc(from=nodes14[9],to=nodes14[10]),  0.03181, 0.08450, (from=0.0, to=0.0), 5.097, 1.04),
                Line("Line12", true, 0.0, 0.0, Arc(from=nodes14[9],to=nodes14[14]),  0.12711, 0.27038, (from=0.0, to=0.0), 3.959, 1.04),
                Line("Line13", true, 0.0, 0.0, Arc(from=nodes14[10],to=nodes14[11]), 0.08205, 0.19207, (from=0.0, to=0.0), 7.690, 1.04),
                Line("Line14", true, 0.0, 0.0, Arc(from=nodes14[12],to=nodes14[13]), 0.22092, 0.19988, (from=0.0, to=0.0), 6.378, 1.04),
                Line("Line15", true, 0.0, 0.0, Arc(from=nodes14[13],to=nodes14[14]), 0.17093, 0.34802, (from=0.0, to=0.0), 10.213, 1.04)
            ]

thermal_generators14 = [ThermalStandard("Bus1", true, nodes14[1], 2.0, -0.169,
                    TechThermal(2.324, PowerSystems.ST, PowerSystems.COAL, (min=0.0, max=3.332), (min=0.0, max=0.1), nothing, nothing),
                    ThreePartCost((430.292599, 2000.0), 0.0, 0.0, 0.0)
                    ),
                    ThermalStandard("Bus2", true, nodes14[2], 0.40, 0.42,
                    TechThermal(1.4, PowerSystems.ST, PowerSystems.COAL, (min=0.0, max=1.40), (min=-0.4, max=0.5), nothing, nothing),
                    ThreePartCost((2500.0, 2000.0), 0.0, 0.0, 0.0)
                    ),
                    ThermalStandard("Bus3", true, nodes14[3], 0.0, 0.23,
                    TechThermal(1.0, PowerSystems.ST, PowerSystems.COAL, (min=0.0, max=1.0), (min=0.0, max=0.4), nothing, nothing),
                    ThreePartCost((100.0, 4000.0), 0.0, 0.0, 0.0)
                    ),
                    ThermalStandard("Bus6", true, nodes14[6], 0.0, 0.12,
                    TechThermal(1.0, PowerSystems.ST, PowerSystems.COAL, (min=0.0, max=1.0), (min=-0.06, max=0.24), nothing, nothing),
                    ThreePartCost((100.0, 4000.0), 0.0, 0.0, 0.0)
                    ),
                    ThermalStandard("Bus8", true, nodes14[8], 0.0, 0.174,
                    TechThermal(1.0, PowerSystems.ST, PowerSystems.COAL, (min=0.0, max=1.0), (min=-0.06, max=0.24), nothing, nothing),
                    ThreePartCost((100.0, 4000.0), 0.0, 0.0, 0.0)
                    )
            ];


loadz1_ts = [ 0.792729978
            0.723201574
            0.710952098
            0.677672816
            0.668249175
            0.67166919
            0.687608809
            0.711821241
            0.756320618
            0.7984057
            0.827836527
            0.840362459
            0.84511032
            0.834592803
            0.822949221
            0.816941743
            0.824079963
            0.905735139
            0.989967048
            1
            0.991227765
            0.960842114
            0.921465115
            0.837001437 ]

loadz2_ts = [ 0.831093782
              0.689863228
              0.666058513
              0.627033103
              0.624901388
              0.62858924
              0.650734211
              0.683424321
              0.750876413
              0.828347191
              0.884248576
              0.888523615
              0.87752169
              0.847534405
              0.8227661
              0.803809323
              0.813282799
              0.907575962
              0.98679848
              1
              0.990489904
              0.952520972
              0.906611479
              0.824307054]

loadz3_ts = [ 0.871297342
              0.670489749
              0.642812243
              0.630092987
              0.652991383
              0.671971681
              0.716278493
              0.770885833
              0.810075243
              0.85562361
              0.892440566
              0.910660449
              0.922135467
              0.898416969
              0.879816542
              0.896390855
              0.978598576
              0.96523761
              1
              0.969626503
              0.901212601
              0.81894251
              0.771004923
              0.717847996]

loads14 = [PowerLoad("Bus2", true, nodes14[2], PowerSystems.ConstantPower, 0.217, 0.127, 0.217, 0.127),
          PowerLoad("Bus3", true, nodes14[3], PowerSystems.ConstantPower, 0.942, 0.19, 0.942, 0.19),
          PowerLoad("Bus4", true, nodes14[4], PowerSystems.ConstantPower, 0.478, -0.039, 0.478, -0.039),
          PowerLoad("Bus5", true, nodes14[5], PowerSystems.ConstantPower, 0.076, 0.016, 0.076, 0.016),
          PowerLoad("Bus6", true, nodes14[6], PowerSystems.ConstantPower, 0.112, 0.075, 0.112, 0.075),
          PowerLoad("Bus9", true, nodes14[9], PowerSystems.ConstantPower, 0.295, 0.166, 0.295, 0.166),
          PowerLoad("Bus10", true, nodes14[10], PowerSystems.ConstantPower, 0.09, 0.058, 0.09, 0.058),
          PowerLoad("Bus11", true, nodes14[11], PowerSystems.ConstantPower, 0.035, 0.018, 0.035, 0.018),
          PowerLoad("Bus12", true, nodes14[12], PowerSystems.ConstantPower, 0.061, 0.016, 0.061, 0.016),
          PowerLoad("Bus13", true, nodes14[13], PowerSystems.ConstantPower, 0.135, 0.058, 0.135, 0.058),
          PowerLoad("Bus14", true, nodes14[14], PowerSystems.ConstantPower, 0.149, 0.050, 0.149, 0.050)]

forecast_DA14 = [Deterministic("scalingfactor", TimeArray(dates, loadz1_ts)),
                 Deterministic("scalingfactor", TimeArray(dates, loadz1_ts)),
                 Deterministic("scalingfactor", TimeArray(dates, loadz3_ts)),
                 Deterministic("scalingfactor", TimeArray(dates, loadz1_ts)),
                 Deterministic("scalingfactor", TimeArray(dates, loadz2_ts)),
                 Deterministic("scalingfactor", TimeArray(dates, loadz3_ts)),
                 Deterministic("scalingfactor", TimeArray(dates, loadz2_ts)),
                 Deterministic("scalingfactor", TimeArray(dates, loadz2_ts)),
                 Deterministic("scalingfactor", TimeArray(dates, loadz2_ts)),
                 Deterministic("scalingfactor", TimeArray(dates, loadz2_ts)),
                 Deterministic("scalingfactor", TimeArray(dates, loadz2_ts))
];

forecasts14 = Dict{Symbol,Vector{<:Forecast}}(:DA=>forecast_DA14);

battery14 = [GenericBattery(name = "Bat",
primemover = PowerSystems.BA,
available = true,
bus = nodes14[1],
energy = 5.0,
capacity = (min = 5.0, max = 100.0),
rating = 70,
activepower = 10.0,
inputactivepowerlimits = (min = 0.0, max = 50.0),
outputactivepowerlimits = (min = 0.0, max = 50.0),
reactivepower = 0.0,
reactivepowerlimits = (min = -50.0, max = 50.0),
efficiency = (in = 0.80, out = 0.90)
)]
