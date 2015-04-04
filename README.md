# Oxford Laser Post Processors

Post processors for the Oxford laser

Instructions:
+ Copy Shopbot_oxford_laser.pp into C:\ProgramData\Vectric\PartWorks\V3.5\PostP
+ Import oxfor_laser.tool for default tool settings

Implementation:
+ Spindle speed is mapped to laser power, 0-100 rpm = 0-100% power
+ Z-moves are used to turn the beamoff to enable the use of tabs (the laser will never move in the Z with this code)
+ X,Y feedrate is the same (in mm/s)

Notes:
+ PostProcessor Editing Guide: http://forum.vectric.com/download/file.php?id=13820
