# create main board
openscad -o chess.stl chess.scad
# divide in 4 blocks
./chess_2_2.sh
# further divide in 16 blocks
./chess_4_4.sh
