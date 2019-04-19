var redis = require('redis')
const express = require('express')
const app = express()
const port = 3000
var redis_url = process.env.DATABASE_URL

var client = redis.createClient(redis_url)

client.on("error", function (err) {
    console.log("Error " + err);
});

client.on("connect", function(){
    client.set("1", "Hello from Convox", redis.print)
    app.listen(port, () => console.log(`Example app listening on port ${port}!`))
})


app.get('/', function(req, res){
    var response
    client.get("1", function(error, result){
        res.send(result)
    })
})
