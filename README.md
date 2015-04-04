# Oxford Laser Post Processors

Post processors for the Oxford laser

Copy Shopbot_oxford_laser.pp into C:\ProgramData\Vectric\PartWorks\V3.5\PostP

Implementation:
+ Spindle speed is mapped to laser power
+ Z-moves are used to turn the beamoff (to enable the use of tabs)
+ Feedrates are in mm/s (rather than mm/min)

Notes:
+ PostProcessor Editing Guide: http://forum.vectric.com/download/file.php?id=13820
