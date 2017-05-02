/**
Author : Tim Biedenkapp @ MongoDB
run the test
**/

// init variables
var bucket = 0;

// prepare DB environment
db.IoTSimpletestCollection.drop();
db.IoTBucketCollection.drop();

// create index
db.IoTSimpletestCollection.createIndex({sensor_id : 1});
db.IoTSimpletestCollection.createIndex({date : 1});
db.IoTBucketCollection.createIndex({ bucket_id : 1 });
db.IoTBucketCollection.createIndex({ startDate : 1, endDate : 1 });

// insert new simple schema record
function mySimpleDocumentLoop (sensor_id) {          
	var date = new Date();
	var ts = date.getDate() +'-'+date.getMonth()+'-'+date.getFullYear()+ ' ' + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
	db.IoTSimpletestCollection.insert({
		'sensor_id' : sensor_id,
		'date' : ts, 
		'temperature' : Math.floor((Math.random() * 100) + 1),
		'humidity' : Math.floor((Math.random() * 100) + 1) 
	});
}

// insert new bucket schema record
function myBucketDocumentLoop (sensor_id, bucketsize) { 
	var date = new Date();
	var ts = date.getDate() +'-'+date.getMonth()+'-'+date.getFullYear()+ ' ' + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();

	var tx = {
		'sensor_id' : sensor_id,
		'date' : ts, 
		'temperature' : Math.floor((Math.random() * 100) + 1),
		'humidity' : Math.floor((Math.random() * 100) + 1) 
	}

	var result = db.IoTBucketCollection.findAndModify({
		query : {'bucket_id': bucket},	   
		sort : {_id: -1},			   
		remove : false,			   
		update : {				  
		  $push: {measurements: tx}, 
		  $inc: {txCount:1},
		  $set: {endDate: tx.date}
		},
		new : true, 	 		  
		fields : {txCount:1}, 		              	
 		upsert : false
	})

	if(result == null || result.txCount >= bucketsize){
		bucket = bucket +1;
		db.IoTBucketCollection.insert({'bucket_id': bucket, startDate : ts});
	}
}

var runtime = 60000 * 10;
var scale = 1024 * 1024;
/*
Simple Schema Test
*/
print("simple schema start test");
db.IoTSimpletestCollection.remove({});
var simplecnt = 0;
// run simple schema test for 1min
var ms = new Date().getTime() + runtime;
while (new Date() < ms){
		mySimpleDocumentLoop(Math.floor((Math.random() * 100) + 1));
		simplecnt++;
}
print("simple schema count: " + simplecnt);
printjson(db.stats(scale));

print("================");

/*
Bucket Schema Test
*/
print("25 bucket schema start test");
db.IoTBucketCollection.remove({});
var bckcnt = 0;
// run bucket test for 1 min
var ms = new Date().getTime() + runtime;
while (new Date() < ms){
		myBucketDocumentLoop(Math.floor((Math.random() * 100) + 1), 25);
		bckcnt++;
}
print("25 bucket inserts: " + bckcnt);
printjson(db.stats(scale));

print("================");

print("50 bucket schema start test");
db.IoTBucketCollection.remove({});
var bckcnt = 0;
// run bucket test for 1 min
var ms = new Date().getTime() + runtime;
while (new Date() < ms){
		myBucketDocumentLoop(Math.floor((Math.random() * 100) + 1), 50);
		bckcnt++;
}
print("50 bucket inserts: " + bckcnt);
printjson(db.stats(scale));

print("================");

print("100 bucket schema start test");
db.IoTBucketCollection.remove({});
var bckcnt = 0;
// run bucket test for 1 min
var ms = new Date().getTime() + runtime;
while (new Date() < ms){
		myBucketDocumentLoop(Math.floor((Math.random() * 100) + 1), 100);
		bckcnt++;
}
print("100 bucket inserts: " + bckcnt);
printjson(db.stats(scale));

print("================");

print("200 bucket schema start test");
db.IoTBucketCollection.remove({});
bckcnt = 0;
var ms = new Date().getTime() + runtime;
while (new Date() < ms){
		myBucketDocumentLoop(Math.floor((Math.random() * 100) + 1), 200);
		bckcnt++;
}
print("200 bucket inserts: " + bckcnt);
printjson(db.stats(scale));


print("================");


print("300 bucket schema start test");
db.IoTBucketCollection.remove({});
bckcnt = 0;
var ms = new Date().getTime() + runtime;
while (new Date() < ms){
		myBucketDocumentLoop(Math.floor((Math.random() * 100) + 1), 300);
		bckcnt++;
}
print("300 bucket inserts: " + bckcnt);
printjson(db.stats(scale));

print("================");