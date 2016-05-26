+================================================
+                                                
+    Vectric machine output configuration file   
+                                                
+================================================
+                                                
+ History                                        
+                                                  
+ Who      When       What                         
+ ======== ========== ===========================
+ Tony     14/07/2006 Written
+ David    09/20/2010 Adapted for PartWorks     
+ Kenny    12/26/2011 Hurco Toolchange
+ Kenny    01/02/2012 Trunion Clearance Sequence  
+ Will	   01/14/2015 Oxford Laser Re-Write               
+================================================
+
+ Notes
+	PostProcessor Guide: http://forum.vectric.com/download/file.php?id=13820
+
+ 	- Spindle speed --> laser power
+ 	- Ignoring Z-moves for safety (may be added later if it is found useful)
+ 	- [34] is used as double-quote
+ 	- Oxford interprets ; as comment

POST_NAME = "ShopBot Oxford Laser (mm) (*.pgm)"

FILE_EXTENSION = "pgm"

UNITS = "MM"

+------------------------------------------------
+    Line terminating characters                 
+------------------------------------------------

LINE_ENDING = "[13][10]"

+------------------------------------------------
+    Block numbering                             
+------------------------------------------------

LINE_NUMBER_START     = 0
LINE_NUMBER_INCREMENT = 10
LINE_NUMBER_MAXIMUM = 999999

+================================================
+                                                
+    Formating for variables                     
+ 		- changed S to s in spindle_speed  
+ 		- changed F,X,Y to always (A) instead of "when changed" (C)   
+ 		- added multiplier to feedrate to change it from mm/min to mm/s
+ 		- Z is used to control the BEAMOFF. 
+			Zx.xxx --> BEAMOFF ;x.xxx                                    
+================================================

VAR LINE_NUMBER = [N|A|N|1.0]
VAR SPINDLE_SPEED = [S|A||1.0]
VAR FEED_RATE = [F|A||1.1|0.0166]
VAR X_POSITION = [X|A|X|1.4]
VAR Y_POSITION = [Y|A|Y|1.4]
VAR Z_POSITION = [Z|C|BEAMOFF ;|0]
VAR ARC_CENTRE_I_INC_POSITION = [I|A|I|1.4]
VAR ARC_CENTRE_J_INC_POSITION = [J|A|J|1.4]
VAR X_HOME_POSITION = [XH|A|X|1.4]
VAR Y_HOME_POSITION = [YH|A|Y|1.4]
VAR Z_HOME_POSITION = [ZH|A|Z|1.4]

+================================================
+                                                
+    Block definitions for toolpath output       
+                                                
+================================================

+---------------------------------------------------
+  Commands output at the start of the file
+---------------------------------------------------

begin HEADER

"; partworks output"
"DVAR $POWER"
"DVAR $FEED"
"DVAR $IL_PASSES"
"DVAR $OL_PASSES"
" "
"$POWER=[S]"
"$FEED=[F]"
"$IL_PASSES=10"
"$OL_PASSES=1"
"G90"
"G71"
"G92 X0 Y0"
"G108"
"BEAMOFF"
"FARCALL [34]ATTENUATOR.PGM[34] [S]"
"MSGCLEAR -1"
"MSGDISPLAY 1, [34]Program Started[34]"
"RPT $OL_PASSES"


+---------------------------------------------------
+  Commands output for rapid moves 
+ 	- commented out (J3) 
+		(wanted to remove (J3) but it seems essential for partworks 3.5 to recognize the post)
+---------------------------------------------------

begin RAPID_MOVE

"G1 [X] [Y] F10 ;(J3)"


+---------------------------------------------------
+  Commands output for the first feed rate move
+---------------------------------------------------

begin FIRST_FEED_MOVE

"G1 [X] [Y] [F]"


+---------------------------------------------------
+  Commands output for feed rate moves
+	- Z is used for BEAMOFF when going over tabs
+---------------------------------------------------

begin FEED_MOVE

"G1 [X] [Y] [F]"
"[Z]"


+---------------------------------------------------
+  Commands output for the first clockwise arc move
+---------------------------------------------------

begin FIRST_CW_ARC_MOVE

"G2 [X] [Y] [I] [J] [F]"


+---------------------------------------------------
+  Commands output for clockwise arc move
+---------------------------------------------------

begin CW_ARC_MOVE

"G2 [X] [Y] [I] [J]"


+---------------------------------------------------
+  Commands output for the first counterclockwise arc move
+---------------------------------------------------

begin FIRST_CCW_ARC_MOVE

"G3 [X] [Y] [I] [J] [F]"


+---------------------------------------------------
+  Commands output for counterclockwise arc move
+---------------------------------------------------

begin CCW_ARC_MOVE

"G3 [X] [Y] [I] [J]"


+---------------------------------------------------
+ Commands output for the First Plunge Move
+	- turns the beam on when the endmill would first plunge into the material
+---------------------------------------------------
begin FIRST_PLUNGE_MOVE

"BEAMON"
"RPT $IL_PASSES"

+---------------------------------------------------
+ Commands output for Retract Moves
+	- turns beam off when the endmill would retract
+---------------------------------------------------
begin RETRACT_MOVE

"ENDRPT"
"BEAMOFF"


+---------------------------------------------------
+  Commands output at the end of the file
+---------------------------------------------------
begin FOOTER

"ENDRPT"
"BEAMOFF"
"G1 X0 Y0 F10"
"MSGDISPLAY 1, [34]Program Finished[34]"
"G91"
"M2"

