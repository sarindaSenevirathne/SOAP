import ballerina/http;

public type ClientConfiguration record {|
    *http:ClientConfiguration;
|};

# Description
public client isolated class Client {

    final http:Client httpEp;

    public isolated function init(string url, *ClientConfiguration config) returns error? {

        self.httpEp = check new (url, retrieveHttpClientConfig(config));

        return;
    }

    remote isolated function send(string path, xml payload, map<string|string[]> headers) returns xml|error {

        headers["Content-Type"] = "application/soap+xml";

        xml postResponse = check self.httpEp->post(path = path, message = payload, headers = headers);

        return postResponse;
    }

}

isolated function retrieveHttpClientConfig(ClientConfiguration config) returns http:ClientConfiguration {
    return {
        httpVersion: "1.1",
        http1Settings: config.http1Settings,
        http2Settings: config.http2Settings,
        timeout: config.timeout,
        poolConfig: config?.poolConfig,
        auth: config?.auth,
        retryConfig: config?.retryConfig,
        responseLimits: config.responseLimits,
        secureSocket: config?.secureSocket,
        circuitBreaker: config?.circuitBreaker
    };
}

