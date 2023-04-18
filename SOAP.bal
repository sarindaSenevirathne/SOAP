import ballerina/http;

# Description
public client isolated class Client {

    final http:Client httpEp;

    public isolated function init(string url) returns error? {

        self.httpEp = check new (url = url, config = {
            httpVersion: "1.1"
        });

        return;
    }

    remote isolated function send(xml payload, map<string|string[]> headers) returns xml|error {

        headers["Content-Type"] = "application/soap+xml";

        xml postResponse = check self.httpEp->post(path = "", message = payload, headers = headers);

        return postResponse;
    }

}

