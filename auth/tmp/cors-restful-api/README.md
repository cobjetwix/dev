CORSnection
-----------
Connect your front-end solution (webapp or/and native mobile app) with a server API that requires authentication.
Authenticate using Social Stategy (Facebook, Twitter...) or Local Strategy over a CORS RESTful service written in NodeJS.

![Example](http://i39.tinypic.com/2q2j043.png)

Technology
----------
Server: NodeJS, CORS, RESTful, PassportJS, FacebookAuth, LocalAuth.

Client: AngularJS, Bootstrap, GruntJS.


Live Demo
---------
[http://corsnection-client.herokuapp.com/](http://corsnection-client.herokuapp.com/)

- Username: root
- Password: c0rS


Installation
------------
Clone the repository (or download/unzip) into a directory.
https://github.com/pablodenadai/cors-restful-api

#### Server
1. Run `$ npm install`
2. Configure /app/app.js with Facebook App Key.
3. Run server via `$ node app/app.js`

#### Client
1. Run `$ sudo npm install`
2. Run `$ sudo bower install`
3. Run client via `$ grunt server`


Todo
----
- In-line documentation. (docco)
- Unit tests.


License
-------
```
The MIT License (MIT)

Copyright (c) 2013 Pablo De Nadai @pablodenadai

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

[![githalytics.com alpha](https://cruel-carlota.pagodabox.com/01a001bf787c1578cc0003019fe604f2 "githalytics.com")](http://githalytics.com/pablodenadai/Corsnection)
