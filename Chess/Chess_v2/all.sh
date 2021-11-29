# create main board
../Software/OpenSCAD-2021.01-x86_64.AppImage -o chess.stl chess.scad
# divide in 4 blocks
./chess_2_2.sh
# further divide in 16 blocks
./chess_4_4.sh
