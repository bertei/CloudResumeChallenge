function visitcount() {
    return fetch("https://vuqzcgsd40.execute-api.us-east-1.amazonaws.com/dev/Test_lambda").then(function(response) {
    return response.json();
    }).then(function(json) {
        return json;
    });
    }
  
    visitcount().then(function(result) {
        const viewCountPlaceholder = document.getElementById("viewCountPlaceholder");
        viewCountPlaceholder.textContent = result;
        console.log(result);
    });