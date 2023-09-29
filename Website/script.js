//'visitcount()' function uses 'fetch()' API to make a GET request to the AWS API Endpoint.
//The endpoint its a AWS API GW which invokes a lambda function that updates a 'visitor-counter' and returns a number.
//Once the visit-number is returned, the function sets the number into the html element. Also logs the result to the console.
function visitcount() {
    return fetch("https://vuqzcgsd40.execute-api.us-east-1.amazonaws.com/dev/Website-Lambda").then(function(response) {
        return response.json();
    }).then(function(json) {
        return json;
    });
}

visitcount().then(function(result) {
    const viewCountPlaceholder = document.getElementById("viewCountPlaceholder");
    viewCountPlaceholder.textContent = "View-Counter: " + result;
});