@echo off

set build_type=%1
set backend=%2

cd saucer
mkdir build 
cd build
cmake .. -Dsaucer_bindings=ON -Dsaucer_backend=%backend%
cmake --build . --config %build_type%