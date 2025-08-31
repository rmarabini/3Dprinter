; Bed leveling Ender 3 by ingenioso3D
; Modified by elproducts CHEP FilamentFriday.com

G90
; heat bed and struder
M140 S90 ; set bed temp
M104 S220; set extruder temperature
M190 S90 ; wait for bed temperature
M109 S220 ; wait for extruderr temperature
M220 S100 ; set speed to 100%
G28 ; Home all axis
G0 Z5 ; Lift Z axis
G0 X32 Y36 ; Move to Position 1
G0 Z0
M0 ; Pause print
G0 Z10 ; Lift Z axis
G0 X32 Y206 ; Move to Position 2
G0 Z0
M0 ; Pause print
G0 Z5 ; Lift Z axis
G0 X202 Y206 ; Move to Position 3
G0 Z0
M0 ; Pause print
G0 Z5 ; Lift Z axis
G0 X202 Y36 ; Move to Position 4
G0 Z0
M0 ; Pause print
G0 Z5 ; Lift Z axis
G0 X117 Y121 ; Move to Position 5
G0 Z0
M0 ; Pause print
; second pass
G0 Z5 ; Lift Z axis
G0 X32 Y206 ; Move to Position 2
G0 Z0
M0 ; Pause print
G0 Z5 ; Lift Z axis
G0 X202 Y206 ; Move to Position 3
G0 Z0
M0 ; Pause print
G0 Z5 ; Lift Z axis
G0 X202 Y36 ; Move to Position 4
G0 Z0
M0 ; Pause print
G0 Z5 ; Lift Z axis
G0 X32 Y36 ; Move to Position 1
G0 Z0
M0 ; Pause print
; third pass
G0 Z5 ; Lift Z axis
G0 X32 Y206 ; Move to Position 2
G0 Z0
M0 ; Pause print
G0 Z5 ; Lift Z axis
G0 X202 Y206 ; Move to Position 3
G0 Z0
M0 ; Pause print
G0 Z5 ; Lift Z axis
G0 X202 Y36 ; Move to Position 4
G0 Z0
M0 ; Pause print
G0 Z5 ; Lift Z axis
G0 X32 Y36 ; Move to Position 1
G0 Z0
M0 ; Pause print

G28;
M84 ; disable motors



