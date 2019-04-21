var https = require('https');


/**
 * HOW TO Make an HTTP Call - POST
 */
// do a POST request
// create the JSON object
jsonObject = JSON.stringify({
    "nick": "uurtucrume9768",
    "password": "yunus123"
});

// prepare the header
var postheaders = {
    'Content-Type' : 'application/json',
    'Content-Length' : Buffer.byteLength(jsonObject, 'utf8')
};

https://dev.gittigidiyor.com:8443/listingapi/rlws/anonymous/developer?method=registerDeveloper&outputCT=json&inputCT=json&lang=tr

// the post options
var optionspost = {
    host : 'dev.gittigidiyor.com',
    port : 8443,
    path : '/listingapi/rlws/anonymous/developer?method=registerDeveloper&outputCT=json&inputCT=json&lang=tr',
    method : 'POST',
    headers : postheaders
};

console.info('Options prepared:');
console.info(optionspost);
console.info('Do the POST call');

// do the POST call
var reqPost = https.request(optionspost, function(res) {
    console.log("statusCode: ", res.statusCode);
    // uncomment it for header details
//  console.log("headers: ", res.headers);

    res.on('data', function(d) {
        console.info('POST result:\n');
        process.stdout.write(d);
        console.info('\n\nPOST completed');
    });
});

// write the json data
reqPost.write(jsonObject);
reqPost.end();
reqPost.on('error', function(e) {
    console.error(e);
});