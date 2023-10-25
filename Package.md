# SOAP Connector
You can use this SOAP connector to create a SOAP client first by providing the URL of the SOAP endpoint. Then you can use the  'send' method to send a request to that endpoint 

Please refer to a sample code below,

```

import ballerina/http;
import sarindas/SOAP;

service / on new http:Listener(9090) {

    resource function post invoke(@http:Payload xml payload) returns xml|error {
        
        SOAP:Client soapClient = check new ("<SOAP ENDPOINT>", optional soapConfiguration);

        xml result = check soapClient->send("", payload, {});

        return result;
    }
}

```