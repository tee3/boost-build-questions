export BOOST_BUILD_PATH=~/opt/local/src/boost/boost_1_51_0/tools/build/v2
export PATH=~/opt/local/src/boost/boost_1_51_0/tools/build/v2/engine/bin.macosxx86_64:$PATH

if [ -d bin ]; then
    read -p "Press <Enter> to remove build directory"
    rm -rf bin
fi
b2 t0
read -p "Press <Enter> to remove build directory"
rm -rf bin
b2 t1
read -p "Press <Enter> to remove build directory"
rm -rf bin
b2 t2
echo "Running again, should rebuild since header always changes"
b2 t2
read -p "Press <Enter> to remove build directory"
rm -rf bin
b2 t3
echo "Running again, should not rebuild since header is changed only if missing"
b2 t3
read -p "Press <Enter> to remove build directory"
rm -rf bin
