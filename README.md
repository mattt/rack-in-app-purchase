# Rack::InAppPurchase

Rack::InAppPurchase is Rack middleware that manages products for in-app-purchases and verifies receipts. Verifying receipts on the server ensures guards against unauthorized use of paid content, as well as providing real-time metrics on purchase history and usage.

Rack::InAppPurchase provides the following endpoints:

- `GET /products/identifiers`: Returns a JSON array of product identifiers from the database
- `POST /receipts/verify`: Verifies a receipt using Apple's receipt verification webservice, registers the receipt in the database, and returns the receipt.

## Installation

    $ gem install rack-in-app-purchase

## Requirements

- Ruby 1.9
- PostgreSQL 9.1 running locally ([Postgres.app](http://postgresapp.com) is the easiest way to get a Postgres server running on your Mac)

## Example Usage

Rack::InAppPurchase can be run as Rack middleware or as a single web application. All that is required is a connection to a Postgres database.

### config.ru

```ruby
require 'bundler'
Bundler.require

run Rack::InAppPurchase
```

### Objective-C

```objective-c
NSURL *url = [NSURL URLWithString:@"https://your-webservice-url.com/verifyReceipt"];
NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
[request setHTTPMethod:@"POST"];

NSString *params = [NSString stringWithFormat:@"receipt_data=%@", [receiptData base64EncodedString]];
NSData *httpBody = [params dataUsingEncoding:NSUTF8StringEncoding];
[request setHTTPBody:httpBody];

[NSURLConnection sendAsynchronousRequest:request
                                   queue:[NSOperationQueue mainQueue]
                       completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {
        id receipt = [NSJSONSerialization JSONObjectWithData:data
                                                     options:0 
                                                     error:nil];
        NSLog(@"Received receipt: %@", receipt);
    } else {
        NSLog(@"Body: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"ERROR: %@", error);
    }
}];
```

### `curl`

    $ curl -X POST -i -d "receipt-data=(Base64-Encoded String)" https://your-webservice-url.com/verifyReceipt

      HTTP/1.1 203 Non-Authoritative Information
      Content-Type: application/json;charset=utf-8
      Content-Length: 365
      Connection: keep-alive
      Server: thin 1.5.0 codename Knife

      {"status":0,"receipt":{"quantity":1,"product_id":"com.example.download","transaction_id":"1000000000000001","purchase_date":"Mon, 01 Jan 2013 12:00:00 GMT","original_transaction_id":"1000000000000001","original_purchase_date":"Mon, 01 Jan 2013 12:00:00 GMT","app_item_id":null,"version_external_identifier":null,"bid":"com.example.app","bvrs":"123456789"}}

An example application can be found in the `/example` directory of this repository.


---

## Contact

Mattt Thompson

- http://github.com/mattt
- http://twitter.com/mattt
- m@mattt.me

## License

Rack::InAppPurchase is available under the MIT license. See the LICENSE file for more info.
