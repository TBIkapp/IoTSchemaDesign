#!/bin/bash
mkdir -p logs/

# 1 min test
echo "++++ 1min test run ++++"

echo "++ MMAPV1 Test ++"
mkdir -p data/mmapv1
./mongod --storageEngine mmapv1 --dbpath data/mmapv1 --fork --logpath logs/mmapv1.log
./mongo IoTTest IoTGenerator.js
killall mongod
rm -r data/*

echo "++ WiredTiger Test ++"
mkdir -p data/wt
./mongod --dbpath data/wt --fork --logpath logs/wt.log
./mongo IoTTest IoTGenerator.js
killall mongod
rm -r data/*

echo "++ inMemory Test ++"
mkdir -p data/inMemory
./mongod --storageEngine inMemory --dbpath data/inMemory --fork --logpath logs/inMemory.log
./mongo IoTTest IoTGenerator.js
killall mongod
rm -r data/*

# 10 min test
echo "++++ 10min test run ++++"

echo "++ MMAPV1 Test ++"
mkdir -p data/mmapv1
./mongod --storageEngine mmapv1 --dbpath data/mmapv1 --fork --logpath logs/mmapv1.log
./mongo IoTTest IoTGenerator10min.js
killall mongod
rm -r data/*

echo "++ WiredTiger Test ++"
mkdir -p data/wt
./mongod --dbpath data/wt --fork --logpath logs/wt.log
./mongo IoTTest IoTGenerator10min.js
killall mongod
rm -r data/*

echo "++ inMemory Test ++"
mkdir -p data/inMemory
./mongod --storageEngine inMemory --dbpath data/inMemory --fork --logpath logs/inMemory.log
./mongo IoTTest IoTGenerator10min.js
killall mongod
rm -r data/*

# 1 hour test
echo "++++ 1hour test run ++++"

echo "++ MMAPV1 Test ++"
mkdir -p data/mmapv1
./mongod --storageEngine mmapv1 --dbpath data/mmapv1 --fork --logpath logs/mmapv1.log
./mongo IoTTest IoTGenerator1hour.js
killall mongod
rm -r data/*

echo "++ WiredTiger Test ++"
mkdir -p data/wt
./mongod --dbpath data/wt --fork --logpath logs/wt.log
./mongo IoTTest IoTGenerator1hour.js
killall mongod
rm -r data/*

echo "++ inMemory Test ++"
mkdir -p data/inMemory
./mongod --storageEngine inMemory --dbpath data/inMemory --fork --logpath logs/inMemory.log
./mongo IoTTest IoTGenerator1hour.js
killall mongod
rm -r data/*

