#!/bin/bash
mkdir -p logs/

# 1 min test
echo "++++ 1min test run ++++"

echo "++ MMAPV1 Test ++"
mkdir -p data/mmapv1_1min
./mongod --storageEngine mmapv1 --dbpath data/mmapv1_1min --fork --logpath logs/mmapv1.log
./mongo IoTTest IoTGenerator.js
./mongo IoTTest --eval "db.stats()"
killall mongod
rm -r data/*

echo "++ WiredTiger Test ++"
mkdir -p data/wt_1min
./mongod --dbpath data/wt_1min --fork --logpath logs/wt.log
./mongo IoTTest IoTGenerator.js
./mongo IoTTest --eval "db.stats()"
killall mongod
rm -r data/*

echo "++ inMemory Test ++"
mkdir -p data/inMemory_1min
./mongod --storageEngine inMemory --dbpath data/inMemory_1min --fork --logpath logs/inMemory.log
./mongo IoTTest IoTGenerator.js
./mongo IoTTest --eval "db.stats()"
killall mongod
rm -r data/*

# 10 min test
echo "++++ 10min test run ++++"

echo "++ MMAPV1 Test ++"
mkdir -p data/mmapv1_10min
./mongod --storageEngine mmapv1 --dbpath data/mmapv1_10min --fork --logpath logs/mmapv1.log
./mongo IoTTest IoTGenerator10min.js
./mongo IoTTest --eval "db.stats()"
killall mongod
rm -r data/*

echo "++ WiredTiger Test ++"
mkdir -p data/wt_10min
./mongod --dbpath data/wt_10min --fork --logpath logs/wt.log
./mongo IoTTest IoTGenerator10min.js
./mongo IoTTest --eval "db.stats()"
killall mongod
rm -r data/*

echo "++ inMemory Test ++"
mkdir -p data/inMemory_10min
./mongod --storageEngine inMemory --dbpath data/inMemory_10min --fork --logpath logs/inMemory.log
./mongo IoTTest IoTGenerator10min.js
./mongo IoTTest --eval "db.stats()"
killall mongod
rm -r data/*

# 1 hour test
echo "++++ 1hour test run ++++"

echo "++ MMAPV1 Test ++"
mkdir -p data/mmapv1_1hr
./mongod --storageEngine mmapv1 --dbpath data/mmapv1_1hr --fork --logpath logs/mmapv1.log
./mongo IoTTest IoTGenerator1hour.js
./mongo IoTTest --eval "db.stats()"
killall mongod
rm -r data/*

echo "++ WiredTiger Test ++"
mkdir -p data/wt_1hr
./mongod --dbpath data/wt_1hr --fork --logpath logs/wt.log
./mongo IoTTest IoTGenerator1hour.js
./mongo IoTTest --eval "db.stats()"
killall mongod
rm -r data/*

echo "++ inMemory Test ++"
mkdir -p data/inMemory_1hr
./mongod --storageEngine inMemory --dbpath data/inMemory_1hr --fork --logpath logs/inMemory.log
./mongo IoTTest IoTGenerator1hour.js
./mongo IoTTest --eval "db.stats()"
killall mongod
rm -r data/*

